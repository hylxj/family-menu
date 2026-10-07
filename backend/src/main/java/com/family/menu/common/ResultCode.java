package com.family.menu.common;

import lombok.Getter;

/**
 * 返回码枚举
 */
@Getter
public enum ResultCode {

    SUCCESS(200, "成功"),
    FAIL(500, "失败"),
    PARAM_ERROR(400, "参数错误"),
    UNAUTHORIZED(401, "未授权"),
    FORBIDDEN(403, "禁止访问"),
    NOT_FOUND(404, "资源不存在"),

    BUSINESS_ERROR(1000, "业务异常"),
    DATA_NOT_FOUND(1001, "数据不存在"),
    DATA_EXISTS(1002, "数据已存在");

    private final Integer code;
    private final String message;

    ResultCode(Integer code, String message) {
        this.code = code;
        this.message = message;
    }
}