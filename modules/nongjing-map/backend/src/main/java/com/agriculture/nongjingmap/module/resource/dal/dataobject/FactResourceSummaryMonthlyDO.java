package com.agriculture.nongjingmap.module.resource.dal.dataobject;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import java.math.BigDecimal;
import lombok.Data;

@TableName("fact_resource_summary_monthly")
@Data
public class FactResourceSummaryMonthlyDO {

    @TableId(type = IdType.AUTO)
    private Long id;
    private String periodMonth;
    private String regionCode;
    private String orgCode;
    private String resourceType;
    private BigDecimal resourceTotalArea;
    private BigDecimal resourceTotalQuantity;
    private BigDecimal resourceTotalValue;
    private Integer resourceItemCount;
}