package com.agriculture.nongjingmap.module.finance.controller;

import com.agriculture.nongjingmap.common.pojo.CommonResult;
import com.agriculture.nongjingmap.module.finance.controller.vo.*;
import com.agriculture.nongjingmap.module.finance.service.FinanceQueryService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import java.util.List;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@Tag(name = "农经一张图-财务接口")
@RestController
@RequestMapping("/api/nongjing/finance")
public class FinanceController {

    private final FinanceQueryService financeQueryService;

    public FinanceController(FinanceQueryService financeQueryService) {
        this.financeQueryService = financeQueryService;
    }

    @Operation(summary = "获取财务页兼容聚合数据")
    @GetMapping("/summary")
    public CommonResult<FinancePageRespVO> getFinancePage(
            @RequestParam(required = false) String regionCode,
            @RequestParam(required = false) String yearMonth) {
        return CommonResult.success(financeQueryService.getFinancePage(regionCode, yearMonth));
    }

    @Operation(summary = "获取财务总览摘要")
    @GetMapping("/overview/summary")
    public CommonResult<FinanceOverviewSummaryRespVO> getOverviewSummary(
            @RequestParam(required = false) String regionCode,
            @RequestParam(required = false) String yearMonth) {
        return CommonResult.success(financeQueryService.getOverviewSummary(regionCode, yearMonth));
    }

    @Operation(summary = "获取财务总览趋势")
    @GetMapping("/overview/trend")
    public CommonResult<List<FinanceOverviewTrendRespVO>> listOverviewTrend(
            @RequestParam(required = false) String regionCode,
            @RequestParam(required = false) String startMonth,
            @RequestParam(required = false) String endMonth) {
        return CommonResult.success(financeQueryService.listOverviewTrend(regionCode, startMonth, endMonth));
    }

    @Operation(summary = "获取财务收入分档统计")
    @GetMapping("/income-bands/stats")
    public CommonResult<List<FinanceIncomeBandStatsRespVO>> listIncomeBandStats(
            @RequestParam(required = false) String regionCode,
            @RequestParam(required = false) String yearMonth) {
        return CommonResult.success(financeQueryService.listIncomeBandStats(regionCode, yearMonth));
    }

    @Operation(summary = "获取财务收入分档趋势")
    @GetMapping("/income-bands/trend")
    public CommonResult<List<FinanceIncomeBandTrendRespVO>> listIncomeBandTrend(
            @RequestParam(required = false) String regionCode,
            @RequestParam(required = false) String bandCode,
            @RequestParam(required = false) String startMonth,
            @RequestParam(required = false) String endMonth) {
        return CommonResult.success(financeQueryService.listIncomeBandTrend(regionCode, bandCode, startMonth, endMonth));
    }

    @Operation(summary = "获取财务收入分档明细")
    @GetMapping("/income-bands/list")
    public CommonResult<List<FinanceIncomeBandDetailRespVO>> listIncomeBandDetails(
            @RequestParam(required = false) String regionCode,
            @RequestParam(required = false) String yearMonth,
            @RequestParam(required = false) String bandCode,
            @RequestParam(required = false) String compareType) {
        return CommonResult.success(financeQueryService.listIncomeBandDetails(regionCode, yearMonth, bandCode, compareType));
    }

    @Operation(summary = "获取财务指标总览")
    @GetMapping("/indicators/summary")
    public CommonResult<List<FinanceIndicatorRespVO>> listIndicatorSummary(
            @RequestParam(required = false) String regionCode,
            @RequestParam(required = false) String yearMonth) {
        return CommonResult.success(financeQueryService.listIndicatorSummary(regionCode, yearMonth));
    }

    @Operation(summary = "获取财务收入来源明细")
    @GetMapping("/income-details/list")
    public CommonResult<List<FinanceIncomeDetailRespVO>> listIncomeDetails(
            @RequestParam(required = false) String regionCode,
            @RequestParam(required = false) String orgCode,
            @RequestParam(required = false) String yearMonth,
            @RequestParam(required = false) String incomeType) {
        return CommonResult.success(financeQueryService.listIncomeDetails(regionCode, orgCode, yearMonth, incomeType));
    }

    @Operation(summary = "获取财务应收明细")
    @GetMapping("/receivables/list")
    public CommonResult<List<FinanceReceivableRespVO>> listReceivables(
            @RequestParam(required = false) String regionCode,
            @RequestParam(required = false) String orgCode,
            @RequestParam(required = false) String yearMonth,
            @RequestParam(required = false) String status) {
        return CommonResult.success(financeQueryService.listReceivables(regionCode, orgCode, yearMonth, status));
    }

    @Operation(summary = "获取财务应付明细")
    @GetMapping("/payables/list")
    public CommonResult<List<FinancePayableRespVO>> listPayables(
            @RequestParam(required = false) String regionCode,
            @RequestParam(required = false) String orgCode,
            @RequestParam(required = false) String yearMonth,
            @RequestParam(required = false) String status) {
        return CommonResult.success(financeQueryService.listPayables(regionCode, orgCode, yearMonth, status));
    }

    @Operation(summary = "获取资产负债变动分析")
    @GetMapping("/balance-sheet/analysis")
    public CommonResult<List<FinanceBalanceAnalysisRespVO>> listBalanceAnalysis(
            @RequestParam(required = false) String regionCode,
            @RequestParam(required = false) String startMonth,
            @RequestParam(required = false) String endMonth) {
        return CommonResult.success(financeQueryService.listBalanceAnalysis(regionCode, startMonth, endMonth));
    }

    @Operation(summary = "获取资产负债表明细")
    @GetMapping("/balance-sheet/detail")
    public CommonResult<List<FinanceStatementLineRespVO>> listBalanceDetail(
            @RequestParam(required = false) String regionCode,
            @RequestParam(required = false) String snapshotDate,
            @RequestParam(required = false) String statementType) {
        return CommonResult.success(financeQueryService.listBalanceDetail(regionCode, snapshotDate, statementType));
    }

    @Operation(summary = "获取收益分配分析")
    @GetMapping("/income-distribution/analysis")
    public CommonResult<List<FinanceDistributionAnalysisRespVO>> listDistributionAnalysis(
            @RequestParam(required = false) String regionCode,
            @RequestParam(required = false) String yearMonth) {
        return CommonResult.success(financeQueryService.listDistributionAnalysis(regionCode, yearMonth));
    }

    @Operation(summary = "获取收益分配明细")
    @GetMapping("/income-distribution/detail")
    public CommonResult<List<FinanceDistributionDetailRespVO>> listDistributionDetail(
            @RequestParam(required = false) String regionCode,
            @RequestParam(required = false) String yearMonth) {
        return CommonResult.success(financeQueryService.listDistributionDetail(regionCode, yearMonth));
    }
}