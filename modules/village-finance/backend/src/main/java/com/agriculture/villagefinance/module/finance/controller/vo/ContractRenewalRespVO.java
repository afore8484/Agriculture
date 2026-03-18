package com.agriculture.villagefinance.module.finance.controller.vo;

import lombok.Data;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.LocalDateTime;

@Data
public class ContractRenewalRespVO {

    private Long renewalId;
    private Long contractId;
    private String renewalNo;
    private LocalDate renewalDate;
    private LocalDate renewalStartDate;
    private LocalDate renewalEndDate;
    private BigDecimal renewalAmount;
    private String renewalContent;
    private String status;
    private LocalDateTime createdAt;
    private String remark;
}
