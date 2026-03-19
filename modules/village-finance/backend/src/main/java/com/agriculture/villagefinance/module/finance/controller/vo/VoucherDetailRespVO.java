package com.agriculture.villagefinance.module.finance.controller.vo;

import lombok.Data;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.List;

@Data
public class VoucherDetailRespVO {

    private Long voucherId;
    private String voucherNo;
    private LocalDate voucherDate;
    private String voucherType;
    private Long bizId;
    private Long ledgerId;
    private Long periodId;
    private Integer attachmentCount;
    private BigDecimal totalDebit;
    private BigDecimal totalCredit;
    private String auditStatus;
    private String remark;
    private List<VoucherEntryRespVO> entries;
    private List<VoucherAttachmentRespVO> attachments;
}
