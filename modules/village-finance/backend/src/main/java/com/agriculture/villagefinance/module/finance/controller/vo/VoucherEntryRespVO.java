package com.agriculture.villagefinance.module.finance.controller.vo;

import lombok.Data;

import java.math.BigDecimal;

@Data
public class VoucherEntryRespVO {

    private Long entryId;
    private Integer lineNo;
    private Long subjectId;
    private String subjectCode;
    private String subjectName;
    private String summary;
    private BigDecimal debitAmount;
    private BigDecimal creditAmount;
}
