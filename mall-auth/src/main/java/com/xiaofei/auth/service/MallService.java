package com.xiaofei.auth.service;

import com.xiaofei.common.auth.vo.MallInfoVo;

import java.util.Map;

/**
 * User: 李飞
 * Date: 2021/8/14
 * Time: 18:01
 */
public interface MallService {

    /**
     * 发送简单的邮件
     *
     * @param mallService 注册用户的信息
     * @return true：发送成功。false：发送失败
     */
    Map<String, Object> sendSimpleEmail(MallInfoVo mallService);


}
