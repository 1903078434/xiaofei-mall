package com.xiaofei.ware.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.ruoyi.common.core.exception.mall.OrderException;
import com.xiaofei.common.dto.SkuHasStockDto;
import com.xiaofei.common.order.dto.OrderSkuDto;
import com.xiaofei.common.order.vo.OrderReqVo;
import com.xiaofei.common.utils.ResponseResult;
import com.xiaofei.common.vo.PageVo;
import com.xiaofei.common.ware.entity.WareSkuEntity;
import com.xiaofei.common.ware.vo.WareSkuVo;

import java.util.List;
import java.util.Map;

/**
 * User: 李飞
 * Date: 2021/8/1
 * Time: 19:21
 */
public interface WareSkuService extends IService<WareSkuEntity> {

    /**
     * 添加库存信息
     *
     * @param wareSkuVo 库存信息
     * @return 成功或失败的信息，key：【isSuccess，msg】
     */
    Map<String, Object> addWareSku(WareSkuVo wareSkuVo);

    /**
     * 根据库存id集合删除库存信息
     *
     * @param skuId 库存id字符串
     * @return true：删除成功。false：删除失败
     */
    boolean deleteWareSkuById(String skuId);

    /**
     * 根据库存id修改库存信息
     *
     * @param wareSkuVo 新的库存信息
     * @return true：修改成功。false：修改失败
     */
    boolean updateWareSkuById(WareSkuVo wareSkuVo);

    /**
     * 分页查询库存信息
     *
     * @param wareSkuVo 查询条件
     * @return 返回查询到的信息
     */
    PageVo<WareSkuEntity> queryByPage(WareSkuVo wareSkuVo);

    /**
     * 支付成功修改库存信息
     *
     * @param skuInfos 商品信息
     */
    boolean paySuccess(List<OrderReqVo.OrderReqSkuInfo> skuInfos) throws OrderException;

    /**
     * 查询是否有库存
     *
     * @param skuIds 商品id集合
     * @return 返回指定商品的库存信息
     */
    List<SkuHasStockDto> getSkuStock(List<Long> skuIds);

    /**
     * 查询库存是否充足，如果充足，锁定库存
     *
     * @param orderSkuDto 需要查询的信息和需要锁定的库存
     * @return true：库存充足。false：库存不足
     */
    ResponseResult<Object> updateStock(List<OrderSkuDto> orderSkuDto);

}
