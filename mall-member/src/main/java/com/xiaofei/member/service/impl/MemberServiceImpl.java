package com.xiaofei.member.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.xiaofei.common.member.entity.MemberEntity;
import com.xiaofei.member.mapper.MemberDao;
import com.xiaofei.member.service.MemberService;
import org.springframework.stereotype.Service;

/**
 * User: 李飞
 * Date: 2021/8/17
 * Time: 12:47
 */
@Service
public class MemberServiceImpl extends ServiceImpl<MemberDao, MemberEntity> implements MemberService {

    /**
     * 通过token获取用户信息
     *
     * @param userId 用户用户id
     * @return 返回用户信息
     */
    @Override
    public MemberEntity getByToken(Long userId) {
        MemberEntity memberEntity = this.getById(userId);
        memberEntity.setPassword("");//将密码设置为空
        return memberEntity;
    }
}
