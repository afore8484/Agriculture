package com.agriculture.villagefinance.module.finance.controller.vo;

import lombok.Data;

import java.math.BigDecimal;
import java.time.LocalDate;

@Data
public class PendingVoucherRespVO {

    private Long voucherId;
    private String voucherNo;
    private LocalDate voucherDate;
    private BigDecimal amount;
}
