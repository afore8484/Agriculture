package com.agriculture.villagefinance.module.finance.controller.vo;

import lombok.Data;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.LocalDateTime;

@Data
public class ContractTerminationRespVO {

    private Long terminationId;
    private Long contractId;
    private LocalDate terminationDate;
    private String terminationType;
    private String terminationReason;
    private BigDecimal settlementAmount;
    private Long voucherId;
    private Long operatorId;
    private LocalDateTime createdAt;
    private String remark;
}
