package com.agriculture.villagefinance.module.finance.dal.dataobject;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.LocalDateTime;

@Data
@TableName("fin_internal_transfer")
public class FinInternalTransferDO {

    @TableId(type = IdType.AUTO)
    private Long id;
    private Long bookId;
    private Long fromAccountId;
    private String fromAccountType;
    private Long toAccountId;
    private String toAccountType;
    private LocalDate txnDate;
    private BigDecimal amount;
    private Long voucherId;
    private String status;
    private Long operatorId;
    private LocalDateTime createdAt;
    private String remark;
}
