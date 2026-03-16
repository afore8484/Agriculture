package com.agriculture.villagefinance.module.finance.controller;

import com.agriculture.villagefinance.common.pojo.CommonResult;
import com.agriculture.villagefinance.module.finance.controller.vo.VoucherActionRespVO;
import com.agriculture.villagefinance.module.finance.controller.vo.VoucherAuditReqVO;
import com.agriculture.villagefinance.module.finance.controller.vo.VoucherCreateReqVO;
import com.agriculture.villagefinance.module.finance.controller.vo.VoucherDeleteRespVO;
import com.agriculture.villagefinance.module.finance.controller.vo.VoucherDetailRespVO;
import com.agriculture.villagefinance.module.finance.controller.vo.VoucherListRespVO;
import com.agriculture.villagefinance.module.finance.controller.vo.VoucherRecycleRespVO;
import com.agriculture.villagefinance.module.finance.controller.vo.VoucherUnauditReqVO;
import com.agriculture.villagefinance.module.finance.controller.vo.VoucherUpdateReqVO;
import com.agriculture.villagefinance.module.finance.service.VoucherService;
import jakarta.validation.Valid;
import jakarta.validation.constraints.NotNull;
import lombok.RequiredArgsConstructor;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.time.LocalDate;
import java.util.List;

@Validated
@RestController
@RequestMapping("/api/village-finance/vouchers")
@RequiredArgsConstructor
public class VoucherController {

    private final VoucherService voucherService;

    @GetMapping
    public CommonResult<List<VoucherListRespVO>> getVouchers(@RequestParam @NotNull Long ledgerId,
                                                             @RequestParam(required = false) Long periodId,
                                                             @RequestParam(required = false) String voucherNo,
                                                             @RequestParam(required = false) String auditStatus,
                                                             @RequestParam(required = false) LocalDate startDate,
                                                             @RequestParam(required = false) LocalDate endDate,
                                                             @RequestParam(required = false) Integer pageNum,
                                                             @RequestParam(required = false) Integer pageSize) {
        return CommonResult.success(voucherService.getVouchers(
                ledgerId, periodId, voucherNo, auditStatus, startDate, endDate, pageNum, pageSize
        ));
    }

    @GetMapping("/{voucherId}")
    public CommonResult<VoucherDetailRespVO> getVoucher(@PathVariable Long voucherId) {
        return CommonResult.success(voucherService.getVoucher(voucherId));
    }

    @PostMapping
    public CommonResult<VoucherActionRespVO> createVoucher(@Valid @RequestBody VoucherCreateReqVO reqVO) {
        return CommonResult.success(voucherService.createVoucher(reqVO));
    }

    @PutMapping("/{voucherId}")
    public CommonResult<VoucherActionRespVO> updateVoucher(@PathVariable Long voucherId,
                                                           @Valid @RequestBody VoucherUpdateReqVO reqVO) {
        return CommonResult.success(voucherService.updateVoucher(voucherId, reqVO));
    }

    @PostMapping("/{voucherId}/audit")
    public CommonResult<VoucherActionRespVO> auditVoucher(@PathVariable Long voucherId,
                                                          @Valid @RequestBody VoucherAuditReqVO reqVO) {
        return CommonResult.success(voucherService.auditVoucher(voucherId, reqVO));
    }

    @PostMapping("/{voucherId}/unaudit")
    public CommonResult<VoucherActionRespVO> unauditVoucher(@PathVariable Long voucherId,
                                                            @Valid @RequestBody VoucherUnauditReqVO reqVO) {
        return CommonResult.success(voucherService.unauditVoucher(voucherId, reqVO));
    }

    @DeleteMapping("/{voucherId}")
    public CommonResult<VoucherDeleteRespVO> deleteVoucher(@PathVariable Long voucherId,
                                                           @RequestParam(required = false) String reason,
                                                           @RequestParam(required = false) Long operatorId) {
        return CommonResult.success(voucherService.deleteVoucher(voucherId, reason, operatorId));
    }

    @GetMapping("/recycle-bin")
    public CommonResult<List<VoucherRecycleRespVO>> getRecycleVouchers(@RequestParam @NotNull Long ledgerId,
                                                                       @RequestParam(required = false) Integer pageNum,
                                                                       @RequestParam(required = false) Integer pageSize) {
        return CommonResult.success(voucherService.getRecycleVouchers(ledgerId, pageNum, pageSize));
    }

    @PostMapping("/{voucherId}/restore")
    public CommonResult<VoucherActionRespVO> restoreVoucher(@PathVariable Long voucherId,
                                                            @RequestParam(required = false) Long operatorId) {
        return CommonResult.success(voucherService.restoreVoucher(voucherId, operatorId));
    }

    @DeleteMapping("/recycle-bin/{voucherId}")
    public CommonResult<VoucherDeleteRespVO> purgeRecycleVoucher(@PathVariable Long voucherId,
                                                                 @RequestParam(required = false) Long operatorId) {
        return CommonResult.success(voucherService.purgeRecycleVoucher(voucherId, operatorId));
    }
}
