package com.agriculture.villagefinance.module.finance.controller.vo;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import lombok.Data;

@Data
public class CashAccountUpdateReqVO {

    @NotBlank(message = "accountName不能为空")
    private String accountName;

    @NotNull(message = "subjectId不能为空")
    private Long subjectId;

    private String remark;
}
