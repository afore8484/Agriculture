package com.agriculture.villagefinance.module.finance.controller;

import com.agriculture.villagefinance.common.pojo.CommonResult;
import com.agriculture.villagefinance.module.finance.controller.vo.PeriodRespVO;
import com.agriculture.villagefinance.module.finance.service.FinanceFoundationQueryService;
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
@RequestMapping("/api/village-finance/periods")
@RequiredArgsConstructor
public class PeriodController {

    private final FinanceFoundationQueryService financeFoundationQueryService;

    @GetMapping
    public CommonResult<List<PeriodRespVO>> getPeriods(@RequestParam @NotNull Long ledgerId,
                                                       @RequestParam(required = false) Integer year) {
        return CommonResult.success(financeFoundationQueryService.getPeriods(ledgerId, year));
    }
}
