import { useState } from "react";
import { toast } from "sonner";
import { Modal, ConfirmDialog } from "./ui/Modal";
import {
  ChevronRight, Search, Eye, CheckCircle, XCircle, Clock, Filter, Edit,
  AlertCircle, ArrowRight, User, Users, Settings, Download, FileText, Plus
} from "lucide-react";

type ApprovalItem = {
  id: number; no: string; payee: string; account: string; summary: string;
  reviewer: string; status: string; date: string; village: string;
  amount: number; payAccount: string; reason?: string;
};

type HistoryItem = {
  no: string; title: string; amount: number; applicant: string;
  reviewer: string; result: string; date: string;
};

// ========== Shared Global Approval History Store ==========
// Uses window-level storage for reliable cross-route state sync

const HISTORY_KEY = "__approvalHistoryStore";

function getGlobalHistory(): HistoryItem[] {
  if (!(window as any)[HISTORY_KEY]) {
    (window as any)[HISTORY_KEY] = [
      { no: "SP-2026-0086", title: "椰林大道绿化养护费", amount: 23750, applicant: "符会计", reviewer: "黄志明→王海燕→符国强", result: "通过", date: "2026-03-06" },
      { no: "SP-2026-0085", title: "文化广场水电费", amount: 2200, applicant: "王出纳", reviewer: "王海燕", result: "通过", date: "2026-03-05" },
      { no: "SP-2026-0084", title: "保洁人员工资", amount: 18000, applicant: "符会计", reviewer: "符国强", result: "驳回", date: "2026-03-04" },
      { no: "SP-2026-0083", title: "办公耗材采购", amount: 1500, applicant: "王出纳", reviewer: "王海燕", result: "通过", date: "2026-03-03" },
    ];
  }
  return (window as any)[HISTORY_KEY];
}

function pushHistoryItem(item: HistoryItem) {
  const list = getGlobalHistory();
  if (!list.some((h: HistoryItem) => h.no === item.no)) {
    list.unshift(item);
  }
}

const initialApprovals: ApprovalItem[] = [
  { id: 1, no: "SP-2026-0089", payee: "琼海宏达建设有限公司", account: "6222****5678", summary: "美丽乡村建设工程款（第二期）", reviewer: "符国强", status: "待审批", date: "2026-03-09", village: "椰林村", amount: 56000, payAccount: "6228****1234" },
  { id: 2, no: "SP-2026-0088", payee: "琼海科信电脑城", account: "6225****9012", summary: "办公设备采购款", reviewer: "王海燕", status: "待审批", date: "2026-03-08", village: "椰林村", amount: 12500, payAccount: "6228****1234" },
  { id: 3, no: "SP-2026-0087", payee: "海南中路建设公司", account: "6221****3456", summary: "村道硬化修缮费用", reviewer: "符国强", status: "审批中", date: "2026-03-07", village: "椰林村", amount: 38000, payAccount: "6228****1234" },
  { id: 4, no: "SP-2026-0086", payee: "海南绿源园林公司", account: "6223****7890", summary: "椰林大道绿化养护费（Q1）", reviewer: "黄志明", status: "已通过", date: "2026-03-06", village: "椰林村", amount: 23750, payAccount: "6228****1234" },
  { id: 5, no: "SP-2026-0085", payee: "海南电网琼海供电局", account: "6220****2345", summary: "文化广场水电费", reviewer: "王海燕", status: "已通过", date: "2026-03-05", village: "椰林村", amount: 2200, payAccount: "6228****1234" },
  { id: 6, no: "SP-2026-0084", payee: "王秀兰等6人", account: "多个账户", summary: "保洁人员工资", reviewer: "符国强", status: "已驳回", date: "2026-03-04", village: "椰林村", amount: 18000, payAccount: "6228****1234", reason: "请补充工资明细清单" },
];

export function ApprovalCenter() {
  const [approvals, setApprovals] = useState(initialApprovals);
  const [statusFilter, setStatusFilter] = useState("全部");
  const [showApprove, setShowApprove] = useState<ApprovalItem | null>(null);
  const [showReject, setShowReject] = useState<ApprovalItem | null>(null);
  const [rejectReason, setRejectReason] = useState("");
  const [showDetail, setShowDetail] = useState<ApprovalItem | null>(null);
  const statuses = ["全部", "待审批", "审批中", "已通过", "已驳回"];
  const filtered = statusFilter === "全部" ? approvals : approvals.filter(d => d.status === statusFilter);

  const counts = {
    待审批: approvals.filter(d => d.status === "待审批").length,
    审批中: approvals.filter(d => d.status === "审批中").length,
    已通过: approvals.filter(d => d.status === "已通过").length,
    已驳回: approvals.filter(d => d.status === "已驳回").length,
  };

  const handleApprove = (item: ApprovalItem) => {
    setApprovals(approvals.map(a => a.id === item.id ? { ...a, status: "已通过" } : a));
    toast.success("审批通过", { description: `${item.no} ${item.summary} 已通过，金额 ¥${item.amount.toLocaleString()}` });
    setShowApprove(null);
    pushHistoryItem({ no: item.no, title: item.summary, amount: item.amount, applicant: "符会计", reviewer: "黄志明→王海燕→符国强", result: "通过", date: item.date });
  };

  const handleReject = (item: ApprovalItem) => {
    if (!rejectReason.trim()) { toast.error("请填写驳回原因"); return; }
    setApprovals(approvals.map(a => a.id === item.id ? { ...a, status: "已驳回", reason: rejectReason } : a));
    toast.error("审批已驳回", { description: `${item.no} ${item.summary}` });
    setShowReject(null);
    setRejectReason("");
    pushHistoryItem({ no: item.no, title: item.summary, amount: item.amount, applicant: "符会计", reviewer: "符国强", result: "驳回", date: item.date });
  };

  return (
    <div className="space-y-4">
      <div className="flex items-center text-muted-foreground text-[13px]">
        <span>在线审批</span><ChevronRight className="w-4 h-4 mx-1" /><span className="text-foreground">审批中心</span>
      </div>
      <h2>审批中心</h2>

      <div className="grid grid-cols-1 md:grid-cols-4 gap-4">
        {([
          { label: "待审批", value: counts["待审批"], icon: Clock, color: "#f59e0b", bg: "bg-amber-50" },
          { label: "审批中", value: counts["审批中"], icon: AlertCircle, color: "#0ea5e9", bg: "bg-blue-50" },
          { label: "已通过", value: counts["已通过"], icon: CheckCircle, color: "#0d9448", bg: "bg-green-50" },
          { label: "已驳回", value: counts["已驳回"], icon: XCircle, color: "#ef4444", bg: "bg-red-50" },
        ] as const).map(card => {
          const Icon = card.icon;
          return (
            <div key={card.label} className={`bg-white rounded-xl p-4 border shadow-sm cursor-pointer hover:shadow-md transition-shadow ${statusFilter === card.label ? "border-primary ring-2 ring-primary/20" : "border-border"}`} onClick={() => setStatusFilter(card.label)}>
              <div className="flex items-center gap-3">
                <div className={`w-10 h-10 rounded-lg flex items-center justify-center ${card.bg}`}><Icon className="w-5 h-5" style={{ color: card.color }} /></div>
                <div>
                  <p className="text-[22px]" style={{ fontWeight: 600 }}>{card.value}</p>
                  <p className="text-[12px] text-muted-foreground">{card.label}</p>
                </div>
              </div>
            </div>
          );
        })}
      </div>

      <div className="bg-white rounded-xl border border-border shadow-sm p-5">
        <div className="flex flex-wrap items-center gap-3 mb-4">
          <div className="flex gap-1">
            {statuses.map(s => (
              <button key={s} className={`px-3 py-1.5 rounded-lg text-[13px] ${statusFilter === s ? "bg-primary text-white" : "bg-muted text-muted-foreground hover:text-foreground"}`} onClick={() => setStatusFilter(s)}>{s}</button>
            ))}
          </div>
          <div className="flex-1" />
          <div className="relative">
            <Search className="w-4 h-4 absolute left-3 top-1/2 -translate-y-1/2 text-muted-foreground" />
            <input type="text" placeholder="搜索收款单位/摘要..." className="pl-9 pr-4 py-2 bg-muted rounded-lg w-[220px] outline-none" />
          </div>
        </div>

        <div className="overflow-x-auto border border-border rounded-lg">
          <table className="w-full text-[13px]">
            <thead className="bg-muted/60">
              <tr>
                <th className="py-3 px-3 text-left text-muted-foreground" style={{ fontWeight: 500 }}>序号</th>
                <th className="py-3 px-3 text-left text-muted-foreground" style={{ fontWeight: 500 }}>单号</th>
                <th className="py-3 px-3 text-left text-muted-foreground" style={{ fontWeight: 500 }}>收款单位</th>
                <th className="py-3 px-3 text-left text-muted-foreground" style={{ fontWeight: 500 }}>摘要</th>
                <th className="py-3 px-3 text-right text-muted-foreground" style={{ fontWeight: 500 }}>金额（元）</th>
                <th className="py-3 px-3 text-left text-muted-foreground" style={{ fontWeight: 500 }}>审核人</th>
                <th className="py-3 px-3 text-left text-muted-foreground" style={{ fontWeight: 500 }}>录入时间</th>
                <th className="py-3 px-3 text-center text-muted-foreground" style={{ fontWeight: 500 }}>审批状态</th>
                <th className="py-3 px-3 text-center text-muted-foreground" style={{ fontWeight: 500 }}>操作</th>
              </tr>
            </thead>
            <tbody>
              {filtered.length === 0 ? (
                <tr><td colSpan={9} className="py-12 text-center text-muted-foreground">暂无{statusFilter === "全部" ? "" : statusFilter}记录</td></tr>
              ) : filtered.map((row, idx) => (
                <tr key={row.id} className="border-t border-border/50 hover:bg-green-50/30">
                  <td className="py-2.5 px-3 text-muted-foreground">{idx + 1}</td>
                  <td className="py-2.5 px-3 text-primary cursor-pointer hover:underline" onClick={() => setShowDetail(row)}>{row.no}</td>
                  <td className="py-2.5 px-3">{row.payee}</td>
                  <td className="py-2.5 px-3">{row.summary}</td>
                  <td className="py-2.5 px-3 text-right" style={{ fontWeight: 500 }}>¥ {row.amount.toLocaleString()}</td>
                  <td className="py-2.5 px-3">{row.reviewer}</td>
                  <td className="py-2.5 px-3 text-muted-foreground">{row.date}</td>
                  <td className="py-2.5 px-3 text-center">
                    <span className={`px-2 py-0.5 rounded-full text-[12px] ${
                      row.status === "待审批" ? "bg-amber-50 text-amber-600" :
                      row.status === "审批中" ? "bg-blue-50 text-blue-600" :
                      row.status === "已通过" ? "bg-green-50 text-green-600" :
                      "bg-red-50 text-red-500"
                    }`}>{row.status}</span>
                  </td>
                  <td className="py-2.5 px-3">
                    <div className="flex items-center justify-center gap-1">
                      <button className="p-1 hover:bg-muted rounded" title="查看" onClick={() => setShowDetail(row)}><Eye className="w-4 h-4 text-muted-foreground" /></button>
                      {(row.status === "待审批" || row.status === "审批中") && (
                        <>
                          <button className="p-1 hover:bg-green-50 rounded" title="通过" onClick={() => setShowApprove(row)}><CheckCircle className="w-4 h-4 text-green-500" /></button>
                          <button className="p-1 hover:bg-red-50 rounded" title="驳回" onClick={() => setShowReject(row)}><XCircle className="w-4 h-4 text-red-400" /></button>
                        </>
                      )}
                    </div>
                  </td>
                </tr>
              ))}
            </tbody>
          </table>
        </div>
        <div className="flex items-center justify-between mt-4 text-[13px]">
          <span className="text-muted-foreground">共 {filtered.length} 条记录</span>
        </div>
      </div>

      {/* Approve Confirm */}
      <ConfirmDialog
        open={!!showApprove}
        onClose={() => setShowApprove(null)}
        onConfirm={() => showApprove && handleApprove(showApprove)}
        title="确认审批通过"
        message={showApprove ? `确认通过 ${showApprove.summary}？\n金额：¥ ${showApprove.amount.toLocaleString()}\n收款方：${showApprove.payee}` : ""}
        confirmText="通过"
        type="info"
      />

      {/* Reject Modal */}
      <Modal open={!!showReject} onClose={() => { setShowReject(null); setRejectReason(""); }} title="驳回审批">
        {showReject && (
          <div className="space-y-4">
            <div className="bg-red-50 rounded-lg p-4 text-[14px]">
              <p className="text-red-700" style={{ fontWeight: 500 }}>{showReject.summary}</p>
              <p className="text-red-600 mt-1">金额：¥ {showReject.amount.toLocaleString()} | 收款方：{showReject.payee}</p>
            </div>
            <div>
              <label className="block text-[13px] text-muted-foreground mb-1">驳回原因 *</label>
              <textarea value={rejectReason} onChange={e => setRejectReason(e.target.value)} placeholder="请输入驳回原因..." className="bg-muted rounded-lg px-3 py-2 outline-none w-full h-24 resize-none focus:ring-2 focus:ring-red-300" />
            </div>
            <div className="flex justify-end gap-3">
              <button onClick={() => { setShowReject(null); setRejectReason(""); }} className="px-4 py-2 border border-border rounded-lg hover:bg-muted">取消</button>
              <button onClick={() => handleReject(showReject)} className="px-4 py-2 bg-red-500 text-white rounded-lg hover:bg-red-600">驳回</button>
            </div>
          </div>
        )}
      </Modal>

      {/* Detail Modal */}
      <Modal open={!!showDetail} onClose={() => setShowDetail(null)} title="审批详情" width="max-w-xl">
        {showDetail && (
          <div className="space-y-4">
            <div className="grid grid-cols-2 gap-3 text-[14px]">
              {[
                ["单号", showDetail.no],
                ["录入时间", showDetail.date],
                ["收款单位", showDetail.payee],
                ["收款账号", showDetail.account],
                ["付款账号", showDetail.payAccount],
                ["所属村", showDetail.village],
              ].map(([l, v]) => (
                <div key={l} className="flex"><span className="text-muted-foreground w-20 flex-shrink-0">{l}</span><span>{v}</span></div>
              ))}
            </div>
            <div className="text-[14px]"><span className="text-muted-foreground">摘要：</span>{showDetail.summary}</div>
            <div className="text-[14px]"><span className="text-muted-foreground">金额：</span><span style={{ fontWeight: 600 }}>¥ {showDetail.amount.toLocaleString()}</span></div>
            <div className="text-[14px]"><span className="text-muted-foreground">当前状态：</span>
              <span className={`px-2 py-0.5 rounded-full text-[12px] ${
                showDetail.status === "待审批" ? "bg-amber-50 text-amber-600" :
                showDetail.status === "已通过" ? "bg-green-50 text-green-600" :
                showDetail.status === "已驳回" ? "bg-red-50 text-red-500" : "bg-blue-50 text-blue-600"
              }`}>{showDetail.status}</span>
            </div>
            {showDetail.reason && <div className="bg-red-50 rounded-lg p-3 text-[13px] text-red-600"><span style={{ fontWeight: 500 }}>驳回原因：</span>{showDetail.reason}</div>}
            <div className="border-t border-border pt-4">
              <h4 className="text-[13px] text-muted-foreground mb-3">审批流程</h4>
              <div className="flex items-center gap-3">
                {["会计初审", "村监委审核", "村主任审批", "村书记终审"].map((step, idx) => (
                  <div key={step} className="flex items-center gap-3">
                    <div className="flex flex-col items-center">
                      <div className={`w-10 h-10 rounded-full flex items-center justify-center ${
                        showDetail.status === "已通过" ? "bg-green-100 text-green-600" :
                        showDetail.status === "已驳回" && idx === 0 ? "bg-red-100 text-red-500" :
                        idx === 0 ? "bg-primary text-white" : "bg-muted text-muted-foreground"
                      }`}>
                        {showDetail.status === "已通过" ? <CheckCircle className="w-4 h-4" /> :
                         showDetail.status === "已驳回" && idx === 0 ? <XCircle className="w-4 h-4" /> :
                         <User className="w-4 h-4" />}
                      </div>
                      <span className="text-[11px] mt-1">{step}</span>
                    </div>
                    {idx < 3 && <ArrowRight className="w-4 h-4 text-muted-foreground/40 mt-[-16px]" />}
                  </div>
                ))}
              </div>
            </div>
          </div>
        )}
      </Modal>
    </div>
  );
}

// =============== PAYMENT MANAGEMENT ===============

export function PaymentManagement() {
  const [payments, setPayments] = useState([
    { id: 1, no: "ZF-2026-045", status: "已支付", amount: 23750, date: "2026-03-06", payee: "海南绿源园林公司", entity: "椰林村" },
    { id: 2, no: "ZF-2026-044", status: "已支付", amount: 2200, date: "2026-03-05", payee: "海南电网琼海供电局", entity: "椰林村" },
    { id: 3, no: "ZF-2026-043", status: "待支付", amount: 56000, date: "2026-03-09", payee: "琼海宏达建设有限公司", entity: "椰林村" },
    { id: 4, no: "ZF-2026-042", status: "待支付", amount: 12500, date: "2026-03-08", payee: "琼海科信电脑城", entity: "椰林村" },
  ]);
  const [showPay, setShowPay] = useState<typeof payments[0] | null>(null);
  const [showPayDetail, setShowPayDetail] = useState<typeof payments[0] | null>(null);
  const [showAddPayment, setShowAddPayment] = useState(false);
  const [newPayment, setNewPayment] = useState({ payee: "", amount: "", entity: "椰林村" });

  const handlePay = (item: typeof payments[0]) => {
    toast.info("正在通过银农直联发起支付...");
    setTimeout(() => {
      setPayments(payments.map(p => p.id === item.id ? { ...p, status: "已支付" } : p));
      toast.success("支付成功", { description: `${item.no} 已成功支付 ¥${item.amount.toLocaleString()} 至 ${item.payee}` });
      setShowPay(null);
    }, 1200);
  };

  return (
    <div className="space-y-4">
      <div className="flex items-center text-muted-foreground text-[13px]">
        <span>在线审批</span><ChevronRight className="w-4 h-4 mx-1" /><span className="text-foreground">支付管理</span>
      </div>
      <h2>支付管理</h2>
      <div className="bg-white rounded-xl border border-border shadow-sm p-5">
        <div className="flex gap-3 mb-4">
          <button onClick={() => setShowAddPayment(true)} className="flex items-center gap-1.5 px-4 py-2 bg-primary text-white rounded-lg hover:bg-primary/90"><Plus className="w-4 h-4" /> 新增支付单</button>
          <div className="flex-1" />
          <button onClick={() => toast.success("导出成功", { description: `已导出 ${payments.length} 条支付记录` })} className="flex items-center gap-1 px-3 py-2 border border-border rounded-lg hover:bg-muted text-[13px]"><Download className="w-4 h-4" /> 导出</button>
        </div>
        <div className="overflow-x-auto border border-border rounded-lg">
          <table className="w-full text-[13px]">
            <thead className="bg-muted/60">
              <tr>
                <th className="py-3 px-3 text-left text-muted-foreground" style={{ fontWeight: 500 }}>序号</th>
                <th className="py-3 px-3 text-left text-muted-foreground" style={{ fontWeight: 500 }}>单号</th>
                <th className="py-3 px-3 text-left text-muted-foreground" style={{ fontWeight: 500 }}>支付对象</th>
                <th className="py-3 px-3 text-right text-muted-foreground" style={{ fontWeight: 500 }}>金额</th>
                <th className="py-3 px-3 text-left text-muted-foreground" style={{ fontWeight: 500 }}>支付日期</th>
                <th className="py-3 px-3 text-left text-muted-foreground" style={{ fontWeight: 500 }}>财务主体</th>
                <th className="py-3 px-3 text-center text-muted-foreground" style={{ fontWeight: 500 }}>状态</th>
                <th className="py-3 px-3 text-center text-muted-foreground" style={{ fontWeight: 500 }}>操作</th>
              </tr>
            </thead>
            <tbody>
              {payments.map((row, idx) => (
                <tr key={row.id} className="border-t border-border/50 hover:bg-green-50/30">
                  <td className="py-2.5 px-3">{idx + 1}</td>
                  <td className="py-2.5 px-3 text-primary">{row.no}</td>
                  <td className="py-2.5 px-3">{row.payee}</td>
                  <td className="py-2.5 px-3 text-right" style={{ fontWeight: 500 }}>¥ {row.amount.toLocaleString()}</td>
                  <td className="py-2.5 px-3 text-muted-foreground">{row.date}</td>
                  <td className="py-2.5 px-3">{row.entity}</td>
                  <td className="py-2.5 px-3 text-center">
                    <span className={`px-2 py-0.5 rounded-full text-[12px] ${row.status === "已支付" ? "bg-green-50 text-green-600" : "bg-amber-50 text-amber-600"}`}>{row.status}</span>
                  </td>
                  <td className="py-2.5 px-3 text-center">
                    {row.status === "待支付" ? (
                      <button onClick={() => setShowPay(row)} className="px-3 py-1 bg-primary text-white rounded text-[12px] hover:bg-primary/90">支付</button>
                    ) : (
                      <button onClick={() => setShowPayDetail(row)} className="p-1 hover:bg-muted rounded"><Eye className="w-4 h-4 text-muted-foreground" /></button>
                    )}
                  </td>
                </tr>
              ))}
            </tbody>
          </table>
        </div>
      </div>
      <ConfirmDialog
        open={!!showPay}
        onClose={() => setShowPay(null)}
        onConfirm={() => showPay && handlePay(showPay)}
        title="确认支付"
        message={showPay ? `确认向 ${showPay.payee} 支付 ¥${showPay.amount.toLocaleString()} 吗？\n\n资金将通过银农直联接口从椰林村基本账户(6228****1234)划转。` : ""}
        confirmText="确认支付"
        type="warning"
      />

      {/* Add Payment Modal */}
      <Modal open={showAddPayment} onClose={() => setShowAddPayment(false)} title="新增支付单">
        <div className="space-y-4">
          <div><label className="block text-[13px] text-muted-foreground mb-1">支付对象 *</label><input value={newPayment.payee} onChange={e => setNewPayment({ ...newPayment, payee: e.target.value })} placeholder="请输入支付对象" className="bg-muted rounded-lg px-3 py-2 outline-none w-full" /></div>
          <div><label className="block text-[13px] text-muted-foreground mb-1">支付金额 *</label><input type="number" value={newPayment.amount} onChange={e => setNewPayment({ ...newPayment, amount: e.target.value })} placeholder="0.00" className="bg-muted rounded-lg px-3 py-2 outline-none w-full text-right" /></div>
          <div><label className="block text-[13px] text-muted-foreground mb-1">财务主体</label><select value={newPayment.entity} onChange={e => setNewPayment({ ...newPayment, entity: e.target.value })} className="bg-muted rounded-lg px-3 py-2 outline-none w-full"><option>椰林村</option><option>南强村</option></select></div>
          <div className="bg-amber-50 rounded-lg p-3 text-[13px] text-amber-700">提示：支付单创建后需在审批中心完成审批才能执行支付。</div>
          <div className="flex justify-end gap-3 pt-2">
            <button onClick={() => setShowAddPayment(false)} className="px-4 py-2 border border-border rounded-lg hover:bg-muted">取消</button>
            <button onClick={() => { if (!newPayment.payee || !newPayment.amount) { toast.error("请填写支付对象和金额"); return; } const newId = Math.max(...payments.map(p => p.id), 0) + 1; const no = `ZF-2026-${String(40 + newId).padStart(3, "0")}`; setPayments([{ id: newId + 100, no, status: "待支付", amount: parseFloat(newPayment.amount) || 0, date: "2026-03-09", payee: newPayment.payee, entity: newPayment.entity }, ...payments]); setShowAddPayment(false); toast.success("支付单已创建", { description: `${no} 待支付 ¥${parseFloat(newPayment.amount || "0").toLocaleString()}` }); setNewPayment({ payee: "", amount: "", entity: "椰林村" }); }} className="px-4 py-2 bg-primary text-white rounded-lg hover:bg-primary/90">提交</button>
          </div>
        </div>
      </Modal>

      {/* Payment Detail Modal */}
      <Modal open={!!showPayDetail} onClose={() => setShowPayDetail(null)} title="支付详情">
        {showPayDetail && (
          <div className="space-y-3 text-[14px]">
            {[
              ["单号", showPayDetail.no],
              ["支付对象", showPayDetail.payee],
              ["金额", `¥ ${showPayDetail.amount.toLocaleString()}`],
              ["支付日期", showPayDetail.date],
              ["财务主体", showPayDetail.entity],
              ["状态", showPayDetail.status],
            ].map(([label, value]) => (
              <div key={label} className="flex"><span className="text-muted-foreground w-24 flex-shrink-0">{label}</span><span>{value}</span></div>
            ))}
          </div>
        )}
      </Modal>
    </div>
  );
}

// =============== TYPES TAB COMPONENT ===============

function TypesTab() {
  const [incomeTypes, setIncomeTypes] = useState([
    { id: 1, name: "经营收入", code: "SR-01", desc: "集体经营产生的收入", enabled: true },
    { id: 2, name: "补助收入", code: "SR-02", desc: "各级政府拨付的补助款", enabled: true },
    { id: 3, name: "投资收益", code: "SR-03", desc: "对外投资取得的收益", enabled: true },
    { id: 4, name: "发包及上交收入", code: "SR-04", desc: "土地发包、承包上交收入", enabled: true },
    { id: 5, name: "其他收入", code: "SR-05", desc: "其他各类收入", enabled: true },
  ]);
  const [expenseTypes, setExpenseTypes] = useState([
    { id: 1, name: "经营支出", code: "ZC-01", desc: "集体经营活动支出", enabled: true },
    { id: 2, name: "管理费用", code: "ZC-02", desc: "村务日常管理费用", enabled: true },
    { id: 3, name: "投资支出", code: "ZC-03", desc: "对外投资支出", enabled: false },
    { id: 4, name: "税金及附加", code: "ZC-04", desc: "各类税费支出", enabled: true },
    { id: 5, name: "其他支出", code: "ZC-05", desc: "其他各类支出", enabled: true },
  ]);
  const [showAddIncome, setShowAddIncome] = useState(false);
  const [showAddExpense, setShowAddExpense] = useState(false);
  const [editItem, setEditItem] = useState<{ kind: "income" | "expense"; item: typeof incomeTypes[0] } | null>(null);
  const [formName, setFormName] = useState("");
  const [formCode, setFormCode] = useState("");
  const [formDesc, setFormDesc] = useState("");

  const resetForm = () => { setFormName(""); setFormCode(""); setFormDesc(""); };

  const handleAddIncome = () => {
    if (!formName || !formCode) { toast.error("请填写类型名称和编码"); return; }
    setIncomeTypes(prev => [...prev, { id: Math.max(...prev.map(t => t.id), 0) + 1, name: formName, code: formCode, desc: formDesc, enabled: true }]);
    setShowAddIncome(false); resetForm();
    toast.success("收入类型添加成功", { description: formName });
  };
  const handleAddExpense = () => {
    if (!formName || !formCode) { toast.error("请填写类型名称和编码"); return; }
    setExpenseTypes(prev => [...prev, { id: Math.max(...prev.map(t => t.id), 0) + 1, name: formName, code: formCode, desc: formDesc, enabled: true }]);
    setShowAddExpense(false); resetForm();
    toast.success("支出类型添加成功", { description: formName });
  };
  const handleEditSave = () => {
    if (!editItem || !formName || !formCode) { toast.error("请填写类型名称和编码"); return; }
    if (editItem.kind === "income") {
      setIncomeTypes(prev => prev.map(t => t.id === editItem.item.id ? { ...t, name: formName, code: formCode, desc: formDesc } : t));
    } else {
      setExpenseTypes(prev => prev.map(t => t.id === editItem.item.id ? { ...t, name: formName, code: formCode, desc: formDesc } : t));
    }
    toast.success("类型已更新", { description: formName });
    setEditItem(null); resetForm();
  };
  const openEdit = (kind: "income" | "expense", item: typeof incomeTypes[0]) => {
    setEditItem({ kind, item }); setFormName(item.name); setFormCode(item.code); setFormDesc(item.desc);
  };
  const toggleEnabled = (kind: "income" | "expense", id: number) => {
    if (kind === "income") {
      setIncomeTypes(prev => prev.map(t => t.id === id ? { ...t, enabled: !t.enabled } : t));
    } else {
      setExpenseTypes(prev => prev.map(t => t.id === id ? { ...t, enabled: !t.enabled } : t));
    }
    toast.success("状态已更新");
  };

  return (
    <div className="p-5">
      <div className="flex items-center justify-between mb-4">
        <p className="text-[13px] text-muted-foreground">管理审批流程中使用的收支类型分类，启用/停用类型将影响新建审批单时的类型选项。</p>
      </div>
      <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
        {/* 收入类型 */}
        <div className="border border-border rounded-xl overflow-hidden">
          <div className="flex items-center justify-between px-4 py-3 bg-green-50/50 border-b border-border">
            <div className="flex items-center gap-2"><div className="w-3 h-3 rounded-full bg-green-500" /><span style={{ fontWeight: 500 }} className="text-green-700">收入类型</span><span className="text-[12px] text-muted-foreground">({incomeTypes.length})</span></div>
            <button onClick={() => { resetForm(); setShowAddIncome(true); }} className="flex items-center gap-1 px-3 py-1.5 bg-primary text-white rounded-lg text-[12px] hover:bg-primary/90"><Plus className="w-3.5 h-3.5" /> 新增</button>
          </div>
          <div className="divide-y divide-border/50">
            {incomeTypes.map(t => (
              <div key={t.id} className="flex items-center justify-between px-4 py-3 hover:bg-green-50/20">
                <div className="flex-1 min-w-0">
                  <div className="flex items-center gap-2">
                    <span className="text-[13px]" style={{ fontWeight: 500 }}>{t.name}</span>
                    <span className="text-[11px] text-muted-foreground bg-muted px-1.5 py-0.5 rounded">{t.code}</span>
                    <span className={`text-[11px] px-1.5 py-0.5 rounded-full ${t.enabled ? "bg-green-50 text-green-600" : "bg-gray-100 text-gray-400"}`}>{t.enabled ? "启用" : "停用"}</span>
                  </div>
                  <p className="text-[12px] text-muted-foreground mt-0.5">{t.desc}</p>
                </div>
                <div className="flex items-center gap-1 ml-3">
                  <button onClick={() => openEdit("income", t)} className="p-1.5 hover:bg-muted rounded"><Edit className="w-3.5 h-3.5 text-muted-foreground" /></button>
                  <button onClick={() => toggleEnabled("income", t.id)} className="p-1.5 hover:bg-muted rounded">{t.enabled ? <CheckCircle className="w-3.5 h-3.5 text-green-500" /> : <XCircle className="w-3.5 h-3.5 text-gray-400" />}</button>
                </div>
              </div>
            ))}
          </div>
        </div>
        {/* 支出类型 */}
        <div className="border border-border rounded-xl overflow-hidden">
          <div className="flex items-center justify-between px-4 py-3 bg-red-50/50 border-b border-border">
            <div className="flex items-center gap-2"><div className="w-3 h-3 rounded-full bg-red-500" /><span style={{ fontWeight: 500 }} className="text-red-600">支出类型</span><span className="text-[12px] text-muted-foreground">({expenseTypes.length})</span></div>
            <button onClick={() => { resetForm(); setShowAddExpense(true); }} className="flex items-center gap-1 px-3 py-1.5 bg-primary text-white rounded-lg text-[12px] hover:bg-primary/90"><Plus className="w-3.5 h-3.5" /> 新增</button>
          </div>
          <div className="divide-y divide-border/50">
            {expenseTypes.map(t => (
              <div key={t.id} className="flex items-center justify-between px-4 py-3 hover:bg-red-50/20">
                <div className="flex-1 min-w-0">
                  <div className="flex items-center gap-2">
                    <span className="text-[13px]" style={{ fontWeight: 500 }}>{t.name}</span>
                    <span className="text-[11px] text-muted-foreground bg-muted px-1.5 py-0.5 rounded">{t.code}</span>
                    <span className={`text-[11px] px-1.5 py-0.5 rounded-full ${t.enabled ? "bg-green-50 text-green-600" : "bg-gray-100 text-gray-400"}`}>{t.enabled ? "启用" : "停用"}</span>
                  </div>
                  <p className="text-[12px] text-muted-foreground mt-0.5">{t.desc}</p>
                </div>
                <div className="flex items-center gap-1 ml-3">
                  <button onClick={() => openEdit("expense", t)} className="p-1.5 hover:bg-muted rounded"><Edit className="w-3.5 h-3.5 text-muted-foreground" /></button>
                  <button onClick={() => toggleEnabled("expense", t.id)} className="p-1.5 hover:bg-muted rounded">{t.enabled ? <CheckCircle className="w-3.5 h-3.5 text-green-500" /> : <XCircle className="w-3.5 h-3.5 text-gray-400" />}</button>
                </div>
              </div>
            ))}
          </div>
        </div>
      </div>

      {/* Add Income Modal */}
      <Modal open={showAddIncome} onClose={() => { setShowAddIncome(false); resetForm(); }} title="新增收入类型">
        <div className="space-y-4">
          <div><label className="block text-[13px] text-muted-foreground mb-1">类型名称 *</label><input value={formName} onChange={e => setFormName(e.target.value)} placeholder="如：租赁收入" className="bg-muted rounded-lg px-3 py-2 outline-none w-full" /></div>
          <div><label className="block text-[13px] text-muted-foreground mb-1">类型编码 *</label><input value={formCode} onChange={e => setFormCode(e.target.value)} placeholder="如：SR-06" className="bg-muted rounded-lg px-3 py-2 outline-none w-full" /></div>
          <div><label className="block text-[13px] text-muted-foreground mb-1">描述</label><input value={formDesc} onChange={e => setFormDesc(e.target.value)} placeholder="类型说明" className="bg-muted rounded-lg px-3 py-2 outline-none w-full" /></div>
          <div className="flex justify-end gap-3 pt-2">
            <button onClick={() => { setShowAddIncome(false); resetForm(); }} className="px-4 py-2 border border-border rounded-lg hover:bg-muted">取消</button>
            <button onClick={handleAddIncome} className="px-4 py-2 bg-primary text-white rounded-lg hover:bg-primary/90">保存</button>
          </div>
        </div>
      </Modal>
      {/* Add Expense Modal */}
      <Modal open={showAddExpense} onClose={() => { setShowAddExpense(false); resetForm(); }} title="新增支出类型">
        <div className="space-y-4">
          <div><label className="block text-[13px] text-muted-foreground mb-1">类型名称 *</label><input value={formName} onChange={e => setFormName(e.target.value)} placeholder="如：工程支出" className="bg-muted rounded-lg px-3 py-2 outline-none w-full" /></div>
          <div><label className="block text-[13px] text-muted-foreground mb-1">类型编码 *</label><input value={formCode} onChange={e => setFormCode(e.target.value)} placeholder="如：ZC-06" className="bg-muted rounded-lg px-3 py-2 outline-none w-full" /></div>
          <div><label className="block text-[13px] text-muted-foreground mb-1">描述</label><input value={formDesc} onChange={e => setFormDesc(e.target.value)} placeholder="类型说明" className="bg-muted rounded-lg px-3 py-2 outline-none w-full" /></div>
          <div className="flex justify-end gap-3 pt-2">
            <button onClick={() => { setShowAddExpense(false); resetForm(); }} className="px-4 py-2 border border-border rounded-lg hover:bg-muted">取消</button>
            <button onClick={handleAddExpense} className="px-4 py-2 bg-primary text-white rounded-lg hover:bg-primary/90">保存</button>
          </div>
        </div>
      </Modal>
      {/* Edit Modal */}
      <Modal open={!!editItem} onClose={() => { setEditItem(null); resetForm(); }} title={`编辑${editItem?.kind === "income" ? "收入" : "支出"}类型`}>
        <div className="space-y-4">
          <div><label className="block text-[13px] text-muted-foreground mb-1">类型名称 *</label><input value={formName} onChange={e => setFormName(e.target.value)} className="bg-muted rounded-lg px-3 py-2 outline-none w-full" /></div>
          <div><label className="block text-[13px] text-muted-foreground mb-1">类型编码 *</label><input value={formCode} onChange={e => setFormCode(e.target.value)} className="bg-muted rounded-lg px-3 py-2 outline-none w-full" /></div>
          <div><label className="block text-[13px] text-muted-foreground mb-1">描述</label><input value={formDesc} onChange={e => setFormDesc(e.target.value)} className="bg-muted rounded-lg px-3 py-2 outline-none w-full" /></div>
          <div className="flex justify-end gap-3 pt-2">
            <button onClick={() => { setEditItem(null); resetForm(); }} className="px-4 py-2 border border-border rounded-lg hover:bg-muted">取消</button>
            <button onClick={handleEditSave} className="px-4 py-2 bg-primary text-white rounded-lg hover:bg-primary/90">保存</button>
          </div>
        </div>
      </Modal>
    </div>
  );
}

// =============== APPROVAL CONFIG ===============

export function ApprovalConfig() {
  const [tab, setTab] = useState("positions");
  const tabs = [
    { key: "positions", label: "审批岗位" },
    { key: "flow", label: "审批流程" },
    { key: "types", label: "收支类型" },
  ];
  const [positions, setPositions] = useState([
    { name: "村书记", level: "最终审批", permissions: "所有支付审批", person: "符国强" },
    { name: "村主任", level: "二级审批", permissions: "5万元以下支付审批", person: "王海燕" },
    { name: "村监委主任", level: "监督审批", permissions: "监督审核", person: "黄志明" },
    { name: "会计", level: "初审", permissions: "凭证审核、数据校验", person: "符会计" },
  ]);
  const [showAddPos, setShowAddPos] = useState(false);
  const [newPosName, setNewPosName] = useState("");
  const [newPosLevel, setNewPosLevel] = useState("初审");
  const [newPosPerson, setNewPosPerson] = useState("");

  const handleAddPosition = () => {
    if (!newPosName || !newPosPerson) { toast.error("请填写岗位名称和人员"); return; }
    setPositions([...positions, { name: newPosName, level: newPosLevel, permissions: "待配置", person: newPosPerson }]);
    setShowAddPos(false);
    setNewPosName(""); setNewPosPerson("");
    toast.success("岗位添加成功", { description: `${newPosName} - ${newPosPerson}` });
  };

  return (
    <div className="space-y-4">
      <div className="flex items-center text-muted-foreground text-[13px]">
        <span>在线审批</span><ChevronRight className="w-4 h-4 mx-1" /><span className="text-foreground">审批配置</span>
      </div>
      <h2>审批配置</h2>
      <div className="bg-white rounded-xl border border-border shadow-sm">
        <div className="flex border-b border-border">
          {tabs.map(t => (
            <button key={t.key} className={`px-5 py-3 border-b-2 transition-colors ${tab === t.key ? "border-primary text-primary" : "border-transparent text-muted-foreground"}`} onClick={() => setTab(t.key)}>{t.label}</button>
          ))}
        </div>

        {tab === "positions" && (
          <div className="p-5">
            <div className="flex justify-end mb-4">
              <button onClick={() => setShowAddPos(true)} className="flex items-center gap-1.5 px-4 py-2 bg-primary text-white rounded-lg hover:bg-primary/90"><Plus className="w-4 h-4" /> 新增岗位</button>
            </div>
            <div className="overflow-x-auto border border-border rounded-lg">
              <table className="w-full text-[13px]">
                <thead className="bg-muted/60">
                  <tr>
                    <th className="py-3 px-4 text-left text-muted-foreground" style={{ fontWeight: 500 }}>岗位名称</th>
                    <th className="py-3 px-4 text-left text-muted-foreground" style={{ fontWeight: 500 }}>审批层级</th>
                    <th className="py-3 px-4 text-left text-muted-foreground" style={{ fontWeight: 500 }}>审批权限</th>
                    <th className="py-3 px-4 text-left text-muted-foreground" style={{ fontWeight: 500 }}>当前人员</th>
                    <th className="py-3 px-4 text-center text-muted-foreground" style={{ fontWeight: 500 }}>操作</th>
                  </tr>
                </thead>
                <tbody>
                  {positions.map(p => (
                    <tr key={p.name} className="border-t border-border/50 hover:bg-green-50/30">
                      <td className="py-3 px-4" style={{ fontWeight: 500 }}>{p.name}</td>
                      <td className="py-3 px-4"><span className="px-2 py-0.5 bg-green-50 text-green-600 rounded text-[12px]">{p.level}</span></td>
                      <td className="py-3 px-4 text-muted-foreground">{p.permissions}</td>
                      <td className="py-3 px-4">{p.person}</td>
                      <td className="py-3 px-4 text-center">
                        <button onClick={() => toast.info("编辑岗位", { description: `正在编辑 ${p.name} 的配置` })} className="px-3 py-1 border border-border rounded text-[12px] hover:bg-muted">编辑</button>
                      </td>
                    </tr>
                  ))}
                </tbody>
              </table>
            </div>
          </div>
        )}

        {tab === "flow" && (
          <div className="p-5">
            <h3 className="mb-4">审批流程配置</h3>
            <div className="flex items-center gap-4 p-6 bg-muted/30 rounded-xl border border-border/50">
              {["会计初审", "村监委审核", "村主任审批", "村书记终审"].map((step, idx) => (
                <div key={step} className="flex items-center gap-4">
                  <div className="flex flex-col items-center">
                    <div className={`w-14 h-14 rounded-full flex items-center justify-center ${idx === 0 ? "bg-primary text-white" : "bg-white border-2 border-primary/30 text-primary"}`}><User className="w-6 h-6" /></div>
                    <span className="text-[13px] mt-2">{step}</span>
                    <span className="text-[11px] text-muted-foreground">第{idx + 1}级</span>
                  </div>
                  {idx < 3 && <ArrowRight className="w-6 h-6 text-primary/40 mt-[-20px]" />}
                </div>
              ))}
            </div>
            <p className="text-[13px] text-muted-foreground mt-4">* 金额超过5万元需经过村书记终审；金额5万元以下由村主任审批即可通过。</p>
            <button onClick={() => toast.info("流程配置", { description: "审批流程修改功能将在下一版本上线" })} className="mt-4 px-4 py-2 border border-border rounded-lg text-[13px] hover:bg-muted">修改流程</button>
          </div>
        )}

        {tab === "types" && (
          <TypesTab />
        )}
      </div>
      <Modal open={showAddPos} onClose={() => setShowAddPos(false)} title="新增审批岗位">
        <div className="space-y-4">
          <div><label className="block text-[13px] text-muted-foreground mb-1">岗位名称 *</label><input value={newPosName} onChange={e => setNewPosName(e.target.value)} className="bg-muted rounded-lg px-3 py-2 outline-none w-full" placeholder="如：纪检监察员" /></div>
          <div><label className="block text-[13px] text-muted-foreground mb-1">审批层级</label><select value={newPosLevel} onChange={e => setNewPosLevel(e.target.value)} className="bg-muted rounded-lg px-3 py-2 outline-none w-full"><option>初审</option><option>二级审批</option><option>监督审批</option><option>最终审批</option></select></div>
          <div><label className="block text-[13px] text-muted-foreground mb-1">负责人 *</label><input value={newPosPerson} onChange={e => setNewPosPerson(e.target.value)} className="bg-muted rounded-lg px-3 py-2 outline-none w-full" placeholder="请输入人员姓名" /></div>
          <div className="flex justify-end gap-3 pt-2">
            <button onClick={() => setShowAddPos(false)} className="px-4 py-2 border border-border rounded-lg hover:bg-muted">取消</button>
            <button onClick={handleAddPosition} className="px-4 py-2 bg-primary text-white rounded-lg hover:bg-primary/90">保存</button>
          </div>
        </div>
      </Modal>
    </div>
  );
}

// =============== APPROVAL HISTORY ===============

export function ApprovalHistory() {
  const historyData = getGlobalHistory();
  const [resultFilter, setResultFilter] = useState("全部结果");
  const [showDetail, setShowDetail] = useState<HistoryItem | null>(null);
  const [dateFilter, setDateFilter] = useState("");
  const [searchText, setSearchText] = useState("");
  const [currentPage, setCurrentPage] = useState(1);
  const pageSize = 5;

  const filtered = historyData.filter(d => {
    const matchResult = resultFilter === "全部结果" || d.result === (resultFilter === "通过" ? "通过" : "驳回");
    const matchDate = !dateFilter || d.date >= dateFilter;
    const matchSearch = !searchText || d.title.includes(searchText) || d.no.includes(searchText);
    return matchResult && matchDate && matchSearch;
  });
  const totalPages = Math.max(1, Math.ceil(filtered.length / pageSize));
  const paged = filtered.slice((currentPage - 1) * pageSize, currentPage * pageSize);

  return (
    <div className="space-y-4">
      <div className="flex items-center text-muted-foreground text-[13px]">
        <span>在线审批</span><ChevronRight className="w-4 h-4 mx-1" /><span className="text-foreground">历史审批</span>
      </div>
      <h2>历史审批</h2>
      <div className="bg-white rounded-xl border border-border shadow-sm p-5">
        <div className="flex flex-wrap gap-3 mb-4">
          <div className="relative">
            <Search className="w-4 h-4 absolute left-3 top-1/2 -translate-y-1/2 text-muted-foreground" />
            <input type="text" placeholder="搜索单号/事项..." value={searchText} onChange={e => { setSearchText(e.target.value); setCurrentPage(1); }} className="pl-9 pr-4 py-2 bg-muted rounded-lg w-[220px] outline-none" />
          </div>
          <input type="date" value={dateFilter} onChange={e => { setDateFilter(e.target.value); setCurrentPage(1); }} className="bg-muted rounded-lg px-3 py-2 outline-none" />
          <select className="bg-muted rounded-lg px-3 py-2 outline-none" value={resultFilter} onChange={e => { setResultFilter(e.target.value); setCurrentPage(1); }}><option>全部结果</option><option>通过</option><option>驳回</option></select>
          <button onClick={() => toast.success("导出成功", { description: `已导出 ${filtered.length} 条历史审批记录` })} className="flex items-center gap-1 px-3 py-2 border border-border rounded-lg hover:bg-muted text-[13px]"><Download className="w-4 h-4" /> 导出</button>
        </div>
        <div className="overflow-x-auto border border-border rounded-lg">
          <table className="w-full text-[13px]">
            <thead className="bg-muted/60">
              <tr>
                <th className="py-3 px-3 text-left text-muted-foreground" style={{ fontWeight: 500 }}>单号</th>
                <th className="py-3 px-3 text-left text-muted-foreground" style={{ fontWeight: 500 }}>事项</th>
                <th className="py-3 px-3 text-right text-muted-foreground" style={{ fontWeight: 500 }}>金额</th>
                <th className="py-3 px-3 text-left text-muted-foreground" style={{ fontWeight: 500 }}>申请人</th>
                <th className="py-3 px-3 text-left text-muted-foreground" style={{ fontWeight: 500 }}>审批路径</th>
                <th className="py-3 px-3 text-center text-muted-foreground" style={{ fontWeight: 500 }}>结果</th>
                <th className="py-3 px-3 text-left text-muted-foreground" style={{ fontWeight: 500 }}>审批日期</th>
                <th className="py-3 px-3 text-center text-muted-foreground" style={{ fontWeight: 500 }}>操作</th>
              </tr>
            </thead>
            <tbody>
              {paged.length === 0 ? (
                <tr><td colSpan={8} className="py-12 text-center text-muted-foreground">暂无匹配的历史记录</td></tr>
              ) : paged.map(row => (
                <tr key={row.no} className="border-t border-border/50 hover:bg-green-50/30">
                  <td className="py-2.5 px-3 text-primary">{row.no}</td>
                  <td className="py-2.5 px-3">{row.title}</td>
                  <td className="py-2.5 px-3 text-right" style={{ fontWeight: 500 }}>¥ {row.amount.toLocaleString()}</td>
                  <td className="py-2.5 px-3">{row.applicant}</td>
                  <td className="py-2.5 px-3 text-[12px] text-muted-foreground">{row.reviewer}</td>
                  <td className="py-2.5 px-3 text-center">
                    <span className={`px-2 py-0.5 rounded-full text-[12px] ${row.result === "通过" ? "bg-green-50 text-green-600" : "bg-red-50 text-red-500"}`}>{row.result}</span>
                  </td>
                  <td className="py-2.5 px-3 text-muted-foreground">{row.date}</td>
                  <td className="py-2.5 px-3 text-center"><button onClick={() => setShowDetail(row)} className="p-1 hover:bg-muted rounded"><Eye className="w-4 h-4 text-muted-foreground" /></button></td>
                </tr>
              ))}
            </tbody>
          </table>
        </div>
        <div className="flex items-center justify-between mt-4 text-[13px]">
          <span className="text-muted-foreground">共 {filtered.length} 条记录，第 {currentPage}/{totalPages} 页</span>
          <div className="flex items-center gap-1">
            <button disabled={currentPage <= 1} onClick={() => setCurrentPage(p => p - 1)} className="px-3 py-1.5 border border-border rounded hover:bg-muted disabled:opacity-40">上一页</button>
            {Array.from({ length: totalPages }, (_, i) => i + 1).slice(0, 5).map(p => (
              <button key={p} onClick={() => setCurrentPage(p)} className={`px-3 py-1.5 rounded ${currentPage === p ? "bg-primary text-white" : "border border-border hover:bg-muted"}`}>{p}</button>
            ))}
            <button disabled={currentPage >= totalPages} onClick={() => setCurrentPage(p => p + 1)} className="px-3 py-1.5 border border-border rounded hover:bg-muted disabled:opacity-40">下一页</button>
          </div>
        </div>
      </div>

      {/* History Detail Modal */}
      <Modal open={!!showDetail} onClose={() => setShowDetail(null)} title="审批详情" width="max-w-md">
        {showDetail && (
          <div className="space-y-3 text-[14px]">
            {[
              ["单号", showDetail.no],
              ["事项", showDetail.title],
              ["金额", `¥ ${showDetail.amount.toLocaleString()}`],
              ["申请人", showDetail.applicant],
              ["审批路径", showDetail.reviewer],
              ["审批结果", showDetail.result],
              ["审批日期", showDetail.date],
            ].map(([label, value]) => (
              <div key={label} className="flex"><span className="text-muted-foreground w-24 flex-shrink-0">{label}</span><span>{value}</span></div>
            ))}
            <div className="pt-3 border-t border-border">
              <span className={`px-3 py-1 rounded-full text-[13px] ${showDetail.result === "通过" ? "bg-green-50 text-green-600" : "bg-red-50 text-red-500"}`}>
                {showDetail.result === "通过" ? "✓ 审批通过" : "✗ 审批驳回"}
              </span>
            </div>
          </div>
        )}
      </Modal>
    </div>
  );
}