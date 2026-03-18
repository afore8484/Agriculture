package com.agriculture.villagefinance.module.finance.controller;

import com.agriculture.villagefinance.common.pojo.CommonResult;
import com.agriculture.villagefinance.module.finance.controller.vo.JournalCreateReqVO;
import com.agriculture.villagefinance.module.finance.controller.vo.JournalListRespVO;
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

import java.time.LocalDate;
import java.util.List;

@Validated
@RestController
@RequestMapping("/api/village-finance/journals")
@RequiredArgsConstructor
public class JournalController {

    private final FinanceFundsService financeFundsService;

    @GetMapping("/bank")
    public CommonResult<List<JournalListRespVO>> getBankJournals(@RequestParam @NotNull Long accountId,
                                                                 @RequestParam(required = false) LocalDate startDate,
                                                                 @RequestParam(required = false) LocalDate endDate,
                                                                 @RequestParam(required = false) Integer pageNum,
                                                                 @RequestParam(required = false) Integer pageSize) {
        return CommonResult.success(financeFundsService.getBankJournals(accountId, startDate, endDate, pageNum, pageSize));
    }

    @PostMapping("/bank")
    public CommonResult<JournalListRespVO> createBankJournal(@Valid @RequestBody JournalCreateReqVO reqVO) {
        return CommonResult.success(financeFundsService.createBankJournal(reqVO));
    }

    @GetMapping("/cash")
    public CommonResult<List<JournalListRespVO>> getCashJournals(@RequestParam @NotNull Long accountId,
                                                                 @RequestParam(required = false) LocalDate startDate,
                                                                 @RequestParam(required = false) LocalDate endDate,
                                                                 @RequestParam(required = false) Integer pageNum,
                                                                 @RequestParam(required = false) Integer pageSize) {
        return CommonResult.success(financeFundsService.getCashJournals(accountId, startDate, endDate, pageNum, pageSize));
    }

    @PostMapping("/cash")
    public CommonResult<JournalListRespVO> createCashJournal(@Valid @RequestBody JournalCreateReqVO reqVO) {
        return CommonResult.success(financeFundsService.createCashJournal(reqVO));
    }
}
