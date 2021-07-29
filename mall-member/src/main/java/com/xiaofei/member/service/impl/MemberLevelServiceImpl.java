package com.xiaofei.member.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.xiaofei.common.member.entity.MemberLevelEntity;
import com.xiaofei.common.member.vo.MemberLevelVo;
import com.xiaofei.common.vo.PageVo;
import com.xiaofei.member.mapper.MemberLevelDao;
import com.xiaofei.member.service.MemberLevelService;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.BeanUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * User: 李飞
 * Date: 2021/7/29
 * Time: 21:09
 */
@Service
@Slf4j
public class MemberLevelServiceImpl extends ServiceImpl<MemberLevelDao, MemberLevelEntity> implements MemberLevelService {

    /**
     * 添加会员信息
     *
     * @param memberLevelVo 填写的会员信息
     * @return true：添加成功。false：添加失败
     */
    @Transactional
    @Override
    public boolean addMemberLevel(MemberLevelVo memberLevelVo) {
        MemberLevelEntity memberLevelEntity = new MemberLevelEntity();

        BeanUtils.copyProperties(memberLevelVo, memberLevelEntity);

        return this.save(memberLevelEntity);
    }

    /**
     * 根据会员等级id删除会员等级
     *
     * @param memberLevelIds 会员等级id集合
     * @return true：删除成功。false：删除失败
     */
    @Transactional
    @Override
    public boolean deleteMemberLevelByIds(List<Long> memberLevelIds) {
        //TODO 会员等级删除功能，未完成

        // return this.removeByIds(memberLevelIds);
        return true;
    }

    /**
     * 修改会员等级
     *
     * @param memberLevelVo 新的会员等级信息
     * @return true：修改成功。false：修改失败
     */
    @Transactional

    @Override
    public boolean updateMemberLevel(MemberLevelVo memberLevelVo) {
        //TODO 会员等级的修改未完成

        MemberLevelEntity memberLevelEntity = new MemberLevelEntity();

        BeanUtils.copyProperties(memberLevelVo, memberLevelEntity);

        //return this.updateById(memberLevelEntity);

        return true;
    }

    /**
     * 分页获取会员等级接口
     */
    @Override
    public PageVo<MemberLevelEntity> queryMemberLevelByPage(MemberLevelVo memberLevelVo) {
        PageHelper.startPage(memberLevelVo.getPageNo(), memberLevelVo.getPageSize());

        QueryWrapper<MemberLevelEntity> queryWrapper = new QueryWrapper<>();
        //构造查询条件
        if (!StringUtils.isEmpty(memberLevelVo.getSearchValue())) {
            queryWrapper.eq("name", memberLevelVo.getSearchValue());
        }

        List<MemberLevelEntity> items = this.list(queryWrapper);

        PageInfo<MemberLevelEntity> pageInfo = new PageInfo<>(items);

        return new PageVo<>(pageInfo.getPageNum(), pageInfo.getPageSize(), pageInfo.getPages(), pageInfo.getTotal(), pageInfo.getList());
    }
}
