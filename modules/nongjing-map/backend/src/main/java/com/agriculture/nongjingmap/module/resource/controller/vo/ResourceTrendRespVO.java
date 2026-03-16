package com.agriculture.nongjingmap.module.resource.controller.vo;

import java.math.BigDecimal;
import lombok.Builder;
import lombok.Value;

@Value
@Builder
public class ResourceTrendRespVO {
    String yearMonth;
    BigDecimal farmLandArea;
    BigDecimal constructLandArea;
    BigDecimal unusedLandArea;
}