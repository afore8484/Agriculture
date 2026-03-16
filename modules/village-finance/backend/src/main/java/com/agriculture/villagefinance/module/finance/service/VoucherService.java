package com.agriculture.villagefinance.module.finance.service;

import com.agriculture.villagefinance.module.finance.controller.vo.VoucherActionRespVO;
import com.agriculture.villagefinance.module.finance.controller.vo.VoucherAuditReqVO;
import com.agriculture.villagefinance.module.finance.controller.vo.VoucherCreateReqVO;
import com.agriculture.villagefinance.module.finance.controller.vo.VoucherDeleteRespVO;
import com.agriculture.villagefinance.module.finance.controller.vo.VoucherDetailRespVO;
import com.agriculture.villagefinance.module.finance.controller.vo.VoucherListRespVO;
import com.agriculture.villagefinance.module.finance.controller.vo.VoucherRecycleRespVO;
import com.agriculture.villagefinance.module.finance.controller.vo.VoucherUnauditReqVO;
import com.agriculture.villagefinance.module.finance.controller.vo.VoucherUpdateReqVO;

import java.time.LocalDate;
import java.util.List;

public interface VoucherService {

    List<VoucherListRespVO> getVouchers(Long ledgerId, Long periodId, String voucherNo, String auditStatus,
                                        LocalDate startDate, LocalDate endDate, Integer pageNum, Integer pageSize);

    VoucherDetailRespVO getVoucher(Long voucherId);

    VoucherActionRespVO createVoucher(VoucherCreateReqVO reqVO);

    VoucherActionRespVO updateVoucher(Long voucherId, VoucherUpdateReqVO reqVO);

    VoucherActionRespVO auditVoucher(Long voucherId, VoucherAuditReqVO reqVO);

    VoucherActionRespVO unauditVoucher(Long voucherId, VoucherUnauditReqVO reqVO);

    VoucherDeleteRespVO deleteVoucher(Long voucherId, String reason, Long operatorId);

    List<VoucherRecycleRespVO> getRecycleVouchers(Long ledgerId, Integer pageNum, Integer pageSize);

    VoucherActionRespVO restoreVoucher(Long voucherId, Long operatorId);

    VoucherDeleteRespVO purgeRecycleVoucher(Long voucherId, Long operatorId);
}
