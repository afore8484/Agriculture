package com.agriculture.villagefinance.module.finance.service.dto;

import com.agriculture.villagefinance.module.finance.controller.vo.VoucherEntryReqVO;
import lombok.Data;

import java.time.LocalDate;
import java.util.List;

@Data
public class BizVoucherCreateCmd {

    private Long ledgerId;
    private Long periodId;
    private LocalDate voucherDate;
    private String voucherType;
    private Long bizId;
    private String summary;
    private String remark;
    private Long operatorId;
    private List<VoucherEntryReqVO> entries;
}
