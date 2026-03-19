package com.agriculture.villagefinance.module.finance.controller.vo;

import jakarta.validation.constraints.NotNull;
import lombok.Data;

import java.math.BigDecimal;
import java.time.LocalDate;

@Data
public class ContractRenewalCreateReqVO {

    @NotNull(message = "contractId不能为空")
    private Long contractId;

    @NotNull(message = "renewalDate不能为空")
    private LocalDate renewalDate;

    private LocalDate renewalStartDate;
    private LocalDate renewalEndDate;
    private BigDecimal renewalAmount;
    private String renewalContent;
    private Long operatorId;
    private String remark;
}
