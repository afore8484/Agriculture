package com.agriculture.villagefinance.module.finance.controller;

import com.agriculture.villagefinance.common.pojo.CommonResult;
import com.agriculture.villagefinance.module.finance.controller.vo.BankAccountCreateReqVO;
import com.agriculture.villagefinance.module.finance.controller.vo.BankAccountRespVO;
import com.agriculture.villagefinance.module.finance.controller.vo.CashAccountCreateReqVO;
import com.agriculture.villagefinance.module.finance.controller.vo.CashAccountRespVO;
import com.agriculture.villagefinance.module.finance.service.FinanceFundsService;
import jakarta.validation.Valid;
import jakarta.validation.constraints.NotNull;
import lombok.RequiredArgsConstructor;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@Validated
@RestController
@RequestMapping("/api/village-finance/accounts")
@RequiredArgsConstructor
public class AccountController {

    private final FinanceFundsService financeFundsService;

    @GetMapping("/cash")
    public CommonResult<List<CashAccountRespVO>> getCashAccounts(@RequestParam @NotNull Long ledgerId,
                                                                 @RequestParam(required = false) String status) {
        return CommonResult.success(financeFundsService.getCashAccounts(ledgerId, status));
    }

    @PostMapping("/cash")
    public CommonResult<CashAccountRespVO> createCashAccount(@Valid @RequestBody CashAccountCreateReqVO reqVO) {
        return CommonResult.success(financeFundsService.createCashAccount(reqVO));
    }

    @GetMapping("/bank")
    public CommonResult<List<BankAccountRespVO>> getBankAccounts(@RequestParam @NotNull Long ledgerId,
                                                                 @RequestParam(required = false) String status) {
        return CommonResult.success(financeFundsService.getBankAccounts(ledgerId, status));
    }

    @PostMapping("/bank")
    public CommonResult<BankAccountRespVO> createBankAccount(@Valid @RequestBody BankAccountCreateReqVO reqVO) {
        return CommonResult.success(financeFundsService.createBankAccount(reqVO));
    }
}
