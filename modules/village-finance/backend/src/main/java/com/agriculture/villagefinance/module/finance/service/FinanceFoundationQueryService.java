package com.agriculture.villagefinance.module.finance.service;

import com.agriculture.villagefinance.module.finance.controller.vo.LedgerRespVO;
import com.agriculture.villagefinance.module.finance.controller.vo.PeriodRespVO;
import com.agriculture.villagefinance.module.finance.controller.vo.SubjectTreeRespVO;

import java.util.List;

public interface FinanceFoundationQueryService {

    List<LedgerRespVO> getLedgers(String orgCode, String status);

    List<PeriodRespVO> getPeriods(Long ledgerId, Integer year);

    List<SubjectTreeRespVO> getSubjectTree(Long ledgerId);
}
