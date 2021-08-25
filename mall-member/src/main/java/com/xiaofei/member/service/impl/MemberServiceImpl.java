package com.xiaofei.member.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.xiaofei.common.member.entity.MemberEntity;
import com.xiaofei.common.member.entity.MemberReceiveAddressEntity;
import com.xiaofei.common.member.vo.MemberQueryRespVo;
import com.xiaofei.common.member.vo.MemberQueryVo;
import com.xiaofei.common.vo.PageVo;
import com.xiaofei.member.mapper.MemberDao;
import com.xiaofei.member.service.MemberReceiveAddressService;
import com.xiaofei.member.service.MemberService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;

/**
 * User: 李飞
 * Date: 2021/8/17
 * Time: 12:47
 */
@Service
public class MemberServiceImpl extends ServiceImpl<MemberDao, MemberEntity> implements MemberService {

    @Autowired
    private MemberReceiveAddressService memberReceiveAddressService;

    /**
     * 通过token获取用户信息
     *
     * @param userId 用户用户id
     * @return 返回用户信息
     */
    @Override
    public MemberEntity getByToken(Long userId) {
        MemberEntity memberEntity = this.getById(userId);
        memberEntity.setPassword("");//将密码设置为空
        return memberEntity;
    }

    /**
     * 分页查询会员信息和会员的收获地址
     *
     * @param memberQueryVo 会员信息查询条件
     * @return 返回查询的会员信息
     */
    @Override
    public PageVo<MemberQueryRespVo> queryMemberByPage(MemberQueryVo memberQueryVo) {
        //先查询用户信息 ====> 再通过用户信息查询用户的收货地址
        PageHelper.startPage(memberQueryVo.getPageNo(), memberQueryVo.getPageSize());

        //TODO 查询条件后面再做
        QueryWrapper<MemberQueryRespVo> queryWrapper = new QueryWrapper<>();

        List<MemberEntity> memberEntitys = this.list();

        PageInfo<MemberEntity> pageInfo = new PageInfo<>(memberEntitys);

        List<MemberQueryRespVo> items = pageInfo.getList().stream().map(memberEntity -> {
            MemberQueryRespVo memberQueryRespVo = new MemberQueryRespVo();

            //查询收获地址信息
            List<MemberReceiveAddressEntity> addressEntities = memberReceiveAddressService.list(new QueryWrapper<MemberReceiveAddressEntity>().eq("member_id", memberEntity.getId()));
            memberQueryRespVo.setMemberEntity(memberEntity);
            memberQueryRespVo.setMemberReceiveAddressEntitys(addressEntities);

            return memberQueryRespVo;
        }).collect(Collectors.toList());

        PageVo<MemberQueryRespVo> page = new PageVo<>(pageInfo.getPageNum(), pageInfo.getPageSize(), pageInfo.getPages(), pageInfo.getTotal());
        page.setItems(items);
        return page;
    }
}
