package com.agriculture.nongjingmap.module.overview.controller.vo;

import java.math.BigDecimal;
import lombok.Builder;
import lombok.Value;

@Value
@Builder
public class MapStatRespVO {
    String metricCode;
    String topicCode;
    String regionCode;
    String regionName;
    String statMonth;
    Integer rankNo;
    BigDecimal metricValue;
}