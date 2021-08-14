package com.xiaofei.auth.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.xiaofei.auth.exception.LoginException;
import com.xiaofei.common.auth.entity.MemberEntity;
import com.xiaofei.common.auth.vo.UserLoginVo;

import java.util.Map;

/**
 * User: 李飞
 * Date: 2021/8/14
 * Time: 21:22
 */
public interface MemberService extends IService<MemberEntity> {

    /**
     * 用户登录
     *
     * @param userLoginVo 用户登录信息
     * @return 返回用户名和token
     */
    Map<String, Object> memberLogin(UserLoginVo userLoginVo) throws LoginException;
}

