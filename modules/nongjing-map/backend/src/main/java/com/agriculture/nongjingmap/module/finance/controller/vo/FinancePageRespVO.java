package com.agriculture.nongjingmap.module.finance.controller.vo;

import java.util.List;
import lombok.Builder;
import lombok.Value;

@Value
@Builder
public class FinancePageRespVO {
    List<FinanceMetricCardRespVO> kpis;
    List<FinanceNamedValueRespVO> incomeBands;
    FinanceTableDataRespVO highThresholdTable;
    FinanceTableDataRespVO lowThresholdTable;
    FinanceTableDataRespVO subjectTable;
    FinanceTableDataRespVO balanceTable;
    List<FinanceNamedValueRespVO> distribution;
    List<FinanceTrendPointRespVO> trend;
}