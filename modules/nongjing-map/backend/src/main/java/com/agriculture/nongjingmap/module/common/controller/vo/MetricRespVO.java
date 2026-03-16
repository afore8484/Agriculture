package com.agriculture.nongjingmap.module.common.controller.vo;

import lombok.Builder;
import lombok.Value;

@Value
@Builder
public class MetricRespVO {
    String metricCode;
    String metricName;
    String metricCategory;
    String unitName;
    String remark;
}