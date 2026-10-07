package com.family.menu.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableLogic;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

import java.io.Serial;
import java.io.Serializable;
import java.time.LocalDateTime;

/**
 * 菜谱
 */
@Data
@TableName("dish")
public class Dish implements Serializable {

    @Serial
    private static final long serialVersionUID = 1L;

    @TableId(type = IdType.AUTO)
    private Long id;

    /** 菜名 */
    private String name;

    /** 分类: 主荤/素菜/汤/凉菜/主食 */
    private String category;

    /** 辣度 0-3 */
    private Integer spicyLevel;

    /** 制作时间(分钟) */
    private Integer cookTime;

    /** 宝宝能吃 */
    private Boolean kidFriendly;

    /** 老人能吃 */
    private Boolean elderFriendly;

    /** 做法描述 */
    private String description;

    /** 标签 */
    private String tags;

    /** 启用 */
    private Boolean isActive;

    /** 排序 */
    private Integer sortOrder;

    /** 创建时间 */
    private LocalDateTime createdAt;

    /** 更新时间 */
    private LocalDateTime updatedAt;

    @TableLogic
    private Integer deleted;
}