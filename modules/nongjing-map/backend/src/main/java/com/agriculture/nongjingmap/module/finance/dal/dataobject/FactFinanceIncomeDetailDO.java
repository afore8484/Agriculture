package com.agriculture.nongjingmap.module.finance.dal.dataobject;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import java.math.BigDecimal;
import java.time.LocalDate;
import lombok.Data;

@TableName("fact_finance_income_detail")
@Data
public class FactFinanceIncomeDetailDO {

    @TableId(type = IdType.AUTO)
    private Long id;
    private String periodMonth;
    private LocalDate bizDate;
    private String regionCode;
    private String orgCode;
    private String incomeType;
    private String incomeItemCode;
    private String incomeItemName;
    private String counterpartyName;
    private BigDecimal amount;
    private String sourceDocNo;
    private String sourceSystem;
    private String remark;
}