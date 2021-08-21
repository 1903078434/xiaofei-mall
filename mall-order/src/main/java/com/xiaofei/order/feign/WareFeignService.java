package com.xiaofei.order.feign;

import com.xiaofei.common.dto.SkuHasStockDto;
import com.xiaofei.common.utils.ResponseResult;
import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.GetMapping;
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

}
