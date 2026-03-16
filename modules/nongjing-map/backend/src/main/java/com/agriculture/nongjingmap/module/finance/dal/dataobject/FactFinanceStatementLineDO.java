package com.agriculture.nongjingmap.module.finance.dal.dataobject;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import java.math.BigDecimal;
import java.time.LocalDate;
import lombok.Data;

@TableName("fact_finance_statement_line")
@Data
public class FactFinanceStatementLineDO {

    @TableId(type = IdType.AUTO)
    private Long id;
    private String statementType;
    private String periodMonth;
    private LocalDate snapshotDate;
    private String regionCode;
    private String orgCode;
    private String lineCode;
    private String lineName;
    private Integer lineNo;
    private String parentLineCode;
    private Integer lineLevel;
    private String lineCategory;
    private BigDecimal beginAmount;
    private BigDecimal currentAmount;
    private BigDecimal endAmount;
    private BigDecimal changeAmount;
    private BigDecimal changeRate;
    private String remark;
}