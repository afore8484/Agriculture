package com.agriculture.nongjingmap.module.asset.controller.vo;

import java.util.List;
import java.util.Map;
import lombok.Builder;
import lombok.Value;

@Value
@Builder
public class AssetTableDataRespVO {
    List<AssetTableColumnRespVO> columns;
    List<Map<String, Object>> rows;
}