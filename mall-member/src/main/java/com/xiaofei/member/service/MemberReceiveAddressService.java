package com.xiaofei.member.service;

import com.xiaofei.member.entity.MemberReceiveAddressEntity;
import com.baomidou.mybatisplus.extension.service.IService;
import com.xiaofei.member.vo.MemberReceiveAddressVo;

import java.util.List;
import java.util.concurrent.ExecutionException;

/**
 *
 */
public interface MemberReceiveAddressService extends IService<MemberReceiveAddressEntity> {

    /**
     * 添加收获地址
     *
     * @param userId                 用户id
     * @param memberReceiveAddressVo 收获地址信息
     * @return true：添加成功。false：添加失败
     */
    boolean addReceiveAddress(Long userId, MemberReceiveAddressVo memberReceiveAddressVo) throws ExecutionException, InterruptedException;

    /**
     * 修改收货地址
     * @param memberReceiveAddressVo 新的收获地址信息
     * @return true：修改成功。false：修改失败
     */
    boolean updateAddress(MemberReceiveAddressVo memberReceiveAddressVo);

    /**
     * 根据id和用户id删除收货地址
     *
     * @param id     收货地址id
     * @param userId 用户id
     * @return true：删除成功。false：删除失败
     */
    boolean deleteReceiveAddressById(Integer id, Long userId);

    /**
     * 获取用户的所有收获地址
     *
     * @param userId 用户id
     * @return 返回指定用户的收获地址
     */
    List<MemberReceiveAddressEntity> getReceiveAddress(Long userId);

    /**
     * 根据用户id和收获地址id查询收获地址信息
     *
     * @param id     收获地址id
     * @param userId 用户id
     * @return 返回查询的收获地址信息
     */
    MemberReceiveAddressEntity getReceiveAddressById(Integer id, Long userId);

}
