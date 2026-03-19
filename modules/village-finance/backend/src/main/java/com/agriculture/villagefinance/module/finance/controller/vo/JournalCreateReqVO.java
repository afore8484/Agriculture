package com.agriculture.villagefinance.module.finance.controller.vo;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import lombok.Data;

import java.math.BigDecimal;
import java.time.LocalDate;

@Data
public class JournalCreateReqVO {

    @NotNull(message = "accountId不能为空")
    private Long accountId;

    @NotNull(message = "txnDate不能为空")
    private LocalDate txnDate;

    @NotBlank(message = "direction不能为空")
    private String direction;

    @NotNull(message = "amount不能为空")
    private BigDecimal amount;

    private String summary;
    private Long operatorId;
}
