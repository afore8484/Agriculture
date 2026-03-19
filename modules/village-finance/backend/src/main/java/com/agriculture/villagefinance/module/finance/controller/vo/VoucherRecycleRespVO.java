package com.agriculture.villagefinance.module.finance.controller.vo;

import lombok.Data;

import java.time.LocalDateTime;

@Data
public class VoucherRecycleRespVO {

    private Long voucherId;
    private String voucherNo;
    private LocalDateTime deletedTime;
}
