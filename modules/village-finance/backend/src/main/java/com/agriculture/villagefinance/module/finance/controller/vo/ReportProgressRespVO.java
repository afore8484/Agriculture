package com.agriculture.villagefinance.module.finance.controller.vo;

import lombok.Data;

@Data
public class ReportProgressRespVO {

    private Long voucherTotal;
    private Long auditedTotal;
    private String percent;
}

