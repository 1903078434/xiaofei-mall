package com.xiaofei.auth.exception;

import com.xiaofei.common.utils.ResponseResult;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 * User: 李飞
 * Date: 2021/8/14
 * Time: 21:45
 */
@ControllerAdvice
@Slf4j
public class GlobalExceptionHandler {

    @ExceptionHandler(LoginException.class)
    @ResponseBody
    public ResponseResult<Object> error(LoginException e) {
        log.error("用户登录的错误信息为：{}", e.getMessage());
        return new ResponseResult<>().error(500, e.getMessage());
    }
}
