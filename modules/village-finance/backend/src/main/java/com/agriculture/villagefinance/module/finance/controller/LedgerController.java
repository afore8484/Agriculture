package com.agriculture.villagefinance.module.finance.controller;

import com.agriculture.villagefinance.common.pojo.CommonResult;
import com.agriculture.villagefinance.module.finance.controller.vo.LedgerRespVO;
import com.agriculture.villagefinance.module.finance.service.FinanceFoundationQueryService;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("/api/village-finance/ledgers")
@RequiredArgsConstructor
public class LedgerController {

    private final FinanceFoundationQueryService financeFoundationQueryService;

    @GetMapping
    public CommonResult<List<LedgerRespVO>> getLedgers(@RequestParam(required = false) String orgCode,
                                                       @RequestParam(required = false) String status) {
        return CommonResult.success(financeFoundationQueryService.getLedgers(orgCode, status));
    }
}
