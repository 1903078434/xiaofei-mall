package com.ruoyi.common.core.exception.mall;

import org.springframework.stereotype.Component;

/**
 * User: 李飞
 * Date: 2021/8/23
 * Time: 21:31
 */
public class OrderException extends Exception {

    public OrderException() {
        super();
    }

    //用详细信息指定一个异常
    public OrderException(String message) {
        super(message);
    }

    //用指定的详细信息和原因构造一个新的异常
    public OrderException(String message, Throwable cause) {
        super(message, cause);
    }

    //用指定原因构造一个新的异常
    public OrderException(Throwable cause) {
        super(cause);
    }

}
