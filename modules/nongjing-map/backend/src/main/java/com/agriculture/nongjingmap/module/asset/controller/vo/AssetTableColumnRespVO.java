package com.agriculture.nongjingmap.module.asset.controller.vo;

import lombok.Builder;
import lombok.Value;

@Value
@Builder
public class AssetTableColumnRespVO {
    String key;
    String label;
}