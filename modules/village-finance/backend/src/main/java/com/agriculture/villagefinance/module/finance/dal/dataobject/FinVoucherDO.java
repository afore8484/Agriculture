package com.agriculture.villagefinance.module.finance.dal.dataobject;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.LocalDateTime;

@Data
@TableName("fin_voucher")
public class FinVoucherDO {

    @TableId(type = IdType.AUTO)
    private Long id;
    private String voucherNo;
    private LocalDate voucherDate;
    private String voucherType;
    private Long bizId;
    private Long bookId;
    private Long periodId;
    private Integer attachmentCount;
    private BigDecimal totalDebit;
    private BigDecimal totalCredit;
    private String status;
    private Long createdBy;
    private LocalDateTime createdAt;
    private Long auditedBy;
    private LocalDateTime auditedAt;
    private String remark;
}
