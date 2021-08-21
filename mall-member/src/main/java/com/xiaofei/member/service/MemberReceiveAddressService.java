package com.xiaofei.member.service;

import com.xiaofei.member.entity.MemberReceiveAddressEntity;
import com.baomidou.mybatisplus.extension.service.IService;
import com.xiaofei.member.vo.MemberReceiveAddressVo;

import java.util.List;

/**
 *
 */
public interface MemberReceiveAddressService extends IService<MemberReceiveAddressEntity> {


    /**
     * 添加收获地址
     *
     *
     * @param userId 用户id
     * @param memberReceiveAddressVo 收获地址信息
     * @return true：添加成功。false：添加失败
     */
    boolean addReceiveAddress(Long userId, MemberReceiveAddressVo memberReceiveAddressVo);

    /**
     * 获取用户的所有收获地址
     *
     * @param userId 用户id
     * @return 返回指定用户的收获地址
     */
    List<MemberReceiveAddressEntity> getReceiveAddress(Long userId);
}
