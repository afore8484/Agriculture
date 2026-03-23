import {
  TrendingUp,
  TrendingDown,
  Wallet,
  FileText,
  CheckCircle2,
  Clock,
  ArrowUpRight,
  AlertCircle,
  Landmark,
  Package,
  Users,
  Receipt,
} from "lucide-react";
import { useNavigate } from "react-router";
import { useEffect, useState } from "react";
import { toast } from "sonner";
import { Modal } from "./ui/Modal";
import {
  BarChart,
  Bar,
  XAxis,
  YAxis,
  CartesianGrid,
  Tooltip,
  ResponsiveContainer,
  PieChart,
  Pie,
  Cell,
} from "recharts";

const statsCards = [
  { label: "本月收入", value: "¥ 412,860.00", change: "+15.3%", trend: "up", icon: TrendingUp, color: "#0d9448" },
  { label: "本月支出", value: "¥ 187,530.00", change: "-2.8%", trend: "down", icon: TrendingDown, color: "#0ea5e9" },
  { label: "资产总额", value: "¥ 7,235,600.00", change: "+3.6%", trend: "up", icon: Wallet, color: "#f59e0b" },
  { label: "待审批事项", value: "9", change: "2 项紧急", trend: "alert", icon: Clock, color: "#ef4444" },
];

const monthlyData = [
  { month: "1月", income: 356000, expense: 168000 },
  { month: "2月", income: 285000, expense: 195000 },
  { month: "3月", income: 398000, expense: 212000 },
  { month: "4月", income: 342000, expense: 176000 },
  { month: "5月", income: 389000, expense: 198000 },
  { month: "6月", income: 412860, expense: 187530 },
];

const assetDistribution = [
  { name: "固定资产", value: 4150000, color: "#0d9448" },
  { name: "流动资产", value: 1835600, color: "#0ea5e9" },
  { name: "在建工程", value: 780000, color: "#f59e0b" },
  { name: "无形资产", value: 470000, color: "#8b5cf6" },
];

const recentVouchers = [
  { id: "PZ-2026-0301", date: "2026-03-09", summary: "收到省级乡村振兴补助款", amount: "¥ 80,000.00", type: "收入", status: "已审核" },
  { id: "PZ-2026-0300", date: "2026-03-08", summary: "支付椰林大道绿化养护费", amount: "¥ 15,800.00", type: "支出", status: "待审核" },
  { id: "PZ-2026-0299", date: "2026-03-08", summary: "槟榔园承包收入", amount: "¥ 12,000.00", type: "收入", status: "已审核" },
  { id: "PZ-2026-0298", date: "2026-03-07", summary: "办公用品采购", amount: "¥ 3,150.00", type: "支出", status: "已审核" },
  { id: "PZ-2026-0297", date: "2026-03-07", summary: "文化广场水电费", amount: "¥ 2,200.00", type: "支出", status: "待审核" },
];

const pendingApprovals = [
  { id: 1, title: "美丽乡村建设工程款", amount: "¥ 56,000.00", applicant: "符国强", date: "2026-03-09", urgency: "紧急" },
  { id: 2, title: "热带水果基地设备采购", amount: "¥ 12,500.00", applicant: "王海燕", date: "2026-03-08", urgency: "普通" },
  { id: 3, title: "村道硬化修缮费用", amount: "¥ 38,000.00", applicant: "陈大文", date: "2026-03-07", urgency: "紧急" },
  { id: 4, title: "党员教育培训经费", amount: "¥ 4,800.00", applicant: "黄志明", date: "2026-03-07", urgency: "普通" },
];

type CommonResult<T> = {
  code: number;
  msg?: string;
  message?: string;
  data: T;
};

type HomeStatsResp = {
  incomeAmount?: number;
  expenseAmount?: number;
  assetAmount?: number;
  pendingTodoCount?: number;
  urgentTodoCount?: number;
};

type HomeTodoResp = {
  todoId?: number;
  title?: string;
  createTime?: string | number;
  bizType?: string;
  urgency?: string;
};

type HomeTrendResp = {
  periodLabel?: string;
  incomeAmount?: number;
  expenseAmount?: number;
};

type HomeAssetDistributionResp = {
  categoryName?: string;
  amount?: number;
};

type HomeRecentVoucherResp = {
  voucherNo?: string;
  voucherDate?: string | number[];
  summary?: string;
  amount?: number;
  direction?: string;
  auditStatus?: string;
};

type HomeProgressResp = {
  voucherTotal?: number;
  auditedTotal?: number;
  percent?: string;
};

type HomeYearOptionResp = {
  year?: number;
};

type HomeOrgOptionResp = {
  orgId?: number;
  orgName?: string;
  orgCode?: string;
  ledgerId?: number;
};

const assetColors = ["#0d9448", "#0ea5e9", "#f59e0b", "#8b5cf6", "#ef4444", "#06b6d4"];

function formatCurrency(value?: number): string {
  const amount = Number(value ?? 0);
  return `¥ ${amount.toLocaleString(undefined, { minimumFractionDigits: 2, maximumFractionDigits: 2 })}`;
}

function mapPeriodLabel(label?: string): string {
  if (!label) {
    return "-";
  }
  const parts = label.split("-");
  if (parts.length === 2) {
    return `${Number(parts[1])}月`;
  }
  return label;
}

function mapVoucherType(direction?: string): "收入" | "支出" {
  return String(direction || "").toUpperCase() === "INCOME" ? "收入" : "支出";
}

function mapVoucherStatus(status?: string): string {
  return String(status || "").toUpperCase() === "AUDITED" ? "已审核" : "待审核";
}

function mapUrgency(urgency?: string): "紧急" | "普通" {
  return String(urgency || "").toUpperCase() === "URGENT" ? "紧急" : "普通";
}

function formatDate(value?: string | number | number[]): string {
  if (value === undefined || value === null || value === "") {
    return "-";
  }
  if (Array.isArray(value)) {
    const [year, month, day] = value;
    if (!year || !month || !day) {
      return "-";
    }
    return `${year}-${String(month).padStart(2, "0")}-${String(day).padStart(2, "0")}`;
  }
  if (typeof value === "number") {
    return new Date(value).toISOString().slice(0, 10);
  }
  return value.includes("T") ? value.split("T")[0] : value;
}

async function requestJson<T>(path: string, query: Record<string, string | number | undefined> = {}): Promise<T> {
  const params = new URLSearchParams();
  Object.entries(query).forEach(([k, v]) => {
    if (v !== undefined && v !== null && `${v}` !== "") {
      params.append(k, `${v}`);
    }
  });
  const queryString = params.toString();
  const response = await fetch(queryString ? `${path}?${queryString}` : path, {
    method: "GET",
    headers: { Accept: "application/json" },
  });
  const body = (await response.json()) as CommonResult<T>;
  if (!response.ok || body.code !== 0) {
    throw new Error(body?.msg || body?.message || `Request failed: ${response.status}`);
  }
  return body.data;
}

const quickActions = [
  { label: "录入凭证", icon: Receipt, color: "#0d9448", path: "/finance/voucher" },
  { label: "资产登记", icon: Package, color: "#0ea5e9", path: "/asset/list" },
  { label: "合同管理", icon: FileText, color: "#f59e0b", path: "/contract/list" },
  { label: "审批处理", icon: CheckCircle2, color: "#8b5cf6", path: "/approval/center" },
  { label: "银行对账", icon: Landmark, color: "#ef4444", path: "/bank/setting" },
  { label: "党员管理", icon: Users, color: "#06b6d4", path: "/party/member" },
];

export function Dashboard() {
  const navigate = useNavigate();
  const currentYear = new Date().getFullYear();
  const [statsCardsData, setStatsCardsData] = useState(statsCards);
  const [monthlyDataData, setMonthlyDataData] = useState(monthlyData);
  const [assetDistributionData, setAssetDistributionData] = useState(assetDistribution);
  const [recentVouchersData, setRecentVouchersData] = useState(recentVouchers);
  const [pendingApprovalsData, setPendingApprovalsData] = useState(pendingApprovals);
  const [yearOptions, setYearOptions] = useState<HomeYearOptionResp[]>([]);
  const [orgOptions, setOrgOptions] = useState<HomeOrgOptionResp[]>([]);
  const [selectedYear, setSelectedYear] = useState<number>(currentYear);
  const [selectedOrgId, setSelectedOrgId] = useState<number | undefined>(undefined);
  const [showVoucherDetail, setShowVoucherDetail] = useState<typeof recentVouchers[0] | null>(null);
  const [showApprovalModal, setShowApprovalModal] = useState<typeof pendingApprovals[0] | null>(null);
  const [showApprovalDetail, setShowApprovalDetail] = useState<typeof pendingApprovals[0] | null>(null);

  useEffect(() => {
    let cancelled = false;
    requestJson<HomeYearOptionResp[]>("/api/village-finance/home/years")
      .then((years) => {
        if (cancelled) {
          return;
        }
        const options = (years || []).filter((item) => Number(item.year) > 0);
        setYearOptions(options);
        if (options.length > 0) {
          setSelectedYear(Number(options[0].year));
        }
      })
      .catch((error) => {
        if (!cancelled) {
          toast.warning(`年段加载失败：${error instanceof Error ? error.message : "未知错误"}`);
        }
      });
    return () => {
      cancelled = true;
    };
  }, []);

  useEffect(() => {
    let cancelled = false;
    requestJson<HomeOrgOptionResp[]>("/api/village-finance/home/orgs", { year: selectedYear })
      .then((orgs) => {
        if (cancelled) {
          return;
        }
        const options = orgs || [];
        setOrgOptions(options);
        if (!options.length) {
          setSelectedOrgId(undefined);
          return;
        }
        setSelectedOrgId((prev) => {
          if (prev && options.some((item) => Number(item.orgId) === prev)) {
            return prev;
          }
          return Number(options[0].orgId);
        });
      })
      .catch((error) => {
        if (!cancelled) {
          toast.warning(`村级组织加载失败：${error instanceof Error ? error.message : "未知错误"}`);
        }
      });
    return () => {
      cancelled = true;
    };
  }, [selectedYear]);

  useEffect(() => {
    let cancelled = false;
    const userId = undefined;
    const contextParams: Record<string, string | number | undefined> = {
      year: selectedYear,
      orgId: selectedOrgId,
    };

    const loadData = async () => {
      const [statsRs, todoRs, chartRs, assetRs, voucherRs, progressRs] = await Promise.allSettled([
        requestJson<HomeStatsResp>("/api/village-finance/home/stats", { ...contextParams, userId }),
        requestJson<HomeTodoResp[]>("/api/village-finance/home/todos", { ...contextParams, userId, limit: 10 }),
        requestJson<HomeTrendResp[]>("/api/village-finance/home/charts", { ...contextParams, months: 6 }),
        requestJson<HomeAssetDistributionResp[]>("/api/village-finance/home/asset-distribution", contextParams),
        requestJson<HomeRecentVoucherResp[]>("/api/village-finance/home/recent-vouchers", { ...contextParams, limit: 5 }),
        requestJson<HomeProgressResp>("/api/village-finance/home/progress", contextParams),
      ]);

      let failedCount = 0;

      if (statsRs.status === "fulfilled") {
        const stats = statsRs.value;
        const urgent = Number(stats.urgentTodoCount ?? 0);
        const progress = progressRs.status === "fulfilled" ? (progressRs.value.percent || "--") : "--";
        if (!cancelled) {
          setStatsCardsData([
            { ...statsCards[0], value: formatCurrency(stats.incomeAmount), change: "--" },
            { ...statsCards[1], value: formatCurrency(stats.expenseAmount), change: "--" },
            { ...statsCards[2], value: formatCurrency(stats.assetAmount), change: "--" },
            {
              ...statsCards[3],
              value: String(stats.pendingTodoCount ?? 0),
              change: `${urgent} 项紧急 / 进度 ${progress}`,
              trend: urgent > 0 ? "alert" : "up",
            },
          ]);
        }
      } else {
        failedCount += 1;
      }

      if (progressRs.status !== "fulfilled") {
        failedCount += 1;
      }

      if (todoRs.status === "fulfilled") {
        const mapped = (todoRs.value || []).map((item, index) => ({
          id: Number(item.todoId ?? index + 1),
          title: item.title || "待审批事项",
          amount: "¥ 0.00",
          applicant: item.bizType || "-",
          date: formatDate(item.createTime),
          urgency: mapUrgency(item.urgency),
        }));
        if (!cancelled) {
          setPendingApprovalsData(mapped);
        }
      } else {
        failedCount += 1;
      }

      if (chartRs.status === "fulfilled") {
        const mapped = (chartRs.value || []).map((item) => ({
          month: mapPeriodLabel(item.periodLabel),
          income: Number(item.incomeAmount ?? 0),
          expense: Number(item.expenseAmount ?? 0),
        }));
        if (!cancelled) {
          setMonthlyDataData(mapped);
        }
      } else {
        failedCount += 1;
      }

      if (assetRs.status === "fulfilled") {
        const mapped = (assetRs.value || []).map((item, index) => ({
          name: item.categoryName || `分类${index + 1}`,
          value: Number(item.amount ?? 0),
          color: assetColors[index % assetColors.length],
        }));
        if (!cancelled) {
          setAssetDistributionData(mapped);
        }
      } else {
        failedCount += 1;
      }

      if (voucherRs.status === "fulfilled") {
        const mapped = (voucherRs.value || []).map((item, index) => {
          const type = mapVoucherType(item.direction);
          return {
            id: item.voucherNo || `PZ-NA-${index + 1}`,
            date: formatDate(item.voucherDate),
            summary: item.summary || "-",
            amount: formatCurrency(item.amount),
            type,
            status: mapVoucherStatus(item.auditStatus),
          };
        });
        if (!cancelled) {
          setRecentVouchersData(mapped);
        }
      } else {
        failedCount += 1;
      }

      if (!cancelled && failedCount > 0) {
        toast.warning(`工作台部分数据加载失败（${failedCount}项）`);
      }
    };

    loadData().catch((error) => {
      if (!cancelled) {
        toast.error(`工作台数据加载失败: ${error instanceof Error ? error.message : "未知错误"}`);
      }
    });

    return () => {
      cancelled = true;
    };
  }, [selectedYear, selectedOrgId]);

  return (
    <div className="space-y-6">
      <div className="flex items-center justify-between">
        <div>
          <h1 className="text-foreground">工作台</h1>
          <p className="text-muted-foreground mt-1">欢迎回来，管理员。当前展示所选年段与村级组织的数据。</p>
        </div>
        <div className="flex gap-2">
          <select
            className="bg-white border border-border rounded-lg px-3 py-1.5 outline-none"
            value={selectedYear}
            onChange={(e) => setSelectedYear(Number(e.target.value))}
          >
            {yearOptions.map((item) => (
              <option key={item.year} value={item.year}>
                {item.year}年度
              </option>
            ))}
          </select>
          <select
            className="bg-white border border-border rounded-lg px-3 py-1.5 outline-none"
            value={selectedOrgId ?? ""}
            onChange={(e) => setSelectedOrgId(e.target.value ? Number(e.target.value) : undefined)}
          >
            {orgOptions.map((item) => (
              <option key={item.orgId} value={item.orgId}>
                {item.orgName || item.orgCode || item.orgId}
              </option>
            ))}
          </select>
        </div>
      </div>

      {/* Stats Cards */}
      <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-4">
        {statsCardsData.map((card) => {
          const Icon = card.icon;
          return (
            <div key={card.label} className="bg-white rounded-xl p-5 border border-border shadow-sm hover:shadow-md transition-shadow">
              <div className="flex items-start justify-between">
                <div>
                  <p className="text-muted-foreground">{card.label}</p>
                  <p className="text-[22px] mt-1" style={{ fontWeight: 600 }}>{card.value}</p>
                </div>
                <div className="w-10 h-10 rounded-lg flex items-center justify-center" style={{ backgroundColor: `${card.color}15` }}>
                  <Icon className="w-5 h-5" style={{ color: card.color }} />
                </div>
              </div>
              <div className="flex items-center gap-1 mt-3">
                {card.trend === "up" && <ArrowUpRight className="w-4 h-4 text-green-600" />}
                {card.trend === "down" && <ArrowUpRight className="w-4 h-4 text-green-600 rotate-180" />}
                {card.trend === "alert" && <AlertCircle className="w-4 h-4 text-red-500" />}
                <span className={`text-[13px] ${card.trend === "alert" ? "text-red-500" : "text-green-600"}`}>
                  {card.change}
                </span>
                <span className="text-muted-foreground text-[13px]">较上期</span>
              </div>
            </div>
          );
        })}
      </div>

      {/* Quick Actions */}
      <div className="bg-white rounded-xl p-5 border border-border shadow-sm">
        <h3 className="mb-4">快捷操作</h3>
        <div className="grid grid-cols-3 md:grid-cols-6 gap-3">
          {quickActions.map((action) => {
            const Icon = action.icon;
            return (
              <button
                key={action.label}
                className="flex flex-col items-center gap-2 p-4 rounded-xl hover:bg-muted transition-colors cursor-pointer"
                onClick={() => navigate(action.path)}
              >
                <div className="w-12 h-12 rounded-xl flex items-center justify-center" style={{ backgroundColor: `${action.color}12` }}>
                  <Icon className="w-6 h-6" style={{ color: action.color }} />
                </div>
                <span className="text-[13px] text-foreground">{action.label}</span>
              </button>
            );
          })}
        </div>
      </div>

      {/* Charts Row */}
      <div className="grid grid-cols-1 lg:grid-cols-3 gap-4">
        <div className="lg:col-span-2 bg-white rounded-xl p-5 border border-border shadow-sm">
          <div className="flex items-center justify-between mb-4">
            <h3>月度收支趋势</h3>
            <select className="bg-muted border-0 rounded px-2 py-1 text-[13px] outline-none">
              <option>近6个月</option>
              <option>近12个月</option>
            </select>
          </div>
          <ResponsiveContainer width="100%" height={280}>
            <BarChart data={monthlyDataData}>
              <CartesianGrid strokeDasharray="3 3" stroke="#e8ece9" />
              <XAxis dataKey="month" axisLine={false} tickLine={false} />
              <YAxis axisLine={false} tickLine={false} tickFormatter={(v) => `${v / 10000}万`} />
              <Tooltip formatter={(value: number) => `¥ ${value.toLocaleString()}`} />
              <Bar dataKey="income" fill="#0d9448" radius={[4, 4, 0, 0]} barSize={24} name="收入" />
              <Bar dataKey="expense" fill="#0ea5e9" radius={[4, 4, 0, 0]} barSize={24} name="支出" />
            </BarChart>
          </ResponsiveContainer>
        </div>

        <div className="bg-white rounded-xl p-5 border border-border shadow-sm">
          <h3 className="mb-4">资产分布</h3>
          <ResponsiveContainer width="100%" height={200}>
            <PieChart>
              <Pie
                data={assetDistributionData}
                cx="50%"
                cy="50%"
                innerRadius={50}
                outerRadius={80}
                dataKey="value"
                stroke="none"
              >
                {assetDistributionData.map((entry) => (
                  <Cell key={entry.name} fill={entry.color} />
                ))}
              </Pie>
              <Tooltip formatter={(value: number) => `¥ ${value.toLocaleString()}`} />
            </PieChart>
          </ResponsiveContainer>
          <div className="space-y-2 mt-2">
            {assetDistributionData.map((item) => (
              <div key={item.name} className="flex items-center justify-between text-[13px]">
                <div className="flex items-center gap-2">
                  <div className="w-3 h-3 rounded-sm" style={{ backgroundColor: item.color }} />
                  <span>{item.name}</span>
                </div>
                <span className="text-muted-foreground">¥ {(item.value / 10000).toFixed(1)}万</span>
              </div>
            ))}
          </div>
        </div>
      </div>

      {/* Tables Row */}
      <div className="grid grid-cols-1 lg:grid-cols-2 gap-4">
        <div className="bg-white rounded-xl p-5 border border-border shadow-sm">
          <div className="flex items-center justify-between mb-4">
            <h3>最近凭证</h3>
            <button className="text-primary text-[13px] hover:underline" onClick={() => navigate("/finance/voucher")}>查看全部</button>
          </div>
          <div className="overflow-x-auto">
            <table className="w-full text-[13px]">
              <thead>
                <tr className="border-b border-border">
                  <th className="text-left py-2 text-muted-foreground" style={{ fontWeight: 500 }}>凭证号</th>
                  <th className="text-left py-2 text-muted-foreground" style={{ fontWeight: 500 }}>日期</th>
                  <th className="text-left py-2 text-muted-foreground" style={{ fontWeight: 500 }}>摘要</th>
                  <th className="text-right py-2 text-muted-foreground" style={{ fontWeight: 500 }}>金额</th>
                  <th className="text-center py-2 text-muted-foreground" style={{ fontWeight: 500 }}>状态</th>
                </tr>
              </thead>
              <tbody>
                {recentVouchersData.map((v) => (
                  <tr key={v.id} className="border-b border-border/50 hover:bg-muted/30 cursor-pointer" onClick={() => setShowVoucherDetail(v)}>
                    <td className="py-2.5 text-primary cursor-pointer hover:underline">{v.id}</td>
                    <td className="py-2.5 text-muted-foreground">{v.date}</td>
                    <td className="py-2.5">{v.summary}</td>
                    <td className={`py-2.5 text-right ${v.type === "收入" ? "text-green-600" : "text-red-500"}`}>{v.type === "收入" ? "+" : "-"}{v.amount}</td>
                    <td className="py-2.5 text-center">
                      <span className={`px-2 py-0.5 rounded-full text-[12px] ${v.status === "已审核" ? "bg-green-50 text-green-600" : "bg-amber-50 text-amber-600"}`}>
                        {v.status}
                      </span>
                    </td>
                  </tr>
                ))}
              </tbody>
            </table>
          </div>
        </div>

        <div className="bg-white rounded-xl p-5 border border-border shadow-sm">
          <div className="flex items-center justify-between mb-4">
            <h3>待审批事项</h3>
            <button className="text-primary text-[13px] hover:underline" onClick={() => navigate("/approval/center")}>查看全部</button>
          </div>
          <div className="space-y-3">
            {pendingApprovalsData.map((item) => (
              <div key={item.id} className="flex items-center justify-between p-3 rounded-lg border border-border/60 hover:border-primary/30 hover:bg-green-50/30 transition-colors">
                <div className="flex-1">
                  <div className="flex items-center gap-2">
                    <span>{item.title}</span>
                    {item.urgency === "紧急" && (
                      <span className="px-1.5 py-0.5 bg-red-50 text-red-500 rounded text-[11px]">紧急</span>
                    )}
                  </div>
                  <div className="flex items-center gap-3 mt-1 text-[13px] text-muted-foreground">
                    <span>申请人：{item.applicant}</span>
                    <span>{item.date}</span>
                  </div>
                </div>
                <div className="text-right">
                  <p style={{ fontWeight: 600 }}>{item.amount}</p>
                  <div className="flex gap-2 mt-1">
                    <button className="px-3 py-1 bg-primary text-white rounded text-[12px] hover:bg-primary/90" onClick={() => setShowApprovalModal(item)}>审批</button>
                    <button className="px-3 py-1 border border-border rounded text-[12px] hover:bg-muted" onClick={() => setShowApprovalDetail(item)}>查看</button>
                  </div>
                </div>
              </div>
            ))}
          </div>
        </div>
      </div>

      {/* Voucher Detail Modal */}
      <Modal open={!!showVoucherDetail} onClose={() => setShowVoucherDetail(null)} title="凭证详情">
        {showVoucherDetail && (
          <div className="space-y-3 text-[14px]">
            {[
              ["凭证号", showVoucherDetail.id],
              ["日期", showVoucherDetail.date],
              ["摘要", showVoucherDetail.summary],
              ["金额", showVoucherDetail.amount],
              ["类型", showVoucherDetail.type],
              ["状态", showVoucherDetail.status],
            ].map(([label, value]) => (
              <div key={String(label)} className="flex"><span className="text-muted-foreground w-20 flex-shrink-0">{label}</span><span>{value}</span></div>
            ))}
            <div className="flex justify-end gap-2 pt-3 border-t border-border">
              <button onClick={() => { setShowVoucherDetail(null); navigate("/finance/voucher"); }} className="px-4 py-2 bg-primary text-white rounded-lg text-[13px] hover:bg-primary/90">前往凭证管理</button>
            </div>
          </div>
        )}
      </Modal>

      {/* Approval Action Modal */}
      <Modal open={!!showApprovalModal} onClose={() => setShowApprovalModal(null)} title="审批处理" width="max-w-md">
        {showApprovalModal && (
          <div className="space-y-4">
            <div className="bg-green-50 rounded-lg p-4">
              <p style={{ fontWeight: 500 }}>{showApprovalModal.title}</p>
              <p className="text-muted-foreground text-[13px] mt-1">申请人：{showApprovalModal.applicant} | {showApprovalModal.date}</p>
              <p className="text-[16px] mt-2" style={{ fontWeight: 600 }}>{showApprovalModal.amount}</p>
            </div>
            <div>
              <label className="block text-[13px] text-muted-foreground mb-1">审批意见</label>
              <textarea placeholder="请输入审批意见（选填）" className="bg-muted rounded-lg px-3 py-2 outline-none w-full h-20 resize-none" />
            </div>
            <div className="flex justify-end gap-3">
              <button onClick={() => { setShowApprovalModal(null); toast.error("已驳回", { description: showApprovalModal.title }); }} className="px-4 py-2 bg-red-500 text-white rounded-lg hover:bg-red-600 text-[13px]">驳回</button>
              <button onClick={() => { setShowApprovalModal(null); toast.success("审批通过", { description: showApprovalModal.title }); }} className="px-4 py-2 bg-primary text-white rounded-lg hover:bg-primary/90 text-[13px]">通过</button>
            </div>
          </div>
        )}
      </Modal>

      {/* Approval Detail Modal */}
      <Modal open={!!showApprovalDetail} onClose={() => setShowApprovalDetail(null)} title="审批详情">
        {showApprovalDetail && (
          <div className="space-y-3 text-[14px]">
            {[
              ["事项", showApprovalDetail.title],
              ["金额", showApprovalDetail.amount],
              ["申请人", showApprovalDetail.applicant],
              ["日期", showApprovalDetail.date],
              ["紧急程度", showApprovalDetail.urgency],
            ].map(([label, value]) => (
              <div key={String(label)} className="flex"><span className="text-muted-foreground w-24 flex-shrink-0">{label}</span><span>{value}</span></div>
            ))}
            <div className="flex justify-end gap-2 pt-3 border-t border-border">
              <button onClick={() => { setShowApprovalDetail(null); navigate("/approval/center"); }} className="px-4 py-2 bg-primary text-white rounded-lg text-[13px] hover:bg-primary/90">前往审批中心</button>
            </div>
          </div>
        )}
      </Modal>
    </div>
  );
}


