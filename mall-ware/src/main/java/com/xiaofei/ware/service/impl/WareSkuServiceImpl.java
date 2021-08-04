package com.xiaofei.ware.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.ruoyi.common.core.web.domain.AjaxResult;
import com.xiaofei.common.dto.SkuHasStockDto;
import com.xiaofei.common.vo.PageVo;
import com.xiaofei.common.ware.entity.WareSkuEntity;
import com.xiaofei.common.ware.vo.WareSkuVo;
import com.xiaofei.ware.feign.ProductFeignService;
import com.xiaofei.ware.mapper.WareSkuDao;
import com.xiaofei.ware.service.WareSkuService;
import io.seata.spring.annotation.GlobalTransactional;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.*;
import java.util.stream.Collectors;

/**
 * User: 李飞
 * Date: 2021/8/1
 * Time: 19:21
 */
@Service
@Slf4j
public class WareSkuServiceImpl extends ServiceImpl<WareSkuDao, WareSkuEntity> implements WareSkuService {

    @Autowired
    private ProductFeignService productFeignService;

    /**
     * 添加库存信息
     *
     * @param wareSkuVo 库存信息
     * @return true：添加成功。false：添加失败
     */
    @GlobalTransactional(timeoutMills = 100000)
    @Override
    public Map<String, Object> addWareSku(WareSkuVo wareSkuVo) {

        //查询指定sku是否存在
        AjaxResult response = productFeignService.querySpuInfoById(wareSkuVo.getSkuId());
        Map<String, Object> skuInfoEntity = (Map<String, Object>) response.get("data");

        Map<String, Object> resp = new HashMap<>();//需要返回的信息
        if (skuInfoEntity != null) {
            //判断该库存是否已经添加了
            WareSkuEntity isNull = this.getOne(new QueryWrapper<WareSkuEntity>()
                    .eq("sku_id", wareSkuVo.getSkuId())
                    .eq("ware_id", wareSkuVo.getWareId()));
            if (isNull == null) {
                //添加操作
                WareSkuEntity wareSkuEntity = new WareSkuEntity();
                BeanUtils.copyProperties(wareSkuVo, wareSkuEntity);
                wareSkuEntity.setSkuName((String) skuInfoEntity.get("skuName"));
                boolean isSuccess = this.save(wareSkuEntity);
                resp.put("isSuccess", isSuccess);
                resp.put("msg", isSuccess ? "添加成功" : "添加失败");
            } else {
                resp.put("isSuccess", false);
                resp.put("msg", "skuId为" + wareSkuVo.getSkuId() + "的商品库存已添加，直接去修改");
            }
        } else {
            resp.put("isSuccess", false);
            resp.put("msg", "skuId为" + wareSkuVo.getSkuId() + "的商品不存在，请先添加商品");
        }
        return resp;
    }

    /**
     * 根据库存id集合删除库存信息
     *
     * @param skuId 库存id字符串
     * @return true：删除成功。false：删除失败
     */
    @Override
    public boolean deleteWareSkuById(String skuId) {
        //TODO 库存删除功能未完成，待完善
        List<String> wareSkuIds = Arrays.stream(skuId.split(",")).collect(Collectors.toList());

        // return this.removeByIds(wareSkuIds);

        return true;
    }

    /**
     * 根据库存id修改库存信息
     *
     * @param wareSkuVo 新的库存信息
     * @return true：修改成功。false：修改失败
     */
    @Override
    public boolean updateWareSkuById(WareSkuVo wareSkuVo) {
        //TODO 库存添加功能未完成
        WareSkuEntity wareSkuEntity = new WareSkuEntity();
        BeanUtils.copyProperties(wareSkuVo, wareSkuEntity);
        //return this.updateById(wareSkuEntity);

        return true;
    }

    /**
     * 分页查询库存信息
     *
     * @param wareSkuVo 查询条件
     * @return 返回查询到的信息
     */
    @Override
    public PageVo<WareSkuEntity> queryByPage(WareSkuVo wareSkuVo) {
        PageHelper.startPage(wareSkuVo.getPageNo(), wareSkuVo.getPageSize());

        QueryWrapper<WareSkuEntity> queryWrapper = new QueryWrapper<>();

        if (wareSkuVo.getSkuId() != null && wareSkuVo.getSkuId() > 0) {
            queryWrapper.eq("sku_id", wareSkuVo.getSkuId());
        }

        if (wareSkuVo.getWareId() != null && wareSkuVo.getWareId() > 0) {
            queryWrapper.eq("ware_id", wareSkuVo.getWareId());
        }

        if (!StringUtils.isEmpty(wareSkuVo.getSkuName())) {
            queryWrapper.like("sku_name", wareSkuVo.getSkuName());
        }

        List<WareSkuEntity> items = this.list(queryWrapper);

        PageInfo<WareSkuEntity> pageInfo = new PageInfo<>(items);

        return new PageVo<>(pageInfo.getPageNum(), pageInfo.getPageSize(), pageInfo.getPages(), pageInfo.getTotal(), pageInfo.getList());
    }

    /**
     * 查询是否有库存
     *
     * @param skuIds 商品id集合
     * @return 返回指定商品的库存信息
     */
    @Override
    public List<SkuHasStockDto> getSkuStock(List<Long> skuIds) {
        return skuIds.stream().map(skuId -> {
            SkuHasStockDto vo = new SkuHasStockDto();
            //查询当前sku的库存量
            //SELECT SUM(stock-stock_locked) FROM `wms_ware_sku` WHERE sku_id=1
            Long count = baseMapper.getSkuStock(skuId); //获取每一个sku的库存总量
            //按照这个计数count，就会判断是否有库存
            vo.setSkuId(skuId);
            vo.setHasStock(count != null && count > 0); //有库存
            return vo;
        }).collect(Collectors.toList());
    }
}


