package com.xiaofei.order.feign;

import com.xiaofei.common.dto.SkuHasStockDto;
import com.xiaofei.common.exception.OrderException;
import com.xiaofei.common.order.dto.OrderSkuDto;
import com.xiaofei.common.utils.ResponseResult;
import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;

/**
 * User: 李飞
 * Date: 2021/8/21
 * Time: 16:30
 */
@FeignClient("mall-ware")
public interface WareFeignService {

    @GetMapping("/ware/waresku/internal/hasStock")
    ResponseResult<List<SkuHasStockDto>> hasStock(@RequestParam("skuIds") List<Long> skuIds);

    @PutMapping("/ware/waresku/auth/hasStock")
    public ResponseResult<Boolean> updateStock(@RequestBody List<OrderSkuDto> orderSkuDtos)  throws OrderException;

}
