package com.xiaofei.member.service;


import com.baomidou.mybatisplus.extension.service.IService;
import com.xiaofei.common.member.entity.MemberLevelEntity;
import com.xiaofei.common.member.vo.MemberLevelVo;
import com.xiaofei.common.vo.PageVo;

import java.util.List;

/**
 * 会员等级
 *
 * @author xiaofei
 * @email 1903078434@qq.com
 * @date 2021-07-27 13:32:34
 */
public interface MemberLevelService extends IService<MemberLevelEntity> {
    /**
     * 添加会员信息
     *
     * @param memberLevelVo 填写的会员信息
     * @return true：添加成功。false：添加失败
     */
    boolean addMemberLevel(MemberLevelVo memberLevelVo);

    /**
     * 根据会员等级id删除会员等级
     *
     * @param memberLevelIds 会员等级id集合
     * @return true：删除成功。false：删除失败
     */
    boolean deleteMemberLevelByIds(List<Long> memberLevelIds);

    /**
     * 修改会员等级
     *
     * @param memberLevelVo 新的会员等级信息
     * @return true：修改成功。false：修改失败
     */
    boolean updateMemberLevel(MemberLevelVo memberLevelVo);

    /**
     * 分页获取会员等级接口
     */
    PageVo<MemberLevelEntity> queryMemberLevelByPage(MemberLevelVo memberLevelVo);

}

