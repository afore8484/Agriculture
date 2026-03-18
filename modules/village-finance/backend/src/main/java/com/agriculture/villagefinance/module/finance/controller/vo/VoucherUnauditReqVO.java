package com.agriculture.villagefinance.module.finance.controller.vo;

import jakarta.validation.constraints.NotNull;
import lombok.Data;

@Data
public class VoucherUnauditReqVO {

    @NotNull(message = "操作人不能为空")
    private Long operatorId;

    private String reason;
}
