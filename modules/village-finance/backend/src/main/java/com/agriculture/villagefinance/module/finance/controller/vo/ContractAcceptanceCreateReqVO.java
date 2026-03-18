package com.agriculture.villagefinance.module.finance.controller.vo;

import jakarta.validation.constraints.NotNull;
import lombok.Data;

import java.math.BigDecimal;
import java.time.LocalDate;

@Data
public class ContractAcceptanceCreateReqVO {

    @NotNull(message = "contractId不能为空")
    private Long contractId;

    @NotNull(message = "acceptanceDate不能为空")
    private LocalDate acceptanceDate;

    private String acceptanceResult;
    private BigDecimal acceptanceAmount;
    private String acceptanceDesc;
    private Long operatorId;
    private String remark;
}
