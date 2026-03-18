package com.agriculture.villagefinance.module.finance.controller;

import com.agriculture.villagefinance.common.pojo.CommonResult;
import com.agriculture.villagefinance.module.finance.controller.vo.PendingVoucherRespVO;
import com.agriculture.villagefinance.module.finance.controller.vo.ReconciliationRespVO;
import com.agriculture.villagefinance.module.finance.service.FinanceFundsService;
import jakarta.validation.constraints.NotNull;
import lombok.RequiredArgsConstructor;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@Validated
@RestController
@RequestMapping("/api/village-finance/reconciliations")
@RequiredArgsConstructor
public class ReconciliationController {

    private final FinanceFundsService financeFundsService;

    @GetMapping
    public CommonResult<List<ReconciliationRespVO>> getReconciliations(@RequestParam @NotNull Long ledgerId,
                                                                        @RequestParam @NotNull Long periodId,
                                                                        @RequestParam(required = false) String accountType) {
        return CommonResult.success(financeFundsService.getReconciliations(ledgerId, periodId, accountType));
    }

    @GetMapping("/pending-vouchers")
    public CommonResult<List<PendingVoucherRespVO>> getPendingVouchers(@RequestParam @NotNull Long ledgerId,
                                                                        @RequestParam @NotNull Long periodId) {
        return CommonResult.success(financeFundsService.getPendingVouchers(ledgerId, periodId));
    }
}
