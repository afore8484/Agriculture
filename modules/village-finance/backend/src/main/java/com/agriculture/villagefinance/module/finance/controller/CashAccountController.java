package com.agriculture.villagefinance.module.finance.controller;

import com.agriculture.villagefinance.common.pojo.CommonResult;
import com.agriculture.villagefinance.module.finance.controller.vo.CashAccountRespVO;
import com.agriculture.villagefinance.module.finance.controller.vo.CashAccountUpdateReqVO;
import com.agriculture.villagefinance.module.finance.service.FinanceFundsService;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/village-finance/cash-accounts")
@RequiredArgsConstructor
public class CashAccountController {

    private final FinanceFundsService financeFundsService;

    @PutMapping("/{accountId}")
    public CommonResult<CashAccountRespVO> update(@PathVariable Long accountId,
                                                   @Valid @RequestBody CashAccountUpdateReqVO reqVO) {
        return CommonResult.success(financeFundsService.updateCashAccount(accountId, reqVO));
    }

    @PostMapping("/{accountId}/enable")
    public CommonResult<CashAccountRespVO> enable(@PathVariable Long accountId) {
        return CommonResult.success(financeFundsService.enableCashAccount(accountId));
    }

    @PostMapping("/{accountId}/disable")
    public CommonResult<CashAccountRespVO> disable(@PathVariable Long accountId) {
        return CommonResult.success(financeFundsService.disableCashAccount(accountId));
    }

    @DeleteMapping("/{accountId}")
    public CommonResult<Boolean> delete(@PathVariable Long accountId) {
        financeFundsService.deleteCashAccount(accountId);
        return CommonResult.success(true);
    }
}
