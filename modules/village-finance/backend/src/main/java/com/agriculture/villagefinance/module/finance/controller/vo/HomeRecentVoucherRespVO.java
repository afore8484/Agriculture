package com.agriculture.villagefinance.module.finance.controller.vo;

import lombok.Data;

import java.math.BigDecimal;
import java.time.LocalDate;

@Data
public class HomeRecentVoucherRespVO {

    private Long voucherId;
    private String voucherNo;
    private LocalDate voucherDate;
    private String summary;
    private BigDecimal amount;
    private String direction;
    private String auditStatus;
    private String voucherType;
    private Long bizId;
}
