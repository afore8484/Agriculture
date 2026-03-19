package com.agriculture.villagefinance.module.finance.controller.vo;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import lombok.Data;

@Data
public class ApprovalInstanceStartReqVO {

    @NotNull(message = "processId不能为空")
    private Long processId;

    @NotBlank(message = "bizType不能为空")
    private String bizType;

    @NotNull(message = "bizId不能为空")
    private Long bizId;

    @NotNull(message = "applicantId不能为空")
    private Long applicantId;

    @NotNull(message = "approverId不能为空")
    private Long approverId;

    @NotBlank(message = "nodeName不能为空")
    private String nodeName;

    private String remark;
}
