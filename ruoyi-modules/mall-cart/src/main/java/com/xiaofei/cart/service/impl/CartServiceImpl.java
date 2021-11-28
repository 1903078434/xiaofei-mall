package com.xiaofei.cart.service.impl;

import com.alibaba.fastjson.JSON;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.ruoyi.common.core.exception.mall.MallCartException;
import com.xiaofei.cart.mapper.CartMapper;
import com.xiaofei.cart.service.CartService;
import com.xiaofei.common.cart.entity.CartEntity;
import com.xiaofei.common.cart.vo.CartReqVo;
import com.xiaofei.common.cart.vo.CartRespVo;
import com.xiaofei.common.product.entity.SkuInfoEntity;
import com.xiaofei.common.product.entity.SkuSaleAttrValueEntity;
import com.xiaofei.common.utils.ResponseResult;
import com.xiaofei.feign.ProductFeignService;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

/**
 *
 */
@Service
public class CartServiceImpl extends ServiceImpl<CartMapper, CartEntity> implements CartService {


    @Autowired
    private ProductFeignService productFeignService;

    /**
     * 添加购物车信息
     *
     * @param cartReqVos 新的购物车信息
     * @return true：添加成功。false：添加失败
     */
    @Transactional
    @Override
    public List<Long> addCart(Long userId, List<CartReqVo> cartReqVos) throws MallCartException {
        List<Long> cartIds = new ArrayList<>();
        for (CartReqVo cartReqVo : cartReqVos) {
            //根据id查询购物车中是否已经有该商品的信息了
            CartEntity cartEntity = this.getOne(new QueryWrapper<CartEntity>()
                    .eq("user_id", userId)
                    .eq("spu_id", cartReqVo.getSpuId())
                    .eq("sku_id", cartReqVo.getSkuId()));

            //判断购物车中是否已经有了该商品的信息
            if (cartEntity == null) {

                cartEntity = new CartEntity();
                BeanUtils.copyProperties(cartReqVo, cartEntity);

                //1、远程查询商品信息
                ResponseResult<SkuInfoEntity> skuInfoEntityResp = productFeignService.querySkuInfoById(cartReqVo.getSkuId());
                SkuInfoEntity skuInfoEntity = skuInfoEntityResp.getData();
                if (skuInfoEntityResp.getCode() != 200 || skuInfoEntity == null) {
                    throw new MallCartException("系统错误，购物车添加失败");
                }

                cartEntity.setSkuName(skuInfoEntity.getSkuName());
                cartEntity.setSkuPrice(skuInfoEntity.getPrice());
                cartEntity.setTotalSkuPrice(skuInfoEntity.getPrice().multiply(new BigDecimal(cartReqVo.getBuyNum())));

                //2、查询商品的销售属性
                ResponseResult<List<SkuSaleAttrValueEntity>> saleAttrResp = productFeignService.querySkuSaleAttrBySkuId(cartReqVo.getSkuId());
                List<SkuSaleAttrValueEntity> saleAttrEntity = saleAttrResp.getData();
                if (saleAttrResp.getCode() != 200 || saleAttrEntity.size() == 0) {
                    throw new MallCartException("系统错误，购物车添加失败");
                }

                Map<String, Object> attrNames = saleAttrEntity.stream().collect(Collectors.toMap(SkuSaleAttrValueEntity::getAttrName, SkuSaleAttrValueEntity::getAttrValue));
                cartEntity.setSaleAttr(JSON.toJSONString(attrNames));

                //设置添加时间

                cartEntity.setAddTime(LocalDateTime.now());
                cartEntity.setUserId(userId);

                this.save(cartEntity);

            } else {
                cartEntity.setBuyNum(cartEntity.getBuyNum() + cartReqVo.getBuyNum());
                cartEntity.setTotalSkuPrice(cartEntity.getSkuPrice().multiply(new BigDecimal(cartReqVo.getBuyNum())));
                //修改购物车信息
                this.updateById(cartEntity);
            }
            cartIds.add(cartEntity.getId());
        }

        return cartIds;
    }

    /**
     * 根据用户id和商品id删除购物车信息
     *
     * @param userId 用户id
     * @param skuIds 商品id
     */
    @Override
    public boolean deleteCartBySkuId(Long userId, List<Long> skuIds) {
        return this.remove(new QueryWrapper<CartEntity>().eq("user_id", userId).in("sku_id", skuIds));
    }

    /**
     * 删除购物车信息
     */
    @Transactional
    @Override
    public boolean deleteCart(String id) {
        //解析id
        List<String> ids = Arrays.stream(id.split(",")).collect(Collectors.toList());
        return this.removeByIds(ids);
    }

    /**
     * 全选和全不选修改
     *
     * @param isCheckAll true：全选。false：全不选
     * @param userId     用户id
     */
    @Override
    public boolean checkAll(boolean isCheckAll, Long userId) {
        CartEntity cartEntity = new CartEntity();
        cartEntity.setUserId(userId);
        cartEntity.setCheck(isCheckAll);
        return this.update(cartEntity, new QueryWrapper<CartEntity>().eq("user_id", userId));
    }

    /**
     * 修改购物车信息
     *
     * @param userId    用户id
     * @param cartReqVo 新的购物车信息
     * @return true：修改成功。false：修改失败
     */
    @Transactional
    @Override
    public Long updateCart(Long userId, CartReqVo cartReqVo) throws MallCartException {

        CartEntity cartEntity = new CartEntity();
        BeanUtils.copyProperties(cartReqVo, cartEntity);

        //如果查询出来的数据为空，就将值设置为传入的值
        cartEntity = this.getById(cartEntity.getId());

        //查询出来当前id的购物车信息
        if (cartEntity != null) {

            //判断购物车的数量是否超过99件
            if (cartReqVo.getBuyNum() > 99 || cartReqVo.getBuyNum() < 1) {
                throw new MallCartException("购物车中，同一件商品最多能添加99件，最少一件");
            }

            cartEntity.setBuyNum(cartReqVo.getBuyNum());
            cartEntity.setCheck(cartReqVo.isCheck());
            cartEntity.setTotalSkuPrice(cartEntity.getSkuPrice().multiply(new BigDecimal(cartReqVo.getBuyNum())));
            this.updateById(cartEntity);
            return cartEntity.getId();
        }
        throw new MallCartException("请先添加该商品到购物车中");
    }

    /**
     * 根据购物车id查询对应的购物车商品信息
     *
     * @param id 购物车id
     * @return 返回对应的购物车信息
     */
    @Override
    public List<CartEntity> queryCartInfoById(String id) {
        return queryCartsByIds(id);
    }

    /**
     * 根据用户id查询用户购物车信息
     *
     * @param userId 用户id
     * @return 返回指定用户的购物车信息
     */
    @Override
    public CartRespVo queryCartByUserId(Long userId) {
        CartRespVo cartRespVo = new CartRespVo();

        List<CartEntity> items = this.list(new QueryWrapper<CartEntity>().eq("user_id", userId));

        final BigDecimal[] totalPrice = {new BigDecimal(0)};
        final Integer[] totalCheck = {0};
        items.forEach(item -> {
            if (item.isCheck()) {
                totalPrice[0] = totalPrice[0].add(item.getTotalSkuPrice());
                totalCheck[0] = totalCheck[0] + 1;
            }
        });

        //封装返回信息
        cartRespVo.setItems(items);
        cartRespVo.setTotalCount(items.size());
        cartRespVo.setTotalPrice(totalPrice[0]);
        cartRespVo.setTotalCheck(totalCheck[0]);
        cartRespVo.setCheckAll(items.size() == totalCheck[0]);

        return cartRespVo;
    }

    /**
     * 根据id集合查询信息
     */
    @Override
    public List<CartEntity> queryCartsByIds(String id) {
        List<String> ids = Arrays.stream(id.split(",")).collect(Collectors.toList());
        return this.list(new QueryWrapper<CartEntity>().in("id", ids));
    }

    /**
     * 查询指定用户下面的选中的商品信息
     *
     * @param userId 用户id
     * @return 返回被选中的商品信息
     */
    @Override
    public List<CartEntity> queryCheckCart(Long userId) {
        return this.list(new QueryWrapper<CartEntity>().eq("user_id", userId));
    }
}




