package com.agriculture.nongjingmap.module.asset.controller.vo;

import lombok.Builder;
import lombok.Value;

@Value
@Builder
public class AssetMetricCardRespVO {
    String label;
    String value;
    String hint;
    String status;
}