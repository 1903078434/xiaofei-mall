package com.xiaofei.feign;

import com.ruoyi.common.core.constant.SecurityConstants;
import com.xiaofei.common.order.vo.OrderItemQueryVo;
import com.xiaofei.common.order.vo.OrderItemResp;
import com.xiaofei.common.utils.ResponseResult;
import com.xiaofei.common.vo.PageVo;
import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestHeader;

/**
 * User: 李飞
 * Date: 2021/11/27
 * Time: 15:40
 */
@FeignClient("mall-order")
public interface OrderFeignService {
    /**
     * 分页查询订单信息
     *
     * @param orderItemQueryVo 查询条件
     */
    @GetMapping("/order/orderitem/auth/orderitems")
    ResponseResult<PageVo<OrderItemResp>> queryOrderItemInfo(@RequestHeader(name = SecurityConstants.DETAILS_USER_ID) Long userId,
                                                             @RequestHeader(name = SecurityConstants.DETAILS_USERNAME) String username,
                                                             OrderItemQueryVo orderItemQueryVo);
}
