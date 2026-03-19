package com.agriculture.villagefinance.module.finance.service;

import com.agriculture.villagefinance.module.finance.controller.vo.BankAccountCreateReqVO;
import com.agriculture.villagefinance.module.finance.controller.vo.BankAccountUpdateReqVO;
import com.agriculture.villagefinance.module.finance.controller.vo.BankAccountRespVO;
import com.agriculture.villagefinance.module.finance.controller.vo.CashAccountCreateReqVO;
import com.agriculture.villagefinance.module.finance.controller.vo.CashAccountUpdateReqVO;
import com.agriculture.villagefinance.module.finance.controller.vo.CashAccountRespVO;
import com.agriculture.villagefinance.module.finance.controller.vo.InternalTransferReqVO;
import com.agriculture.villagefinance.module.finance.controller.vo.InternalTransferRespVO;
import com.agriculture.villagefinance.module.finance.controller.vo.JournalCreateReqVO;
import com.agriculture.villagefinance.module.finance.controller.vo.JournalListRespVO;
import com.agriculture.villagefinance.module.finance.controller.vo.PendingVoucherRespVO;
import com.agriculture.villagefinance.module.finance.controller.vo.PeriodCloseReqVO;
import com.agriculture.villagefinance.module.finance.controller.vo.PeriodCloseRespVO;
import com.agriculture.villagefinance.module.finance.controller.vo.PeriodReopenReqVO;
import com.agriculture.villagefinance.module.finance.controller.vo.PeriodReopenRespVO;
import com.agriculture.villagefinance.module.finance.controller.vo.ReconciliationRespVO;
import com.agriculture.villagefinance.module.finance.controller.vo.TrialBalanceRespVO;

import java.time.LocalDate;
import java.util.List;

public interface FinanceFundsService {

    List<CashAccountRespVO> getCashAccounts(Long ledgerId, String status);

    CashAccountRespVO createCashAccount(CashAccountCreateReqVO reqVO);

    CashAccountRespVO updateCashAccount(Long accountId, CashAccountUpdateReqVO reqVO);

    CashAccountRespVO enableCashAccount(Long accountId);

    CashAccountRespVO disableCashAccount(Long accountId);

    void deleteCashAccount(Long accountId);

    List<BankAccountRespVO> getBankAccounts(Long ledgerId, String status);

    BankAccountRespVO createBankAccount(BankAccountCreateReqVO reqVO);

    BankAccountRespVO updateBankAccount(Long accountId, BankAccountUpdateReqVO reqVO);

    BankAccountRespVO enableBankAccount(Long accountId);

    BankAccountRespVO disableBankAccount(Long accountId);

    void deleteBankAccount(Long accountId);

    List<JournalListRespVO> getBankJournals(Long accountId, LocalDate startDate, LocalDate endDate, Integer pageNum, Integer pageSize);

    JournalListRespVO createBankJournal(JournalCreateReqVO reqVO);

    List<JournalListRespVO> getCashJournals(Long accountId, LocalDate startDate, LocalDate endDate, Integer pageNum, Integer pageSize);

    JournalListRespVO createCashJournal(JournalCreateReqVO reqVO);

    List<InternalTransferRespVO> getInternalTransfers(Long fromAccountId, Long toAccountId, LocalDate startDate, LocalDate endDate);

    InternalTransferRespVO createInternalTransfer(InternalTransferReqVO reqVO);

    InternalTransferRespVO deleteInternalTransfer(Long transferId, Long operatorId);

    List<ReconciliationRespVO> getReconciliations(Long ledgerId, Long periodId, String accountType);

    List<PendingVoucherRespVO> getPendingVouchers(Long ledgerId, Long periodId);

    TrialBalanceRespVO trialBalance(Long ledgerId, Long periodId, Long templateId);

    PeriodCloseRespVO closePeriod(PeriodCloseReqVO reqVO);

    PeriodReopenRespVO reopenPeriod(PeriodReopenReqVO reqVO);
}
