package com.agriculture.villagefinance.module.finance.service;

import com.agriculture.villagefinance.module.finance.controller.vo.HomeAssetDistributionRespVO;
import com.agriculture.villagefinance.module.finance.controller.vo.HomeOrgOptionRespVO;
import com.agriculture.villagefinance.module.finance.controller.vo.HomeRecentVoucherRespVO;
import com.agriculture.villagefinance.module.finance.controller.vo.HomeStatsRespVO;
import com.agriculture.villagefinance.module.finance.controller.vo.HomeTodoRespVO;
import com.agriculture.villagefinance.module.finance.controller.vo.HomeTrendRespVO;
import com.agriculture.villagefinance.module.finance.controller.vo.HomeYearOptionRespVO;
import com.agriculture.villagefinance.module.finance.controller.vo.ReportProgressRespVO;

import java.util.List;

public interface FinanceHomeService {

    List<HomeYearOptionRespVO> queryHomeYears();

    List<HomeOrgOptionRespVO> queryHomeOrgs(Integer year);

    HomeStatsRespVO queryHomeStats(Long ledgerId, Long orgId, Long periodId, String period, Integer year, Long userId);

    List<HomeTodoRespVO> queryHomeTodos(Long userId, Long orgId, Integer year, Integer limit);

    List<HomeTrendRespVO> queryHomeCharts(Long ledgerId, Long orgId, Long periodId, String period, Integer year, Integer months);

    List<HomeAssetDistributionRespVO> queryAssetDistribution(Long ledgerId, Long orgId, Integer year);

    List<HomeRecentVoucherRespVO> queryRecentVouchers(Long ledgerId, Long orgId, Long periodId, String period, Integer year, Integer limit);

    ReportProgressRespVO queryHomeProgress(Long ledgerId, Long orgId, Long periodId, String period, Integer year);
}
