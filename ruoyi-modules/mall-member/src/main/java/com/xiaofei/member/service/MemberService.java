package com.xiaofei.member.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.xiaofei.common.member.entity.MemberEntity;
import com.xiaofei.common.member.vo.*;
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
     * 修改会员的状态
     *
     * @param memberUpdateVo 修改信息
     * @return true：修改成功。false：修改失败
     */
    boolean updateMemberStatus(MemberUpdateVo memberUpdateVo);

    /**
     * 修改用户密码
     *
     * @param userId           用户id
     * @param username         用户名
     * @param memberPasswordVo 旧密码和新密码
     * @return true：修改成功。false：修改失败
     */
    boolean updateMemberPassword(Long userId, String username, MemberPasswordVo memberPasswordVo);

    /**
     * 修改用户信息
     *
     * @param userId         用户id
     * @param username       用户名
     * @param memberUpdateVo 新的用户信息
     * @return true：修改成功。false：修改失败
     */
    boolean updateMemberInfo(Long userId, String username, MemberUpdateVo memberUpdateVo);

    /**
     * 分页查询会员信息和会员的收获地址
     *
     * @param memberQueryVo 会员信息查询条件
     * @return 返回查询的会员信息
     */
    PageVo<MemberQueryRespVo> queryMemberByPage(MemberQueryVo memberQueryVo);

    /**
     * 查询用户的优惠订单等信息
     *
     * @param userId   用户id
     * @param username 用户名
     */
    MemberPageRespVo queryMemberDetailInfo(Long userId, String username);

}
