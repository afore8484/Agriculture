import { createHashRouter } from "react-router";
import { Layout } from "./components/Layout";
import { Dashboard } from "./components/Dashboard";
import { CashierManagement, VoucherManagement, LedgerManagement, PeriodEndProcessing, FinanceSettings } from "./components/FinanceCenter";
import { BalanceSheet, IncomeStatement, ProgressReport, StatisticsReport } from "./components/ReportCenter";
import { AssetList, AssetDepreciation, AssetReport, AssetSettle } from "./components/AssetManagement";
import { ContractList, ContractChange, ContractReport } from "./components/ContractManagement";
import { ApprovalCenter, PaymentManagement, ApprovalConfig, ApprovalHistory } from "./components/OnlineApproval";
import { BankSetting, BankAccount, BankPartner } from "./components/BankDirect";
import { PartyOrg, PartyMember, PartyStudy, PartyExam } from "./components/PartyBuilding";

export const router = createHashRouter([
  {
    path: "/",
    Component: Layout,
    children: [
      { index: true, Component: Dashboard },
      // Finance Center
      { path: "finance/cashier", Component: CashierManagement },
      { path: "finance/voucher", Component: VoucherManagement },
      { path: "finance/ledger", Component: LedgerManagement },
      { path: "finance/period-end", Component: PeriodEndProcessing },
      { path: "finance/settings", Component: FinanceSettings },
      // Report Center
      { path: "report/balance-sheet", Component: BalanceSheet },
      { path: "report/income", Component: IncomeStatement },
      { path: "report/progress", Component: ProgressReport },
      { path: "report/statistics", Component: StatisticsReport },
      // Asset Management
      { path: "asset/list", Component: AssetList },
      { path: "asset/depreciation", Component: AssetDepreciation },
      { path: "asset/report", Component: AssetReport },
      { path: "asset/settle", Component: AssetSettle },
      // Contract Management
      { path: "contract/list", Component: ContractList },
      { path: "contract/change", Component: ContractChange },
      { path: "contract/report", Component: ContractReport },
      // Online Approval
      { path: "approval/center", Component: ApprovalCenter },
      { path: "approval/payment", Component: PaymentManagement },
      { path: "approval/config", Component: ApprovalConfig },
      { path: "approval/history", Component: ApprovalHistory },
      // Bank Direct
      { path: "bank/setting", Component: BankSetting },
      { path: "bank/account", Component: BankAccount },
      { path: "bank/partner", Component: BankPartner },
      // Party Building
      { path: "party/org", Component: PartyOrg },
      { path: "party/member", Component: PartyMember },
      { path: "party/study", Component: PartyStudy },
      { path: "party/exam", Component: PartyExam },
    ],
  },
]);
