package com.agriculture.villagefinance.module.finance.service.dto;

import lombok.Data;

import java.time.LocalDate;

@Data
public class BizVoucherTraceRespVO {

    private Long voucherId;
    private String voucherNo;
    private String voucherType;
    private Long bizId;
    private Long ledgerId;
    private Long periodId;
    private String status;
    private LocalDate voucherDate;
}
