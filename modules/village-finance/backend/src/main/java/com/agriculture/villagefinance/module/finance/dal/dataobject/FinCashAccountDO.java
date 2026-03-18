package com.agriculture.villagefinance.module.finance.dal.dataobject;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

import java.math.BigDecimal;
import java.time.LocalDateTime;

@Data
@TableName("fin_cash_account")
public class FinCashAccountDO {

    @TableId(type = IdType.AUTO)
    private Long id;
    private Long bookId;
    private String accountName;
    private Long subjectId;
    private BigDecimal initBalance;
    private BigDecimal currentBalance;
    private String status;
    private String remark;
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;
}
