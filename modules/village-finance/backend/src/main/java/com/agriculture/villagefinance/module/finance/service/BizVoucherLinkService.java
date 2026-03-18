package com.agriculture.villagefinance.module.finance.service;

import com.agriculture.villagefinance.module.finance.controller.vo.VoucherActionRespVO;
import com.agriculture.villagefinance.module.finance.service.dto.BizVoucherCreateCmd;
import com.agriculture.villagefinance.module.finance.service.dto.BizVoucherTraceRespVO;

public interface BizVoucherLinkService {

    VoucherActionRespVO createVoucher(BizVoucherCreateCmd cmd);

    BizVoucherTraceRespVO traceByVoucherId(Long voucherId);

    BizVoucherTraceRespVO queryVoucherByBiz(String voucherType, Long bizId);
}
