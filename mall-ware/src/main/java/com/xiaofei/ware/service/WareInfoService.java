package com.xiaofei.ware.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.xiaofei.common.vo.PageVo;
import com.xiaofei.common.ware.entity.WareInfoEntity;
import com.xiaofei.common.ware.vo.WareInfoVo;

/**
 * User: 李飞
 * Date: 2021/8/1
 * Time: 16:09
 */
public interface WareInfoService extends IService<WareInfoEntity> {

    /**
     * 添加仓库信息
     *
     * @param wareInfoVo 仓库信息
     * @return true：添加成功。false：添加失败
     */
    boolean addWareInfo(WareInfoVo wareInfoVo);

    /**
     * 根据仓库id集合删除仓库信息
     *
     * @param wareId 仓库id字符串，用 ， 隔开的
     * @return true：删除成功。false：删除失败
     */
    boolean deleteWareById(String wareId);

    /**
     * 根据仓库id修改仓库信息
     *
     * @param wareInfoVo 新的仓库信息
     * @return true：修改成功。false：修改失败
     */
    boolean updateWareInfoById(WareInfoVo wareInfoVo);

    /**
     * 分页查询
     *
     * @param wareInfoVo 仓库查询条件
     * @return 返回查询的信息
     */
    PageVo<WareInfoEntity> queryByPage(WareInfoVo wareInfoVo);


}
