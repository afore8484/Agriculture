package com.agriculture.villagefinance.module.finance.controller.vo;

import lombok.Data;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.LocalDateTime;

@Data
public class ContractAcceptanceRespVO {

    private Long acceptanceId;
    private Long contractId;
    private LocalDate acceptanceDate;
    private String acceptanceResult;
    private BigDecimal acceptanceAmount;
    private String acceptanceDesc;
    private Long operatorId;
    private LocalDateTime createdAt;
    private String remark;
}
