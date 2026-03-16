package com.agriculture.nongjingmap.module.finance.dal.dataobject;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import java.math.BigDecimal;
import java.time.LocalDate;
import lombok.Data;

@TableName("fact_finance_receivable_detail")
@Data
public class FactFinanceReceivableDetailDO {

    @TableId(type = IdType.AUTO)
    private Long id;
    private String periodMonth;
    private String regionCode;
    private String orgCode;
    private String debtorName;
    private String contractNo;
    private BigDecimal amount;
    private BigDecimal receivedAmount;
    private BigDecimal unreceivedAmount;
    private LocalDate dueDate;
    private Integer agingDays;
    private String status;
}