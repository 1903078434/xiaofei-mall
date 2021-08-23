package com.xiaofei.common.exception;

import com.xiaofei.common.utils.ResponseResult;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.security.auth.login.LoginException;

/**
 * 自定义异常类
 * User: 李飞
 * Date: 2021/8/14
 * Time: 21:45
 */
@ControllerAdvice
@Slf4j
public class GlobalExceptionHandler {

    @ExceptionHandler(Exception.class)
    @ResponseBody
    public ResponseResult<Object> maxException(LoginException e) {
        log.error("异常信息为：{}", e.getMessage());
        //未经授权的权限为401
        return new ResponseResult<>().error(500, "系统未知错误");
    }

    @ExceptionHandler(MallLoginException.class)
    @ResponseBody
    public ResponseResult<Object> mallException(LoginException e) {
        log.error("用户登录的错误信息为：{}", e.getMessage());
        //未经授权的权限为401
        return new ResponseResult<>().error(HttpStatus.UNAUTHORIZED.value(), e.getMessage());
    }

    @ExceptionHandler(MallCartException.class)
    @ResponseBody
    public ResponseResult<Object> cartException(MallCartException e) {
        log.error("用户登录的错误信息为：{}", e.getMessage());
        //未经授权的权限为401
        return new ResponseResult<>().error(503, e.getMessage());
    }

    @ExceptionHandler(OrderException.class)
    @ResponseBody
    public ResponseResult<Object> orderException(MallCartException e) {
        log.error("订单错误信息为：{}", e.getMessage());
        //未经授权的权限为401
        return new ResponseResult<>().error(415, e.getMessage());
    }
}
