package com.agriculture.villagefinance.module.finance.dal.dataobject;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

import java.math.BigDecimal;

@Data
@TableName("fin_voucher_entry")
public class FinVoucherEntryDO {

    @TableId(type = IdType.AUTO)
    private Long id;
    private Long voucherId;
    private Integer lineNo;
    private Long subjectId;
    private String summary;
    private BigDecimal debitAmount;
    private BigDecimal creditAmount;
    private String auxType;
    private Long auxId;
    private Integer sortOrder;
    private String remark;
}
