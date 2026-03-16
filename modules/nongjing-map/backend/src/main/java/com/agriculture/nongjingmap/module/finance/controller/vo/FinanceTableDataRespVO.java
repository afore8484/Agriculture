package com.agriculture.nongjingmap.module.finance.controller.vo;

import java.util.List;
import java.util.Map;
import lombok.Builder;
import lombok.Value;

@Value
@Builder
public class FinanceTableDataRespVO {
    List<FinanceTableColumnRespVO> columns;
    List<Map<String, Object>> rows;
}