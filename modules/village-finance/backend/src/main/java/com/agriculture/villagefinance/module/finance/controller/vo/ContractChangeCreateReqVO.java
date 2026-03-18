package com.agriculture.villagefinance.module.finance.controller.vo;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import lombok.Data;

import java.math.BigDecimal;
import java.time.LocalDate;

@Data
public class ContractChangeCreateReqVO {

    @NotNull(message = "contractId不能为空")
    private Long contractId;

    @NotBlank(message = "changeType不能为空")
    private String changeType;

    @NotNull(message = "changeDate不能为空")
    private LocalDate changeDate;

    private BigDecimal afterAmount;
    private LocalDate afterEndDate;
    private String changeContent;
    private Long operatorId;
    private String remark;
}
