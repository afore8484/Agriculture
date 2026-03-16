package com.agriculture.villagefinance.framework.web;

import com.agriculture.villagefinance.common.pojo.CommonResult;
import org.springframework.web.bind.MethodArgumentNotValidException;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;

@RestControllerAdvice
public class GlobalExceptionHandler {

    @ExceptionHandler({IllegalArgumentException.class, IllegalStateException.class})
    public CommonResult<Void> handleBizException(RuntimeException ex) {
        return CommonResult.error(400, ex.getMessage());
    }

    @ExceptionHandler(MethodArgumentNotValidException.class)
    public CommonResult<Void> handleValidationException(MethodArgumentNotValidException ex) {
        String message = ex.getBindingResult().getAllErrors().stream()
                .findFirst()
                .map(error -> error.getDefaultMessage())
                .orElse("请求参数不合法");
        return CommonResult.error(400, message);
    }

    @ExceptionHandler(Exception.class)
    public CommonResult<Void> handleException(Exception ex) {
        return CommonResult.error(500, ex.getMessage());
    }
}
