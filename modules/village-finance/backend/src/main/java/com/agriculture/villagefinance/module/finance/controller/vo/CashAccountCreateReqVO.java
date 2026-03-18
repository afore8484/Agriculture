package com.agriculture.villagefinance.module.finance.controller.vo;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import lombok.Data;

import java.math.BigDecimal;

@Data
public class CashAccountCreateReqVO {

    @NotNull(message = "ledgerId不能为空")
    private Long ledgerId;

    @NotBlank(message = "accountName不能为空")
    private String accountName;

    @NotNull(message = "initBalance不能为空")
    private BigDecimal initBalance;

    @NotNull(message = "subjectId不能为空")
    private Long subjectId;

    private String remark;
}
