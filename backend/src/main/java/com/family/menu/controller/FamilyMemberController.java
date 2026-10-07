package com.family.menu.controller;

import com.family.menu.common.Result;
import com.family.menu.entity.FamilyMember;
import com.family.menu.service.FamilyMemberService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * 家庭成员 Controller
 */
@Slf4j
@RestController
@RequestMapping("/members")
@RequiredArgsConstructor
public class FamilyMemberController {

    private final FamilyMemberService familyMemberService;

    @GetMapping
    public Result<List<FamilyMember>> list() {
        return Result.success(familyMemberService.listAll());
    }

    @PostMapping
    public Result<Long> save(@RequestBody FamilyMember member) {
        return Result.success(familyMemberService.save(member));
    }

    @PutMapping("/{id}")
    public Result<Long> update(@PathVariable Long id, @RequestBody FamilyMember member) {
        member.setId(id);
        return Result.success(familyMemberService.save(member));
    }

    @DeleteMapping("/{id}")
    public Result<Void> delete(@PathVariable Long id) {
        familyMemberService.delete(id);
        return Result.success();
    }

    @PostMapping("/{id}/toggle")
    public Result<Void> toggle(@PathVariable Long id) {
        familyMemberService.toggleActive(id);
        return Result.success();
    }
}