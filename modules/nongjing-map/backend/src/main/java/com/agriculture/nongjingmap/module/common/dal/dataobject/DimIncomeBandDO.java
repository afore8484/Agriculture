package com.agriculture.nongjingmap.module.common.dal.dataobject;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import java.math.BigDecimal;
import lombok.Data;

@TableName("dim_income_band")
@Data
public class DimIncomeBandDO {

    @TableId(type = IdType.AUTO)
    private Long id;
    private String bandCode;
    private String bandName;
    private BigDecimal thresholdAmount;
    private Integer sortNo;
    private String remark;
}