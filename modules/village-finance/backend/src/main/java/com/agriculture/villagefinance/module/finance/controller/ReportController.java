package com.agriculture.villagefinance.module.finance.controller;

import com.agriculture.villagefinance.common.pojo.CommonResult;
import com.agriculture.villagefinance.module.finance.controller.vo.DetailLedgerRespVO;
import com.agriculture.villagefinance.module.finance.controller.vo.GeneralLedgerRespVO;
import com.agriculture.villagefinance.module.finance.controller.vo.JournalLedgerRespVO;
import com.agriculture.villagefinance.module.finance.controller.vo.AssistBalanceRespVO;
import com.agriculture.villagefinance.module.finance.controller.vo.MultiLedgerRespVO;
import com.agriculture.villagefinance.module.finance.controller.vo.ReportExportRespVO;
import com.agriculture.villagefinance.module.finance.controller.vo.ReportPrintRespVO;
import com.agriculture.villagefinance.module.finance.controller.vo.ReportProgressRespVO;
import com.agriculture.villagefinance.module.finance.service.FinanceReportService;
import lombok.RequiredArgsConstructor;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.time.LocalDate;
import java.util.List;

@RestController
@Validated
@RequiredArgsConstructor
@RequestMapping({"/api/village-finance/report", "/api/report"})
public class ReportController {

    private final FinanceReportService financeReportService;

    @GetMapping("/general-ledger")
    public CommonResult<List<GeneralLedgerRespVO>> getGeneralLedger(@RequestParam Long ledgerId,
                                                                    @RequestParam Long periodId,
                                                                    @RequestParam(required = false) String subjectCode,
                                                                    @RequestParam(required = false) Boolean includeChild) {
        return CommonResult.success(financeReportService.queryGeneralLedger(
                ledgerId, periodId, subjectCode, includeChild
        ));
    }

    @GetMapping("/detail-ledger")
    public CommonResult<List<DetailLedgerRespVO>> getDetailLedger(@RequestParam Long ledgerId,
                                                                  @RequestParam Long periodId,
                                                                  @RequestParam Long subjectId,
                                                                  @RequestParam(required = false)
                                                                  @DateTimeFormat(iso = DateTimeFormat.ISO.DATE)
                                                                  LocalDate startDate,
                                                                  @RequestParam(required = false)
                                                                  @DateTimeFormat(iso = DateTimeFormat.ISO.DATE)
                                                                  LocalDate endDate) {
        return CommonResult.success(financeReportService.queryDetailLedger(
                ledgerId, periodId, subjectId, startDate, endDate
        ));
    }

    @GetMapping("/balance")
    public CommonResult<List<GeneralLedgerRespVO>> getSubjectBalance(@RequestParam Long ledgerId,
                                                                     @RequestParam Long periodId) {
        return CommonResult.success(financeReportService.querySubjectBalance(ledgerId, periodId));
    }

    @GetMapping("/journal")
    public CommonResult<List<JournalLedgerRespVO>> getJournalLedger(@RequestParam Long ledgerId,
                                                                    @RequestParam Long periodId,
                                                                    @RequestParam(required = false)
                                                                    @DateTimeFormat(iso = DateTimeFormat.ISO.DATE)
                                                                    LocalDate startDate,
                                                                    @RequestParam(required = false)
                                                                    @DateTimeFormat(iso = DateTimeFormat.ISO.DATE)
                                                                    LocalDate endDate,
                                                                    @RequestParam(required = false) String keyword) {
        return CommonResult.success(financeReportService.queryJournalLedger(
                ledgerId, periodId, startDate, endDate, keyword
        ));
    }

    @GetMapping("/assist-balance")
    public CommonResult<List<AssistBalanceRespVO>> getAssistBalance(@RequestParam Long ledgerId,
                                                                    @RequestParam Long periodId,
                                                                    @RequestParam(required = false) String assistTypeId) {
        return CommonResult.success(financeReportService.queryAssistBalance(ledgerId, periodId, assistTypeId));
    }

    @GetMapping("/multi-ledger")
    public CommonResult<List<MultiLedgerRespVO>> getMultiLedger(@RequestParam Long ledgerId,
                                                                @RequestParam Long periodId,
                                                                @RequestParam(required = false) String subjectGroup) {
        return CommonResult.success(financeReportService.queryMultiLedger(ledgerId, periodId, subjectGroup));
    }

    @GetMapping("/progress")
    public CommonResult<ReportProgressRespVO> getReportProgress(@RequestParam Long ledgerId,
                                                                @RequestParam Long periodId) {
        return CommonResult.success(financeReportService.queryReportProgress(ledgerId, periodId));
    }

    @GetMapping("/export")
    public CommonResult<ReportExportRespVO> exportReport(@RequestParam String reportType,
                                                         @RequestParam Long periodId,
                                                         @RequestParam(required = false) String format) {
        return CommonResult.success(financeReportService.exportReport(reportType, periodId, format));
    }

    @GetMapping("/print")
    public CommonResult<ReportPrintRespVO> printReport(@RequestParam String reportType,
                                                       @RequestParam Long periodId) {
        return CommonResult.success(financeReportService.printReport(reportType, periodId));
    }
}
