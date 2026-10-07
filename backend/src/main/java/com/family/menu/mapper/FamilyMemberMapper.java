package com.family.menu.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.family.menu.entity.FamilyMember;
import org.apache.ibatis.annotations.Mapper;

/**
 * 家庭成员 Mapper
 */
@Mapper
public interface FamilyMemberMapper extends BaseMapper<FamilyMember> {
}