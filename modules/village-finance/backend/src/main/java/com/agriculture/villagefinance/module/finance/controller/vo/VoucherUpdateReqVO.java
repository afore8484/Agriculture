package com.agriculture.villagefinance.module.finance.controller.vo;

import jakarta.validation.Valid;
import jakarta.validation.constraints.NotEmpty;
import jakarta.validation.constraints.NotNull;
import lombok.Data;

import java.time.LocalDate;
import java.util.List;

@Data
public class VoucherUpdateReqVO {

    private LocalDate voucherDate;

    private String voucherType;

    private String summary;

    private String remark;

    @NotNull(message = "操作人不能为空")
    private Long operatorId;

    private List<Long> attachmentIds;

    @Valid
    @NotEmpty(message = "凭证明细不能为空")
    private List<VoucherEntryReqVO> entries;
}
