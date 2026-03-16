package com.agriculture.villagefinance.module.finance.controller.vo;

import lombok.Data;

import java.time.LocalDateTime;

@Data
public class VoucherActionRespVO {

    private Long voucherId;
    private String voucherNo;
    private String status;
    private LocalDateTime auditTime;
}
