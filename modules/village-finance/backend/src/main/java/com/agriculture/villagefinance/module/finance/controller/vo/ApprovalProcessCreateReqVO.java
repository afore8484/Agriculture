package com.agriculture.villagefinance.module.finance.controller.vo;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import lombok.Data;

@Data
public class ApprovalProcessCreateReqVO {

    @NotBlank(message = "processCode不能为空")
    private String processCode;

    @NotBlank(message = "processName不能为空")
    private String processName;

    @NotBlank(message = "bizType不能为空")
    private String bizType;

    @NotNull(message = "createdBy不能为空")
    private Long createdBy;

    private String remark;
}
