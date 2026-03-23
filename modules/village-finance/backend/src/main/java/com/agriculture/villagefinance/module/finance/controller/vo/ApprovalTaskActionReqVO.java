package com.agriculture.villagefinance.module.finance.controller.vo;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import lombok.Data;

@Data
public class ApprovalTaskActionReqVO {

    @NotNull(message = "approverId不能为空")
    private Long approverId;

    @NotBlank(message = "actionType不能为空")
    private String actionType;

    private String actionRemark;
}
