package com.agriculture.nongjingmap.module.resource.controller.vo;

import lombok.Builder;
import lombok.Value;

@Value
@Builder
public class ResourceMetricCardRespVO {
    String label;
    String value;
    String hint;
    String status;
}