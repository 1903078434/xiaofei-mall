package com.xiaofei.common.exception;

import org.springframework.stereotype.Component;

/**
 * User: 李飞
 * Date: 2021/8/19
 * Time: 13:31
 */
@Component
public class MallCartException extends Exception {
    public MallCartException() {
        super();
    }

    //用详细信息指定一个异常
    public MallCartException(String message) {
        super(message);
    }

    //用指定的详细信息和原因构造一个新的异常
    public MallCartException(String message, Throwable cause) {
        super(message, cause);
    }

    //用指定原因构造一个新的异常
    public MallCartException(Throwable cause) {
        super(cause);
    }
}
