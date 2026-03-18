package com.agriculture.villagefinance.module.finance.controller.vo;

import jakarta.validation.constraints.NotNull;
import lombok.Data;

import java.math.BigDecimal;
import java.time.LocalDate;

@Data
public class InternalTransferReqVO {

    @NotNull(message = "fromAccountId不能为空")
    private Long fromAccountId;

    @NotNull(message = "toAccountId不能为空")
    private Long toAccountId;

    @NotNull(message = "amount不能为空")
    private BigDecimal amount;

    @NotNull(message = "txnDate不能为空")
    private LocalDate txnDate;

    private Long operatorId;
    private String remark;
}
