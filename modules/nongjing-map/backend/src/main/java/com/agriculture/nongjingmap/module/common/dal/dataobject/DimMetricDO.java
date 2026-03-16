package com.agriculture.nongjingmap.module.common.dal.dataobject;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

@TableName("dim_metric")
@Data
public class DimMetricDO {

    @TableId(type = IdType.AUTO)
    private Long id;
    private String metricCode;
    private String metricName;
    private String metricCategory;
    private String unitName;
    private String remark;
}