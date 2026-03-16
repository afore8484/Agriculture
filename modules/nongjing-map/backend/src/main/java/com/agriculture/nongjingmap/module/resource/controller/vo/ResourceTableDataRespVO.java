package com.agriculture.nongjingmap.module.resource.controller.vo;

import java.util.List;
import java.util.Map;
import lombok.Builder;
import lombok.Value;

@Value
@Builder
public class ResourceTableDataRespVO {
    List<ResourceTableColumnRespVO> columns;
    List<Map<String, Object>> rows;
}