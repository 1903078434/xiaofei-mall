package com.xiaofei.common.constant;

/**
 * User: 李飞
 * Date: 2021/11/26
 * Time: 16:32
 */
public class MQConstants {
    /**
     * 交换机
     */
    public final static String PRODUCT_EXCHANGE = "product.topic";
    /**
     * 监听新增和修改队列
     */
    public final static String PRODUCT_INSERT_QUEUE = "product.insert.queue";
    /**
     * 监听删除的队列
     */
    public final static String PRODUCT_DELETE_QUEUE = "product.delete.queue";
    /**
     * 新增或修改的RoutingKey
     */
    public final static String PRODUCT_INSERT_KEY = "product.insert";
    /**
     * 删除的RoutingKey
     */
    public final static String PRODUCT_DELETE_KEY = "product.delete";
}
