package com.xiaofei.member.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.xiaofei.common.member.entity.MemberEntity;

/**
 * User: 李飞
 * Date: 2021/8/16
 * Time: 15:57
 */
public interface MemberService extends IService<MemberEntity> {

    /**
     * 通过token获取用户信息
     *
     * @param userId 用户id
     * @return 返回用户信息
     */
    MemberEntity getByToken(Long userId);
}
