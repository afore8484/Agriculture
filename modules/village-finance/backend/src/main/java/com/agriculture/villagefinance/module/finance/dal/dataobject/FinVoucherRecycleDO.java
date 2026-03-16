package com.agriculture.villagefinance.module.finance.dal.dataobject;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.LocalDateTime;

@Data
@TableName("fin_voucher_recycle")
public class FinVoucherRecycleDO {

    @TableId(type = IdType.AUTO)
    private Long id;
    private Long originalVoucherId;
    private String voucherNo;
    private LocalDate voucherDate;
    private String voucherType;
    private Long bookId;
    private Long periodId;
    private BigDecimal totalDebit;
    private BigDecimal totalCredit;
    private String deleteReason;
    private Long deletedBy;
    private LocalDateTime deletedAt;
    private Integer restoreFlag;
    private Integer purgeFlag;
    private String voucherSnapshot;
    private String remark;
}
