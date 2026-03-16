package com.agriculture.nongjingmap.module.resource.controller.vo;

import lombok.Builder;
import lombok.Value;

@Value
@Builder
public class ResourceTableColumnRespVO {
    String key;
    String label;
}