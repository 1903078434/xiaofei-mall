package com.xiaofei.order.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.xiaofei.common.cart.entity.CartEntity;
import com.xiaofei.common.dto.SkuHasStockDto;
import com.xiaofei.common.member.entity.MemberReceiveAddressEntity;
import com.xiaofei.common.order.vo.OrderInfoResp;
import com.xiaofei.common.utils.ResponseResult;
import com.xiaofei.order.entity.OrderEntity;
import com.xiaofei.order.feign.CartFeignService;
import com.xiaofei.order.feign.MemberFeignService;
import com.xiaofei.order.feign.WareFeignService;
import com.xiaofei.order.mapper.OrderMapper;
import com.xiaofei.order.service.OrderService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.util.List;
import java.util.concurrent.CompletableFuture;
import java.util.concurrent.ExecutionException;
import java.util.concurrent.ThreadPoolExecutor;
import java.util.stream.Collectors;

/**
 *
 */
@Service
public class OrderServiceImpl extends ServiceImpl<OrderMapper, OrderEntity> implements OrderService {

    @Autowired
    private ThreadPoolExecutor threadPoolExecutor;//引入配置的线程池
    @Autowired
    private MemberFeignService memberFeignService;
    @Autowired
    private CartFeignService cartFeignService;
    @Autowired
    private WareFeignService wareFeignService;

    /**
     * 通过购物车中对商品进行下单
     *
     * @param userId 用户id
     * @return 返回所需要的订单信息
     */
    @Override
    public OrderInfoResp queryOrderInfo(Long userId) throws ExecutionException, InterruptedException {

        OrderInfoResp orderInfoResp = new OrderInfoResp();
        //1、远程调用，获取用户信息
        CompletableFuture<Void> getReceiveAddress = CompletableFuture.runAsync(() -> {
            ResponseResult<List<MemberReceiveAddressEntity>> receiveAddress = memberFeignService.getReceiveAddress(userId);
            if (receiveAddress.getCode() == 200) {
                //成功
                orderInfoResp.setReceiveAddress(receiveAddress.getData());
            }
        }, threadPoolExecutor);

        //2、远程调用，获取购物车中选中的商品的信息
        OrderInfoResp.CartInfo cartInfo = new OrderInfoResp.CartInfo();
        CompletableFuture<Void> getCartInfo = CompletableFuture.runAsync(() -> {
            ResponseResult<List<CartEntity>> cartInfos = cartFeignService.queryCheckCart(userId);
            if (cartInfos.getCode() == 200) {
                //成功
                cartInfo.setItems(cartInfos.getData());
            }
        }, threadPoolExecutor);

        //3、库存查询，判断是否有库存，当getCartInfo完成之后才执行该线程
        CompletableFuture<Void> getStockSku = getCartInfo.thenRunAsync(() -> {
            //获取购物车中所有商品的id
            List<Long> skuIds = cartInfo.getItems().stream().map(CartEntity::getSkuId).collect(Collectors.toList());
            //远程调用，获取商品的库存信息
            ResponseResult<List<SkuHasStockDto>> skuStocks = wareFeignService.hasStock(skuIds);
            //获取出来有库存的用户信息
            List<Long> hasStockIds = skuStocks.getData().stream().filter(SkuHasStockDto::getHasStock).map(SkuHasStockDto::getSkuId).collect(Collectors.toList());
            //过滤掉没有库存的商品
            List<CartEntity> cartEntitys = cartInfo.getItems().stream().filter(item -> hasStockIds.contains(item.getSkuId())).collect(Collectors.toList());

            //设置还能购买商品的信息
            BigDecimal[] totalPrice = {new BigDecimal(0)};
            orderInfoResp.setHasStock(cartInfo.getItems().size() - cartEntitys.size() > 0);//设置是否有商品没有库存
            cartInfo.setTotalCount(cartEntitys.size());//设置商品的总数
            cartInfo.setItems(cartEntitys);//设置有库存的商品
            cartEntitys.forEach(item -> totalPrice[0] = totalPrice[0].add(item.getTotalSkuPrice()));//算出订单总价
            cartInfo.setTotalPrice(totalPrice[0]);//设置订单总价
            orderInfoResp.setCartInfo(cartInfo);
        }, threadPoolExecutor);

        //TODO 后面还可以整合优惠信息

        //一定要等所有执行完了才能返回，否则，异步任务可能还没有执行完成就返回了
        CompletableFuture.allOf(getReceiveAddress, getCartInfo, getStockSku).get();

        return orderInfoResp;
    }
}




