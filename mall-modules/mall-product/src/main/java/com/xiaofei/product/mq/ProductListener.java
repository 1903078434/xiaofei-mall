package com.xiaofei.product.mq;

import com.xiaofei.common.constant.MQConstants;
import com.xiaofei.product.service.SpuInfoService;
import org.springframework.amqp.core.ExchangeTypes;
import org.springframework.amqp.rabbit.annotation.Exchange;
import org.springframework.amqp.rabbit.annotation.Queue;
import org.springframework.amqp.rabbit.annotation.QueueBinding;
import org.springframework.amqp.rabbit.annotation.RabbitListener;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.io.IOException;

/**
 * User: 李飞
 * Date: 2021/11/26
 * Time: 16:35
 */
@Component
public class ProductListener {
    @Autowired
    private SpuInfoService spuInfoService;

    /**
     * 监听酒店新增或修改的业务
     *
     * @param skuId 商品id
     */
//    @RabbitListener(queues = MqConstants.PRODUCT_INSERT_QUEUE)//使用此方法需要配合配置类绑定交换机一起使用
    @RabbitListener(bindings = @QueueBinding(
            value = @Queue(name = MQConstants.PRODUCT_INSERT_QUEUE),
            exchange = @Exchange(name = MQConstants.PRODUCT_EXCHANGE, type = ExchangeTypes.DIRECT),
            key = MQConstants.PRODUCT_INSERT_KEY
    ))
    public void listenSkuUp(Long skuId) throws IOException {
        spuInfoService.spuUp(skuId);
    }

    /**
     * 监听酒店删除的业务
     *
     * @param id 酒店id
     */
//    @RabbitListener(queues = MqConstants.PRODUCT_DELETE_QUEUE)//使用此方法需要配合配置类绑定交换机一起使用
/*    @RabbitListener(bindings = @QueueBinding(
            value = @Queue(name = MQConstants.PRODUCT_DELETE_QUEUE),
            exchange = @Exchange(name = MQConstants.PRODUCT_EXCHANGE, type = ExchangeTypes.DIRECT),
            key = MQConstants.PRODUCT_DELETE_KEY
    ))
    public void listenSkuDelete(Long id) throws IOException {
        productService.
    }*/
}
