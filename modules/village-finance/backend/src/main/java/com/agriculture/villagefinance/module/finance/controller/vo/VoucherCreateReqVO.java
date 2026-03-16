package com.agriculture.villagefinance.module.finance.controller.vo;

import jakarta.validation.Valid;
import jakarta.validation.constraints.NotEmpty;
import jakarta.validation.constraints.NotNull;
import lombok.Data;

import java.time.LocalDate;
import java.util.List;

@Data
public class VoucherCreateReqVO {

    @NotNull(message = "账套不能为空")
    private Long ledgerId;

    @NotNull(message = "会计期间不能为空")
    private Long periodId;

    @NotNull(message = "凭证日期不能为空")
    private LocalDate voucherDate;

    private String voucherType;

    private String summary;

    private String remark;

    @NotNull(message = "制单人不能为空")
    private Long createdBy;

    private List<Long> attachmentIds;

    @Valid
    @NotEmpty(message = "凭证明细不能为空")
    private List<VoucherEntryReqVO> entries;
}
