package com.agriculture.villagefinance.module.finance.controller;

import com.agriculture.villagefinance.common.pojo.CommonResult;
import com.agriculture.villagefinance.module.finance.controller.vo.InternalTransferReqVO;
import com.agriculture.villagefinance.module.finance.controller.vo.InternalTransferRespVO;
import com.agriculture.villagefinance.module.finance.service.FinanceFundsService;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.time.LocalDate;
import java.util.List;

@Validated
@RestController
@RequestMapping("/api/village-finance/internal-transfers")
@RequiredArgsConstructor
public class InternalTransferController {

    private final FinanceFundsService financeFundsService;

    @GetMapping
    public CommonResult<List<InternalTransferRespVO>> getTransfers(@RequestParam(required = false) Long fromAccountId,
                                                                   @RequestParam(required = false) Long toAccountId,
                                                                   @RequestParam(required = false) LocalDate startDate,
                                                                   @RequestParam(required = false) LocalDate endDate) {
        return CommonResult.success(financeFundsService.getInternalTransfers(fromAccountId, toAccountId, startDate, endDate));
    }

    @PostMapping
    public CommonResult<InternalTransferRespVO> createTransfer(@Valid @RequestBody InternalTransferReqVO reqVO) {
        return CommonResult.success(financeFundsService.createInternalTransfer(reqVO));
    }

    @DeleteMapping("/{transferId}")
    public CommonResult<InternalTransferRespVO> deleteTransfer(@PathVariable Long transferId,
                                                               @RequestParam(required = false) Long operatorId) {
        return CommonResult.success(financeFundsService.deleteInternalTransfer(transferId, operatorId));
    }
}
