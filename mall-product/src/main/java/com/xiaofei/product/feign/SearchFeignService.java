package com.xiaofei.product.feign;

import com.xiaofei.common.dto.SkuESDto;
import com.xiaofei.common.utils.ResponseResult;
import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;

import java.util.List;

/**
 * User: 李飞
 * Date: 2021/8/4
 * Time: 18:38
 */
@FeignClient("mall-elasticsearch")
public interface SearchFeignService {

    /**
     * 商品上架
     */
    @PostMapping("/elasticsearch/product")
    public ResponseResult<Boolean> addProduct(@RequestBody List<SkuESDto> skuESDtos);
}
