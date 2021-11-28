package com.xiaofei.member.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.xiaofei.common.member.entity.MemberEntity;
import com.xiaofei.common.member.entity.MemberReceiveAddressEntity;
import com.xiaofei.common.member.enums.MemberStatusEnum;
import com.xiaofei.common.member.vo.*;
import com.xiaofei.common.order.entity.OrderItemEntity;
import com.xiaofei.common.order.vo.OrderItemQueryVo;
import com.xiaofei.common.order.vo.OrderItemResp;
import com.xiaofei.common.utils.ResponseResult;
import com.xiaofei.common.vo.PageVo;
import com.xiaofei.feign.OrderFeignService;
import com.xiaofei.member.mapper.MemberDao;
import com.xiaofei.member.service.MemberReceiveAddressService;
import com.xiaofei.member.service.MemberService;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
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
    @Autowired
    private OrderFeignService orderFeignService;

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
     * 修改用户信息
     *
     * @param userId         用户id
     * @param username       用户名
     * @param memberUpdateVo 新的用户信息
     * @return true：修改成功。false：修改失败
     */
    @Transactional
    @Override
    public boolean updateMemberInfo(Long userId, String username, MemberUpdateVo memberUpdateVo) {
        MemberEntity memberEntity = new MemberEntity();
        BeanUtils.copyProperties(memberUpdateVo, memberEntity);
        memberEntity.setStatus(null);
        memberEntity.setUsername(null);
        memberEntity.setGrowth(null);
        memberEntity.setIntegration(null);
        memberEntity.setId(userId);
        memberEntity.setLevelId(null);
        return this.updateById(memberEntity);
    }

    /**
     * 修改用户密码
     *
     * @param userId           用户id
     * @param username         用户名
     * @param memberPasswordVo 旧密码和新密码
     * @return true：修改成功。false：修改失败
     */
    @Override
    public boolean updateMemberPassword(Long userId, String username, MemberPasswordVo memberPasswordVo) {
        MemberEntity memberEntity = null;
        if (StringUtils.isEmpty(memberPasswordVo.getOldPassword()) ||
                StringUtils.isEmpty(memberPasswordVo.getPassword()) ||
                StringUtils.isEmpty(memberPasswordVo.getPassword1()) ||
                !memberPasswordVo.getPassword().equals(memberPasswordVo.getPassword1())) {
            return false;
        }

        //用户信息查出为空
        memberEntity = this.getOne(new QueryWrapper<MemberEntity>()
                .eq("id", userId).eq("username", username));
        if (memberEntity == null) {
            return false;
        }
        //旧密码不正确
        BCryptPasswordEncoder passwordEncoder = new BCryptPasswordEncoder();
        boolean matches = passwordEncoder.matches(memberPasswordVo.getOldPassword(),memberEntity.getPassword());
        if (!matches) {
            return false;
        }
        memberEntity.setId(userId);
        memberEntity.setPassword(passwordEncoder.encode(memberPasswordVo.getPassword()));
        return this.updateById(memberEntity);

    }

    /**
     * 修改会员的状态
     *
     * @param memberUpdateVo 修改信息
     * @return true：修改成功。false：修改失败
     */
    @Override
    public boolean updateMemberStatus(MemberUpdateVo memberUpdateVo) {
        MemberStatusEnum memberStatusEnum = MemberStatusEnum.getStatus(memberUpdateVo.getStatus());
        if (memberStatusEnum != null) {
            MemberEntity memberEntity = new MemberEntity();
            BeanUtils.copyProperties(memberUpdateVo, memberEntity);
            memberEntity.setStatus(memberStatusEnum.getStatus());
            return this.update(memberEntity, new QueryWrapper<MemberEntity>().eq("id", memberEntity.getId()));
        } else {
            return false;
        }
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

    /**
     * 查询用户的优惠订单等信息
     *
     * @param userId   用户id
     * @param username 用户名
     */
    @Override
    public MemberPageRespVo queryMemberDetailInfo(Long userId, String username) {
        MemberPageRespVo memberInfoResp = new MemberPageRespVo();

        // 1、查询最近三个订单的信息
        OrderItemQueryVo orderItemQueryVo = new OrderItemQueryVo();
        orderItemQueryVo.setPageNo(1);
        orderItemQueryVo.setPageSize(3);
        ResponseResult<PageVo<OrderItemResp>> orderResp = orderFeignService.queryOrderItemInfo(userId, username, orderItemQueryVo);
        List<OrderItemResp> orderItemResps = orderResp.getData().getItems();
        if (orderResp.getCode() == 200) {
            List<OrderItemEntity> orderItems = new ArrayList<>();
            orderItemResps.forEach(orderItemResp -> orderItems.addAll(orderItemResp.getOrderItemEntitys()));
            memberInfoResp.setOrderItems(orderItems);
        }

        //查询用户信息
        MemberEntity memberEntity = this.getById(userId);
        memberEntity.setPassword("");
        memberInfoResp.setMemberEntity(memberEntity);

        return memberInfoResp;

    }
}
