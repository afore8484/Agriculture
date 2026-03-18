package com.agriculture.villagefinance.module.finance.controller;

import com.agriculture.villagefinance.common.pojo.CommonResult;
import com.agriculture.villagefinance.module.finance.controller.vo.PeriodCloseReqVO;
import com.agriculture.villagefinance.module.finance.controller.vo.PeriodCloseRespVO;
import com.agriculture.villagefinance.module.finance.controller.vo.PeriodReopenReqVO;
import com.agriculture.villagefinance.module.finance.controller.vo.PeriodReopenRespVO;
import com.agriculture.villagefinance.module.finance.controller.vo.TrialBalanceRespVO;
import com.agriculture.villagefinance.module.finance.service.FinanceFundsService;
import jakarta.validation.Valid;
import jakarta.validation.constraints.NotNull;
import lombok.RequiredArgsConstructor;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@Validated
@RestController
@RequestMapping("/api/village-finance/period-close")
@RequiredArgsConstructor
public class PeriodCloseController {

    private final FinanceFundsService financeFundsService;

    @PostMapping("/trial-balance")
    public CommonResult<TrialBalanceRespVO> trialBalance(@RequestParam @NotNull Long ledgerId,
                                                         @RequestParam @NotNull Long periodId,
                                                         @RequestParam(required = false) Long templateId) {
        return CommonResult.success(financeFundsService.trialBalance(ledgerId, periodId, templateId));
    }

    @PostMapping("/close")
    public CommonResult<PeriodCloseRespVO> close(@Valid @RequestBody PeriodCloseReqVO reqVO) {
        return CommonResult.success(financeFundsService.closePeriod(reqVO));
    }

    @PostMapping("/reopen")
    public CommonResult<PeriodReopenRespVO> reopen(@Valid @RequestBody PeriodReopenReqVO reqVO) {
        return CommonResult.success(financeFundsService.reopenPeriod(reqVO));
    }
}
