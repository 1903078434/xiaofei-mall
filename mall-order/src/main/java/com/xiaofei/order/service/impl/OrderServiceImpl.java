package com.xiaofei.order.service.impl;

import com.alibaba.fastjson.JSON;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.xiaofei.common.cart.entity.CartEntity;
import com.xiaofei.common.dto.SkuHasStockDto;
import com.xiaofei.common.exception.OrderException;
import com.xiaofei.common.member.entity.MemberReceiveAddressEntity;
import com.xiaofei.common.order.constant.*;
import com.xiaofei.common.order.dto.OrderSkuDto;
import com.xiaofei.common.order.vo.OrderInfoResp;
import com.xiaofei.common.order.vo.OrderVo;
import com.xiaofei.common.product.entity.SpuInfoEntity;
import com.xiaofei.common.utils.ResponseResult;
import com.xiaofei.order.entity.OrderEntity;
import com.xiaofei.order.entity.OrderItemEntity;
import com.xiaofei.order.feign.CartFeignService;
import com.xiaofei.order.feign.MemberFeignService;
import com.xiaofei.order.feign.ProductFeignService;
import com.xiaofei.order.feign.WareFeignService;
import com.xiaofei.order.mapper.OrderMapper;
import com.xiaofei.order.service.OrderService;
import io.seata.spring.annotation.GlobalTransactional;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Map;
import java.util.Random;
import java.util.Set;
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
    @Autowired
    private ProductFeignService productFeignService;

    /**
     * 确认订单信息
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

    /**
     * 创建订单
     *
     * @param userId   用户id
     * @param username 用户名
     * @param orderVo  订单所需要的信息
     */
    @GlobalTransactional//引入阿里的分布式事务管理
    @Override
    public void crateOrder(Long userId, String username, OrderVo orderVo) throws OrderException {

        //把所有商品的id提取出来
        List<OrderSkuDto> orderSkuDtos = orderVo.getOrderItemInfos().stream().map(orderItemInfo -> {
            OrderSkuDto orderSkuDto = new OrderSkuDto();
            BeanUtils.copyProperties(orderItemInfo, orderSkuDto);
            orderSkuDto.setBuyNum(orderItemInfo.getSkuQuantity());
            return orderSkuDto;
        }).collect(Collectors.toList());
        //远程库存服务，如果库存不足会抛出异常
        wareFeignService.updateStock(orderSkuDtos);

        //设置订单信息
        OrderEntity orderEntity = new OrderEntity();

        //TODO 生成订单号，这里先使时间戳加简单随机数生成，后续学习算法再完善
        String orderSn = System.currentTimeMillis() + new Random().nextInt(10) + "";

        //TODO 优惠信息，物流信息，发票信息，后续完善

        BeanUtils.copyProperties(orderVo.getReceivingInfo(), orderEntity);//设置收货人和地址信息

        //获取订单总金额

        orderEntity.setMemberId(userId);//设置用户id
        orderEntity.setOrderSn(orderSn);//设置订单编号
        orderEntity.setCreateTime(LocalDateTime.now());//设置创建时间
        orderEntity.setMemberUsername(username);//设置用户名
        orderEntity.setTotalAmount(orderVo.getTotalAmount());//设置订单总价
        orderEntity.setPayAmount(orderVo.getTotalAmount());//TODO 设置应付总额，后续结合优惠信息完善
        orderEntity.setFreightAmount(new BigDecimal(0));//TODO 设置运费
        orderEntity.setPromotionAmount(new BigDecimal(0));//TODO 促销优惠金额
        orderEntity.setIntegrationAmount(new BigDecimal(0));//TODO 积分抵扣
        orderEntity.setCouponAmount(new BigDecimal(0));//TODO 优惠券抵扣
        orderEntity.setDiscountAmount(new BigDecimal(0));//TODO 后台调整订单减少的价格
        orderEntity.setPayType(PayTypeEnum.BANK_PAY.getPayId());//TODO 设置支付方式
        orderEntity.setSourceType(OrderSourceEnum.PC_SOURCE.getSourceId());//TODO 设置订单来源
        orderEntity.setStatus(OrderStatusEnum.PENDING_PAYMENT.getStatusId());//订单状态
        orderEntity.setConfirmStatus(OrderConfirmEnum.NOT_CONFIRM.getConfirmId());//订单确认收获状态
        orderEntity.setDeleteStatus(OrderDelStatusEnum.NOT_DELETE.getDelId());//订单删除状态
        orderEntity.setUseIntegration(0);//TODO 下单使用的积分
        orderEntity.setModifyTime(LocalDateTime.now());
        System.out.println(JSON.toJSONString(orderEntity));

        //设置订单项信息，获取所有的spuId
        Set<Long> spuIds = orderVo.getOrderItemInfos().stream().map(OrderVo.OrderItemInfo::getSkuId).collect(Collectors.toSet());

        Map<Long, SpuInfoEntity> spuInfoMap = productFeignService.querySpuInfoByIds(spuIds).getData()
                .stream().collect(Collectors.toMap(SpuInfoEntity::getId, spuInfoEntity -> spuInfoEntity));

        List<OrderItemEntity> orderItems = orderVo.getOrderItemInfos().stream().map(orderItemInfo -> {
            OrderItemEntity orderItemEntity = new OrderItemEntity();
            BeanUtils.copyProperties(orderItemInfo, orderItemEntity);
            SpuInfoEntity spuInfoEntity = spuInfoMap.get(orderItemInfo.getSpuId());
            if(spuInfoEntity !=null){
                orderItemEntity.setOrderId(orderEntity.getId());
                orderItemEntity.setOrderSn(orderEntity.getOrderSn());
                orderItemEntity.setSpuName(spuInfoEntity.getSpuName());
                orderItemEntity.setSpuPic(orderItemInfo.getSkuPic());
                orderItemEntity.setSpuPic(orderItemInfo.getSkuPic());
                orderItemEntity.setSpuBrand(spuInfoEntity.getBrandId()+"");
                orderItemEntity.setCategoryId(spuInfoEntity.getCatalogId());
                //TODO 促销优惠后的价格，优惠券分解价格，积分分解价格，最终的价格，购买赠送的积分，购买赠送的成长值
                orderItemEntity.setPromotionAmount(orderItemEntity.getSkuPrice().multiply(new BigDecimal(orderItemInfo.getSkuQuantity())));
                orderItemEntity.setRealAmount(orderItemEntity.getSkuPrice().multiply(new BigDecimal(orderItemInfo.getSkuQuantity())));
                orderItemEntity.setCouponAmount(orderItemEntity.getSkuPrice().multiply(new BigDecimal(orderItemInfo.getSkuQuantity())));
                orderItemEntity.setIntegrationAmount(orderItemEntity.getSkuPrice().multiply(new BigDecimal(orderItemInfo.getSkuQuantity())));
                orderItemEntity.setRealAmount(orderItemEntity.getSkuPrice().multiply(new BigDecimal(orderItemInfo.getSkuQuantity())));
                orderItemEntity.setGiftIntegration(0);
                orderItemEntity.setGiftGrowth(0);
                //TODO
            }
            return orderItemEntity;
        }).collect(Collectors.toList());

        System.out.println();
    }
}




