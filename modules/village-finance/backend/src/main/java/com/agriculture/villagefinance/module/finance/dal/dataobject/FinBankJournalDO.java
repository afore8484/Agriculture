package com.agriculture.villagefinance.module.finance.dal.dataobject;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.LocalDateTime;

@Data
@TableName("fin_bank_journal")
public class FinBankJournalDO {

    @TableId(type = IdType.AUTO)
    private Long id;
    private Long accountId;
    private LocalDate txnDate;
    private String summary;
    private String direction;
    private BigDecimal amount;
    private BigDecimal incomeAmount;
    private BigDecimal expenseAmount;
    private BigDecimal balance;
    private String bizType;
    private Long bizId;
    private String status;
    private Long createdBy;
    private LocalDateTime createdAt;
}
