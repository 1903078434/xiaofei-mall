package com.xiaofei.auth.exception;

/**
 * User: 李飞
 * Date: 2021/8/14
 * Time: 21:43
 */
public class LoginException extends Exception {
    public LoginException() {
        super();
    }

    //用详细信息指定一个异常
    public LoginException(String message) {
        super(message);
    }

    //用指定的详细信息和原因构造一个新的异常
    public LoginException(String message, Throwable cause) {
        super(message, cause);
    }

    //用指定原因构造一个新的异常
    public LoginException(Throwable cause) {
        super(cause);
    }
}
