package com.agriculture.villagefinance.module.finance.service;

import com.agriculture.villagefinance.module.finance.controller.vo.DetailLedgerRespVO;
import com.agriculture.villagefinance.module.finance.controller.vo.GeneralLedgerRespVO;
import com.agriculture.villagefinance.module.finance.controller.vo.JournalLedgerRespVO;
import com.agriculture.villagefinance.module.finance.controller.vo.MultiLedgerRespVO;
import com.agriculture.villagefinance.module.finance.controller.vo.ReportExportRespVO;
import com.agriculture.villagefinance.module.finance.controller.vo.ReportPrintRespVO;
import com.agriculture.villagefinance.module.finance.controller.vo.ReportProgressRespVO;
import com.agriculture.villagefinance.module.finance.controller.vo.AssistBalanceRespVO;

import java.time.LocalDate;
import java.util.List;

public interface FinanceReportService {

    List<GeneralLedgerRespVO> queryGeneralLedger(Long ledgerId, Long periodId, String subjectCode, Boolean includeChild);

    List<DetailLedgerRespVO> queryDetailLedger(Long ledgerId, Long periodId, Long subjectId, LocalDate startDate, LocalDate endDate);

    List<GeneralLedgerRespVO> querySubjectBalance(Long ledgerId, Long periodId);

    List<JournalLedgerRespVO> queryJournalLedger(Long ledgerId, Long periodId, LocalDate startDate, LocalDate endDate, String keyword);

    List<AssistBalanceRespVO> queryAssistBalance(Long ledgerId, Long periodId, String assistTypeId);

    List<MultiLedgerRespVO> queryMultiLedger(Long ledgerId, Long periodId, String subjectGroup);

    ReportProgressRespVO queryReportProgress(Long ledgerId, Long periodId);

    ReportExportRespVO exportReport(String reportType, Long periodId, String format);

    ReportPrintRespVO printReport(String reportType, Long periodId);
}
