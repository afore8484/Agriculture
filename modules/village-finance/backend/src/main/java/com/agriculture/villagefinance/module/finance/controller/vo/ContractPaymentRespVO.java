package com.agriculture.villagefinance.module.finance.controller.vo;

import lombok.Data;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.LocalDateTime;

@Data
public class ContractPaymentRespVO {

    private Long paymentId;
    private Long contractId;
    private String paymentType;
    private LocalDate paymentDate;
    private BigDecimal amount;
    private Long bankAccountId;
    private Long cashAccountId;
    private Long journalId;
    private Long voucherId;
    private String status;
    private LocalDateTime createdAt;
    private String remark;
}
