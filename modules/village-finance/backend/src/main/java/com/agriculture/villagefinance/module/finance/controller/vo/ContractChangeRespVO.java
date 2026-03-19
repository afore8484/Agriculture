package com.agriculture.villagefinance.module.finance.controller.vo;

import lombok.Data;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.LocalDateTime;

@Data
public class ContractChangeRespVO {

    private Long changeId;
    private Long contractId;
    private String changeType;
    private LocalDate changeDate;
    private BigDecimal beforeAmount;
    private BigDecimal afterAmount;
    private LocalDate beforeEndDate;
    private LocalDate afterEndDate;
    private String changeContent;
    private Long voucherId;
    private LocalDateTime createdAt;
    private String remark;
}
