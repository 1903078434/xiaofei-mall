package com.xiaofei.cart.service.impl;

import com.alibaba.fastjson.JSON;
import com.xiaofei.cart.entity.CartEntity;
import com.xiaofei.cart.feign.ProductFeign;
import com.xiaofei.cart.repository.CartRepository;
import com.xiaofei.cart.service.CartService;
import com.xiaofei.cart.vo.CartReqVo;
import com.xiaofei.cart.vo.CartRespVo;
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
import java.util.Arrays;
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

            //设置添加时间
            cartEntity.setAddTime(System.currentTimeMillis());

            cartEntity = mongoTemplate.insert(cartEntity);
            if (StringUtils.isEmpty(cartEntity.getId())) {
                cartEntity = cartRepository.findByUserIdAndSpuIdAndSkuId(cartReqVo.getUserId(), cartReqVo.getSpuId(), cartReqVo.getSkuId());
            }
            return cartEntity.getId();

        } else {
            //修改购物车信息
            Query query = new Query().addCriteria(Criteria.where("_id").is(cartEntity.getId()));
            Update update = new Update();
            update.set("buyNum", cartEntity.getBuyNum() + cartReqVo.getBuyNum());
            update.set("totalSkuPrice", cartEntity.getSkuPrice().multiply(new BigDecimal(cartReqVo.getBuyNum())));
            mongoTemplate.updateMulti(query, update, CartEntity.class);
            return cartEntity.getId();
        }
    }

    /**
     * 删除购物车信息
     */
    //@Transactional
    @Override
    public void deleteCart(String id) {
        //解析id
        List<String> ids = Arrays.stream(id.split(",")).collect(Collectors.toList());
        cartRepository.deleteAllById(ids);
        //cartRepository.deleteById(id);
    }

    /**
     * 全选和全不选修改
     *
     * @param isCheckAll true：全选。false：全不选
     * @param userId     用户id
     */
    @Override
    public boolean checkAll(boolean isCheckAll, Long userId) {
        Query query = new Query().addCriteria(Criteria.where("userId").is(userId));
        Update update = new Update();
        update.set("check", isCheckAll);
        return mongoTemplate.updateMulti(query, update, CartEntity.class).getMatchedCount() > 0;
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
            if (cartReqVo.getBuyNum() > 99 || cartReqVo.getBuyNum() < 1) {
                throw new MallCartException("购物车中，同一件商品最多能添加99件，最少一件");
            }

            Query query = new Query().addCriteria(Criteria.where("_id").is(cartEntity.getId()));

            Update update = new Update();
            update.set("buyNum", cartReqVo.getBuyNum());
            update.set("check", cartReqVo.isCheck());
            update.set("totalSkuPrice", cartEntity.getSkuPrice().multiply(new BigDecimal(cartReqVo.getBuyNum())));

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
        return mongoTemplate.findById(id, CartEntity.class);
        //return cartRepository.findById(id).get();
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

        List<CartEntity> items = cartRepository.findByUserId(userId);

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
        Query query = new Query();
        query.addCriteria(Criteria.where("_id").in(ids));
        return mongoTemplate.find(query, CartEntity.class);
    }

    /**
     * 查询指定用户下面的选中的商品信息
     *
     * @param userId 用户id
     * @return 返回被选中的商品信息
     */
    @Override
    public List<CartEntity> queryCheckCart(Long userId) {
        return cartRepository.findByUserIdAndCheck(userId, true);
    }
}
