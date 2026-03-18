package com.agriculture.villagefinance.module.finance.controller.vo;

import lombok.Data;

import java.math.BigDecimal;
import java.time.LocalDate;

@Data
public class InternalTransferRespVO {

    private Long transferId;
    private Long voucherId;
    private LocalDate txnDate;
    private BigDecimal amount;
    private String status;
}
