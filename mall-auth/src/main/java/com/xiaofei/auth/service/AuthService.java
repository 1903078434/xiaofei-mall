package com.xiaofei.auth.service;

import com.ruoyi.common.core.exception.mall.MallLoginException;
import com.xiaofei.auth.vo.UserInfoVo;

import java.util.Map;

/**
 * User: 李飞
 * Date: 2021/12/22
 * Time: 13:48
 */
public interface AuthService {
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

    /**
     * 发送简单的邮件
     *
     * @param registerEmail 注册的邮箱
     * @return true：发送成功。false：发送失败
     */
    Map<String, Object> sendSimpleEmail(String registerEmail);

}
