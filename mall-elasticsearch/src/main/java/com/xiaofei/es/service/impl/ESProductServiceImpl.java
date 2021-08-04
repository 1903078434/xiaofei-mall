package com.xiaofei.es.service.impl;

import com.xiaofei.common.dto.SkuESDto;
import com.xiaofei.es.entity.Product;
import com.xiaofei.es.repository.ESProductRepository;
import com.xiaofei.es.service.ESProductService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;

/**
 * User: 李飞
 * Date: 2021/8/4
 * Time: 18:40
 */
@Service
@Slf4j
public class ESProductServiceImpl implements ESProductService {

    @Autowired
    private ESProductRepository productRepository;

    /**
     * 将商品信息保存到ES中
     *
     * @param skuESDtos 商品信息
     * @return true：保存成功。false：保存失败
     */
    @Override
    public boolean saveProduct(List<SkuESDto> skuESDtos) {
        try {
            List<Product> products = skuESDtos.stream().map(skuESDto -> {
                Product product = new Product();
                BeanUtils.copyProperties(skuESDto, product);
                return product;
            }).collect(Collectors.toList());
            productRepository.saveAll(products);
        } catch (Exception e) {
            log.error("ES保存商品失败，错误信息为：{}", e);
            return false;
        }
        return true;
    }
}
