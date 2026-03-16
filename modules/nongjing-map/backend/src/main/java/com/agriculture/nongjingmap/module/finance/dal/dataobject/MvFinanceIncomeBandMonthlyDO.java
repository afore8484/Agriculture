package com.agriculture.nongjingmap.module.finance.dal.dataobject;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import java.math.BigDecimal;
import lombok.Data;

@TableName("mv_finance_income_band_monthly")
@Data
public class MvFinanceIncomeBandMonthlyDO {

    @TableId(type = IdType.AUTO)
    private Long id;
    private String periodMonth;
    private String regionCode;
    private String bandCode;
    private String bandName;
    private Integer villageCount;
    private BigDecimal incomeTotal;
    private BigDecimal villageRatio;
}