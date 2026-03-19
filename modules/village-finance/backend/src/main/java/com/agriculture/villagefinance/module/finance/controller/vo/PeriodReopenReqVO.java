package com.agriculture.villagefinance.module.finance.controller.vo;

import jakarta.validation.constraints.NotNull;
import lombok.Data;

@Data
public class PeriodReopenReqVO {

    @NotNull(message = "ledgerId不能为空")
    private Long ledgerId;

    @NotNull(message = "periodId不能为空")
    private Long periodId;

    private String reason;
    private Long operatorId;
}
