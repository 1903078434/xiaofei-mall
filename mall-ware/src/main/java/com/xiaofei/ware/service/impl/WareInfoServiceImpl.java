package com.xiaofei.ware.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.xiaofei.common.vo.PageVo;
import com.xiaofei.common.ware.entity.WareInfoEntity;
import com.xiaofei.common.ware.vo.WareInfoVo;
import com.xiaofei.ware.mapper.WareInfoDao;
import com.xiaofei.ware.service.WareInfoService;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.BeanUtils;
import org.springframework.stereotype.Service;

import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors;

/**
 * User: 李飞
 * Date: 2021/8/1
 * Time: 16:09
 */
@Service
public class WareInfoServiceImpl extends ServiceImpl<WareInfoDao, WareInfoEntity> implements WareInfoService {

    /**
     * 添加仓库信息
     *
     * @param wareInfoVo 仓库信息
     * @return true：添加成功。false：添加失败
     */
    @Override
    public boolean addWareInfo(WareInfoVo wareInfoVo) {
        WareInfoEntity wareInfoEntity = new WareInfoEntity();

        BeanUtils.copyProperties(wareInfoVo, wareInfoEntity);

        return this.save(wareInfoEntity);
    }

    /**
     * 根据仓库id集合删除仓库信息
     *
     * @param wareId 仓库id字符串，用 ， 隔开的
     * @return true：删除成功。false：删除失败
     */
    @Override
    public boolean deleteWareById(String wareId) {
        //TODO 仓库删除功能未完成，待完善
        List<String> wareIds = Arrays.stream(wareId.split(",")).collect(Collectors.toList());

        // return this.removeByIds(wareIds);

        return true;
    }

    /**
     * 根据仓库id修改仓库信息
     *
     * @param wareInfoVo 新的仓库信息
     * @return true：修改成功。false：修改失败
     */
    @Override
    public boolean updateWareInfoById(WareInfoVo wareInfoVo) {
        //TODO 库存修改操作，未完成
        WareInfoEntity wareInfoEntity = new WareInfoEntity();
        BeanUtils.copyProperties(wareInfoVo, wareInfoEntity);

        //return this.updateById(wareInfoEntity);

        return true;

    }

    /**
     * 分页查询
     *
     * @param wareInfoVo 仓库查询条件
     * @return 返回查询的信息
     */
    @Override
    public PageVo<WareInfoEntity> queryByPage(WareInfoVo wareInfoVo) {

        PageHelper.startPage(wareInfoVo.getPageNo(), wareInfoVo.getPageSize());

        String searchValue = wareInfoVo.getSearchValue();

        QueryWrapper<WareInfoEntity> queryWrapper = new QueryWrapper<>();

        if (!StringUtils.isEmpty(searchValue)) {
            queryWrapper.like("name", searchValue);
        }

        List<WareInfoEntity> items = this.list(queryWrapper);

        PageInfo<WareInfoEntity> pageInfo = new PageInfo<>(items);

        return new PageVo<>(pageInfo.getPageNum(), pageInfo.getPageSize(), pageInfo.getPages(), pageInfo.getTotal(), pageInfo.getList());

    }
}
