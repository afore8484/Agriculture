package com.agriculture.villagefinance.module.finance.controller.vo;

import jakarta.validation.constraints.NotNull;
import lombok.Data;

@Data
public class VoucherAuditReqVO {

    @NotNull(message = "审核人不能为空")
    private Long operatorId;

    private String auditRemark;
}
