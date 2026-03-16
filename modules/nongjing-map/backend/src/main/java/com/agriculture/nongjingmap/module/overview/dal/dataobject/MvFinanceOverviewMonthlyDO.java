package com.agriculture.nongjingmap.module.overview.dal.dataobject;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import java.math.BigDecimal;
import lombok.Data;

@TableName("mv_finance_overview_monthly")
@Data
public class MvFinanceOverviewMonthlyDO {

    @TableId(type = IdType.AUTO)
    private Long id;
    private String regionCode;
    private String statMonth;
    private Integer orgCount;
    private Integer townshipCount;
    private Integer villageCount;
    private Integer unsettledCount;
    private Integer noBookCount;
    private Integer warningCount;
    private BigDecimal incomeTotal;
}