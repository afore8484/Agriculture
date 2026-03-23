import { useState } from "react";
import {
  ArrowLeft,
  BarChart3,
  ChevronRight,
  Download,
  Eye,
  PieChart as PieChartIcon,
  Printer,
  TrendingDown,
  TrendingUp,
} from "lucide-react";
import { toast } from "sonner";
import {
  Bar,
  BarChart,
  CartesianGrid,
  Cell,
  Legend,
  Pie,
  PieChart,
  ResponsiveContainer,
  Tooltip,
  XAxis,
  YAxis,
} from "recharts";

type BalanceItem = {
  code: string;
  name: string;
  beginBalance: number;
  endBalance: number;
};

type BalanceGroup = {
  name: string;
  items: BalanceItem[];
};

type DetailRecord = {
  date: string;
  no: string;
  summary: string;
  debit: number;
  credit: number;
};

const assetGroups: BalanceGroup[] = [
  {
    name: "流动资产",
    items: [
      { code: "1001", name: "库存现金", beginBalance: 15600, endBalance: 12800 },
      { code: "1002", name: "银行存款", beginBalance: 1285600, endBalance: 1320600 },
      { code: "1131", name: "应收款项", beginBalance: 45000, endBalance: 38500 },
      { code: "1151", name: "存货", beginBalance: 28000, endBalance: 32000 },
    ],
  },
  {
    name: "非流动资产",
    items: [
      { code: "1501", name: "固定资产", beginBalance: 3200000, endBalance: 3185000 },
      { code: "1502", name: "累计折旧", beginBalance: -320000, endBalance: -335000 },
      { code: "1601", name: "在建工程", beginBalance: 650000, endBalance: 662500 },
      { code: "1701", name: "无形资产", beginBalance: 450000, endBalance: 445000 },
    ],
  },
];

const liabilityGroups: BalanceGroup[] = [
  {
    name: "流动负债",
    items: [
      { code: "2101", name: "应付款项", beginBalance: 85000, endBalance: 78000 },
      { code: "2151", name: "应付工资", beginBalance: 45000, endBalance: 42000 },
      { code: "2171", name: "应交税费", beginBalance: 12500, endBalance: 15800 },
    ],
  },
  {
    name: "所有者权益",
    items: [
      { code: "3101", name: "实收资本", beginBalance: 4800000, endBalance: 4800000 },
      { code: "3111", name: "公积公益金", beginBalance: 250000, endBalance: 268000 },
      { code: "3121", name: "本年收益", beginBalance: 162700, endBalance: 158600 },
    ],
  },
];

const detailRecords: Record<string, DetailRecord[]> = {
  "1001": [
    { date: "2026-03-06", no: "记-0296", summary: "收取村民活动中心场地租赁收入", debit: 800, credit: 0 },
    { date: "2026-03-07", no: "现付-0023", summary: "采购清洁用品", debit: 0, credit: 260 },
    { date: "2026-03-08", no: "记-0299", summary: "收取小卖部零售收入", debit: 1200, credit: 0 },
  ],
  "1002": [
    { date: "2026-03-07", no: "记-0298", summary: "收到省级乡村振兴补助款", debit: 80000, credit: 0 },
    { date: "2026-03-08", no: "记-0300", summary: "支付村道硬化维修费", debit: 0, credit: 38000 },
    { date: "2026-03-08", no: "记-0299", summary: "槟榔园承包收入", debit: 12000, credit: 0 },
    { date: "2026-03-09", no: "记-0301", summary: "支付美丽乡村建设工程款", debit: 0, credit: 56000 },
  ],
  "1131": [
    { date: "2026-03-05", no: "记-0294", summary: "应收承包费-符永昌", debit: 0, credit: 3500 },
    { date: "2026-03-08", no: "记-0299", summary: "应收民宿分成-陈大芳", debit: 0, credit: 3000 },
  ],
};

const incomeData = [
  { name: "经营收入", current: 185600, cumulative: 528000 },
  { name: "补助收入", current: 50000, cumulative: 150000 },
  { name: "投资收益", current: 0, cumulative: 12000 },
  { name: "其他收入", current: 2400, cumulative: 8500 },
];

const expenseData = [
  { name: "经营支出", current: 60300, cumulative: 185000 },
  { name: "管理费用", current: 24150, cumulative: 75600 },
  { name: "税金及附加", current: 3200, cumulative: 9800 },
  { name: "其他支出", current: 1800, cumulative: 5500 },
];

const incomeStructure = [
  { name: "经营收入", value: 528000, color: "#1d4ed8" },
  { name: "补助收入", value: 150000, color: "#0f766e" },
  { name: "投资收益", value: 12000, color: "#d97706" },
  { name: "其他收入", value: 8500, color: "#7c3aed" },
];

const progressData = [
  { month: "1月", plan: 300000, actual: 285000 },
  { month: "2月", plan: 320000, actual: 298000 },
  { month: "3月", plan: 350000, actual: 342000 },
  { month: "4月", plan: 360000, actual: 351000 },
  { month: "5月", plan: 380000, actual: 372000 },
  { month: "6月", plan: 400000, actual: 389000 },
];

const statisticsCards = [
  { label: "资产总额", value: "5,361,400", trend: "+0.13%", icon: TrendingUp, color: "#0d9448" },
  { label: "负债总额", value: "135,800", trend: "-4.72%", icon: TrendingDown, color: "#ef4444" },
  { label: "累计收入", value: "698,500", trend: "+12.3%", icon: BarChart3, color: "#2563eb" },
  { label: "结构占比", value: "经营收入 75.6%", trend: "稳定", icon: PieChartIcon, color: "#7c3aed" },
];

function money(value: number) {
  return value.toLocaleString("zh-CN", { minimumFractionDigits: 2, maximumFractionDigits: 2 });
}

function breadcrumb(title: string) {
  return (
    <div className="flex items-center text-muted-foreground text-[13px]">
      <span>报表中心</span>
      <ChevronRight className="w-4 h-4 mx-1" />
      <span className="text-foreground">{title}</span>
    </div>
  );
}

function toolbar(title: string, exportText: string) {
  return (
    <div className="flex items-center justify-between">
      <h2>{title}</h2>
      <div className="flex gap-2">
        <button
          onClick={() => toast.success("导出成功", { description: exportText })}
          className="flex items-center gap-1.5 px-3 py-1.5 border border-border rounded-lg hover:bg-muted text-[13px]"
        >
          <Download className="w-4 h-4" /> 导出
        </button>
        <button
          onClick={() => toast.success("打印预览已生成")}
          className="flex items-center gap-1.5 px-3 py-1.5 border border-border rounded-lg hover:bg-muted text-[13px]"
        >
          <Printer className="w-4 h-4" /> 打印
        </button>
      </div>
    </div>
  );
}

export function BalanceSheet() {
  const [detailView, setDetailView] = useState<null | { group: string; item: BalanceItem }>(null);

  const assetTotalBegin = assetGroups.flatMap((g) => g.items).reduce((sum, item) => sum + item.beginBalance, 0);
  const assetTotalEnd = assetGroups.flatMap((g) => g.items).reduce((sum, item) => sum + item.endBalance, 0);
  const liabilityTotalBegin = liabilityGroups.flatMap((g) => g.items).reduce((sum, item) => sum + item.beginBalance, 0);
  const liabilityTotalEnd = liabilityGroups.flatMap((g) => g.items).reduce((sum, item) => sum + item.endBalance, 0);

  if (detailView) {
    const item = detailView.item;
    const records = detailRecords[item.code] || [
      { date: "2026-03-01", no: "记-0290", summary: `${item.name}期初调整`, debit: 0, credit: 0 },
    ];

    return (
      <div className="space-y-4">
        <div className="flex items-center text-muted-foreground text-[13px]">
          <span>报表中心</span>
          <ChevronRight className="w-4 h-4 mx-1" />
          <span>资产负债表</span>
          <ChevronRight className="w-4 h-4 mx-1" />
          <span className="text-foreground">{item.name}明细</span>
        </div>
        <div className="flex items-center gap-3">
          <button
            onClick={() => setDetailView(null)}
            className="flex items-center gap-1 px-3 py-1.5 border border-border rounded-lg hover:bg-muted text-[13px]"
          >
            <ArrowLeft className="w-4 h-4" /> 返回
          </button>
          <h2>{item.code} {item.name}明细账</h2>
        </div>
        <div className="grid grid-cols-1 md:grid-cols-3 gap-4">
          <div className="bg-white rounded-xl p-4 border border-border shadow-sm">
            <p className="text-[12px] text-muted-foreground">期初余额</p>
            <p className="text-[20px] mt-1" style={{ fontWeight: 600 }}>￥ {money(item.beginBalance)}</p>
          </div>
          <div className="bg-white rounded-xl p-4 border border-border shadow-sm">
            <p className="text-[12px] text-muted-foreground">期末余额</p>
            <p className="text-[20px] mt-1" style={{ fontWeight: 600, color: "#0d9448" }}>￥ {money(item.endBalance)}</p>
          </div>
          <div className="bg-white rounded-xl p-4 border border-border shadow-sm">
            <p className="text-[12px] text-muted-foreground">本期变动</p>
            <p
              className="text-[20px] mt-1"
              style={{ fontWeight: 600, color: item.endBalance - item.beginBalance >= 0 ? "#0d9448" : "#ef4444" }}
            >
              {item.endBalance - item.beginBalance >= 0 ? "+" : ""}{money(item.endBalance - item.beginBalance)}
            </p>
          </div>
        </div>
        <div className="bg-white rounded-xl border border-border shadow-sm p-5">
          <div className="flex items-center justify-between mb-4">
            <h3>明细记录</h3>
            <button
              onClick={() => toast.success("导出成功", { description: `${item.name}明细已导出` })}
              className="flex items-center gap-1 px-3 py-1.5 border border-border rounded-lg hover:bg-muted text-[13px]"
            >
              <Download className="w-4 h-4" /> 导出
            </button>
          </div>
          <div className="overflow-x-auto border border-border rounded-lg">
            <table className="w-full text-[13px]">
              <thead className="bg-muted/60">
                <tr>
                  <th className="py-3 px-3 text-left text-muted-foreground" style={{ fontWeight: 500 }}>日期</th>
                  <th className="py-3 px-3 text-left text-muted-foreground" style={{ fontWeight: 500 }}>凭证号</th>
                  <th className="py-3 px-3 text-left text-muted-foreground" style={{ fontWeight: 500 }}>摘要</th>
                  <th className="py-3 px-3 text-right text-muted-foreground" style={{ fontWeight: 500 }}>借方</th>
                  <th className="py-3 px-3 text-right text-muted-foreground" style={{ fontWeight: 500 }}>贷方</th>
                </tr>
              </thead>
              <tbody>
                {records.map((record, index) => (
                  <tr key={index} className="border-t border-border/50 hover:bg-blue-50/20">
                    <td className="py-2.5 px-3 text-muted-foreground">{record.date}</td>
                    <td className="py-2.5 px-3 text-primary">{record.no}</td>
                    <td className="py-2.5 px-3">{record.summary}</td>
                    <td className="py-2.5 px-3 text-right">{record.debit > 0 ? `￥ ${money(record.debit)}` : "-"}</td>
                    <td className="py-2.5 px-3 text-right">{record.credit > 0 ? `￥ ${money(record.credit)}` : "-"}</td>
                  </tr>
                ))}
              </tbody>
            </table>
          </div>
        </div>
      </div>
    );
  }

  return (
    <div className="space-y-4">
      {breadcrumb("资产负债表")}
      {toolbar("资产负债表", "资产负债表已导出为 Excel 文件")}
      <div className="bg-white rounded-xl border border-border shadow-sm p-5">
        <div className="text-center mb-4">
          <h3>椰林村集体经济组织</h3>
          <p className="text-muted-foreground text-[13px]">资产负债表  会计期间：2026年6月  单位：元</p>
        </div>
        <div className="grid grid-cols-2 gap-4">
          <div className="border border-border rounded-lg overflow-hidden">
            <table className="w-full text-[13px]">
              <thead className="bg-blue-50">
                <tr>
                  <th className="py-2.5 px-3 text-left" style={{ fontWeight: 500 }}>资产</th>
                  <th className="py-2.5 px-3 text-right" style={{ fontWeight: 500 }}>期初数</th>
                  <th className="py-2.5 px-3 text-right" style={{ fontWeight: 500 }}>期末数</th>
                  <th className="py-2.5 px-3 text-center" style={{ fontWeight: 500 }}>明细</th>
                </tr>
              </thead>
              <tbody>
                {assetGroups.map((group) => (
                  <>
                    <tr key={`${group.name}-header`} className="bg-muted/30">
                      <td colSpan={4} className="py-2 px-3" style={{ fontWeight: 500 }}>{group.name}</td>
                    </tr>
                    {group.items.map((item) => (
                      <tr key={item.code} className="border-t border-border/30 hover:bg-blue-50/20">
                        <td className="py-2 px-3 pl-6">{item.name}</td>
                        <td className="py-2 px-3 text-right">{money(item.beginBalance)}</td>
                        <td className="py-2 px-3 text-right">{money(item.endBalance)}</td>
                        <td className="py-2 px-3 text-center">
                          <button
                            onClick={() => setDetailView({ group: group.name, item })}
                            className="p-1 hover:bg-blue-100 rounded"
                            title="查看明细"
                          >
                            <Eye className="w-3.5 h-3.5 text-primary" />
                          </button>
                        </td>
                      </tr>
                    ))}
                  </>
                ))}
                <tr className="border-t-2 border-border bg-blue-50/50">
                  <td className="py-2.5 px-3" style={{ fontWeight: 600 }}>资产合计</td>
                  <td className="py-2.5 px-3 text-right" style={{ fontWeight: 600 }}>{money(assetTotalBegin)}</td>
                  <td className="py-2.5 px-3 text-right" style={{ fontWeight: 600 }}>{money(assetTotalEnd)}</td>
                  <td />
                </tr>
              </tbody>
            </table>
          </div>
          <div className="border border-border rounded-lg overflow-hidden">
            <table className="w-full text-[13px]">
              <thead className="bg-green-50">
                <tr>
                  <th className="py-2.5 px-3 text-left" style={{ fontWeight: 500 }}>负债及所有者权益</th>
                  <th className="py-2.5 px-3 text-right" style={{ fontWeight: 500 }}>期初数</th>
                  <th className="py-2.5 px-3 text-right" style={{ fontWeight: 500 }}>期末数</th>
                  <th className="py-2.5 px-3 text-center" style={{ fontWeight: 500 }}>明细</th>
                </tr>
              </thead>
              <tbody>
                {liabilityGroups.map((group) => (
                  <>
                    <tr key={`${group.name}-header`} className="bg-muted/30">
                      <td colSpan={4} className="py-2 px-3" style={{ fontWeight: 500 }}>{group.name}</td>
                    </tr>
                    {group.items.map((item) => (
                      <tr key={item.code} className="border-t border-border/30 hover:bg-green-50/20">
                        <td className="py-2 px-3 pl-6">{item.name}</td>
                        <td className="py-2 px-3 text-right">{money(item.beginBalance)}</td>
                        <td className="py-2 px-3 text-right">{money(item.endBalance)}</td>
                        <td className="py-2 px-3 text-center">
                          <button
                            onClick={() => setDetailView({ group: group.name, item })}
                            className="p-1 hover:bg-green-100 rounded"
                            title="查看明细"
                          >
                            <Eye className="w-3.5 h-3.5 text-primary" />
                          </button>
                        </td>
                      </tr>
                    ))}
                  </>
                ))}
                <tr className="border-t-2 border-border bg-green-50/50">
                  <td className="py-2.5 px-3" style={{ fontWeight: 600 }}>负债及权益合计</td>
                  <td className="py-2.5 px-3 text-right" style={{ fontWeight: 600 }}>{money(liabilityTotalBegin)}</td>
                  <td className="py-2.5 px-3 text-right" style={{ fontWeight: 600 }}>{money(liabilityTotalEnd)}</td>
                  <td />
                </tr>
              </tbody>
            </table>
          </div>
        </div>
      </div>
    </div>
  );
}

export function IncomeStatement() {
  const [detailItem, setDetailItem] = useState<null | { name: string; current: number; cumulative: number }>(null);

  const totalIncome = incomeData.reduce((sum, item) => sum + item.cumulative, 0);
  const totalExpense = expenseData.reduce((sum, item) => sum + item.cumulative, 0);
  const netIncome = totalIncome - totalExpense;

  if (detailItem) {
    return (
      <div className="space-y-4">
        <div className="flex items-center text-muted-foreground text-[13px]">
          <span>报表中心</span>
          <ChevronRight className="w-4 h-4 mx-1" />
          <span>收益表</span>
          <ChevronRight className="w-4 h-4 mx-1" />
          <span className="text-foreground">{detailItem.name}</span>
        </div>
        <div className="flex items-center gap-3">
          <button onClick={() => setDetailItem(null)} className="flex items-center gap-1 px-3 py-1.5 border border-border rounded-lg hover:bg-muted text-[13px]"><ArrowLeft className="w-4 h-4" /> 返回</button>
          <h2>{detailItem.name}明细分析</h2>
        </div>
        <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
          <div className="bg-white rounded-xl border border-border shadow-sm p-5">
            <p className="text-[12px] text-muted-foreground">本期金额</p>
            <p className="text-[22px] mt-1" style={{ fontWeight: 600 }}>￥ {money(detailItem.current)}</p>
          </div>
          <div className="bg-white rounded-xl border border-border shadow-sm p-5">
            <p className="text-[12px] text-muted-foreground">累计金额</p>
            <p className="text-[22px] mt-1" style={{ fontWeight: 600, color: "#1d4ed8" }}>￥ {money(detailItem.cumulative)}</p>
          </div>
        </div>
      </div>
    );
  }

  return (
    <div className="space-y-4">
      {breadcrumb("收益表")}
      {toolbar("收益表", "收益表已导出")}
      <div className="grid grid-cols-1 md:grid-cols-3 gap-4">
        <div className="bg-white rounded-xl border border-border shadow-sm p-5">
          <p className="text-[12px] text-muted-foreground">累计收入</p>
          <p className="text-[22px] mt-1" style={{ fontWeight: 600, color: "#0d9448" }}>￥ {money(totalIncome)}</p>
        </div>
        <div className="bg-white rounded-xl border border-border shadow-sm p-5">
          <p className="text-[12px] text-muted-foreground">累计支出</p>
          <p className="text-[22px] mt-1" style={{ fontWeight: 600, color: "#ef4444" }}>￥ {money(totalExpense)}</p>
        </div>
        <div className="bg-white rounded-xl border border-border shadow-sm p-5">
          <p className="text-[12px] text-muted-foreground">本年收益</p>
          <p className="text-[22px] mt-1" style={{ fontWeight: 600, color: netIncome >= 0 ? "#1d4ed8" : "#ef4444" }}>￥ {money(netIncome)}</p>
        </div>
      </div>
      <div className="grid grid-cols-1 xl:grid-cols-[1.2fr_0.8fr] gap-4">
        <div className="bg-white rounded-xl border border-border shadow-sm p-5">
          <h3 className="mb-4">收支结构</h3>
          <div className="h-[320px]">
            <ResponsiveContainer width="100%" height="100%">
              <BarChart data={[...incomeData, ...expenseData]}>
                <CartesianGrid strokeDasharray="3 3" vertical={false} />
                <XAxis dataKey="name" />
                <YAxis />
                <Tooltip formatter={(value: number) => `￥ ${money(value)}`} />
                <Legend />
                <Bar dataKey="current" name="本期" fill="#2563eb" radius={[4, 4, 0, 0]} />
                <Bar dataKey="cumulative" name="累计" fill="#10b981" radius={[4, 4, 0, 0]} />
              </BarChart>
            </ResponsiveContainer>
          </div>
        </div>
        <div className="bg-white rounded-xl border border-border shadow-sm p-5">
          <h3 className="mb-4">收入占比</h3>
          <div className="h-[320px]">
            <ResponsiveContainer width="100%" height="100%">
              <PieChart>
                <Pie data={incomeStructure} dataKey="value" nameKey="name" outerRadius={105} label>
                  {incomeStructure.map((entry) => <Cell key={entry.name} fill={entry.color} />)}
                </Pie>
                <Tooltip formatter={(value: number) => `￥ ${money(value)}`} />
                <Legend />
              </PieChart>
            </ResponsiveContainer>
          </div>
        </div>
      </div>
      <div className="bg-white rounded-xl border border-border shadow-sm p-5">
        <h3 className="mb-4">项目明细</h3>
        <div className="overflow-x-auto">
          <table className="w-full text-[13px]">
            <thead className="bg-muted/60">
              <tr>
                <th className="py-3 px-3 text-left">项目</th>
                <th className="py-3 px-3 text-right">本期</th>
                <th className="py-3 px-3 text-right">累计</th>
                <th className="py-3 px-3 text-center">查看</th>
              </tr>
            </thead>
            <tbody>
              {[...incomeData, ...expenseData].map((item) => (
                <tr key={item.name} className="border-t border-border/50 hover:bg-muted/20">
                  <td className="py-2.5 px-3">{item.name}</td>
                  <td className="py-2.5 px-3 text-right">￥ {money(item.current)}</td>
                  <td className="py-2.5 px-3 text-right">￥ {money(item.cumulative)}</td>
                  <td className="py-2.5 px-3 text-center">
                    <button onClick={() => setDetailItem(item)} className="p-1 hover:bg-blue-100 rounded" title="查看明细"><Eye className="w-3.5 h-3.5 text-primary" /></button>
                  </td>
                </tr>
              ))}
            </tbody>
          </table>
        </div>
      </div>
    </div>
  );
}

export function ProgressReport() {
  return (
    <div className="space-y-4">
      {breadcrumb("进度报表")}
      {toolbar("进度报表", "进度报表已导出")}
      <div className="grid grid-cols-1 md:grid-cols-3 gap-4">
        <div className="bg-white rounded-xl border border-border shadow-sm p-5">
          <p className="text-[12px] text-muted-foreground">计划完成率</p>
          <p className="text-[22px] mt-1" style={{ fontWeight: 600, color: "#1d4ed8" }}>97.1%</p>
        </div>
        <div className="bg-white rounded-xl border border-border shadow-sm p-5">
          <p className="text-[12px] text-muted-foreground">累计计划金额</p>
          <p className="text-[22px] mt-1" style={{ fontWeight: 600 }}>￥ {money(progressData.reduce((sum, item) => sum + item.plan, 0))}</p>
        </div>
        <div className="bg-white rounded-xl border border-border shadow-sm p-5">
          <p className="text-[12px] text-muted-foreground">累计实际金额</p>
          <p className="text-[22px] mt-1" style={{ fontWeight: 600, color: "#0d9448" }}>￥ {money(progressData.reduce((sum, item) => sum + item.actual, 0))}</p>
        </div>
      </div>
      <div className="bg-white rounded-xl border border-border shadow-sm p-5">
        <h3 className="mb-4">月度执行进度</h3>
        <div className="h-[340px]">
          <ResponsiveContainer width="100%" height="100%">
            <BarChart data={progressData}>
              <CartesianGrid strokeDasharray="3 3" vertical={false} />
              <XAxis dataKey="month" />
              <YAxis />
              <Tooltip formatter={(value: number) => `￥ ${money(value)}`} />
              <Legend />
              <Bar dataKey="plan" name="计划" fill="#94a3b8" radius={[4, 4, 0, 0]} />
              <Bar dataKey="actual" name="实际" fill="#2563eb" radius={[4, 4, 0, 0]} />
            </BarChart>
          </ResponsiveContainer>
        </div>
      </div>
      <div className="bg-white rounded-xl border border-border shadow-sm p-5">
        <h3 className="mb-4">进度点评</h3>
        <ul className="space-y-3 text-[13px] text-foreground/90">
          <li>1. 本年度整体执行进度稳定，实际完成率维持在 95% 以上。</li>
          <li>2. 3 月和 6 月有较明显增长，主要来自补助资金拨付和经营收入回款。</li>
          <li>3. 建议关注 2 月和 4 月的计划偏差，及时核对项目支付和结算节奏。</li>
        </ul>
      </div>
    </div>
  );
}

export function StatisticsReport() {
  return (
    <div className="space-y-4">
      {breadcrumb("统计分析")}
      {toolbar("统计分析", "统计分析报表已导出")}
      <div className="grid grid-cols-1 md:grid-cols-2 xl:grid-cols-4 gap-4">
        {statisticsCards.map((card) => {
          const Icon = card.icon;
          return (
            <div key={card.label} className="bg-white rounded-xl border border-border shadow-sm p-5">
              <div className="flex items-center justify-between">
                <div>
                  <p className="text-[12px] text-muted-foreground">{card.label}</p>
                  <p className="text-[22px] mt-1" style={{ fontWeight: 600 }}>{card.value}</p>
                  <p className="text-[12px] mt-2" style={{ color: card.color }}>{card.trend}</p>
                </div>
                <div className="w-11 h-11 rounded-xl flex items-center justify-center" style={{ backgroundColor: `${card.color}15`, color: card.color }}>
                  <Icon className="w-5 h-5" />
                </div>
              </div>
            </div>
          );
        })}
      </div>
      <div className="grid grid-cols-1 xl:grid-cols-[1.2fr_0.8fr] gap-4">
        <div className="bg-white rounded-xl border border-border shadow-sm p-5">
          <h3 className="mb-4">收入趋势分析</h3>
          <div className="h-[320px]">
            <ResponsiveContainer width="100%" height="100%">
              <BarChart data={progressData.map((item) => ({ month: item.month, value: item.actual }))}>
                <CartesianGrid strokeDasharray="3 3" vertical={false} />
                <XAxis dataKey="month" />
                <YAxis />
                <Tooltip formatter={(value: number) => `￥ ${money(value)}`} />
                <Bar dataKey="value" fill="#0f766e" radius={[4, 4, 0, 0]} />
              </BarChart>
            </ResponsiveContainer>
          </div>
        </div>
        <div className="bg-white rounded-xl border border-border shadow-sm p-5">
          <h3 className="mb-4">收入构成占比</h3>
          <div className="h-[320px]">
            <ResponsiveContainer width="100%" height="100%">
              <PieChart>
                <Pie data={incomeStructure} dataKey="value" nameKey="name" outerRadius={100} label>
                  {incomeStructure.map((entry) => <Cell key={entry.name} fill={entry.color} />)}
                </Pie>
                <Tooltip formatter={(value: number) => `￥ ${money(value)}`} />
                <Legend />
              </PieChart>
            </ResponsiveContainer>
          </div>
        </div>
      </div>
      <div className="bg-white rounded-xl border border-border shadow-sm p-5">
        <div className="flex items-center justify-between mb-4">
          <h3>分析结论</h3>
          <button onClick={() => toast.info("统计结论已同步至分析台账")} className="flex items-center gap-1.5 px-3 py-1.5 border border-border rounded-lg hover:bg-muted text-[13px]">
            <BarChart3 className="w-4 h-4" /> 同步结论
          </button>
        </div>
        <ul className="space-y-3 text-[13px] text-foreground/90">
          <li>1. 当前资产规模稳定，资产结构以固定资产和银行存款为主。</li>
          <li>2. 负债规模较低，村集体整体偿债压力可控。</li>
          <li>3. 收入端以经营收入和补助收入为核心，需持续提升经营性收入占比。</li>
        </ul>
      </div>
    </div>
  );
}
