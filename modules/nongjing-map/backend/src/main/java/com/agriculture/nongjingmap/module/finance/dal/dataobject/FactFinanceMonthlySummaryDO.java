package com.agriculture.nongjingmap.module.finance.dal.dataobject;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import java.math.BigDecimal;
import lombok.Data;

@TableName("fact_finance_monthly_summary")
@Data
public class FactFinanceMonthlySummaryDO {

    @TableId(type = IdType.AUTO)
    private Long id;
    private String periodMonth;
    private String regionCode;
    private String orgCode;
    private BigDecimal totalIncome;
    private BigDecimal operatingIncome;
    private BigDecimal subsidyIncome;
    private BigDecimal investmentIncome;
    private BigDecimal otherIncome;
    private BigDecimal totalExpense;
    private BigDecimal operatingExpense;
    private BigDecimal managementExpense;
    private BigDecimal yearProfit;
    private BigDecimal undistributedProfit;
    private BigDecimal currencyFunds;
    private BigDecimal accountsReceivable;
    private BigDecimal inventoryAmount;
    private BigDecimal fixedAssetsOriginal;
    private BigDecimal fixedAssetsNet;
    private BigDecimal accountsPayable;
    private String isClosed;
    private String isAccountSetCreated;
}