package com.agriculture.villagefinance.module.finance.controller.vo;

import jakarta.validation.constraints.NotNull;
import lombok.Data;

import java.math.BigDecimal;

@Data
public class VoucherEntryReqVO {

    @NotNull(message = "科目不能为空")
    private Long subjectId;

    private String summary;

    @NotNull(message = "借方金额不能为空")
    private BigDecimal debitAmount;

    @NotNull(message = "贷方金额不能为空")
    private BigDecimal creditAmount;

    private String auxType;

    private Long auxId;

    private Integer sortOrder;

    private String remark;
}
