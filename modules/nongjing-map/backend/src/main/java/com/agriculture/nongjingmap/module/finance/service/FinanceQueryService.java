package com.agriculture.nongjingmap.module.finance.service;

import com.agriculture.nongjingmap.module.finance.controller.vo.*;
import java.util.List;

public interface FinanceQueryService {

    FinanceOverviewSummaryRespVO getOverviewSummary(String regionCode, String yearMonth);

    List<FinanceOverviewTrendRespVO> listOverviewTrend(String regionCode, String startMonth, String endMonth);

    List<FinanceIncomeBandStatsRespVO> listIncomeBandStats(String regionCode, String yearMonth);

    List<FinanceIncomeBandTrendRespVO> listIncomeBandTrend(String regionCode, String bandCode, String startMonth, String endMonth);

    List<FinanceIncomeBandDetailRespVO> listIncomeBandDetails(String regionCode, String yearMonth, String bandCode, String compareType);

    List<FinanceIndicatorRespVO> listIndicatorSummary(String regionCode, String yearMonth);

    List<FinanceIncomeDetailRespVO> listIncomeDetails(String regionCode, String orgCode, String yearMonth, String incomeType);

    List<FinanceReceivableRespVO> listReceivables(String regionCode, String orgCode, String yearMonth, String status);

    List<FinancePayableRespVO> listPayables(String regionCode, String orgCode, String yearMonth, String status);

    List<FinanceBalanceAnalysisRespVO> listBalanceAnalysis(String regionCode, String startMonth, String endMonth);

    List<FinanceStatementLineRespVO> listBalanceDetail(String regionCode, String snapshotDate, String statementType);

    List<FinanceDistributionAnalysisRespVO> listDistributionAnalysis(String regionCode, String yearMonth);

    List<FinanceDistributionDetailRespVO> listDistributionDetail(String regionCode, String yearMonth);

    FinancePageRespVO getFinancePage(String regionCode, String yearMonth);
}