package com.xiaofei.product.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.xiaofei.common.product.constant.HomeAdvEntity;
import com.xiaofei.common.product.vo.AdvQueryVo;
import com.xiaofei.common.product.vo.HomeRespVo;
import com.xiaofei.common.vo.PageVo;

import java.util.concurrent.ExecutionException;

/**
 *
 */
public interface HomeAdvService extends IService<HomeAdvEntity> {
    /**
     * 添加
     *
     * @param homeAdv 广告信息
     * @return true：添加成功。false：添加失败
     */
    Boolean insertHomeAdv(HomeAdvEntity homeAdv);

    /**
     * 修改
     *
     * @param homeAdv 广告信息
     * @return true：成功。false：失败
     */
    Boolean updateHomeAdv(HomeAdvEntity homeAdv);

    /**
     * 删除
     *
     * @param advIds id集合
     * @return true：成功。false：失败
     */
    Boolean removeHomeAdv(Long[] advIds);

    /**
     * 根据查询条件
     *
     * @param advQueryVo 查询条件
     * @return 返回查询好的分页信息
     */
    PageVo<HomeAdvEntity> queryByPage(AdvQueryVo advQueryVo);

    /**
     * 首页广告资源加载
     *
     * @return 返回广告
     */
    HomeRespVo queryAdvInfo() throws ExecutionException, InterruptedException;


}
