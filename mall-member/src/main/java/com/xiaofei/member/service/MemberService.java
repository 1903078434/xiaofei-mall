package com.xiaofei.member.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.xiaofei.common.member.entity.MemberEntity;
import com.xiaofei.common.member.vo.MemberQueryRespVo;
import com.xiaofei.common.member.vo.MemberQueryVo;
import com.xiaofei.common.vo.PageVo;

/**
 * User: 李飞
 * Date: 2021/8/16
 * Time: 15:57
 */
public interface MemberService extends IService<MemberEntity> {

    /**
     * 通过token获取用户信息
     *
     * @param userId 用户id
     * @return 返回用户信息
     */
    MemberEntity getByToken(Long userId);

    /**
     * 分页查询会员信息和会员的收获地址
     *
     * @param memberQueryVo 会员信息查询条件
     * @return 返回查询的会员信息
     */
    PageVo<MemberQueryRespVo> queryMemberByPage(MemberQueryVo memberQueryVo);
}
