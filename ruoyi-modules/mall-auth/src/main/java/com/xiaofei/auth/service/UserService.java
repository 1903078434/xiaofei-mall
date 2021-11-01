package com.xiaofei.auth.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.ruoyi.common.core.exception.mall.MallLoginException;
import com.xiaofei.common.auth.entity.MemberEntity;
import com.xiaofei.common.auth.vo.UserInfoVo;

import java.util.Map;

/**
 * User: 李飞
 * Date: 2021/8/14
 * Time: 21:22
 */
public interface UserService extends IService<MemberEntity> {

    /**
     * 用户注册
     *
     * @param userInfoVo 用户注册信息
     * @return 返回用户注册是否成功
     */
    Map<String, Object> userRegister(UserInfoVo userInfoVo);

    /**
     * 用户登录
     *
     * @param userInfoVo 用户登录信息
     * @return 返回用户名和token
     */
    Map<String, Object> userLogin(UserInfoVo userInfoVo) throws MallLoginException;

    /**
     * 退出登录
     *
     * @param username 用户名
     * @return 返回退出信息
     */
    Map<String, Object> loginOut(String username);
}

