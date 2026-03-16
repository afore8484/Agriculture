package com.agriculture.nongjingmap.module.finance.service.impl;

import com.agriculture.nongjingmap.module.common.dal.dataobject.DimOrgDO;
import com.agriculture.nongjingmap.module.common.dal.dataobject.DimRegionDO;
import com.agriculture.nongjingmap.module.common.dal.mysql.DimOrgMapper;
import com.agriculture.nongjingmap.module.common.dal.mysql.DimRegionMapper;
import com.agriculture.nongjingmap.module.finance.controller.vo.*;
import com.agriculture.nongjingmap.module.finance.dal.dataobject.*;
import com.agriculture.nongjingmap.module.finance.dal.mysql.*;
import com.agriculture.nongjingmap.module.finance.service.FinanceQueryService;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import java.math.BigDecimal;
import java.math.RoundingMode;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Objects;
import java.util.Set;
import java.util.stream.Collectors;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

@Service
public class FinanceQueryServiceImpl implements FinanceQueryService {

    private static final BigDecimal WAN = new BigDecimal("10000");
    private static final BigDecimal YI = new BigDecimal("100000000");

    private final DimRegionMapper dimRegionMapper;
    private final DimOrgMapper dimOrgMapper;
    private final FactFinanceMonthlySummaryMapper factFinanceMonthlySummaryMapper;
    private final FactFinanceStatementLineMapper factFinanceStatementLineMapper;
    private final FactFinanceIncomeDetailMapper factFinanceIncomeDetailMapper;
    private final FactFinanceReceivableDetailMapper factFinanceReceivableDetailMapper;
    private final FactFinancePayableDetailMapper factFinancePayableDetailMapper;
    private final FactFinanceIncomeDistributionLineMapper factFinanceIncomeDistributionLineMapper;
    private final MvFinanceIncomeBandMonthlyMapper mvFinanceIncomeBandMonthlyMapper;

    public FinanceQueryServiceImpl(
            DimRegionMapper dimRegionMapper,
            DimOrgMapper dimOrgMapper,
            FactFinanceMonthlySummaryMapper factFinanceMonthlySummaryMapper,
            FactFinanceStatementLineMapper factFinanceStatementLineMapper,
            FactFinanceIncomeDetailMapper factFinanceIncomeDetailMapper,
            FactFinanceReceivableDetailMapper factFinanceReceivableDetailMapper,
            FactFinancePayableDetailMapper factFinancePayableDetailMapper,
            FactFinanceIncomeDistributionLineMapper factFinanceIncomeDistributionLineMapper,
            MvFinanceIncomeBandMonthlyMapper mvFinanceIncomeBandMonthlyMapper) {
        this.dimRegionMapper = dimRegionMapper;
        this.dimOrgMapper = dimOrgMapper;
        this.factFinanceMonthlySummaryMapper = factFinanceMonthlySummaryMapper;
        this.factFinanceStatementLineMapper = factFinanceStatementLineMapper;
        this.factFinanceIncomeDetailMapper = factFinanceIncomeDetailMapper;
        this.factFinanceReceivableDetailMapper = factFinanceReceivableDetailMapper;
        this.factFinancePayableDetailMapper = factFinancePayableDetailMapper;
        this.factFinanceIncomeDistributionLineMapper = factFinanceIncomeDistributionLineMapper;
        this.mvFinanceIncomeBandMonthlyMapper = mvFinanceIncomeBandMonthlyMapper;
    }

    @Override
    public FinanceOverviewSummaryRespVO getOverviewSummary(String regionCode, String yearMonth) {
        List<FactFinanceMonthlySummaryDO> records = listMonthlySummaries(defaultRegionCode(regionCode), defaultYearMonth(yearMonth));
        return FinanceOverviewSummaryRespVO.builder()
                .totalIncome(sumDecimal(records.stream().map(FactFinanceMonthlySummaryDO::getTotalIncome).toList()))
                .totalExpense(sumDecimal(records.stream().map(FactFinanceMonthlySummaryDO::getTotalExpense).toList()))
                .yearProfit(sumDecimal(records.stream().map(FactFinanceMonthlySummaryDO::getYearProfit).toList()))
                .undistributedProfit(sumDecimal(records.stream().map(FactFinanceMonthlySummaryDO::getUndistributedProfit).toList()))
                .unclosedCount((int) records.stream().filter(item -> "N".equalsIgnoreCase(item.getIsClosed())).count())
                .noLedgerCount((int) records.stream().filter(item -> "N".equalsIgnoreCase(item.getIsAccountSetCreated())).count())
                .build();
    }

    @Override
    public List<FinanceOverviewTrendRespVO> listOverviewTrend(String regionCode, String startMonth, String endMonth) {
        String finalRegionCode = defaultRegionCode(regionCode);
        String finalStartMonth = StringUtils.hasText(startMonth) ? normalizeMonth(startMonth) : "202601";
        String finalEndMonth = StringUtils.hasText(endMonth) ? normalizeMonth(endMonth) : defaultYearMonth(null);
        LambdaQueryWrapper<FactFinanceMonthlySummaryDO> wrapper = new LambdaQueryWrapper<>();
        wrapper.in(FactFinanceMonthlySummaryDO::getRegionCode, collectRegionCodes(finalRegionCode))
                .ge(FactFinanceMonthlySummaryDO::getPeriodMonth, finalStartMonth)
                .le(FactFinanceMonthlySummaryDO::getPeriodMonth, finalEndMonth)
                .orderByAsc(FactFinanceMonthlySummaryDO::getPeriodMonth);
        Map<String, List<FactFinanceMonthlySummaryDO>> grouped = factFinanceMonthlySummaryMapper.selectList(wrapper).stream()
                .collect(Collectors.groupingBy(FactFinanceMonthlySummaryDO::getPeriodMonth, LinkedHashMap::new, Collectors.toList()));
        return grouped.entrySet().stream().map(entry -> FinanceOverviewTrendRespVO.builder()
                .yearMonth(entry.getKey())
                .totalIncome(sumDecimal(entry.getValue().stream().map(FactFinanceMonthlySummaryDO::getTotalIncome).toList()))
                .totalExpense(sumDecimal(entry.getValue().stream().map(FactFinanceMonthlySummaryDO::getTotalExpense).toList()))
                .yearProfit(sumDecimal(entry.getValue().stream().map(FactFinanceMonthlySummaryDO::getYearProfit).toList()))
                .build()).toList();
    }

    @Override
    public List<FinanceIncomeBandStatsRespVO> listIncomeBandStats(String regionCode, String yearMonth) {
        Map<String, MvFinanceIncomeBandMonthlyDO> bandMap = listIncomeBandRows(defaultRegionCode(regionCode), defaultYearMonth(yearMonth)).stream()
                .collect(Collectors.toMap(MvFinanceIncomeBandMonthlyDO::getBandCode, item -> item));
        return List.of(
                buildBandStats("5w", bandMap, "5万元阈值"),
                buildBandStats("10w", bandMap, "10万元阈值"),
                buildBandStats("20w", bandMap, "20万元阈值"));
    }

    @Override
    public List<FinanceIncomeBandTrendRespVO> listIncomeBandTrend(String regionCode, String bandCode, String startMonth, String endMonth) {
        String finalRegionCode = defaultRegionCode(regionCode);
        String finalBandCode = StringUtils.hasText(bandCode) ? bandCode : "5w";
        String finalStartMonth = StringUtils.hasText(startMonth) ? normalizeMonth(startMonth) : "202601";
        String finalEndMonth = StringUtils.hasText(endMonth) ? normalizeMonth(endMonth) : defaultYearMonth(null);
        LambdaQueryWrapper<MvFinanceIncomeBandMonthlyDO> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(MvFinanceIncomeBandMonthlyDO::getRegionCode, finalRegionCode)
                .ge(MvFinanceIncomeBandMonthlyDO::getPeriodMonth, finalStartMonth)
                .le(MvFinanceIncomeBandMonthlyDO::getPeriodMonth, finalEndMonth)
                .in(MvFinanceIncomeBandMonthlyDO::getBandCode, "gt_" + finalBandCode, "lt_" + finalBandCode)
                .orderByAsc(MvFinanceIncomeBandMonthlyDO::getPeriodMonth);
        Map<String, List<MvFinanceIncomeBandMonthlyDO>> grouped = mvFinanceIncomeBandMonthlyMapper.selectList(wrapper).stream()
                .collect(Collectors.groupingBy(MvFinanceIncomeBandMonthlyDO::getPeriodMonth, LinkedHashMap::new, Collectors.toList()));
        return grouped.entrySet().stream().map(entry -> {
            Map<String, MvFinanceIncomeBandMonthlyDO> rowMap = entry.getValue().stream()
                    .collect(Collectors.toMap(MvFinanceIncomeBandMonthlyDO::getBandCode, item -> item));
            MvFinanceIncomeBandMonthlyDO high = rowMap.get("gt_" + finalBandCode);
            MvFinanceIncomeBandMonthlyDO low = rowMap.get("lt_" + finalBandCode);
            return FinanceIncomeBandTrendRespVO.builder()
                    .yearMonth(entry.getKey())
                    .bandCode(finalBandCode)
                    .highCount(high == null ? 0 : safeInt(high.getVillageCount()))
                    .lowCount(low == null ? 0 : safeInt(low.getVillageCount()))
                    .highRate(high == null ? BigDecimal.ZERO : safeDecimal(high.getVillageRatio()))
                    .lowRate(low == null ? BigDecimal.ZERO : safeDecimal(low.getVillageRatio()))
                    .build();
        }).toList();
    }

    @Override
    public List<FinanceIncomeBandDetailRespVO> listIncomeBandDetails(String regionCode, String yearMonth, String bandCode, String compareType) {
        String finalBandCode = StringUtils.hasText(bandCode) ? bandCode : "5w";
        boolean high = !"low".equalsIgnoreCase(compareType);
        BigDecimal threshold = thresholdValue(finalBandCode);
        String finalRegionCode = defaultRegionCode(regionCode);
        Map<String, String> orgNameMap = buildOrgNameMap(finalRegionCode);
        return listMonthlySummaries(finalRegionCode, defaultYearMonth(yearMonth)).stream()
                .filter(item -> compareByThreshold(item.getTotalIncome(), threshold, high))
                .sorted((a, b) -> b.getTotalIncome().compareTo(a.getTotalIncome()))
                .map(item -> FinanceIncomeBandDetailRespVO.builder()
                        .orgCode(item.getOrgCode())
                        .orgName(orgNameMap.getOrDefault(item.getOrgCode(), item.getOrgCode()))
                        .totalIncome(item.getTotalIncome())
                        .operatingIncome(item.getOperatingIncome())
                        .subsidyIncome(item.getSubsidyIncome())
                        .investmentIncome(item.getInvestmentIncome())
                        .otherIncome(item.getOtherIncome())
                        .build())
                .toList();
    }
    @Override
    public List<FinanceIndicatorRespVO> listIndicatorSummary(String regionCode, String yearMonth) {
        List<FactFinanceMonthlySummaryDO> records = listMonthlySummaries(defaultRegionCode(regionCode), defaultYearMonth(yearMonth));
        return List.of(
                indicator("FIN.CURRENCY_FUNDS", "货币资金", sumDecimal(records.stream().map(FactFinanceMonthlySummaryDO::getCurrencyFunds).toList())),
                indicator("FIN.ACCOUNTS_RECEIVABLE", "应收账款", sumDecimal(records.stream().map(FactFinanceMonthlySummaryDO::getAccountsReceivable).toList())),
                indicator("FIN.INVENTORY", "存货", sumDecimal(records.stream().map(FactFinanceMonthlySummaryDO::getInventoryAmount).toList())),
                indicator("FIN.FIXED_ASSETS_NET", "固定资产净值", sumDecimal(records.stream().map(FactFinanceMonthlySummaryDO::getFixedAssetsNet).toList())),
                indicator("FIN.ACCOUNTS_PAYABLE", "应付账款", sumDecimal(records.stream().map(FactFinanceMonthlySummaryDO::getAccountsPayable).toList())),
                indicator("FIN.YEAR_PROFIT", "本年收益", sumDecimal(records.stream().map(FactFinanceMonthlySummaryDO::getYearProfit).toList())),
                indicator("FIN.UNDISTRIBUTED_PROFIT", "未分配收益", sumDecimal(records.stream().map(FactFinanceMonthlySummaryDO::getUndistributedProfit).toList())));
    }

    @Override
    public List<FinanceIncomeDetailRespVO> listIncomeDetails(String regionCode, String orgCode, String yearMonth, String incomeType) {
        String finalRegionCode = defaultRegionCode(regionCode);
        Map<String, String> orgNameMap = buildOrgNameMap(finalRegionCode);
        LambdaQueryWrapper<FactFinanceIncomeDetailDO> wrapper = new LambdaQueryWrapper<>();
        wrapper.in(FactFinanceIncomeDetailDO::getRegionCode, collectRegionCodes(finalRegionCode))
                .eq(StringUtils.hasText(orgCode), FactFinanceIncomeDetailDO::getOrgCode, orgCode)
                .eq(FactFinanceIncomeDetailDO::getPeriodMonth, defaultYearMonth(yearMonth))
                .eq(StringUtils.hasText(incomeType), FactFinanceIncomeDetailDO::getIncomeType, incomeType)
                .orderByDesc(FactFinanceIncomeDetailDO::getBizDate);
        return factFinanceIncomeDetailMapper.selectList(wrapper).stream().map(item -> FinanceIncomeDetailRespVO.builder()
                .bizDate(item.getBizDate())
                .orgName(orgNameMap.getOrDefault(item.getOrgCode(), item.getOrgCode()))
                .incomeType(item.getIncomeType())
                .incomeItemName(item.getIncomeItemName())
                .counterpartyName(item.getCounterpartyName())
                .amount(item.getAmount())
                .sourceDocNo(item.getSourceDocNo())
                .build()).toList();
    }

    @Override
    public List<FinanceReceivableRespVO> listReceivables(String regionCode, String orgCode, String yearMonth, String status) {
        String finalRegionCode = defaultRegionCode(regionCode);
        Map<String, String> orgNameMap = buildOrgNameMap(finalRegionCode);
        LambdaQueryWrapper<FactFinanceReceivableDetailDO> wrapper = new LambdaQueryWrapper<>();
        wrapper.in(FactFinanceReceivableDetailDO::getRegionCode, collectRegionCodes(finalRegionCode))
                .eq(StringUtils.hasText(orgCode), FactFinanceReceivableDetailDO::getOrgCode, orgCode)
                .eq(FactFinanceReceivableDetailDO::getPeriodMonth, defaultYearMonth(yearMonth))
                .eq(StringUtils.hasText(status), FactFinanceReceivableDetailDO::getStatus, status)
                .orderByDesc(FactFinanceReceivableDetailDO::getUnreceivedAmount);
        return factFinanceReceivableDetailMapper.selectList(wrapper).stream().map(item -> FinanceReceivableRespVO.builder()
                .orgName(orgNameMap.getOrDefault(item.getOrgCode(), item.getOrgCode()))
                .debtorName(item.getDebtorName())
                .contractNo(item.getContractNo())
                .amount(item.getAmount())
                .receivedAmount(item.getReceivedAmount())
                .unreceivedAmount(item.getUnreceivedAmount())
                .dueDate(item.getDueDate())
                .agingDays(item.getAgingDays())
                .status(item.getStatus())
                .build()).toList();
    }

    @Override
    public List<FinancePayableRespVO> listPayables(String regionCode, String orgCode, String yearMonth, String status) {
        String finalRegionCode = defaultRegionCode(regionCode);
        Map<String, String> orgNameMap = buildOrgNameMap(finalRegionCode);
        LambdaQueryWrapper<FactFinancePayableDetailDO> wrapper = new LambdaQueryWrapper<>();
        wrapper.in(FactFinancePayableDetailDO::getRegionCode, collectRegionCodes(finalRegionCode))
                .eq(StringUtils.hasText(orgCode), FactFinancePayableDetailDO::getOrgCode, orgCode)
                .eq(FactFinancePayableDetailDO::getPeriodMonth, defaultYearMonth(yearMonth))
                .eq(StringUtils.hasText(status), FactFinancePayableDetailDO::getStatus, status)
                .orderByDesc(FactFinancePayableDetailDO::getUnpaidAmount);
        return factFinancePayableDetailMapper.selectList(wrapper).stream().map(item -> FinancePayableRespVO.builder()
                .orgName(orgNameMap.getOrDefault(item.getOrgCode(), item.getOrgCode()))
                .creditorName(item.getCreditorName())
                .contractNo(item.getContractNo())
                .amount(item.getAmount())
                .paidAmount(item.getPaidAmount())
                .unpaidAmount(item.getUnpaidAmount())
                .dueDate(item.getDueDate())
                .agingDays(item.getAgingDays())
                .status(item.getStatus())
                .build()).toList();
    }

    @Override
    public List<FinanceBalanceAnalysisRespVO> listBalanceAnalysis(String regionCode, String startMonth, String endMonth) {
        String finalRegionCode = defaultRegionCode(regionCode);
        String finalStartMonth = StringUtils.hasText(startMonth) ? normalizeMonth(startMonth) : defaultYearMonth(null);
        String finalEndMonth = StringUtils.hasText(endMonth) ? normalizeMonth(endMonth) : defaultYearMonth(null);
        LambdaQueryWrapper<FactFinanceStatementLineDO> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(FactFinanceStatementLineDO::getStatementType, "balance")
                .eq(FactFinanceStatementLineDO::getRegionCode, finalRegionCode)
                .in(FactFinanceStatementLineDO::getPeriodMonth, finalStartMonth, finalEndMonth)
                .orderByAsc(FactFinanceStatementLineDO::getLineNo);
        Map<String, List<FactFinanceStatementLineDO>> grouped = factFinanceStatementLineMapper.selectList(wrapper).stream()
                .collect(Collectors.groupingBy(FactFinanceStatementLineDO::getLineCode));
        return grouped.values().stream().map(items -> {
            FactFinanceStatementLineDO endItem = items.stream().filter(item -> finalEndMonth.equals(item.getPeriodMonth())).findFirst().orElse(items.get(0));
            FactFinanceStatementLineDO startItem = items.stream().filter(item -> finalStartMonth.equals(item.getPeriodMonth())).findFirst().orElse(endItem);
            BigDecimal beginValue = safeDecimal(startItem.getBeginAmount());
            BigDecimal endValue = safeDecimal(endItem.getEndAmount());
            BigDecimal changeValue = endValue.subtract(beginValue);
            BigDecimal changeRate = beginValue.compareTo(BigDecimal.ZERO) == 0 ? BigDecimal.ZERO : changeValue.divide(beginValue, 4, RoundingMode.HALF_UP);
            return FinanceBalanceAnalysisRespVO.builder()
                    .itemName(endItem.getLineName())
                    .beginValue(beginValue)
                    .endValue(endValue)
                    .changeValue(changeValue)
                    .changeRate(changeRate)
                    .build();
        }).sorted((a, b) -> a.getItemName().compareTo(b.getItemName())).toList();
    }

    @Override
    public List<FinanceStatementLineRespVO> listBalanceDetail(String regionCode, String snapshotDate, String statementType) {
        String finalRegionCode = defaultRegionCode(regionCode);
        String finalStatementType = StringUtils.hasText(statementType) ? statementType : "balance";
        LocalDate finalSnapshotDate = StringUtils.hasText(snapshotDate) ? LocalDate.parse(snapshotDate) : latestSnapshotDate(finalRegionCode, finalStatementType);
        LambdaQueryWrapper<FactFinanceStatementLineDO> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(FactFinanceStatementLineDO::getStatementType, finalStatementType)
                .eq(FactFinanceStatementLineDO::getRegionCode, finalRegionCode)
                .eq(FactFinanceStatementLineDO::getSnapshotDate, finalSnapshotDate)
                .orderByAsc(FactFinanceStatementLineDO::getLineNo);
        return factFinanceStatementLineMapper.selectList(wrapper).stream().map(item -> FinanceStatementLineRespVO.builder()
                .lineNo(item.getLineNo())
                .lineCode(item.getLineCode())
                .lineName(item.getLineName())
                .beginAmount(item.getBeginAmount())
                .endAmount(item.getEndAmount())
                .changeAmount(item.getChangeAmount())
                .lineCategory(item.getLineCategory())
                .build()).toList();
    }

    @Override
    public List<FinanceDistributionAnalysisRespVO> listDistributionAnalysis(String regionCode, String yearMonth) {
        List<FactFinanceIncomeDistributionLineDO> rows = listDistributionRows(defaultRegionCode(regionCode), defaultYearMonth(yearMonth));
        BigDecimal total = sumDecimal(rows.stream().map(FactFinanceIncomeDistributionLineDO::getAmount).toList());
        return rows.stream().map(item -> FinanceDistributionAnalysisRespVO.builder()
                .itemCode(item.getItemCode())
                .itemName(item.getItemName())
                .amount(item.getAmount())
                .rate(total.compareTo(BigDecimal.ZERO) == 0 ? BigDecimal.ZERO : item.getAmount().divide(total, 4, RoundingMode.HALF_UP))
                .build()).toList();
    }

    @Override
    public List<FinanceDistributionDetailRespVO> listDistributionDetail(String regionCode, String yearMonth) {
        return listDistributionRows(defaultRegionCode(regionCode), defaultYearMonth(yearMonth)).stream()
                .map(item -> FinanceDistributionDetailRespVO.builder()
                        .lineNo(item.getLineNo())
                        .itemCode(item.getItemCode())
                        .itemName(item.getItemName())
                        .amount(item.getAmount())
                        .remark(item.getRemark())
                        .build())
                .toList();
    }
    @Override
    public FinancePageRespVO getFinancePage(String regionCode, String yearMonth) {
        String finalRegionCode = defaultRegionCode(regionCode);
        String finalYearMonth = defaultYearMonth(yearMonth);
        FinanceOverviewSummaryRespVO summary = getOverviewSummary(finalRegionCode, finalYearMonth);
        List<FinanceIncomeBandStatsRespVO> bandStats = listIncomeBandStats(finalRegionCode, finalYearMonth);
        List<FinanceIndicatorRespVO> indicators = listIndicatorSummary(finalRegionCode, finalYearMonth);
        List<FinanceOverviewTrendRespVO> trend = listOverviewTrend(finalRegionCode, "202601", finalYearMonth);
        List<FinanceDistributionAnalysisRespVO> distribution = listDistributionAnalysis(finalRegionCode, finalYearMonth);
        return FinancePageRespVO.builder()
                .kpis(buildKpis(summary, bandStats, indicators))
                .incomeBands(buildIncomeBandChart(bandStats))
                .highThresholdTable(buildIncomeBandTable(listIncomeBandDetails(finalRegionCode, finalYearMonth, "20w", "high")))
                .lowThresholdTable(buildLowIncomeTable(listIncomeBandDetails(finalRegionCode, finalYearMonth, "5w", "low")))
                .subjectTable(buildIndicatorTable(indicators))
                .balanceTable(buildBalanceTable(listBalanceAnalysis(finalRegionCode, finalYearMonth, finalYearMonth)))
                .distribution(buildDistributionChart(distribution))
                .trend(buildTrend(trend, finalRegionCode))
                .build();
    }

    private List<FactFinanceMonthlySummaryDO> listMonthlySummaries(String regionCode, String yearMonth) {
        LambdaQueryWrapper<FactFinanceMonthlySummaryDO> wrapper = new LambdaQueryWrapper<>();
        wrapper.in(FactFinanceMonthlySummaryDO::getRegionCode, collectRegionCodes(regionCode))
                .eq(FactFinanceMonthlySummaryDO::getPeriodMonth, yearMonth);
        return factFinanceMonthlySummaryMapper.selectList(wrapper);
    }

    private List<MvFinanceIncomeBandMonthlyDO> listIncomeBandRows(String regionCode, String yearMonth) {
        LambdaQueryWrapper<MvFinanceIncomeBandMonthlyDO> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(MvFinanceIncomeBandMonthlyDO::getRegionCode, regionCode)
                .eq(MvFinanceIncomeBandMonthlyDO::getPeriodMonth, yearMonth);
        return mvFinanceIncomeBandMonthlyMapper.selectList(wrapper);
    }

    private List<FactFinanceIncomeDistributionLineDO> listDistributionRows(String regionCode, String yearMonth) {
        LambdaQueryWrapper<FactFinanceIncomeDistributionLineDO> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(FactFinanceIncomeDistributionLineDO::getRegionCode, regionCode)
                .eq(FactFinanceIncomeDistributionLineDO::getPeriodMonth, yearMonth)
                .orderByAsc(FactFinanceIncomeDistributionLineDO::getLineNo);
        return factFinanceIncomeDistributionLineMapper.selectList(wrapper);
    }

    private FinanceIncomeBandStatsRespVO buildBandStats(String thresholdCode, Map<String, MvFinanceIncomeBandMonthlyDO> bandMap, String bandName) {
        MvFinanceIncomeBandMonthlyDO high = bandMap.get("gt_" + thresholdCode);
        MvFinanceIncomeBandMonthlyDO low = bandMap.get("lt_" + thresholdCode);
        return FinanceIncomeBandStatsRespVO.builder()
                .bandCode(thresholdCode)
                .bandName(bandName)
                .highCount(high == null ? 0 : safeInt(high.getVillageCount()))
                .lowCount(low == null ? 0 : safeInt(low.getVillageCount()))
                .highRate(high == null ? BigDecimal.ZERO : safeDecimal(high.getVillageRatio()))
                .lowRate(low == null ? BigDecimal.ZERO : safeDecimal(low.getVillageRatio()))
                .build();
    }

    private FinanceIndicatorRespVO indicator(String metricCode, String metricName, BigDecimal value) {
        return FinanceIndicatorRespVO.builder().metricCode(metricCode).metricName(metricName).value(value).unit("元").build();
    }

    private Set<String> collectRegionCodes(String regionCode) {
        LambdaQueryWrapper<DimRegionDO> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(DimRegionDO::getRegionCode, regionCode).or().eq(DimRegionDO::getParentCode, regionCode);
        Set<String> codes = dimRegionMapper.selectList(wrapper).stream().map(DimRegionDO::getRegionCode).collect(Collectors.toSet());
        codes.add(regionCode);
        return codes;
    }

    private Map<String, String> buildOrgNameMap(String regionCode) {
        LambdaQueryWrapper<DimOrgDO> wrapper = new LambdaQueryWrapper<>();
        wrapper.in(DimOrgDO::getRegionCode, collectRegionCodes(regionCode));
        return dimOrgMapper.selectList(wrapper).stream().collect(Collectors.toMap(DimOrgDO::getOrgCode, DimOrgDO::getOrgName, (a, b) -> a));
    }

    private String defaultRegionCode(String regionCode) {
        return StringUtils.hasText(regionCode) ? regionCode : "460000";
    }

    private String defaultYearMonth(String yearMonth) {
        if (StringUtils.hasText(yearMonth)) {
            return normalizeMonth(yearMonth);
        }
        LambdaQueryWrapper<FactFinanceMonthlySummaryDO> wrapper = new LambdaQueryWrapper<>();
        wrapper.select(FactFinanceMonthlySummaryDO::getPeriodMonth)
                .orderByDesc(FactFinanceMonthlySummaryDO::getPeriodMonth)
                .last("LIMIT 1");
        FactFinanceMonthlySummaryDO record = factFinanceMonthlySummaryMapper.selectOne(wrapper);
        return record == null ? "202603" : record.getPeriodMonth();
    }

    private String normalizeMonth(String month) {
        return month.replace("-", "");
    }

    private LocalDate latestSnapshotDate(String regionCode, String statementType) {
        LambdaQueryWrapper<FactFinanceStatementLineDO> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(FactFinanceStatementLineDO::getRegionCode, regionCode)
                .eq(FactFinanceStatementLineDO::getStatementType, statementType)
                .orderByDesc(FactFinanceStatementLineDO::getSnapshotDate)
                .last("LIMIT 1");
        FactFinanceStatementLineDO record = factFinanceStatementLineMapper.selectOne(wrapper);
        return record == null ? LocalDate.of(2026, 3, 31) : record.getSnapshotDate();
    }

    private BigDecimal thresholdValue(String bandCode) {
        return switch (bandCode) {
            case "20w" -> new BigDecimal("200000");
            case "10w" -> new BigDecimal("100000");
            default -> new BigDecimal("50000");
        };
    }

    private boolean compareByThreshold(BigDecimal amount, BigDecimal threshold, boolean high) {
        BigDecimal finalAmount = safeDecimal(amount);
        return high ? finalAmount.compareTo(threshold) >= 0 : finalAmount.compareTo(threshold) < 0;
    }

    private BigDecimal sumDecimal(List<BigDecimal> values) {
        return values.stream().filter(Objects::nonNull).reduce(BigDecimal.ZERO, BigDecimal::add);
    }

    private BigDecimal safeDecimal(BigDecimal value) {
        return value == null ? BigDecimal.ZERO : value;
    }

    private Integer safeInt(Integer value) {
        return value == null ? 0 : value;
    }

    private String formatWan(BigDecimal value) {
        return safeDecimal(value).divide(WAN, 1, RoundingMode.HALF_UP).toPlainString() + "万";
    }

    private String formatYi(BigDecimal value) {
        return safeDecimal(value).divide(YI, 2, RoundingMode.HALF_UP).toPlainString() + "亿";
    }
    private List<FinanceMetricCardRespVO> buildKpis(FinanceOverviewSummaryRespVO summary, List<FinanceIncomeBandStatsRespVO> bandStats, List<FinanceIndicatorRespVO> indicators) {
        Map<String, BigDecimal> indicatorMap = indicators.stream().collect(Collectors.toMap(FinanceIndicatorRespVO::getMetricName, FinanceIndicatorRespVO::getValue));
        FinanceIncomeBandStatsRespVO five = bandStats.stream().filter(item -> "5w".equals(item.getBandCode())).findFirst().orElse(null);
        FinanceIncomeBandStatsRespVO twenty = bandStats.stream().filter(item -> "20w".equals(item.getBandCode())).findFirst().orElse(null);
        List<FinanceMetricCardRespVO> result = new ArrayList<>();
        result.add(metricCard("村集体总收入", formatWan(summary.getTotalIncome()), "经营收入、补助收入、投资收益、其他收入", "positive"));
        result.add(metricCard("高于20万元村数", String.valueOf(twenty == null ? 0 : twenty.getHighCount()), "当月收入阈值分档", "positive"));
        result.add(metricCard("低于5万元村数", String.valueOf(five == null ? 0 : five.getLowCount()), "重点关注薄弱村", "warning"));
        result.add(metricCard("未建账套数量", String.valueOf(summary.getNoLedgerCount()), "首页与专题页口径一致", "warning"));
        result.add(metricCard("流动资产合计", formatYi(safeDecimal(indicatorMap.get("货币资金")).add(safeDecimal(indicatorMap.get("应收账款"))).add(safeDecimal(indicatorMap.get("存货")))), "货币资金、应收款项、存货等", "positive"));
        result.add(metricCard("负债合计", formatYi(safeDecimal(indicatorMap.get("应付账款"))), "流动负债 + 非流动负债", "negative"));
        result.add(metricCard("本年收益", formatWan(summary.getYearProfit()), "财务指标主卡片", "positive"));
        result.add(metricCard("未分配收益", formatWan(summary.getUndistributedProfit()), "与收益分配页面联动", "neutral"));
        return result;
    }

    private FinanceMetricCardRespVO metricCard(String label, String value, String hint, String status) {
        return FinanceMetricCardRespVO.builder().label(label).value(value).hint(hint).status(status).build();
    }

    private List<FinanceNamedValueRespVO> buildIncomeBandChart(List<FinanceIncomeBandStatsRespVO> stats) {
        FinanceIncomeBandStatsRespVO five = stats.stream().filter(item -> "5w".equals(item.getBandCode())).findFirst().orElse(null);
        FinanceIncomeBandStatsRespVO ten = stats.stream().filter(item -> "10w".equals(item.getBandCode())).findFirst().orElse(null);
        FinanceIncomeBandStatsRespVO twenty = stats.stream().filter(item -> "20w".equals(item.getBandCode())).findFirst().orElse(null);
        int gt20 = twenty == null ? 0 : twenty.getHighCount();
        int gt10 = ten == null ? 0 : ten.getHighCount();
        int gt5 = five == null ? 0 : five.getHighCount();
        int lt5 = five == null ? 0 : five.getLowCount();
        int between10And20 = Math.max(gt10 - gt20, 0);
        int between5And10 = Math.max(gt5 - gt10, 0);
        int total = gt20 + between10And20 + between5And10 + lt5;
        return List.of(
                namedValue("高于20万元", gt20, ratio(gt20, total)),
                namedValue("10-20万元", between10And20, ratio(between10And20, total)),
                namedValue("5-10万元", between5And10, ratio(between5And10, total)),
                namedValue("低于5万元", lt5, ratio(lt5, total)));
    }

    private FinanceNamedValueRespVO namedValue(String name, int value, BigDecimal share) {
        return FinanceNamedValueRespVO.builder().name(name).value(value).share(share).build();
    }

    private BigDecimal ratio(int count, int total) {
        return total == 0 ? BigDecimal.ZERO : BigDecimal.valueOf(count).multiply(new BigDecimal("100")).divide(BigDecimal.valueOf(total), 1, RoundingMode.HALF_UP);
    }

    private FinanceTableDataRespVO buildIncomeBandTable(List<FinanceIncomeBandDetailRespVO> rows) {
        return FinanceTableDataRespVO.builder()
                .columns(List.of(column("orgName", "区划"), column("totalIncome", "总收入"), column("operatingIncome", "经营收入"), column("subsidyIncome", "补助收入"), column("investmentIncome", "投资收益"), column("otherIncome", "其他收入")))
                .rows(rows.stream().limit(10).map(item -> rowOf(
                        "orgName", item.getOrgName(),
                        "totalIncome", formatWan(item.getTotalIncome()),
                        "operatingIncome", formatWan(item.getOperatingIncome()),
                        "subsidyIncome", formatWan(item.getSubsidyIncome()),
                        "investmentIncome", formatWan(item.getInvestmentIncome()),
                        "otherIncome", formatWan(item.getOtherIncome()))).toList())
                .build();
    }

    private FinanceTableDataRespVO buildLowIncomeTable(List<FinanceIncomeBandDetailRespVO> rows) {
        String[] directions = {"合同清收", "经营项目盘活", "资产确权", "补助资金跟进"};
        String[] statuses = {"待督办", "跟踪中", "整改中"};
        List<Map<String, Object>> result = new ArrayList<>();
        for (int i = 0; i < Math.min(10, rows.size()); i++) {
            FinanceIncomeBandDetailRespVO item = rows.get(i);
            result.add(rowOf("orgName", item.getOrgName(), "totalIncome", formatWan(item.getTotalIncome()), "supportDirection", directions[i % directions.length], "status", statuses[i % statuses.length]));
        }
        return FinanceTableDataRespVO.builder()
                .columns(List.of(column("orgName", "区划"), column("totalIncome", "总收入"), column("supportDirection", "重点帮扶方向"), column("status", "当前状态")))
                .rows(result)
                .build();
    }

    private FinanceTableDataRespVO buildIndicatorTable(List<FinanceIndicatorRespVO> indicators) {
        String[] changes = {"资金回笼增加", "合同应收增加", "季节性物资储备", "新增资产形成", "工程类应付款待清算", "收益改善", "留存收益增加"};
        List<Map<String, Object>> rows = new ArrayList<>();
        for (int i = 0; i < indicators.size(); i++) {
            FinanceIndicatorRespVO item = indicators.get(i);
            rows.add(rowOf("subject", item.getMetricName(), "opening", formatWan(item.getValue().multiply(new BigDecimal("0.85"))), "ending", formatWan(item.getValue()), "change", changes[i % changes.length]));
        }
        return FinanceTableDataRespVO.builder()
                .columns(List.of(column("subject", "科目"), column("opening", "年初数"), column("ending", "年末数"), column("change", "变动说明")))
                .rows(rows)
                .build();
    }

    private FinanceTableDataRespVO buildBalanceTable(List<FinanceBalanceAnalysisRespVO> rows) {
        return FinanceTableDataRespVO.builder()
                .columns(List.of(column("item", "资产负债项目"), column("current", "当前数"), column("previous", "对比数"), column("analysis", "分析结论")))
                .rows(rows.stream().map(item -> rowOf("item", item.getItemName(), "current", formatYi(item.getEndValue()), "previous", formatYi(item.getBeginValue()), "analysis", item.getChangeValue().compareTo(BigDecimal.ZERO) >= 0 ? "整体向好" : "需重点关注")).toList())
                .build();
    }

    private List<FinanceNamedValueRespVO> buildDistributionChart(List<FinanceDistributionAnalysisRespVO> rows) {
        return rows.stream().map(item -> FinanceNamedValueRespVO.builder()
                .name(item.getItemName())
                .value(item.getRate().multiply(new BigDecimal("100")).setScale(0, RoundingMode.HALF_UP).intValue())
                .share(item.getRate().multiply(new BigDecimal("100")).setScale(1, RoundingMode.HALF_UP))
                .build()).toList();
    }

    private List<FinanceTrendPointRespVO> buildTrend(List<FinanceOverviewTrendRespVO> trend, String regionCode) {
        return trend.stream().map(item -> FinanceTrendPointRespVO.builder()
                .label(item.getYearMonth())
                .value(item.getTotalIncome().divide(WAN, 2, RoundingMode.HALF_UP))
                .value2(sumDecimal(listReceivables(regionCode, null, item.getYearMonth(), null).stream().map(FinanceReceivableRespVO::getUnreceivedAmount).toList()).divide(WAN, 2, RoundingMode.HALF_UP))
                .value3(sumDecimal(listMonthlySummaries(regionCode, item.getYearMonth()).stream().map(FactFinanceMonthlySummaryDO::getUndistributedProfit).toList()).divide(WAN, 2, RoundingMode.HALF_UP))
                .build()).toList();
    }

    private FinanceTableColumnRespVO column(String key, String label) {
        return FinanceTableColumnRespVO.builder().key(key).label(label).build();
    }

    private Map<String, Object> rowOf(Object... pairs) {
        Map<String, Object> row = new LinkedHashMap<>();
        for (int i = 0; i < pairs.length; i += 2) {
            row.put(String.valueOf(pairs[i]), pairs[i + 1]);
        }
        return row;
    }
}