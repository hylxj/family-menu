package com.family.menu.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.family.menu.entity.FamilyMember;
import com.family.menu.exception.BusinessException;
import com.family.menu.common.ResultCode;
import com.family.menu.mapper.FamilyMemberMapper;
import com.family.menu.service.FamilyMemberService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.util.List;

@Slf4j
@Service
@RequiredArgsConstructor
public class FamilyMemberServiceImpl implements FamilyMemberService {

    private final FamilyMemberMapper familyMemberMapper;

    @Override
    public List<FamilyMember> listAll() {
        return familyMemberMapper.selectList(
                new LambdaQueryWrapper<FamilyMember>()
                        .orderByAsc(FamilyMember::getId));
    }

    @Override
    public Long save(FamilyMember member) {
        if (member == null || member.getName() == null || member.getName().isBlank()) {
            throw new BusinessException(ResultCode.PARAM_ERROR, "姓名不能为空");
        }
        if (member.getSpicyMax() == null || member.getSpicyMax() < 0 || member.getSpicyMax() > 3) {
            throw new BusinessException(ResultCode.PARAM_ERROR, "辣度上限必须在 0-3 之间");
        }
        if (member.getIsActive() == null) {
            member.setIsActive(true);
        }
        if (member.getId() == null) {
            familyMemberMapper.insert(member);
            log.info("新增家庭成员: {} ({})", member.getName(), member.getRelation());
        } else {
            familyMemberMapper.updateById(member);
            log.info("更新家庭成员: id={} name={}", member.getId(), member.getName());
        }
        return member.getId();
    }

    @Override
    public void delete(Long id) {
        familyMemberMapper.deleteById(id);
        log.info("删除家庭成员: id={}", id);
    }

    @Override
    public void toggleActive(Long id) {
        FamilyMember m = familyMemberMapper.selectById(id);
        if (m == null) throw new BusinessException(ResultCode.DATA_NOT_FOUND, "成员不存在");
        m.setIsActive(!Boolean.TRUE.equals(m.getIsActive()));
        familyMemberMapper.updateById(m);
    }
}
