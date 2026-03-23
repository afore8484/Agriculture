package com.agriculture.villagefinance.module.finance.controller;

import com.agriculture.villagefinance.common.pojo.CommonResult;
import com.agriculture.villagefinance.module.finance.controller.vo.HomeAssetDistributionRespVO;
import com.agriculture.villagefinance.module.finance.controller.vo.HomeOrgOptionRespVO;
import com.agriculture.villagefinance.module.finance.controller.vo.HomeRecentVoucherRespVO;
import com.agriculture.villagefinance.module.finance.controller.vo.HomeStatsRespVO;
import com.agriculture.villagefinance.module.finance.controller.vo.HomeTodoRespVO;
import com.agriculture.villagefinance.module.finance.controller.vo.HomeTrendRespVO;
import com.agriculture.villagefinance.module.finance.controller.vo.HomeYearOptionRespVO;
import com.agriculture.villagefinance.module.finance.controller.vo.ReportProgressRespVO;
import com.agriculture.villagefinance.module.finance.service.FinanceHomeService;
import cn.iocoder.yudao.framework.tenant.core.aop.TenantIgnore;
import jakarta.annotation.security.PermitAll;
import lombok.RequiredArgsConstructor;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@PermitAll
@TenantIgnore
@Validated
@RequiredArgsConstructor
@RequestMapping({"/api/village-finance/home", "/api/home"})
public class HomeController {

    private final FinanceHomeService financeHomeService;

    @GetMapping("/years")
    public CommonResult<List<HomeYearOptionRespVO>> getHomeYears() {
        return CommonResult.success(financeHomeService.queryHomeYears());
    }

    @GetMapping("/orgs")
    public CommonResult<List<HomeOrgOptionRespVO>> getHomeOrgs(@RequestParam(required = false) Integer year) {
        return CommonResult.success(financeHomeService.queryHomeOrgs(year));
    }

    @GetMapping("/stats")
    public CommonResult<HomeStatsRespVO> getHomeStats(@RequestParam(required = false) Long ledgerId,
                                                      @RequestParam(required = false) Long orgId,
                                                      @RequestParam(required = false) Long periodId,
                                                      @RequestParam(required = false) String period,
                                                      @RequestParam(required = false) Integer year,
                                                      @RequestParam(required = false) Long userId) {
        return CommonResult.success(financeHomeService.queryHomeStats(ledgerId, orgId, periodId, period, year, userId));
    }

    @GetMapping("/todos")
    public CommonResult<List<HomeTodoRespVO>> getHomeTodos(@RequestParam(required = false) Long userId,
                                                           @RequestParam(required = false) Long orgId,
                                                           @RequestParam(required = false) Integer year,
                                                           @RequestParam(required = false) Integer limit) {
        return CommonResult.success(financeHomeService.queryHomeTodos(userId, orgId, year, limit));
    }

    @GetMapping("/charts")
    public CommonResult<List<HomeTrendRespVO>> getHomeCharts(@RequestParam(required = false) Long ledgerId,
                                                             @RequestParam(required = false) Long orgId,
                                                             @RequestParam(required = false) Long periodId,
                                                             @RequestParam(required = false) String period,
                                                             @RequestParam(required = false) Integer year,
                                                             @RequestParam(required = false) Integer months) {
        return CommonResult.success(financeHomeService.queryHomeCharts(ledgerId, orgId, periodId, period, year, months));
    }

    @GetMapping("/asset-distribution")
    public CommonResult<List<HomeAssetDistributionRespVO>> getAssetDistribution(@RequestParam(required = false) Long ledgerId,
                                                                                 @RequestParam(required = false) Long orgId,
                                                                                 @RequestParam(required = false) Integer year) {
        return CommonResult.success(financeHomeService.queryAssetDistribution(ledgerId, orgId, year));
    }

    @GetMapping("/recent-vouchers")
    public CommonResult<List<HomeRecentVoucherRespVO>> getRecentVouchers(@RequestParam(required = false) Long ledgerId,
                                                                          @RequestParam(required = false) Long orgId,
                                                                          @RequestParam(required = false) Long periodId,
                                                                          @RequestParam(required = false) String period,
                                                                          @RequestParam(required = false) Integer year,
                                                                          @RequestParam(required = false) Integer limit) {
        return CommonResult.success(financeHomeService.queryRecentVouchers(ledgerId, orgId, periodId, period, year, limit));
    }

    @GetMapping("/progress")
    public CommonResult<ReportProgressRespVO> getHomeProgress(@RequestParam(required = false) Long ledgerId,
                                                               @RequestParam(required = false) Long orgId,
                                                               @RequestParam(required = false) Long periodId,
                                                               @RequestParam(required = false) String period,
                                                               @RequestParam(required = false) Integer year) {
        return CommonResult.success(financeHomeService.queryHomeProgress(ledgerId, orgId, periodId, period, year));
    }
}
