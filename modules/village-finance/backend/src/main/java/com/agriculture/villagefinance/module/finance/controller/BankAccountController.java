package com.agriculture.villagefinance.module.finance.controller;

import com.agriculture.villagefinance.common.pojo.CommonResult;
import com.agriculture.villagefinance.module.finance.controller.vo.BankAccountRespVO;
import com.agriculture.villagefinance.module.finance.controller.vo.BankAccountUpdateReqVO;
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
@RequestMapping("/api/village-finance/bank-accounts")
@RequiredArgsConstructor
public class BankAccountController {

    private final FinanceFundsService financeFundsService;

    @PutMapping("/{accountId}")
    public CommonResult<BankAccountRespVO> update(@PathVariable Long accountId,
                                                   @Valid @RequestBody BankAccountUpdateReqVO reqVO) {
        return CommonResult.success(financeFundsService.updateBankAccount(accountId, reqVO));
    }

    @PostMapping("/{accountId}/enable")
    public CommonResult<BankAccountRespVO> enable(@PathVariable Long accountId) {
        return CommonResult.success(financeFundsService.enableBankAccount(accountId));
    }

    @PostMapping("/{accountId}/disable")
    public CommonResult<BankAccountRespVO> disable(@PathVariable Long accountId) {
        return CommonResult.success(financeFundsService.disableBankAccount(accountId));
    }

    @DeleteMapping("/{accountId}")
    public CommonResult<Boolean> delete(@PathVariable Long accountId) {
        financeFundsService.deleteBankAccount(accountId);
        return CommonResult.success(true);
    }
}
