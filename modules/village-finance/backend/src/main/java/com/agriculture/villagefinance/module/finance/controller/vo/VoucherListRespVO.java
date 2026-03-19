package com.agriculture.villagefinance.module.finance.controller.vo;

import lombok.Data;

import java.math.BigDecimal;
import java.time.LocalDate;

@Data
public class VoucherListRespVO {

    private Long voucherId;
    private String voucherNo;
    private LocalDate voucherDate;
    private String voucherType;
    private Long bizId;
    private BigDecimal totalAmount;
    private String auditStatus;
}
