package com.agriculture.villagefinance.module.finance.controller.vo;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import lombok.Data;

import java.math.BigDecimal;
import java.time.LocalDate;

@Data
public class ContractTerminationCreateReqVO {

    @NotNull(message = "contractId不能为空")
    private Long contractId;

    @NotNull(message = "terminationDate不能为空")
    private LocalDate terminationDate;

    @NotBlank(message = "terminationType不能为空")
    private String terminationType;

    private String terminationReason;
    private BigDecimal settlementAmount;
    private Long operatorId;
    private String remark;
}
