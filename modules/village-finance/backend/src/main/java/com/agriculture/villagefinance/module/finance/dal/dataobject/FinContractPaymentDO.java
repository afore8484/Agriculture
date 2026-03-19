package com.agriculture.villagefinance.module.finance.dal.dataobject;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.LocalDateTime;

@Data
@TableName("fin_contract_payment")
public class FinContractPaymentDO {

    @TableId(type = IdType.AUTO)
    private Long id;
    private Long contractId;
    private String paymentType;
    private LocalDate paymentDate;
    private BigDecimal amount;
    private Long bankAccountId;
    private Long cashAccountId;
    private Long journalId;
    private Long voucherId;
    private String status;
    private Long createdBy;
    private LocalDateTime createdAt;
    private String remark;
}
