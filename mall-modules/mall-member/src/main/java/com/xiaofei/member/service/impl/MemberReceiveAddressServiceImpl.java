package com.xiaofei.member.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.xiaofei.common.product.entity.ProvincesEntity;
import com.xiaofei.common.utils.ResponseResult;
import com.xiaofei.common.member.entity.MemberReceiveAddressEntity;
import com.xiaofei.feign.ProductFeignService;
import com.xiaofei.member.mapper.MemberReceiveAddressMapper;
import com.xiaofei.member.service.MemberReceiveAddressService;
import com.xiaofei.member.vo.MemberReceiveAddressVo;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.concurrent.CompletableFuture;
import java.util.concurrent.ExecutionException;
import java.util.concurrent.ThreadPoolExecutor;

/**
 *
 */
@Service
public class MemberReceiveAddressServiceImpl extends ServiceImpl<MemberReceiveAddressMapper, MemberReceiveAddressEntity> implements MemberReceiveAddressService {

    @Autowired
    private ProductFeignService productFeignService;
    @Autowired
    private ThreadPoolExecutor threadPoolExecutor;

    /**
     * 添加收获地址
     *
     * @param userId                 用户id
     * @param memberReceiveAddressVo 收获地址信息
     * @return true：添加成功。false：添加失败
     */
    @Override
    public boolean addReceiveAddress(Long userId, MemberReceiveAddressVo memberReceiveAddressVo) throws ExecutionException, InterruptedException {

        MemberReceiveAddressEntity memberReceiveAddressEntity = new MemberReceiveAddressEntity();

        //远程调用地区信息
        CompletableFuture<Void> getProvinces = CompletableFuture.runAsync(() -> {
            //远程调用，获取地区信息
            ResponseResult<ProvincesEntity> resp = productFeignService.queryProvincesById(memberReceiveAddressVo.getProvincesId());
            ProvincesEntity provincesEntity = resp.getData();
            //设置地区信息
            String[] split = provincesEntity.getMergerName().split(",");
            memberReceiveAddressEntity.setProvince(split[1]);
            memberReceiveAddressEntity.setCity(split[2]);
            memberReceiveAddressEntity.setRegion(split[3]);
            memberReceiveAddressEntity.setAreacode(provincesEntity.getCityCode());
            memberReceiveAddressEntity.setPostCode(provincesEntity.getZipCode());
        }, threadPoolExecutor);

        //查询是否有默认地址
        CompletableFuture<Void> setOther = CompletableFuture.runAsync(() -> {
            BeanUtils.copyProperties(memberReceiveAddressVo, memberReceiveAddressEntity);
            memberReceiveAddressEntity.setProvincesId(memberReceiveAddressVo.getProvincesId());
            //查询当前用户是否有了默认收获地址，如果没有默认收获地址，则设置为默认收获地址
            List<MemberReceiveAddressEntity> address = this.list(new QueryWrapper<MemberReceiveAddressEntity>().eq("member_id", userId)
                    .eq("default_status", true));
            memberReceiveAddressEntity.setDefaultStatus(address.size() == 0 ? 1 : 0);
            memberReceiveAddressEntity.setMemberId(userId);
        }, threadPoolExecutor);

        CompletableFuture.allOf(getProvinces, setOther).get();

        return this.save(memberReceiveAddressEntity);
    }

    /**
     * 修改收货地址
     *
     * @param memberReceiveAddressVo 新的收获地址信息
     * @return true：修改成功。false：修改失败
     */
    @Override
    public boolean updateAddress(MemberReceiveAddressVo memberReceiveAddressVo) {
        MemberReceiveAddressEntity memberReceiveAddressEntity = new MemberReceiveAddressEntity();

        MemberReceiveAddressEntity entity = queryProvincesById(memberReceiveAddressVo.getProvincesId());
        BeanUtils.copyProperties(memberReceiveAddressVo,entity);

        BeanUtils.copyProperties(entity, memberReceiveAddressEntity);

        return this.updateById(memberReceiveAddressEntity);
    }

    /**
     * 根据id和用户id删除收货地址
     *
     * @param id     收货地址id
     * @param userId 用户id
     * @return true：删除成功。false：删除失败
     */
    @Override
    public boolean deleteReceiveAddressById(Integer id, Long userId) {
        return this.remove(new QueryWrapper<MemberReceiveAddressEntity>().eq("id", id).eq("member_id", userId));
    }

    /**
     * 获取用户的所有收获地址
     *
     * @param userId 用户id
     * @return 返回指定用户的收获地址
     */
    @Override
    public List<MemberReceiveAddressEntity> getReceiveAddress(Long userId) {
        return this.list(new QueryWrapper<MemberReceiveAddressEntity>().eq("member_id", userId));
    }

    /**
     * 根据用户id和收获地址id查询收获地址信息
     *
     * @param id     收获地址id
     * @param userId 用户id
     * @return 返回查询的收获地址信息
     */
    @Override
    public MemberReceiveAddressEntity getReceiveAddressById(Integer id, Long userId) {
        MemberReceiveAddressEntity memberReceiveAddressEntity = this.getOne(new QueryWrapper<MemberReceiveAddressEntity>()
                .eq("id", id).eq("member_id", userId));

        //远程调用获取地区的全路径信息
        ResponseResult<List<Integer>> resp = productFeignService.findProvincesPath(memberReceiveAddressEntity.getProvincesId());
        memberReceiveAddressEntity.setProvincesPath(resp.getData());

        return memberReceiveAddressEntity;
    }

    /**
     * 远程调用，获取地区信息
     */
    private MemberReceiveAddressEntity queryProvincesById(Integer provincesId) {
        MemberReceiveAddressEntity memberReceiveAddressEntity = new MemberReceiveAddressEntity();
        ResponseResult<ProvincesEntity> resp = productFeignService.queryProvincesById(provincesId);
        ProvincesEntity provincesEntity = resp.getData();
        //设置地区信息
        String[] split = provincesEntity.getMergerName().split(",");
        memberReceiveAddressEntity.setProvince(split[1]);
        memberReceiveAddressEntity.setCity(split[2]);
        memberReceiveAddressEntity.setRegion(split[3]);
        memberReceiveAddressEntity.setAreacode(provincesEntity.getCityCode());
        memberReceiveAddressEntity.setPostCode(provincesEntity.getZipCode());

        return memberReceiveAddressEntity;
    }


}




