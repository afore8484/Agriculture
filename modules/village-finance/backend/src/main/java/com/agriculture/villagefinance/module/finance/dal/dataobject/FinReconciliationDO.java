package com.agriculture.villagefinance.module.finance.dal.dataobject;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

import java.math.BigDecimal;
import java.time.LocalDateTime;

@Data
@TableName("fin_reconciliation")
public class FinReconciliationDO {

    @TableId(type = IdType.AUTO)
    private Long id;
    private Long bookId;
    private Long periodId;
    private Long accountId;
    private String accountType;
    private String accountName;
    private BigDecimal bookBalance;
    private BigDecimal bankBalance;
    private BigDecimal diffAmount;
    private LocalDateTime generatedAt;
}
