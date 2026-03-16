package com.agriculture.nongjingmap.module.finance.dal.dataobject;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import java.math.BigDecimal;
import java.time.LocalDate;
import lombok.Data;

@TableName("fact_finance_income_distribution_line")
@Data
public class FactFinanceIncomeDistributionLineDO {

    @TableId(type = IdType.AUTO)
    private Long id;
    private String periodMonth;
    private LocalDate snapshotDate;
    private String regionCode;
    private String orgCode;
    private String itemCode;
    private String itemName;
    private Integer lineNo;
    private BigDecimal amount;
    private String remark;
}