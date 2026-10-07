package com.family.menu.exception;

import cn.hutool.core.util.StrUtil;
import com.family.menu.common.Result;
import com.family.menu.common.ResultCode;
import jakarta.servlet.http.HttpServletRequest;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.validation.BindException;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.MethodArgumentNotValidException;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;

import java.util.stream.Collectors;

/**
 * 全局异常处理
 */
@Slf4j
@RestControllerAdvice
public class GlobalExceptionHandler {

    /** 业务异常 */
    @ExceptionHandler(BusinessException.class)
    public Result<Void> handleBusinessException(BusinessException e, HttpServletRequest request) {
        log.warn("业务异常 [{}]: {}", request.getRequestURI(), e.getMessage());
        return Result.fail(e.getCode(), e.getMessage());
    }

    /** 参数校验异常 */
    @ExceptionHandler(MethodArgumentNotValidException.class)
    public Result<Void> handleValidException(MethodArgumentNotValidException e) {
        String msg = e.getBindingResult().getFieldErrors().stream()
                .map(FieldError::getDefaultMessage)
                .collect(Collectors.joining("; "));
        log.warn("参数校验失败: {}", msg);
        return Result.fail(ResultCode.PARAM_ERROR.getCode(), msg);
    }

    /** 表单绑定异常 */
    @ExceptionHandler(BindException.class)
    public Result<Void> handleBindException(BindException e) {
        String msg = e.getBindingResult().getFieldErrors().stream()
                .map(FieldError::getDefaultMessage)
                .collect(Collectors.joining("; "));
        return Result.fail(ResultCode.PARAM_ERROR.getCode(), msg);
    }

    /** 非法参数 */
    @ExceptionHandler(IllegalArgumentException.class)
    public Result<Void> handleIllegalArgument(IllegalArgumentException e) {
        return Result.fail(ResultCode.PARAM_ERROR.getCode(), e.getMessage());
    }

    /** 空指针 */
    @ExceptionHandler(NullPointerException.class)
    public ResponseEntity<Result<Void>> handleNPE(NullPointerException e, HttpServletRequest request) {
        log.error("空指针异常 [{}]", request.getRequestURI(), e);
        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                .body(Result.fail("系统异常: 空指针"));
    }

    /** 兜底 */
    @ExceptionHandler(Exception.class)
    public Result<Void> handleException(Exception e, HttpServletRequest request) {
        log.error("系统异常 [{}]", request.getRequestURI(), e);
        String msg = StrUtil.isNotBlank(e.getMessage()) ? e.getMessage() : "系统繁忙";
        return Result.fail(ResultCode.FAIL.getCode(), msg);
    }
}