package com.xiaofei.member.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.xiaofei.common.product.entity.ProvincesEntity;
import com.xiaofei.common.utils.ResponseResult;
import com.xiaofei.member.entity.MemberReceiveAddressEntity;
import com.xiaofei.member.feign.ProductFeign;
import com.xiaofei.member.service.MemberReceiveAddressService;
import com.xiaofei.member.mapper.MemberReceiveAddressMapper;
import com.xiaofei.member.vo.MemberReceiveAddressVo;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 *
 */
@Service
public class MemberReceiveAddressServiceImpl extends ServiceImpl<MemberReceiveAddressMapper, MemberReceiveAddressEntity> implements MemberReceiveAddressService {

    @Autowired
    private ProductFeign productFeign;

    /**
     * 添加收获地址
     *
     * @param userId                 用户id
     * @param memberReceiveAddressVo 收获地址信息
     * @return true：添加成功。false：添加失败
     */
    @Override
    public boolean addReceiveAddress(Long userId, MemberReceiveAddressVo memberReceiveAddressVo) {
        ResponseResult<ProvincesEntity> resp = productFeign.queryProvincesById(memberReceiveAddressVo.getProvincesId());
        ProvincesEntity provincesEntity = resp.getData();

        MemberReceiveAddressEntity memberReceiveAddressEntity = new MemberReceiveAddressEntity();

        BeanUtils.copyProperties(memberReceiveAddressVo, memberReceiveAddressEntity);

        String[] split = provincesEntity.getMergerName().split(",");
        memberReceiveAddressEntity.setProvince(split[1]);
        memberReceiveAddressEntity.setCity(split[2]);
        memberReceiveAddressEntity.setRegion(split[3]);
        //查询当前用户是否有了默认收获地址，如果没有默认收获地址，则设置为默认收获地址
        List<MemberReceiveAddressEntity> address = this.list(new QueryWrapper<MemberReceiveAddressEntity>().eq("member_id", userId)
                .eq("default_status", true));
        memberReceiveAddressEntity.setDefaultStatus(address.size() == 0 ? 1 : 0);
        memberReceiveAddressEntity.setMemberId(userId);
        memberReceiveAddressEntity.setAreacode(provincesEntity.getCityCode());
        memberReceiveAddressEntity.setPostCode(provincesEntity.getZipCode());
        return this.save(memberReceiveAddressEntity);
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
}




