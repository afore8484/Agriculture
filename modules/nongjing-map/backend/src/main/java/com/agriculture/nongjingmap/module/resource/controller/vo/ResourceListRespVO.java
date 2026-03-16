package com.agriculture.nongjingmap.module.resource.controller.vo;

import java.math.BigDecimal;
import lombok.Builder;
import lombok.Value;

@Value
@Builder
public class ResourceListRespVO {
    String resourceCode;
    String resourceName;
    String resourceType;
    String locationDesc;
    BigDecimal area;
    BigDecimal estimatedValue;
    String usableStatus;
}