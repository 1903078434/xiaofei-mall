package com.xiaofei.cart.service.impl;

import com.alibaba.fastjson.JSON;
import com.xiaofei.cart.entity.CartEntity;
import com.xiaofei.cart.feign.ProductFeign;
import com.xiaofei.cart.repository.CartRepository;
import com.xiaofei.cart.service.CartService;
import com.xiaofei.common.cart.vo.CartReqVo;
import com.xiaofei.common.exception.MallCartException;
import com.xiaofei.common.product.entity.SkuInfoEntity;
import com.xiaofei.common.product.entity.SkuSaleAttrValueEntity;
import com.xiaofei.common.utils.ResponseResult;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.data.mongodb.core.query.Criteria;
import org.springframework.data.mongodb.core.query.Query;
import org.springframework.data.mongodb.core.query.Update;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

/**
 * User: 李飞
 * Date: 2021/8/19
 * Time: 10:59
 */
@Service
@Slf4j
public class CartServiceImpl implements CartService {

    @Autowired
    private CartRepository cartRepository;

    @Autowired
    private MongoTemplate mongoTemplate;

    @Autowired
    private ProductFeign productFeign;

    /**
     * 添加购物车信息
     *
     * @param cartReqVo 新的购物车信息
     * @return true：添加成功。false：添加失败
     */
    //@Transactional
    @Override
    public String addCart(CartReqVo cartReqVo) throws MallCartException {
        //根据id查询购物车中是否已经有该商品的信息了
        CartEntity cartEntity = cartRepository.findByUserIdAndSpuIdAndSkuId(cartReqVo.getUserId(), cartReqVo.getSpuId(), cartReqVo.getSkuId());

        //判断购物车中是否已经有了该商品的信息
        if (cartEntity == null) {

            cartEntity = new CartEntity();
            BeanUtils.copyProperties(cartReqVo, cartEntity);

            //1、远程查询商品信息
            ResponseResult<SkuInfoEntity> skuInfoEntityResp = productFeign.querySkuInfoById(cartReqVo.getSkuId());
            SkuInfoEntity skuInfoEntity = skuInfoEntityResp.getData();
            if (skuInfoEntityResp.getCode() != 200 || skuInfoEntity == null) {
                throw new MallCartException("系统错误，购物车添加失败");
            }

            cartEntity.setSkuName(skuInfoEntity.getSkuName());
            cartEntity.setSkuPrice(skuInfoEntity.getPrice());
            cartEntity.setTotalSkuPrice(skuInfoEntity.getPrice().multiply(new BigDecimal(cartReqVo.getBuyNum())));

            //2、查询商品的销售属性
            ResponseResult<List<SkuSaleAttrValueEntity>> saleAttrResp = productFeign.querySkuSaleAttrBySkuId(cartReqVo.getSkuId());
            List<SkuSaleAttrValueEntity> saleAttrEntity = saleAttrResp.getData();
            if (saleAttrResp.getCode() != 200 || saleAttrEntity.size() == 0) {
                throw new MallCartException("系统错误，购物车添加失败");
            }

            Map<String, Object> attrNames = saleAttrEntity.stream().collect(Collectors.toMap(SkuSaleAttrValueEntity::getAttrName, SkuSaleAttrValueEntity::getAttrValue));
            cartEntity.setSaleAttr(JSON.toJSONString(attrNames));

            cartEntity = cartRepository.insert(cartEntity);
            return cartEntity.getId();

        } else {
            //修改购物车信息
            return this.updateCart(cartReqVo);
        }
    }

    /**
     * 删除购物车信息
     */
    //@Transactional
    @Override
    public void deleteCart(String id) {
        cartRepository.deleteById(id);
    }

    /**
     * 修改购物车信息
     *
     * @param cartReqVo 新的购物车信息
     * @return true：修改成功。false：修改失败
     */
    //@Transactional
    @Override
    public String updateCart(CartReqVo cartReqVo) throws MallCartException {
        CartEntity cartEntity;
        if (StringUtils.isEmpty(cartReqVo.getId())) {
            cartEntity = cartRepository.findByUserIdAndSpuIdAndSkuId(cartReqVo.getUserId(), cartReqVo.getSpuId(), cartReqVo.getSkuId());
        } else {
            //如果查询出来的数据为空，就将值设置为传入的值
            cartEntity = cartRepository.findById(cartReqVo.getId()).orElse(null);
        }
        //查询出来当前id的购物车信息
        if (cartEntity != null) {

            //判断购物车的数量是否超过99件
            if (cartEntity.getBuyNum() >= 99 || cartEntity.getBuyNum() + cartReqVo.getBuyNum() > 99) {
                throw new MallCartException("购物车中，同一件商品只能添加99件");
            }

            Query query = new Query().addCriteria(Criteria.where("_id").is(cartEntity.getId()));

            Update update = new Update();
            update.set("buyNum", cartEntity.getBuyNum() + cartReqVo.getBuyNum());
            update.set("check", cartReqVo.isCheck());

            mongoTemplate.updateMulti(query, update, CartEntity.class);
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
    public CartEntity queryCartInfoById(String id) {
        return cartRepository.findById(id).get();
    }
}
