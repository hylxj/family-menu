package com.family.menu.service;

import com.family.menu.entity.FamilyMember;

import java.util.List;

/**
 * 家庭成员 Service
 */
public interface FamilyMemberService {

    /** 查询所有家庭成员（含已禁用的） */
    List<FamilyMember> listAll();

    /** 保存或更新（id 为空则新增） */
    Long save(FamilyMember member);

    /** 逻辑删除 */
    void delete(Long id);

    /** 切换启用/禁用 */
    void toggleActive(Long id);
}
