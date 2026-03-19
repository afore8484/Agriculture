package com.agriculture.villagefinance.module.finance.controller.vo;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import lombok.Data;

@Data
public class ApprovalProcessUpdateReqVO {

    @NotNull(message = "processId不能为空")
    private Long processId;

    @NotBlank(message = "processName不能为空")
    private String processName;

    @NotBlank(message = "bizType不能为空")
    private String bizType;

    @NotNull(message = "updatedBy不能为空")
    private Long updatedBy;

    private String remark;
}
