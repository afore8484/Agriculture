import { useState } from "react";
import { toast } from "sonner";
import { useNavigate } from "react-router";
import { Modal, ConfirmDialog } from "./ui/Modal";
import {
  Plus, Search, Download, Upload, Printer, Trash2, Edit, Eye, CheckCircle, XCircle, Filter,
  FileSpreadsheet, ChevronRight, RefreshCw, RotateCcw, Settings, BookOpen, ArrowRightLeft, FileText, BarChart3,
  CreditCard, Repeat, ClipboardList,
} from "lucide-react";

// =============== CASHIER MANAGEMENT ===============

const cashierTabs = [
  { key: "bank", label: "银行日记账" },
  { key: "cash", label: "现金日记账" },
  { key: "fund-report", label: "资金报表" },
  { key: "account", label: "账户管理" },
  { key: "template", label: "出纳模板" },
  { key: "transfer", label: "内部转账" },
  { key: "reconcile", label: "出纳对账" },
];

const initialBankJournal = [
  { id: 1, voucherNo: "银付-2026-0089", date: "2026-03-09", summary: "支付美丽乡村建设工程款", counterparty: "琼海宏达建设公司", debit: 56000, credit: 0, balance: 1685600, status: "已审核" },
  { id: 2, voucherNo: "银收-2026-0156", date: "2026-03-08", summary: "收到槟榔园承包费", counterparty: "符永昌", debit: 0, credit: 12000, balance: 1741600, status: "已审核" },
  { id: 3, voucherNo: "银付-2026-0088", date: "2026-03-08", summary: "缴纳水电费", counterparty: "海南电网琼海供电局", debit: 4500, credit: 0, balance: 1729600, status: "待审核" },
  { id: 4, voucherNo: "银收-2026-0155", date: "2026-03-07", summary: "收到省级乡村振兴补助款", counterparty: "博鳌镇财政所", debit: 0, credit: 80000, balance: 1734100, status: "已审核" },
  { id: 5, voucherNo: "银付-2026-0087", date: "2026-03-07", summary: "办公用品采购", counterparty: "琼海文华办公", debit: 3150, credit: 0, balance: 1654100, status: "已审核" },
  { id: 6, voucherNo: "银付-2026-0086", date: "2026-03-06", summary: "支付村道硬化修缮费", counterparty: "海南中路建设公司", debit: 38000, credit: 0, balance: 1657250, status: "待审核" },
  { id: 7, voucherNo: "银收-2026-0154", date: "2026-03-06", summary: "民宿经营收入分成", counterparty: "陈大文", debit: 0, credit: 5600, balance: 1695250, status: "已审核" },
  { id: 8, voucherNo: "银付-2026-0085", date: "2026-03-05", summary: "支付保洁人员工资", counterparty: "王秀兰等6人", debit: 18000, credit: 0, balance: 1689650, status: "已审核" },
];

export function CashierManagement() {
  const navigate = useNavigate();
  const [activeTab, setActiveTab] = useState("bank");
  const [data, setData] = useState(initialBankJournal);
  const [selectedRows, setSelectedRows] = useState<number[]>([]);
  const [showAdd, setShowAdd] = useState(false);
  const [showDelete, setShowDelete] = useState(false);
  const [deleteTarget, setDeleteTarget] = useState<number | null>(null);
  const [showDetail, setShowDetail] = useState<typeof initialBankJournal[0] | null>(null);
  const [showEdit, setShowEdit] = useState<typeof initialBankJournal[0] | null>(null);
  const [searchText, setSearchText] = useState("");
  const [statusFilter, setStatusFilter] = useState("全部状态");

  // Form state
  const [formSummary, setFormSummary] = useState("");
  const [formCounterparty, setFormCounterparty] = useState("");
  const [formDebit, setFormDebit] = useState("");
  const [formCredit, setFormCredit] = useState("");

  const filteredData = data.filter(row => {
    const matchSearch = !searchText || row.voucherNo.includes(searchText) || row.summary.includes(searchText);
    const matchStatus = statusFilter === "全部状态" || row.status === statusFilter;
    return matchSearch && matchStatus;
  });

  const toggleRow = (id: number) => setSelectedRows(prev => prev.includes(id) ? prev.filter(r => r !== id) : [...prev, id]);
  const toggleAll = () => setSelectedRows(selectedRows.length === filteredData.length ? [] : filteredData.map(r => r.id));

  const handleAdd = () => {
    if (!formSummary || !formCounterparty) { toast.error("请填写摘要和对方单位"); return; }
    const debit = parseFloat(formDebit) || 0;
    const credit = parseFloat(formCredit) || 0;
    if (debit === 0 && credit === 0) { toast.error("请填写借方或贷方金额"); return; }
    const newId = Math.max(...data.map(d => d.id)) + 1;
    const lastBalance = data[0]?.balance || 0;
    const newBalance = lastBalance - debit + credit;
    const prefix = debit > 0 ? "银付" : "银收";
    const no = `${prefix}-2026-${String(newId + 89).padStart(4, "0")}`;
    const newEntry = { id: newId, voucherNo: no, date: "2026-03-09", summary: formSummary, counterparty: formCounterparty, debit, credit, balance: newBalance, status: "待审核" };
    setData([newEntry, ...data]);
    setShowAdd(false);
    setFormSummary(""); setFormCounterparty(""); setFormDebit(""); setFormCredit("");
    toast.success("银行日记账记录已新增", { description: `${no} ${formSummary}` });
  };

  const handleDelete = () => {
    if (deleteTarget) {
      const item = data.find(d => d.id === deleteTarget);
      setData(data.filter(d => d.id !== deleteTarget));
      toast.success("已删除记录", { description: item?.voucherNo });
      setDeleteTarget(null);
    } else if (selectedRows.length > 0) {
      setData(data.filter(d => !selectedRows.includes(d.id)));
      toast.success(`已批量删除 ${selectedRows.length} 条记录`);
      setSelectedRows([]);
    }
  };

  const handleReview = (id: number) => {
    setData(data.map(d => d.id === id ? { ...d, status: "已审核" } : d));
    const item = data.find(d => d.id === id);
    toast.success("审核通过", { description: `${item?.voucherNo} 已审核` });
  };

  const handleExport = () => {
    toast.success("导出成功", { description: `已导出 ${filteredData.length} 条银行日记账记录为 Excel 文件` });
  };

  const handlePrint = () => {
    toast.info("打印预览", { description: "正在生成打印预览，请稍候..." });
    setTimeout(() => toast.success("打印预览已生成"), 1000);
  };

  const handleGenerateVoucher = () => {
    const unreviewed = data.filter(d => d.status === "待审核");
    if (unreviewed.length === 0) { toast.warning("无待审核记录需要生成凭证"); return; }
    toast.info("正在生成记账凭证...");
    setTimeout(() => {
      toast.success("凭证生成完成", { description: `已从 ${unreviewed.length} 条出纳记录生成对应记账凭证` });
      setTimeout(() => navigate("/finance/voucher"), 1500);
    }, 800);
  };

  return (
    <div className="space-y-4">
      <div className="flex items-center text-muted-foreground text-[13px]">
        <span>财务中心</span><ChevronRight className="w-4 h-4 mx-1" /><span className="text-foreground">出纳管理</span>
      </div>
      <h2>出纳管理</h2>

      <div className="bg-white rounded-xl border border-border shadow-sm">
        <div className="flex border-b border-border overflow-x-auto">
          {cashierTabs.map(tab => (
            <button key={tab.key} className={`px-5 py-3 whitespace-nowrap transition-colors border-b-2 ${activeTab === tab.key ? "border-primary text-primary" : "border-transparent text-muted-foreground hover:text-foreground"}`} onClick={() => setActiveTab(tab.key)}>{tab.label}</button>
          ))}
        </div>
        <div className="p-5">
          {activeTab === "bank" && (<>
          <div className="flex flex-wrap items-center gap-3 mb-4">
            <div className="relative">
              <Search className="w-4 h-4 absolute left-3 top-1/2 -translate-y-1/2 text-muted-foreground" />
              <input type="text" placeholder="搜索凭证号/摘要..." value={searchText} onChange={e => setSearchText(e.target.value)} className="pl-9 pr-4 py-2 bg-muted rounded-lg w-[220px] outline-none focus:ring-2 focus:ring-primary/30" />
            </div>
            <div className="flex items-center gap-2">
              <label className="text-muted-foreground text-[13px]">日期：</label>
              <input type="date" defaultValue="2026-03-01" className="bg-muted rounded-lg px-3 py-2 outline-none" />
              <span className="text-muted-foreground">至</span>
              <input type="date" defaultValue="2026-03-09" className="bg-muted rounded-lg px-3 py-2 outline-none" />
            </div>
            <select className="bg-muted rounded-lg px-3 py-2 outline-none" value={statusFilter} onChange={e => setStatusFilter(e.target.value)}>
              <option>全部状态</option><option>已审核</option><option>待审核</option>
            </select>
          </div>

          <div className="flex flex-wrap items-center gap-2 mb-4">
            <button onClick={() => setShowAdd(true)} className="flex items-center gap-1.5 px-4 py-2 bg-primary text-white rounded-lg hover:bg-primary/90"><Plus className="w-4 h-4" /> 新增</button>
            <button onClick={() => toast.info("请选择 Excel 文件上传", { description: "支持 .xlsx、.xls 格式" })} className="flex items-center gap-1.5 px-4 py-2 border border-border rounded-lg hover:bg-muted"><Upload className="w-4 h-4" /> 导入</button>
            <button onClick={handleExport} className="flex items-center gap-1.5 px-4 py-2 border border-border rounded-lg hover:bg-muted"><Download className="w-4 h-4" /> 导出</button>
            <button onClick={() => { toast.success("模板下载成功", { description: "银行日记账导入模板.xlsx" }); }} className="flex items-center gap-1.5 px-4 py-2 border border-border rounded-lg hover:bg-muted"><FileSpreadsheet className="w-4 h-4" /> 导入模板</button>
            <button onClick={handlePrint} className="flex items-center gap-1.5 px-4 py-2 border border-border rounded-lg hover:bg-muted"><Printer className="w-4 h-4" /> 打印</button>
            <button onClick={handleGenerateVoucher} className="flex items-center gap-1.5 px-4 py-2 border border-border rounded-lg hover:bg-muted text-green-600"><RefreshCw className="w-4 h-4" /> 生成凭证</button>
            {selectedRows.length > 0 && (
              <button onClick={() => setShowDelete(true)} className="flex items-center gap-1.5 px-4 py-2 border border-destructive text-destructive rounded-lg hover:bg-red-50"><Trash2 className="w-4 h-4" /> 删除 ({selectedRows.length})</button>
            )}
          </div>

          <div className="overflow-x-auto border border-border rounded-lg">
            <table className="w-full text-[13px]">
              <thead className="bg-muted/60">
                <tr>
                  <th className="py-3 px-3 text-left w-10"><input type="checkbox" checked={selectedRows.length === filteredData.length && filteredData.length > 0} onChange={toggleAll} className="rounded" /></th>
                  <th className="py-3 px-3 text-left text-muted-foreground" style={{ fontWeight: 500 }}>凭证号</th>
                  <th className="py-3 px-3 text-left text-muted-foreground" style={{ fontWeight: 500 }}>日期</th>
                  <th className="py-3 px-3 text-left text-muted-foreground" style={{ fontWeight: 500 }}>摘要</th>
                  <th className="py-3 px-3 text-left text-muted-foreground" style={{ fontWeight: 500 }}>对方单位</th>
                  <th className="py-3 px-3 text-right text-muted-foreground" style={{ fontWeight: 500 }}>借方金额</th>
                  <th className="py-3 px-3 text-right text-muted-foreground" style={{ fontWeight: 500 }}>贷方金额</th>
                  <th className="py-3 px-3 text-right text-muted-foreground" style={{ fontWeight: 500 }}>余额</th>
                  <th className="py-3 px-3 text-center text-muted-foreground" style={{ fontWeight: 500 }}>状态</th>
                  <th className="py-3 px-3 text-center text-muted-foreground" style={{ fontWeight: 500 }}>操作</th>
                </tr>
              </thead>
              <tbody>
                {filteredData.length === 0 ? (
                  <tr><td colSpan={10} className="py-12 text-center text-muted-foreground">暂无数据，请调整筛选条件或新增记录</td></tr>
                ) : filteredData.map(row => (
                  <tr key={row.id} className="border-t border-border/50 hover:bg-green-50/30">
                    <td className="py-2.5 px-3"><input type="checkbox" checked={selectedRows.includes(row.id)} onChange={() => toggleRow(row.id)} className="rounded" /></td>
                    <td className="py-2.5 px-3 text-primary cursor-pointer hover:underline" onClick={() => setShowDetail(row)}>{row.voucherNo}</td>
                    <td className="py-2.5 px-3 text-muted-foreground">{row.date}</td>
                    <td className="py-2.5 px-3">{row.summary}</td>
                    <td className="py-2.5 px-3">{row.counterparty}</td>
                    <td className="py-2.5 px-3 text-right text-red-500">{row.debit > 0 ? `¥ ${row.debit.toLocaleString()}` : "-"}</td>
                    <td className="py-2.5 px-3 text-right text-green-600">{row.credit > 0 ? `¥ ${row.credit.toLocaleString()}` : "-"}</td>
                    <td className="py-2.5 px-3 text-right" style={{ fontWeight: 500 }}>¥ {row.balance.toLocaleString()}</td>
                    <td className="py-2.5 px-3 text-center">
                      <span className={`px-2 py-0.5 rounded-full text-[12px] ${row.status === "已审核" ? "bg-green-50 text-green-600" : "bg-amber-50 text-amber-600"}`}>{row.status}</span>
                    </td>
                    <td className="py-2.5 px-3">
                      <div className="flex items-center justify-center gap-1">
                        <button className="p-1 hover:bg-muted rounded" title="查看" onClick={() => setShowDetail(row)}><Eye className="w-4 h-4 text-muted-foreground" /></button>
                        <button className="p-1 hover:bg-muted rounded" title="编辑" onClick={() => setShowEdit({ ...row })}><Edit className="w-4 h-4 text-muted-foreground" /></button>
                        {row.status === "待审核" && (
                          <button className="p-1 hover:bg-muted rounded" title="审核" onClick={() => handleReview(row.id)}><CheckCircle className="w-4 h-4 text-green-500" /></button>
                        )}
                        <button className="p-1 hover:bg-muted rounded" title="删除" onClick={() => { setDeleteTarget(row.id); setShowDelete(true); }}><Trash2 className="w-4 h-4 text-red-400" /></button>
                      </div>
                    </td>
                  </tr>
                ))}
              </tbody>
            </table>
          </div>
          <div className="flex items-center justify-between mt-4 text-[13px]">
            <span className="text-muted-foreground">共 {filteredData.length} 条记录</span>
            <div className="flex items-center gap-1">
              <button className="px-3 py-1.5 border border-border rounded hover:bg-muted">上一页</button>
              <button className="px-3 py-1.5 bg-primary text-white rounded">1</button>
              <button className="px-3 py-1.5 border border-border rounded hover:bg-muted">下一页</button>
            </div>
          </div>
          </>)}

          {activeTab === "cash" && (
            <div>
              <div className="flex flex-wrap gap-2 mb-4"><button onClick={() => toast.info("新增现金日记账")} className="flex items-center gap-1.5 px-4 py-2 bg-primary text-white rounded-lg hover:bg-primary/90"><Plus className="w-4 h-4" /> 新增</button><button onClick={() => toast.success("导出成功")} className="flex items-center gap-1.5 px-4 py-2 border border-border rounded-lg hover:bg-muted"><Download className="w-4 h-4" /> 导出</button></div>
              <div className="overflow-x-auto border border-border rounded-lg"><table className="w-full text-[13px]"><thead className="bg-muted/60"><tr><th className="py-3 px-3 text-left text-muted-foreground" style={{ fontWeight: 500 }}>凭证号</th><th className="py-3 px-3 text-left text-muted-foreground" style={{ fontWeight: 500 }}>日期</th><th className="py-3 px-3 text-left text-muted-foreground" style={{ fontWeight: 500 }}>摘要</th><th className="py-3 px-3 text-right text-muted-foreground" style={{ fontWeight: 500 }}>收入</th><th className="py-3 px-3 text-right text-muted-foreground" style={{ fontWeight: 500 }}>支出</th><th className="py-3 px-3 text-right text-muted-foreground" style={{ fontWeight: 500 }}>余额</th></tr></thead>
              <tbody>{[{ no: "现收-0012", date: "2026-03-08", s: "村民活动中心场地租赁收入", i: 800, e: 0, b: 13300 },{ no: "现付-0023", date: "2026-03-07", s: "购买清洁用品", i: 0, e: 260, b: 12500 },{ no: "现收-0011", date: "2026-03-06", s: "村委小卖部零售收入", i: 1200, e: 0, b: 12760 },{ no: "现付-0022", date: "2026-03-05", s: "办公室饮用水", i: 0, e: 120, b: 11560 }].map((r,idx) => (<tr key={`cash-${idx}`} className="border-t border-border/50 hover:bg-green-50/30"><td className="py-2.5 px-3 text-primary">{r.no}</td><td className="py-2.5 px-3 text-muted-foreground">{r.date}</td><td className="py-2.5 px-3">{r.s}</td><td className="py-2.5 px-3 text-right text-green-600">{r.i > 0 ? `¥ ${r.i.toLocaleString()}` : "-"}</td><td className="py-2.5 px-3 text-right text-red-500">{r.e > 0 ? `¥ ${r.e.toLocaleString()}` : "-"}</td><td className="py-2.5 px-3 text-right" style={{ fontWeight: 500 }}>¥ {r.b.toLocaleString()}</td></tr>))}</tbody></table></div>
            </div>
          )}

          {activeTab === "fund-report" && (
            <div>
              <div className="grid grid-cols-1 md:grid-cols-3 gap-4 mb-4">
                {[{ l: "银行存款", v: "¥ 1,685,600", co: "#0d9448" },{ l: "库存现金", v: "¥ 13,300", co: "#0ea5e9" },{ l: "资金合计", v: "¥ 1,698,900", co: "#f59e0b" }].map(c => (<div key={c.l} className="bg-muted/30 rounded-lg p-4 border border-border/50"><p className="text-[12px] text-muted-foreground">{c.l}</p><p className="text-[22px] mt-1" style={{ fontWeight: 600, color: c.co }}>{c.v}</p></div>))}
              </div>
              <div className="overflow-x-auto border border-border rounded-lg"><table className="w-full text-[13px]"><thead className="bg-muted/60"><tr><th className="py-3 px-3 text-left text-muted-foreground" style={{ fontWeight: 500 }}>账户</th><th className="py-3 px-3 text-right text-muted-foreground" style={{ fontWeight: 500 }}>期初余额</th><th className="py-3 px-3 text-right text-muted-foreground" style={{ fontWeight: 500 }}>本期收入</th><th className="py-3 px-3 text-right text-muted-foreground" style={{ fontWeight: 500 }}>本期支出</th><th className="py-3 px-3 text-right text-muted-foreground" style={{ fontWeight: 500 }}>期末余额</th></tr></thead>
              <tbody>{[{ n: "海南农商银行（基本户）", b: 1687650, i: 97600, e: 99650, en: 1685600 },{ n: "库存现金", b: 11680, i: 2000, e: 380, en: 13300 }].map(r => (<tr key={r.n} className="border-t border-border/50 hover:bg-green-50/30"><td className="py-2.5 px-3">{r.n}</td><td className="py-2.5 px-3 text-right">¥ {r.b.toLocaleString()}</td><td className="py-2.5 px-3 text-right text-green-600">¥ {r.i.toLocaleString()}</td><td className="py-2.5 px-3 text-right text-red-500">¥ {r.e.toLocaleString()}</td><td className="py-2.5 px-3 text-right" style={{ fontWeight: 500 }}>¥ {r.en.toLocaleString()}</td></tr>))}</tbody></table></div>
            </div>
          )}

          {activeTab === "account" && (
            <div>
              <div className="flex gap-2 mb-4"><button onClick={() => toast.info("新增账户")} className="flex items-center gap-1.5 px-4 py-2 bg-primary text-white rounded-lg hover:bg-primary/90"><Plus className="w-4 h-4" /> 新增账户</button></div>
              <div className="overflow-x-auto border border-border rounded-lg"><table className="w-full text-[13px]"><thead className="bg-muted/60"><tr><th className="py-3 px-3 text-left text-muted-foreground" style={{ fontWeight: 500 }}>账户名称</th><th className="py-3 px-3 text-left text-muted-foreground" style={{ fontWeight: 500 }}>账号</th><th className="py-3 px-3 text-left text-muted-foreground" style={{ fontWeight: 500 }}>开户行</th><th className="py-3 px-3 text-right text-muted-foreground" style={{ fontWeight: 500 }}>余额</th><th className="py-3 px-3 text-center text-muted-foreground" style={{ fontWeight: 500 }}>状态</th></tr></thead>
              <tbody>{[{ n: "椰林村基本账户", no: "6228****1234", bk: "海南农商银行琼海支行", bal: 1685600 },{ n: "椰林村专用账户", no: "6225****5678", bk: "中国农业银行琼海支行", bal: 356000 },{ n: "库存现金", no: "-", bk: "-", bal: 13300 }].map(r => (<tr key={r.n} className="border-t border-border/50 hover:bg-green-50/30"><td className="py-2.5 px-3" style={{ fontWeight: 500 }}>{r.n}</td><td className="py-2.5 px-3 text-muted-foreground">{r.no}</td><td className="py-2.5 px-3 text-muted-foreground">{r.bk}</td><td className="py-2.5 px-3 text-right" style={{ fontWeight: 500 }}>¥ {r.bal.toLocaleString()}</td><td className="py-2.5 px-3 text-center"><span className="px-2 py-0.5 bg-green-50 text-green-600 rounded-full text-[12px]">正常</span></td></tr>))}</tbody></table></div>
            </div>
          )}

          {activeTab === "template" && (
            <div>
              <div className="flex gap-2 mb-4"><button onClick={() => toast.info("新增模板")} className="flex items-center gap-1.5 px-4 py-2 bg-primary text-white rounded-lg hover:bg-primary/90"><Plus className="w-4 h-4" /> 新增模板</button></div>
              <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-4">{[{ n: "工资发放", d: "每月固定工资支出模板", s: "管理费用/银行存款" },{ n: "水电费", d: "公共设施水电费支出", s: "管理费用/银行存款" },{ n: "承包费收入", d: "土地承包收入入账", s: "银行存款/经营收入" },{ n: "补助款收入", d: "上级补助资金入账", s: "银行存款/补助收入" },{ n: "工程款支付", d: "建设工程进度款支付", s: "在建工程/银行存款" }].map(t => (<div key={t.n} className="border border-border rounded-lg p-4 hover:shadow-md transition-shadow"><h4>{t.n}</h4><p className="text-[12px] text-muted-foreground mt-1">{t.d}</p><p className="text-[12px] text-primary mt-2">{t.s}</p><button onClick={() => toast.success("已应用模板", { description: t.n })} className="mt-3 px-3 py-1.5 bg-primary text-white rounded-lg text-[12px] hover:bg-primary/90">使用模板</button></div>))}</div>
            </div>
          )}

          {activeTab === "transfer" && (
            <div>
              <div className="flex gap-2 mb-4"><button onClick={() => toast.info("新增内部转账")} className="flex items-center gap-1.5 px-4 py-2 bg-primary text-white rounded-lg hover:bg-primary/90"><Plus className="w-4 h-4" /> 新增内部转账</button></div>
              <div className="overflow-x-auto border border-border rounded-lg"><table className="w-full text-[13px]"><thead className="bg-muted/60"><tr><th className="py-3 px-3 text-left text-muted-foreground" style={{ fontWeight: 500 }}>日期</th><th className="py-3 px-3 text-left text-muted-foreground" style={{ fontWeight: 500 }}>转出账户</th><th className="py-3 px-3 text-left text-muted-foreground" style={{ fontWeight: 500 }}>转入账户</th><th className="py-3 px-3 text-right text-muted-foreground" style={{ fontWeight: 500 }}>金额</th><th className="py-3 px-3 text-left text-muted-foreground" style={{ fontWeight: 500 }}>摘要</th><th className="py-3 px-3 text-center text-muted-foreground" style={{ fontWeight: 500 }}>状态</th></tr></thead>
              <tbody>{[{ d: "2026-03-05", f: "银行存款", t: "库存现金", a: 5000, s: "提取备用金" },{ d: "2026-02-28", f: "银行存款", t: "库存现金", a: 3000, s: "提取零星费用备用金" }].map((r,i) => (<tr key={`tf${i}`} className="border-t border-border/50 hover:bg-green-50/30"><td className="py-2.5 px-3 text-muted-foreground">{r.d}</td><td className="py-2.5 px-3">{r.f}</td><td className="py-2.5 px-3">{r.t}</td><td className="py-2.5 px-3 text-right" style={{ fontWeight: 500 }}>¥ {r.a.toLocaleString()}</td><td className="py-2.5 px-3">{r.s}</td><td className="py-2.5 px-3 text-center"><span className="px-2 py-0.5 bg-green-50 text-green-600 rounded-full text-[12px]">已完成</span></td></tr>))}</tbody></table></div>
            </div>
          )}

          {activeTab === "reconcile" && (
            <div>
              <div className="grid grid-cols-1 md:grid-cols-3 gap-4 mb-4">
                {[{ l: "银行对账单余额", v: "¥ 1,685,600", co: "#0d9448" },{ l: "出纳账面余额", v: "¥ 1,685,600", co: "#0ea5e9" },{ l: "未达账项", v: "0 笔", co: "#10b981" }].map(c => (<div key={c.l} className="bg-muted/30 rounded-lg p-4 border border-border/50"><p className="text-[12px] text-muted-foreground">{c.l}</p><p className="text-[22px] mt-1" style={{ fontWeight: 600, color: c.co }}>{c.v}</p></div>))}
              </div>
              <div className="bg-green-50 border border-green-200 rounded-lg p-4 flex items-center gap-3"><CheckCircle className="w-6 h-6 text-green-600" /><div><p className="text-green-700" style={{ fontWeight: 500 }}>对账结果：银行余额与账面余额一致</p><p className="text-[13px] text-green-600 mt-1">最近对账时间：2026-03-09 14:30 | 操作人：符会计</p></div></div>
              <div className="mt-4 flex gap-2"><button onClick={() => { toast.info("正在执行对账..."); setTimeout(() => toast.success("对账完成", { description: "银行余额与账面余额一致，无未达账项" }), 1200); }} className="flex items-center gap-1.5 px-4 py-2 bg-primary text-white rounded-lg hover:bg-primary/90"><RefreshCw className="w-4 h-4" /> 开始对账</button><button onClick={() => toast.success("导出成功")} className="flex items-center gap-1.5 px-4 py-2 border border-border rounded-lg hover:bg-muted"><Download className="w-4 h-4" /> 导出对账单</button></div>
            </div>
          )}

        </div>
      </div>

      {/* Add Modal */}
      <Modal open={showAdd} onClose={() => setShowAdd(false)} title="新增银行日记账">
        <div className="space-y-4">
          <div><label className="block text-[13px] text-muted-foreground mb-1">摘要 *</label><input type="text" value={formSummary} onChange={e => setFormSummary(e.target.value)} placeholder="请输入业务摘要" className="bg-muted rounded-lg px-3 py-2 outline-none w-full focus:ring-2 focus:ring-primary/30" /></div>
          <div><label className="block text-[13px] text-muted-foreground mb-1">对方单位 *</label><input type="text" value={formCounterparty} onChange={e => setFormCounterparty(e.target.value)} placeholder="请输入对方单位" className="bg-muted rounded-lg px-3 py-2 outline-none w-full focus:ring-2 focus:ring-primary/30" /></div>
          <div className="grid grid-cols-2 gap-4">
            <div><label className="block text-[13px] text-muted-foreground mb-1">借方金额（支出）</label><input type="number" value={formDebit} onChange={e => setFormDebit(e.target.value)} placeholder="0.00" className="bg-muted rounded-lg px-3 py-2 outline-none w-full text-right" /></div>
            <div><label className="block text-[13px] text-muted-foreground mb-1">贷方金额（收入）</label><input type="number" value={formCredit} onChange={e => setFormCredit(e.target.value)} placeholder="0.00" className="bg-muted rounded-lg px-3 py-2 outline-none w-full text-right" /></div>
          </div>
          <div className="flex justify-end gap-3 pt-2">
            <button onClick={() => setShowAdd(false)} className="px-4 py-2 border border-border rounded-lg hover:bg-muted">取消</button>
            <button onClick={handleAdd} className="px-4 py-2 bg-primary text-white rounded-lg hover:bg-primary/90">保存</button>
          </div>
        </div>
      </Modal>

      {/* Delete Confirm */}
      <ConfirmDialog open={showDelete} onClose={() => { setShowDelete(false); setDeleteTarget(null); }} onConfirm={handleDelete} title="确认删除" message={deleteTarget ? `确定要删除该条记录吗？此操作不可撤销。` : `确定要删除选中的 ${selectedRows.length} 条记录吗？`} confirmText="删除" type="danger" />

      {/* Detail Modal */}
      <Modal open={!!showDetail} onClose={() => setShowDetail(null)} title="记录详情">
        {showDetail && (
          <div className="space-y-3 text-[14px]">
            {[
              ["凭证号", showDetail.voucherNo],
              ["日期", showDetail.date],
              ["摘要", showDetail.summary],
              ["对方单位", showDetail.counterparty],
              ["借方金额", showDetail.debit > 0 ? `¥ ${showDetail.debit.toLocaleString()}` : "-"],
              ["贷方金额", showDetail.credit > 0 ? `¥ ${showDetail.credit.toLocaleString()}` : "-"],
              ["余额", `¥ ${showDetail.balance.toLocaleString()}`],
              ["状态", showDetail.status],
            ].map(([label, value]) => (
              <div key={label} className="flex"><span className="text-muted-foreground w-24 flex-shrink-0">{label}</span><span>{value}</span></div>
            ))}
          </div>
        )}
      </Modal>

      {/* Edit Modal */}
      <Modal open={!!showEdit} onClose={() => setShowEdit(null)} title="编辑记录">
        {showEdit && (
          <div className="space-y-4">
            <div><label className="block text-[13px] text-muted-foreground mb-1">摘要</label><input type="text" value={showEdit.summary} onChange={e => setShowEdit({ ...showEdit, summary: e.target.value })} className="bg-muted rounded-lg px-3 py-2 outline-none w-full" /></div>
            <div><label className="block text-[13px] text-muted-foreground mb-1">对方单位</label><input type="text" value={showEdit.counterparty} onChange={e => setShowEdit({ ...showEdit, counterparty: e.target.value })} className="bg-muted rounded-lg px-3 py-2 outline-none w-full" /></div>
            <div className="grid grid-cols-2 gap-4">
              <div><label className="block text-[13px] text-muted-foreground mb-1">借方金额</label><input type="number" value={showEdit.debit} onChange={e => setShowEdit({ ...showEdit, debit: parseFloat(e.target.value) || 0 })} className="bg-muted rounded-lg px-3 py-2 outline-none w-full text-right" /></div>
              <div><label className="block text-[13px] text-muted-foreground mb-1">贷方金额</label><input type="number" value={showEdit.credit} onChange={e => setShowEdit({ ...showEdit, credit: parseFloat(e.target.value) || 0 })} className="bg-muted rounded-lg px-3 py-2 outline-none w-full text-right" /></div>
            </div>
            <div className="flex justify-end gap-3 pt-2">
              <button onClick={() => setShowEdit(null)} className="px-4 py-2 border border-border rounded-lg hover:bg-muted">取消</button>
              <button onClick={() => { setData(data.map(d => d.id === showEdit.id ? { ...showEdit } : d)); toast.success("记录已更新", { description: showEdit.voucherNo }); setShowEdit(null); }} className="px-4 py-2 bg-primary text-white rounded-lg hover:bg-primary/90">保存</button>
            </div>
          </div>
        )}
      </Modal>
    </div>
  );
}

// =============== VOUCHER MANAGEMENT ===============

const initialVouchers = [
  { id: 1, no: "记-2026-0301", date: "2026-03-09", summary: "收到省级乡村振兴补助款", subject: "银行存款/补助收入", debit: 80000, credit: 80000, maker: "符会计", status: "已审核", attachments: 2 },
  { id: 2, no: "记-2026-0300", date: "2026-03-08", summary: "支付村道硬化修缮费", subject: "在建工程/银行存款", debit: 38000, credit: 38000, maker: "符会计", status: "待审核", attachments: 3 },
  { id: 3, no: "记-2026-0299", date: "2026-03-08", summary: "槟榔园承包收入", subject: "银行存款/经营收入", debit: 12000, credit: 12000, maker: "王出纳", status: "已审核", attachments: 1 },
  { id: 4, no: "记-2026-0298", date: "2026-03-07", summary: "村委会办公用品采购", subject: "管理费用/银行存款", debit: 3150, credit: 3150, maker: "符会计", status: "已审核", attachments: 2 },
  { id: 5, no: "记-2026-0297", date: "2026-03-07", summary: "文化广场水电费", subject: "管理费用/银行存款", debit: 2200, credit: 2200, maker: "王出纳", status: "待审核", attachments: 1 },
  { id: 6, no: "记-2026-0296", date: "2026-03-06", summary: "民宿经营收入分成", subject: "银行存款/经营收入", debit: 5600, credit: 5600, maker: "符会计", status: "已审核", attachments: 1 },
];

export function VoucherManagement() {
  const [activeTab, setActiveTab] = useState("list");
  const [vouchers, setVouchers] = useState(initialVouchers);
  const [recycled, setRecycled] = useState<typeof initialVouchers>([]);
  const [showDelete, setShowDelete] = useState(false);
  const [deleteId, setDeleteId] = useState<number | null>(null);
  const [selectedIds, setSelectedIds] = useState<number[]>([]);
  const [showDetail, setShowDetail] = useState<typeof initialVouchers[0] | null>(null);
  const [showEdit, setShowEdit] = useState<typeof initialVouchers[0] | null>(null);

  // Entry form state
  const [entrySummary, setEntrySummary] = useState("");
  const [entrySubjectDebit, setEntrySubjectDebit] = useState("1002 银行存款");
  const [entrySubjectCredit, setEntrySubjectCredit] = useState("5001 经营收入");
  const [entryDebit, setEntryDebit] = useState("");
  const [entryCredit, setEntryCredit] = useState("");

  const tabs = [
    { key: "list", label: `凭证列表 (${vouchers.length})` },
    { key: "entry", label: "凭证录入" },
    { key: "recycle", label: `凭证回收站 (${recycled.length})` },
  ];

  const handleSaveVoucher = () => {
    if (!entrySummary) { toast.error("请填写摘要"); return; }
    const amount = parseFloat(entryDebit) || parseFloat(entryCredit) || 0;
    if (amount <= 0) { toast.error("请填写金额"); return; }
    const newId = Math.max(...vouchers.map(v => v.id), 0) + 1;
    const newNo = `记-2026-${String(302 + newId).padStart(4, "0")}`;
    const newVoucher = { id: newId + 100, no: newNo, date: "2026-03-09", summary: entrySummary, subject: `${entrySubjectDebit}/${entrySubjectCredit}`, debit: amount, credit: amount, maker: "符会计", status: "待审核" as const, attachments: 0 };
    setVouchers([newVoucher, ...vouchers]);
    setEntrySummary(""); setEntryDebit(""); setEntryCredit("");
    toast.success("凭证保存成功", { description: `${newNo} ${entrySummary}` });
    setActiveTab("list");
  };

  const handleSaveAndNew = () => {
    if (!entrySummary) { toast.error("请填写摘要"); return; }
    const amount = parseFloat(entryDebit) || parseFloat(entryCredit) || 0;
    if (amount <= 0) { toast.error("请填写金额"); return; }
    const newId = Math.max(...vouchers.map(v => v.id), 0) + 1;
    const newNo = `记-2026-${String(302 + newId).padStart(4, "0")}`;
    const newVoucher = { id: newId + 100, no: newNo, date: "2026-03-09", summary: entrySummary, subject: `${entrySubjectDebit}/${entrySubjectCredit}`, debit: amount, credit: amount, maker: "符会计", status: "待审核" as const, attachments: 0 };
    setVouchers([newVoucher, ...vouchers]);
    setEntrySummary(""); setEntryDebit(""); setEntryCredit("");
    toast.success("凭证已保存，请继续录入下一张", { description: newNo });
  };

  const handleDeleteVoucher = () => {
    if (deleteId) {
      const item = vouchers.find(v => v.id === deleteId);
      if (item) { setRecycled([item, ...recycled]); setVouchers(vouchers.filter(v => v.id !== deleteId)); toast.success("已移入回收站", { description: item.no }); }
    }
    setDeleteId(null);
  };

  const handleRestore = (id: number) => {
    const item = recycled.find(v => v.id === id);
    if (item) { setVouchers([item, ...vouchers]); setRecycled(recycled.filter(v => v.id !== id)); toast.success("已还原凭证", { description: item.no }); }
  };

  const handlePermanentDelete = (id: number) => {
    const item = recycled.find(v => v.id === id);
    setRecycled(recycled.filter(v => v.id !== id));
    toast.success("已彻底删除", { description: item?.no });
  };

  const handleBatchReview = () => {
    const pending = vouchers.filter(v => v.status === "待审核");
    if (pending.length === 0) { toast.warning("没有待审核的凭证"); return; }
    setVouchers(vouchers.map(v => v.status === "待审核" ? { ...v, status: "已审核" } : v));
    toast.success(`批量审核完成`, { description: `${pending.length} 张凭证已审核通过` });
  };

  const handleUnreview = () => {
    if (selectedIds.length === 0) { toast.warning("请先选择需要反审核的凭证"); return; }
    const count = selectedIds.length;
    setVouchers(vouchers.map(v => selectedIds.includes(v.id) ? { ...v, status: "待审核" } : v));
    setSelectedIds([]);
    toast.success(`反审核完成`, { description: `${count} 张凭证已恢复为待审核状态` });
  };

  return (
    <div className="space-y-4">
      <div className="flex items-center text-muted-foreground text-[13px]">
        <span>财务中心</span><ChevronRight className="w-4 h-4 mx-1" /><span className="text-foreground">凭证管理</span>
      </div>
      <h2>凭证管理</h2>
      <div className="bg-white rounded-xl border border-border shadow-sm">
        <div className="flex border-b border-border">
          {tabs.map(tab => (
            <button key={tab.key} className={`px-5 py-3 border-b-2 transition-colors ${activeTab === tab.key ? "border-primary text-primary" : "border-transparent text-muted-foreground hover:text-foreground"}`} onClick={() => setActiveTab(tab.key)}>{tab.label}</button>
          ))}
        </div>

        {activeTab === "list" && (
          <div className="p-5">
            <div className="flex flex-wrap gap-2 mb-4">
              <button onClick={() => setActiveTab("entry")} className="flex items-center gap-1.5 px-4 py-2 bg-primary text-white rounded-lg hover:bg-primary/90"><Plus className="w-4 h-4" /> 新增凭证</button>
              <button onClick={handleBatchReview} className="flex items-center gap-1.5 px-4 py-2 border border-border rounded-lg hover:bg-muted"><CheckCircle className="w-4 h-4 text-green-500" /> 批量审核</button>
              <button onClick={handleUnreview} className="flex items-center gap-1.5 px-4 py-2 border border-border rounded-lg hover:bg-muted"><RotateCcw className="w-4 h-4" /> 反审核</button>
              <button onClick={() => toast.success("导出成功", { description: `已导出 ${vouchers.length} 条凭证数据` })} className="flex items-center gap-1.5 px-4 py-2 border border-border rounded-lg hover:bg-muted"><Download className="w-4 h-4" /> 导出</button>
              <button onClick={() => { toast.info("正在生成打印预览..."); setTimeout(() => toast.success("打印预览已生成"), 800); }} className="flex items-center gap-1.5 px-4 py-2 border border-border rounded-lg hover:bg-muted"><Printer className="w-4 h-4" /> 打印</button>
            </div>
            <div className="overflow-x-auto border border-border rounded-lg">
              <table className="w-full text-[13px]">
                <thead className="bg-muted/60">
                  <tr>
                    <th className="py-3 px-3 text-left w-10"><input type="checkbox" className="rounded" onChange={e => setSelectedIds(e.target.checked ? vouchers.map(v => v.id) : [])} /></th>
                    <th className="py-3 px-3 text-left text-muted-foreground" style={{ fontWeight: 500 }}>凭证号</th>
                    <th className="py-3 px-3 text-left text-muted-foreground" style={{ fontWeight: 500 }}>日期</th>
                    <th className="py-3 px-3 text-left text-muted-foreground" style={{ fontWeight: 500 }}>摘要</th>
                    <th className="py-3 px-3 text-left text-muted-foreground" style={{ fontWeight: 500 }}>会计科目</th>
                    <th className="py-3 px-3 text-right text-muted-foreground" style={{ fontWeight: 500 }}>借方</th>
                    <th className="py-3 px-3 text-right text-muted-foreground" style={{ fontWeight: 500 }}>贷方</th>
                    <th className="py-3 px-3 text-center text-muted-foreground" style={{ fontWeight: 500 }}>附件</th>
                    <th className="py-3 px-3 text-center text-muted-foreground" style={{ fontWeight: 500 }}>制单人</th>
                    <th className="py-3 px-3 text-center text-muted-foreground" style={{ fontWeight: 500 }}>状态</th>
                    <th className="py-3 px-3 text-center text-muted-foreground" style={{ fontWeight: 500 }}>操作</th>
                  </tr>
                </thead>
                <tbody>
                  {vouchers.map(row => (
                    <tr key={row.id} className="border-t border-border/50 hover:bg-green-50/30">
                      <td className="py-2.5 px-3"><input type="checkbox" checked={selectedIds.includes(row.id)} onChange={e => setSelectedIds(e.target.checked ? [...selectedIds, row.id] : selectedIds.filter(i => i !== row.id))} className="rounded" /></td>
                      <td className="py-2.5 px-3 text-primary cursor-pointer hover:underline">{row.no}</td>
                      <td className="py-2.5 px-3 text-muted-foreground">{row.date}</td>
                      <td className="py-2.5 px-3">{row.summary}</td>
                      <td className="py-2.5 px-3 text-[12px] text-muted-foreground">{row.subject}</td>
                      <td className="py-2.5 px-3 text-right">¥ {row.debit.toLocaleString()}</td>
                      <td className="py-2.5 px-3 text-right">¥ {row.credit.toLocaleString()}</td>
                      <td className="py-2.5 px-3 text-center text-primary">{row.attachments}</td>
                      <td className="py-2.5 px-3 text-center">{row.maker}</td>
                      <td className="py-2.5 px-3 text-center">
                        <span className={`px-2 py-0.5 rounded-full text-[12px] ${row.status === "已审核" ? "bg-green-50 text-green-600" : "bg-amber-50 text-amber-600"}`}>{row.status}</span>
                      </td>
                      <td className="py-2.5 px-3">
                        <div className="flex items-center justify-center gap-1">
                          <button className="p-1 hover:bg-muted rounded" title="查看" onClick={() => setShowDetail(row)}><Eye className="w-4 h-4 text-muted-foreground" /></button>
                          <button className="p-1 hover:bg-muted rounded" title="编辑" onClick={() => setShowEdit({ ...row })}><Edit className="w-4 h-4 text-muted-foreground" /></button>
                          <button className="p-1 hover:bg-muted rounded" title="删除" onClick={() => { setDeleteId(row.id); setShowDelete(true); }}><Trash2 className="w-4 h-4 text-red-400" /></button>
                        </div>
                      </td>
                    </tr>
                  ))}
                </tbody>
              </table>
            </div>
            <div className="flex items-center justify-between mt-4 text-[13px]">
              <span className="text-muted-foreground">共 {vouchers.length} 条记录</span>
            </div>
          </div>
        )}

        {activeTab === "entry" && (
          <div className="p-5">
            <div className="max-w-4xl">
              <div className="grid grid-cols-3 gap-4 mb-6">
                <div><label className="block text-[13px] text-muted-foreground mb-1">凭证字号</label><div className="flex gap-2"><select className="bg-muted rounded-lg px-3 py-2 outline-none flex-1"><option>记</option><option>收</option><option>付</option></select><input type="text" value="0302" readOnly className="bg-muted rounded-lg px-3 py-2 outline-none w-24" /></div></div>
                <div><label className="block text-[13px] text-muted-foreground mb-1">制单日期</label><input type="date" defaultValue="2026-03-09" className="bg-muted rounded-lg px-3 py-2 outline-none w-full" /></div>
                <div><label className="block text-[13px] text-muted-foreground mb-1">附单据数</label><input type="number" defaultValue={0} className="bg-muted rounded-lg px-3 py-2 outline-none w-full" /></div>
              </div>
              <div className="border border-border rounded-lg overflow-hidden mb-4">
                <table className="w-full text-[13px]">
                  <thead className="bg-muted/60">
                    <tr>
                      <th className="py-2.5 px-3 text-left text-muted-foreground" style={{ fontWeight: 500 }}>摘要</th>
                      <th className="py-2.5 px-3 text-left text-muted-foreground" style={{ fontWeight: 500 }}>会计科目</th>
                      <th className="py-2.5 px-3 text-right text-muted-foreground" style={{ fontWeight: 500 }}>借方金额</th>
                      <th className="py-2.5 px-3 text-right text-muted-foreground" style={{ fontWeight: 500 }}>贷方金额</th>
                    </tr>
                  </thead>
                  <tbody>
                    <tr className="border-t border-border/50">
                      <td className="py-2 px-2" rowSpan={2}><input type="text" value={entrySummary} onChange={e => setEntrySummary(e.target.value)} placeholder="请输入摘要" className="bg-muted rounded px-2 py-1.5 w-full outline-none" /></td>
                      <td className="py-2 px-2"><select className="bg-muted rounded px-2 py-1.5 w-full outline-none" value={entrySubjectDebit} onChange={e => setEntrySubjectDebit(e.target.value)}><option>1001 库存现金</option><option>1002 银行存款</option><option>1501 固定资产</option><option>1601 在建工程</option><option>5301 管理费用</option></select></td>
                      <td className="py-2 px-2"><input type="number" value={entryDebit} onChange={e => setEntryDebit(e.target.value)} placeholder="0.00" className="bg-muted rounded px-2 py-1.5 w-full outline-none text-right" /></td>
                      <td className="py-2 px-2 text-center text-muted-foreground">-</td>
                    </tr>
                    <tr className="border-t border-border/50">
                      <td className="py-2 px-2"><select className="bg-muted rounded px-2 py-1.5 w-full outline-none" value={entrySubjectCredit} onChange={e => setEntrySubjectCredit(e.target.value)}><option>5001 经营收入</option><option>5101 补助收入</option><option>1002 银行存款</option><option>2101 应付款</option></select></td>
                      <td className="py-2 px-2 text-center text-muted-foreground">-</td>
                      <td className="py-2 px-2"><input type="number" value={entryCredit} onChange={e => setEntryCredit(e.target.value)} placeholder="0.00" className="bg-muted rounded px-2 py-1.5 w-full outline-none text-right" /></td>
                    </tr>
                  </tbody>
                  <tfoot className="bg-muted/30">
                    <tr className="border-t border-border">
                      <td colSpan={2} className="py-2.5 px-3 text-right" style={{ fontWeight: 500 }}>合计</td>
                      <td className="py-2.5 px-3 text-right" style={{ fontWeight: 500 }}>¥ {(parseFloat(entryDebit) || 0).toLocaleString(undefined, { minimumFractionDigits: 2 })}</td>
                      <td className="py-2.5 px-3 text-right" style={{ fontWeight: 500 }}>¥ {(parseFloat(entryCredit) || 0).toLocaleString(undefined, { minimumFractionDigits: 2 })}</td>
                    </tr>
                  </tfoot>
                </table>
              </div>
              <div className="mb-6"><label className="block text-[13px] text-muted-foreground mb-1">备注</label><textarea placeholder="请输入备注信息..." className="bg-muted rounded-lg px-3 py-2 outline-none w-full h-20 resize-none" /></div>
              <div className="mb-6">
                <label className="block text-[13px] text-muted-foreground mb-2">上传附件</label>
                <div className="border-2 border-dashed border-border rounded-lg p-8 text-center hover:border-primary/50 transition-colors cursor-pointer" onClick={() => toast.info("请选择文件", { description: "支持 jpg、png、pdf 格式，单文件不超过10MB" })}>
                  <Upload className="w-8 h-8 text-muted-foreground mx-auto mb-2" /><p className="text-muted-foreground text-[13px]">点击或拖拽文件到此处上传</p>
                </div>
              </div>
              <div className="flex gap-3">
                <button onClick={handleSaveVoucher} className="px-6 py-2 bg-primary text-white rounded-lg hover:bg-primary/90">保存</button>
                <button onClick={handleSaveAndNew} className="px-6 py-2 border border-primary text-primary rounded-lg hover:bg-primary/5">保存并新增</button>
                <button onClick={() => setActiveTab("list")} className="px-6 py-2 border border-border rounded-lg hover:bg-muted">取消</button>
              </div>
            </div>
          </div>
        )}

        {activeTab === "recycle" && (
          <div className="p-5">
            {recycled.length === 0 ? (
              <div className="text-center py-20">
                <Trash2 className="w-16 h-16 text-muted-foreground/30 mx-auto mb-4" />
                <p className="text-muted-foreground">回收站为空</p>
                <p className="text-[13px] text-muted-foreground/60 mt-1">被删除的凭证将在这里显示，支持还原和彻底删除操作</p>
              </div>
            ) : (
              <div className="overflow-x-auto border border-border rounded-lg">
                <table className="w-full text-[13px]">
                  <thead className="bg-muted/60">
                    <tr>
                      <th className="py-3 px-3 text-left text-muted-foreground" style={{ fontWeight: 500 }}>凭证号</th>
                      <th className="py-3 px-3 text-left text-muted-foreground" style={{ fontWeight: 500 }}>摘要</th>
                      <th className="py-3 px-3 text-right text-muted-foreground" style={{ fontWeight: 500 }}>金额</th>
                      <th className="py-3 px-3 text-center text-muted-foreground" style={{ fontWeight: 500 }}>操作</th>
                    </tr>
                  </thead>
                  <tbody>
                    {recycled.map(v => (
                      <tr key={v.id} className="border-t border-border/50 hover:bg-red-50/20">
                        <td className="py-2.5 px-3 text-muted-foreground">{v.no}</td>
                        <td className="py-2.5 px-3">{v.summary}</td>
                        <td className="py-2.5 px-3 text-right">¥ {v.debit.toLocaleString()}</td>
                        <td className="py-2.5 px-3 text-center">
                          <button onClick={() => handleRestore(v.id)} className="px-3 py-1 bg-primary text-white rounded text-[12px] mr-2 hover:bg-primary/90">还原</button>
                          <button onClick={() => handlePermanentDelete(v.id)} className="px-3 py-1 border border-red-300 text-red-500 rounded text-[12px] hover:bg-red-50">彻底删除</button>
                        </td>
                      </tr>
                    ))}
                  </tbody>
                </table>
              </div>
            )}
          </div>
        )}
      </div>
      <ConfirmDialog open={showDelete} onClose={() => { setShowDelete(false); setDeleteId(null); }} onConfirm={handleDeleteVoucher} title="删除凭证" message="删除后凭证将移入回收站，您可以随时还原。确认删除吗？" confirmText="删除" type="warning" />

      {/* Voucher Detail Modal */}
      <Modal open={!!showDetail} onClose={() => setShowDetail(null)} title="凭证详情" width="max-w-xl">
        {showDetail && (
          <div className="space-y-3 text-[14px]">
            {[
              ["凭证号", showDetail.no],
              ["日期", showDetail.date],
              ["摘要", showDetail.summary],
              ["会计科目", showDetail.subject],
              ["借方金额", `¥ ${showDetail.debit.toLocaleString()}`],
              ["贷方金额", `¥ ${showDetail.credit.toLocaleString()}`],
              ["附件数", `${showDetail.attachments} 个`],
              ["制单人", showDetail.maker],
              ["状态", showDetail.status],
            ].map(([label, value]) => (
              <div key={label} className="flex"><span className="text-muted-foreground w-24 flex-shrink-0">{label}</span><span>{value}</span></div>
            ))}
          </div>
        )}
      </Modal>

      {/* Voucher Edit Modal */}
      <Modal open={!!showEdit} onClose={() => setShowEdit(null)} title="编辑凭证" width="max-w-xl">
        {showEdit && (
          <div className="space-y-4">
            <div><label className="block text-[13px] text-muted-foreground mb-1">摘要</label><input type="text" value={showEdit.summary} onChange={e => setShowEdit({ ...showEdit, summary: e.target.value })} className="bg-muted rounded-lg px-3 py-2 outline-none w-full" /></div>
            <div><label className="block text-[13px] text-muted-foreground mb-1">会计科目</label><input type="text" value={showEdit.subject} onChange={e => setShowEdit({ ...showEdit, subject: e.target.value })} className="bg-muted rounded-lg px-3 py-2 outline-none w-full" /></div>
            <div className="grid grid-cols-2 gap-4">
              <div><label className="block text-[13px] text-muted-foreground mb-1">借方金额</label><input type="number" value={showEdit.debit} onChange={e => setShowEdit({ ...showEdit, debit: parseFloat(e.target.value) || 0 })} className="bg-muted rounded-lg px-3 py-2 outline-none w-full text-right" /></div>
              <div><label className="block text-[13px] text-muted-foreground mb-1">贷方金额</label><input type="number" value={showEdit.credit} onChange={e => setShowEdit({ ...showEdit, credit: parseFloat(e.target.value) || 0 })} className="bg-muted rounded-lg px-3 py-2 outline-none w-full text-right" /></div>
            </div>
            <div className="flex justify-end gap-3 pt-2">
              <button onClick={() => setShowEdit(null)} className="px-4 py-2 border border-border rounded-lg hover:bg-muted">取消</button>
              <button onClick={() => { setVouchers(vouchers.map(v => v.id === showEdit.id ? { ...showEdit } : v)); toast.success("凭证已更新", { description: showEdit.no }); setShowEdit(null); }} className="px-4 py-2 bg-primary text-white rounded-lg hover:bg-primary/90">保存</button>
            </div>
          </div>
        )}
      </Modal>
    </div>
  );
}

// =============== LEDGER MANAGEMENT ===============

const ledgerTabs = [
  { key: "chronological", label: "序时账" },
  { key: "subject-summary", label: "科目汇总表" },
  { key: "subject-balance", label: "科目余额表" },
  { key: "general-ledger", label: "总账" },
  { key: "detail-ledger", label: "明细账" },
  { key: "income-expense", label: "收支明细表" },
  { key: "multi-column", label: "多栏账" },
  { key: "log", label: "财务日志" },
];
const chronoData = [
  { date: "2026-03-09", no: "记-0301", summary: "收到省级乡村振兴补助款", subject: "银行存款", debit: 80000, credit: 0 },
  { date: "2026-03-09", no: "记-0301", summary: "收到省级乡村振兴补助款", subject: "补助收入", debit: 0, credit: 80000 },
  { date: "2026-03-08", no: "记-0300", summary: "支付村道硬化修缮费", subject: "在建工程", debit: 38000, credit: 0 },
  { date: "2026-03-08", no: "记-0300", summary: "支付村道硬化修缮费", subject: "银行存款", debit: 0, credit: 38000 },
  { date: "2026-03-08", no: "记-0299", summary: "槟榔园承包收入", subject: "银行存款", debit: 12000, credit: 0 },
  { date: "2026-03-08", no: "记-0299", summary: "槟榔园承包收入", subject: "经营收入", debit: 0, credit: 12000 },
];
const subSummary = [
  { code: "1001", name: "库存现金", d: 5600, c: 3200 },
  { code: "1002", name: "银行存款", d: 97600, c: 99650 },
  { code: "1501", name: "固定资产", d: 0, c: 0 },
  { code: "1601", name: "在建工程", d: 38000, c: 0 },
  { code: "5001", name: "经营收入", d: 0, c: 17600 },
  { code: "5101", name: "补助收入", d: 0, c: 80000 },
  { code: "5301", name: "管理费用", d: 5350, c: 0 },
];
const subBalance = [
  { code: "1001", name: "库存现金", bd: 12500, bc: 0, pd: 5600, pc: 3200, ed: 14900, ec: 0 },
  { code: "1002", name: "银行存款", bd: 1687650, bc: 0, pd: 97600, pc: 99650, ed: 1685600, ec: 0 },
  { code: "1501", name: "固定资产", bd: 179600, bc: 0, pd: 0, pc: 0, ed: 179600, ec: 0 },
  { code: "1601", name: "在建工程", bd: 742000, bc: 0, pd: 38000, pc: 0, ed: 780000, ec: 0 },
  { code: "2101", name: "应付款", bd: 0, bc: 45000, pd: 0, pc: 0, ed: 0, ec: 45000 },
  { code: "3001", name: "资本", bd: 0, bc: 2576750, pd: 0, pc: 0, ed: 0, ec: 2576750 },
  { code: "5001", name: "经营收入", bd: 0, bc: 0, pd: 0, pc: 17600, ed: 0, ec: 17600 },
  { code: "5101", name: "补助收入", bd: 0, bc: 0, pd: 0, pc: 80000, ed: 0, ec: 80000 },
  { code: "5301", name: "管理费用", bd: 0, bc: 0, pd: 5350, pc: 0, ed: 5350, ec: 0 },
];
const glData = [
  { month: "2026-01", sub: "银行存款", begin: 1520000, pd: 195000, pc: 127350, end: 1587650 },
  { month: "2026-02", sub: "银行存款", begin: 1587650, pd: 168000, pc: 68000, end: 1687650 },
  { month: "2026-03", sub: "银行存款", begin: 1687650, pd: 97600, pc: 99650, end: 1685600 },
];
const dlData = [
  { date: "2026-03-05", no: "记-0295", summary: "支付保洁人员工资", d: 18000, c: 0, bal: 1669650 },
  { date: "2026-03-06", no: "记-0296", summary: "民宿经营收入分成", d: 0, c: 5600, bal: 1675250 },
  { date: "2026-03-06", no: "记-0297", summary: "支付村道硬化修缮费", d: 38000, c: 0, bal: 1637250 },
  { date: "2026-03-07", no: "记-0298", summary: "办公用品采购", d: 3150, c: 0, bal: 1634100 },
  { date: "2026-03-07", no: "记-0299", summary: "收到省级乡村振兴补助款", d: 0, c: 80000, bal: 1714100 },
  { date: "2026-03-08", no: "记-0300", summary: "槟榔园承包收入", d: 0, c: 12000, bal: 1726100 },
];
const ieData = [
  { date: "2026-03-06", summary: "民宿经营收入分成", t: "经营收入", inc: 5600, exp: 0 },
  { date: "2026-03-07", summary: "收到省级乡村振兴补助款", t: "补助收入", inc: 80000, exp: 0 },
  { date: "2026-03-08", summary: "槟榔园承包收入", t: "经营收入", inc: 12000, exp: 0 },
  { date: "2026-03-05", summary: "支付保洁人员工资", t: "-", inc: 0, exp: 18000 },
  { date: "2026-03-06", summary: "支付村道硬化修缮费", t: "-", inc: 0, exp: 38000 },
  { date: "2026-03-07", summary: "办公用品采购", t: "-", inc: 0, exp: 3150 },
];
const mcData = [
  { month: "2026-01", a: 42000, b: 120000, c: 15600, d: 95000 },
  { month: "2026-02", a: 35000, b: 85000, c: 12800, d: 45000 },
  { month: "2026-03", a: 17600, b: 80000, c: 5350, d: 38000 },
];
const logEntries = [
  { time: "2026-03-09 14:30", op: "符会计", act: "新增凭证", detail: "记-0301 收到省级乡村振兴补助款 ¥80,000" },
  { time: "2026-03-09 11:20", op: "符会计", act: "审核凭证", detail: "批量审核 3 张凭证" },
  { time: "2026-03-08 16:45", op: "王出纳", act: "新增凭证", detail: "记-0299 槟榔园承包收入 ¥12,000" },
  { time: "2026-03-08 15:30", op: "符会计", act: "新增凭证", detail: "记-0300 支付村道硬化修缮费 ¥38,000" },
  { time: "2026-03-07 10:15", op: "符会计", act: "导出报表", detail: "导出2026年3月序时账" },
  { time: "2026-03-06 09:00", op: "符会计", act: "期末结转", detail: "执行2026年2月损益结转" },
];

const TH = ({ children, align = "left" }: { children: any; align?: string }) => <th className={`py-3 px-3 text-${align} text-muted-foreground`} style={{ fontWeight: 500 }}>{children}</th>;
const F = (v: number) => v > 0 ? `¥ ${v.toLocaleString()}` : "-";

export function LedgerManagement() {
  const [activeTab, setActiveTab] = useState("chronological");
  return (
    <div className="space-y-4">
      <div className="flex items-center text-muted-foreground text-[13px]"><span>财务中心</span><ChevronRight className="w-4 h-4 mx-1" /><span className="text-foreground">账簿管理</span></div>
      <h2>账簿管理</h2>
      <div className="bg-white rounded-xl border border-border shadow-sm">
        <div className="flex border-b border-border overflow-x-auto">
          {ledgerTabs.map(t => (<button key={t.key} className={`px-4 py-3 whitespace-nowrap border-b-2 transition-colors ${activeTab === t.key ? "border-primary text-primary" : "border-transparent text-muted-foreground hover:text-foreground"}`} onClick={() => setActiveTab(t.key)}>{t.label}</button>))}
        </div>
        <div className="p-5">
          <div className="flex flex-wrap gap-3 mb-4">
            <input type="date" defaultValue="2026-03-01" className="bg-muted rounded-lg px-3 py-2 outline-none" />
            <span className="text-muted-foreground leading-[36px]">至</span>
            <input type="date" defaultValue="2026-03-09" className="bg-muted rounded-lg px-3 py-2 outline-none" />
            {activeTab !== "log" && <select className="bg-muted rounded-lg px-3 py-2 outline-none"><option>一级科目</option><option>二级科目</option><option>明细科目</option></select>}
            {(activeTab === "detail-ledger" || activeTab === "general-ledger") && <select className="bg-muted rounded-lg px-3 py-2 outline-none"><option>1002 银行存款</option><option>1001 库存现金</option><option>5001 经营收入</option></select>}
            <button onClick={() => toast.info("查询完成", { description: "已刷新数据" })} className="flex items-center gap-1.5 px-4 py-2 bg-primary text-white rounded-lg"><Search className="w-4 h-4" /> 查询</button>
            <button onClick={() => toast.success("导出成功", { description: "账簿数据已导出" })} className="flex items-center gap-1.5 px-4 py-2 border border-border rounded-lg hover:bg-muted"><Download className="w-4 h-4" /> 导出</button>
            <button onClick={() => { toast.info("正在生成打印预览..."); setTimeout(() => toast.success("打印预览已生成"), 800); }} className="flex items-center gap-1.5 px-4 py-2 border border-border rounded-lg hover:bg-muted"><Printer className="w-4 h-4" /> 打印</button>
          </div>
          <div className="overflow-x-auto border border-border rounded-lg">
            {activeTab === "chronological" && (
              <table className="w-full text-[13px]"><thead className="bg-muted/60"><tr><TH>日期</TH><TH>凭证号</TH><TH>摘要</TH><TH>会计科目</TH><TH align="right">借方金额</TH><TH align="right">贷方金额</TH></tr></thead>
              <tbody>{chronoData.map((r, i) => (<tr key={`c${i}`} className="border-t border-border/50 hover:bg-green-50/30"><td className="py-2.5 px-3 text-muted-foreground">{r.date}</td><td className="py-2.5 px-3 text-primary">{r.no}</td><td className="py-2.5 px-3">{r.summary}</td><td className="py-2.5 px-3">{r.subject}</td><td className="py-2.5 px-3 text-right">{F(r.debit)}</td><td className="py-2.5 px-3 text-right">{F(r.credit)}</td></tr>))}</tbody>
              <tfoot className="bg-muted/30"><tr className="border-t border-border"><td colSpan={4} className="py-2.5 px-3 text-right" style={{ fontWeight: 500 }}>本页合计</td><td className="py-2.5 px-3 text-right" style={{ fontWeight: 500 }}>¥ 130,000</td><td className="py-2.5 px-3 text-right" style={{ fontWeight: 500 }}>¥ 130,000</td></tr></tfoot></table>
            )}
            {activeTab === "subject-summary" && (
              <table className="w-full text-[13px]"><thead className="bg-muted/60"><tr><TH>科目编码</TH><TH>科目名称</TH><TH align="right">本期借方发生额</TH><TH align="right">本期贷方发生额</TH></tr></thead>
              <tbody>{subSummary.map(r => (<tr key={r.code} className="border-t border-border/50 hover:bg-green-50/30"><td className="py-2.5 px-3 text-primary">{r.code}</td><td className="py-2.5 px-3">{r.name}</td><td className="py-2.5 px-3 text-right">{F(r.d)}</td><td className="py-2.5 px-3 text-right">{F(r.c)}</td></tr>))}</tbody>
              <tfoot className="bg-muted/30"><tr className="border-t border-border"><td colSpan={2} className="py-2.5 px-3 text-right" style={{ fontWeight: 500 }}>合计</td><td className="py-2.5 px-3 text-right" style={{ fontWeight: 500 }}>¥ {subSummary.reduce((s,r)=>s+r.d,0).toLocaleString()}</td><td className="py-2.5 px-3 text-right" style={{ fontWeight: 500 }}>¥ {subSummary.reduce((s,r)=>s+r.c,0).toLocaleString()}</td></tr></tfoot></table>
            )}
            {activeTab === "subject-balance" && (
              <table className="w-full text-[13px]"><thead className="bg-muted/60"><tr><TH>科目编码</TH><TH>科目名称</TH><TH align="right">期初借方</TH><TH align="right">期初贷方</TH><TH align="right">本期借方</TH><TH align="right">本期贷方</TH><TH align="right">期末借方</TH><TH align="right">期末贷方</TH></tr></thead>
              <tbody>{subBalance.map(r => (<tr key={r.code} className="border-t border-border/50 hover:bg-green-50/30"><td className="py-2.5 px-3 text-primary">{r.code}</td><td className="py-2.5 px-3">{r.name}</td><td className="py-2.5 px-3 text-right">{F(r.bd)}</td><td className="py-2.5 px-3 text-right">{F(r.bc)}</td><td className="py-2.5 px-3 text-right">{F(r.pd)}</td><td className="py-2.5 px-3 text-right">{F(r.pc)}</td><td className="py-2.5 px-3 text-right" style={{ fontWeight: 500 }}>{F(r.ed)}</td><td className="py-2.5 px-3 text-right" style={{ fontWeight: 500 }}>{F(r.ec)}</td></tr>))}</tbody></table>
            )}
            {activeTab === "general-ledger" && (
              <table className="w-full text-[13px]"><thead className="bg-muted/60"><tr><TH>月份</TH><TH>科目</TH><TH align="right">期初余额</TH><TH align="right">本期借方</TH><TH align="right">本期贷方</TH><TH align="right">期末余额</TH><TH align="center">方向</TH></tr></thead>
              <tbody>{glData.map((r,i) => (<tr key={`gl${i}`} className="border-t border-border/50 hover:bg-green-50/30"><td className="py-2.5 px-3 text-muted-foreground">{r.month}</td><td className="py-2.5 px-3">{r.sub}</td><td className="py-2.5 px-3 text-right">¥ {r.begin.toLocaleString()}</td><td className="py-2.5 px-3 text-right">{F(r.pd)}</td><td className="py-2.5 px-3 text-right">{F(r.pc)}</td><td className="py-2.5 px-3 text-right" style={{ fontWeight: 500 }}>¥ {r.end.toLocaleString()}</td><td className="py-2.5 px-3 text-center"><span className="px-2 py-0.5 bg-green-50 text-green-600 rounded text-[12px]">借</span></td></tr>))}</tbody></table>
            )}
            {activeTab === "detail-ledger" && (
              <table className="w-full text-[13px]"><thead className="bg-muted/60"><tr><TH>日期</TH><TH>凭证号</TH><TH>摘要</TH><TH align="right">借方</TH><TH align="right">贷方</TH><TH align="center">方向</TH><TH align="right">余额</TH></tr></thead>
              <tbody>{dlData.map((r,i) => (<tr key={`dl${i}`} className="border-t border-border/50 hover:bg-green-50/30"><td className="py-2.5 px-3 text-muted-foreground">{r.date}</td><td className="py-2.5 px-3 text-primary">{r.no}</td><td className="py-2.5 px-3">{r.summary}</td><td className="py-2.5 px-3 text-right">{F(r.d)}</td><td className="py-2.5 px-3 text-right">{F(r.c)}</td><td className="py-2.5 px-3 text-center"><span className="px-2 py-0.5 bg-green-50 text-green-600 rounded text-[12px]">借</span></td><td className="py-2.5 px-3 text-right" style={{ fontWeight: 500 }}>¥ {r.bal.toLocaleString()}</td></tr>))}</tbody></table>
            )}
            {activeTab === "income-expense" && (
              <table className="w-full text-[13px]"><thead className="bg-muted/60"><tr><TH>日期</TH><TH>摘要</TH><TH>收入类型</TH><TH align="right">收入金额</TH><TH align="right">支出金额</TH></tr></thead>
              <tbody>{ieData.map((r,i) => (<tr key={`ie${i}`} className="border-t border-border/50 hover:bg-green-50/30"><td className="py-2.5 px-3 text-muted-foreground">{r.date}</td><td className="py-2.5 px-3">{r.summary}</td><td className="py-2.5 px-3">{r.t !== "-" ? <span className="px-2 py-0.5 bg-green-50 text-green-600 rounded text-[12px]">{r.t}</span> : "-"}</td><td className="py-2.5 px-3 text-right text-green-600">{F(r.inc)}</td><td className="py-2.5 px-3 text-right text-red-500">{F(r.exp)}</td></tr>))}</tbody>
              <tfoot className="bg-muted/30"><tr className="border-t border-border"><td colSpan={3} className="py-2.5 px-3 text-right" style={{ fontWeight: 500 }}>合计</td><td className="py-2.5 px-3 text-right text-green-600" style={{ fontWeight: 500 }}>¥ {ieData.reduce((s,r)=>s+r.inc,0).toLocaleString()}</td><td className="py-2.5 px-3 text-right text-red-500" style={{ fontWeight: 500 }}>¥ {ieData.reduce((s,r)=>s+r.exp,0).toLocaleString()}</td></tr></tfoot></table>
            )}
            {activeTab === "multi-column" && (
              <table className="w-full text-[13px]"><thead className="bg-muted/60"><tr><TH>月份</TH><TH align="right">经营收入</TH><TH align="right">补助收入</TH><TH align="right">管理费用</TH><TH align="right">在建工程</TH><TH align="right">收入合计</TH><TH align="right">支出合计</TH></tr></thead>
              <tbody>{mcData.map(r => (<tr key={r.month} className="border-t border-border/50 hover:bg-green-50/30"><td className="py-2.5 px-3 text-muted-foreground">{r.month}</td><td className="py-2.5 px-3 text-right text-green-600">¥ {r.a.toLocaleString()}</td><td className="py-2.5 px-3 text-right text-green-600">¥ {r.b.toLocaleString()}</td><td className="py-2.5 px-3 text-right text-red-500">¥ {r.c.toLocaleString()}</td><td className="py-2.5 px-3 text-right text-red-500">¥ {r.d.toLocaleString()}</td><td className="py-2.5 px-3 text-right text-green-600" style={{ fontWeight: 500 }}>¥ {(r.a+r.b).toLocaleString()}</td><td className="py-2.5 px-3 text-right text-red-500" style={{ fontWeight: 500 }}>¥ {(r.c+r.d).toLocaleString()}</td></tr>))}</tbody></table>
            )}
            {activeTab === "log" && (
              <table className="w-full text-[13px]"><thead className="bg-muted/60"><tr><TH>时间</TH><TH>操作人</TH><TH>操作类型</TH><TH>操作详情</TH></tr></thead>
              <tbody>{logEntries.map((r,i) => (<tr key={`log${i}`} className="border-t border-border/50 hover:bg-green-50/30"><td className="py-2.5 px-3 text-muted-foreground">{r.time}</td><td className="py-2.5 px-3">{r.op}</td><td className="py-2.5 px-3"><span className="px-2 py-0.5 bg-blue-50 text-blue-600 rounded text-[12px]">{r.act}</span></td><td className="py-2.5 px-3 text-muted-foreground">{r.detail}</td></tr>))}</tbody></table>
            )}
          </div>
        </div>
      </div>
    </div>
  );
}

// =============== PERIOD END PROCESSING ===============

export function PeriodEndProcessing() {
  const [periods, setPeriods] = useState([
    { month: "2026年1月", status: "已结账", date: "2026-02-01" },
    { month: "2026年2月", status: "已结账", date: "2026-03-01" },
    { month: "2026年3月", status: "未结账", date: "-" },
  ]);
  const [showCarryOver, setShowCarryOver] = useState(false);
  const [showTrialBalance, setShowTrialBalance] = useState(false);

  const handleSettle = (month: string) => {
    toast.info("正在执行月结处理...");
    setTimeout(() => {
      setPeriods(periods.map(p => p.month === month ? { ...p, status: "已结账", date: "2026-03-09" } : p));
      toast.success("月结完成", { description: `${month} 已成功结账` });
    }, 1000);
  };

  const handleUnsettle = (month: string) => {
    setPeriods(periods.map(p => p.month === month ? { ...p, status: "未结账", date: "-" } : p));
    toast.success("反结账完成", { description: `${month} 已恢复为未结账状态` });
  };

  return (
    <div className="space-y-4">
      <div className="flex items-center text-muted-foreground text-[13px]">
        <span>财务中心</span><ChevronRight className="w-4 h-4 mx-1" /><span className="text-foreground">期末处理</span>
      </div>
      <h2>期末处理</h2>

      <div className="grid grid-cols-1 md:grid-cols-3 gap-4">
        <div className="bg-white rounded-xl p-5 border border-border shadow-sm hover:shadow-md transition-shadow cursor-pointer">
          <div className="w-12 h-12 rounded-xl bg-green-50 flex items-center justify-center mb-3"><RefreshCw className="w-6 h-6 text-primary" /></div>
          <h3>结转损益</h3>
          <p className="text-[13px] text-muted-foreground mt-1">自动生成结转损益凭证，将收入和支出科目余额结转至本年利润科目</p>
          <button onClick={() => {
            setShowCarryOver(true);
            toast.info("正在计算结转数据...");
            setTimeout(() => { setShowCarryOver(false); toast.success("结转损益完成", { description: "已生成 3 张结转凭证，收入结转 ¥238,000，支出结转 ¥89,450" }); }, 1500);
          }} className="mt-3 px-4 py-2 bg-primary text-white rounded-lg text-[13px] hover:bg-primary/90">
            {showCarryOver ? "结转中..." : "一键结转"}
          </button>
        </div>
        <div className="bg-white rounded-xl p-5 border border-border shadow-sm hover:shadow-md transition-shadow cursor-pointer">
          <div className="w-12 h-12 rounded-xl bg-green-50 flex items-center justify-center mb-3"><BookOpen className="w-6 h-6 text-green-600" /></div>
          <h3>结转试算</h3>
          <p className="text-[13px] text-muted-foreground mt-1">结账前进行试算平衡检查，确保借贷方金额平衡</p>
          <button onClick={() => {
            setShowTrialBalance(true);
            toast.info("正在进行试算平衡检查...");
            setTimeout(() => { setShowTrialBalance(false); toast.success("试算平衡", { description: "借方合计 ¥5,361,400 = 贷方合计 ¥5,361,400，试算平衡通过" }); }, 1200);
          }} className="mt-3 px-4 py-2 border border-border rounded-lg text-[13px] hover:bg-muted">
            {showTrialBalance ? "检查中..." : "开始试算"}
          </button>
        </div>
        <div className="bg-white rounded-xl p-5 border border-border shadow-sm hover:shadow-md transition-shadow cursor-pointer">
          <div className="w-12 h-12 rounded-xl bg-amber-50 flex items-center justify-center mb-3"><Settings className="w-6 h-6 text-amber-600" /></div>
          <h3>结转科目配置</h3>
          <p className="text-[13px] text-muted-foreground mt-1">设置结转科目映射关系、结转模板和自定义结转规则</p>
          <button onClick={() => toast.info("配置管理", { description: "结转科目配置页面正在开发中" })} className="mt-3 px-4 py-2 border border-border rounded-lg text-[13px] hover:bg-muted">配置管理</button>
        </div>
      </div>

      <div className="bg-white rounded-xl border border-border shadow-sm p-5">
        <h3 className="mb-4">月末结账</h3>
        <div className="overflow-x-auto border border-border rounded-lg">
          <table className="w-full text-[13px]">
            <thead className="bg-muted/60">
              <tr>
                <th className="py-3 px-4 text-left text-muted-foreground" style={{ fontWeight: 500 }}>会计期间</th>
                <th className="py-3 px-4 text-center text-muted-foreground" style={{ fontWeight: 500 }}>状态</th>
                <th className="py-3 px-4 text-left text-muted-foreground" style={{ fontWeight: 500 }}>结账日期</th>
                <th className="py-3 px-4 text-center text-muted-foreground" style={{ fontWeight: 500 }}>操作</th>
              </tr>
            </thead>
            <tbody>
              {periods.map(p => (
                <tr key={p.month} className="border-t border-border/50 hover:bg-green-50/30">
                  <td className="py-3 px-4">{p.month}</td>
                  <td className="py-3 px-4 text-center">
                    <span className={`px-2 py-0.5 rounded-full text-[12px] ${p.status === "已结账" ? "bg-green-50 text-green-600" : "bg-amber-50 text-amber-600"}`}>{p.status}</span>
                  </td>
                  <td className="py-3 px-4 text-muted-foreground">{p.date}</td>
                  <td className="py-3 px-4 text-center">
                    {p.status === "已结账" ? (
                      <button onClick={() => handleUnsettle(p.month)} className="px-3 py-1 border border-border rounded text-[12px] hover:bg-muted"><RotateCcw className="w-3 h-3 inline mr-1" />反结账</button>
                    ) : (
                      <button onClick={() => handleSettle(p.month)} className="px-3 py-1 bg-primary text-white rounded text-[12px] hover:bg-primary/90"><CheckCircle className="w-3 h-3 inline mr-1" />月结</button>
                    )}
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

// =============== FINANCE SETTINGS SUB-PAGES ===============

function AccountSetPage({ goBack }: { goBack: () => void }) {
  const [sets, setSets] = useState([
    { id: 1, name: "椰林村2026年度账套", period: "2026-01 至 2026-12", currency: "人民币", status: "当前使用" },
    { id: 2, name: "椰林村2025年度账套", period: "2025-01 至 2025-12", currency: "人民币", status: "已归档" },
  ]);
  const [showAdd, setShowAdd] = useState(false);
  const [showEdit, setShowEdit] = useState<typeof sets[0] | null>(null);
  const [formName, setFormName] = useState(""); const [formYear, setFormYear] = useState("2027"); const [formCurrency, setFormCurrency] = useState("人民币");
  const handleAdd = () => { if (!formName) { toast.error("请填写账套名称"); return; } setSets(p => [{ id: Math.max(...p.map(s => s.id), 0) + 1, name: formName, period: `${formYear}-01 至 ${formYear}-12`, currency: formCurrency, status: "未启用" }, ...p]); setShowAdd(false); setFormName(""); toast.success("账套创建成功", { description: formName }); };
  const handleEditSave = () => { if (!showEdit) return; setSets(p => p.map(s => s.id === showEdit.id ? { ...showEdit } : s)); toast.success("账套信息已保存", { description: showEdit.name }); setShowEdit(null); };
  const bb = <button onClick={goBack} className="flex items-center gap-1 px-3 py-1.5 border border-border rounded-lg hover:bg-muted text-[13px]"><ChevronRight className="w-4 h-4 rotate-180" /> 返回设置</button>;
  return (
    <div className="space-y-4"><div className="flex items-center text-muted-foreground text-[13px]"><span>财务中心</span><ChevronRight className="w-4 h-4 mx-1" /><span>财务设置</span><ChevronRight className="w-4 h-4 mx-1" /><span className="text-foreground">账套管理</span></div>
      <div className="flex items-center gap-3">{bb}<h2>账套管理</h2></div>
      <div className="bg-white rounded-xl border border-border shadow-sm p-5">
        <div className="flex justify-end mb-4"><button onClick={() => { setFormName(""); setFormYear("2027"); setShowAdd(true); }} className="flex items-center gap-1.5 px-4 py-2 bg-primary text-white rounded-lg hover:bg-primary/90"><Plus className="w-4 h-4" /> 新建账套</button></div>
        <div className="overflow-x-auto border border-border rounded-lg"><table className="w-full text-[13px]"><thead className="bg-muted/60"><tr><th className="py-3 px-3 text-left text-muted-foreground" style={{fontWeight:500}}>账套名称</th><th className="py-3 px-3 text-left text-muted-foreground" style={{fontWeight:500}}>会计期间</th><th className="py-3 px-3 text-center text-muted-foreground" style={{fontWeight:500}}>记账本位币</th><th className="py-3 px-3 text-center text-muted-foreground" style={{fontWeight:500}}>状态</th><th className="py-3 px-3 text-center text-muted-foreground" style={{fontWeight:500}}>操作</th></tr></thead>
        <tbody>{sets.map(s => (<tr key={s.id} className="border-t border-border/50 hover:bg-green-50/30"><td className="py-2.5 px-3" style={{fontWeight:500}}>{s.name}</td><td className="py-2.5 px-3 text-muted-foreground">{s.period}</td><td className="py-2.5 px-3 text-center">{s.currency}</td><td className="py-2.5 px-3 text-center"><span className={`px-2 py-0.5 rounded-full text-[12px] ${s.status==="当前使用"?"bg-green-50 text-green-600":"bg-gray-100 text-gray-500"}`}>{s.status}</span></td><td className="py-2.5 px-3 text-center"><button onClick={()=>setShowEdit({...s})} className="px-3 py-1 border border-border rounded text-[12px] hover:bg-muted">编辑</button></td></tr>))}</tbody></table></div>
        <div className="flex justify-end mt-4"><button onClick={()=>toast.success("账套配置已保存")} className="px-4 py-2 bg-primary text-white rounded-lg hover:bg-primary/90">保存</button></div>
      </div>
      <Modal open={showAdd} onClose={() => setShowAdd(false)} title="新建账套"><div className="space-y-4">
        <div><label className="block text-[13px] text-muted-foreground mb-1">账套名称 *</label><input value={formName} onChange={e => setFormName(e.target.value)} placeholder="如：椰林村2027年度账套" className="bg-muted rounded-lg px-3 py-2 outline-none w-full" /></div>
        <div className="grid grid-cols-2 gap-4"><div><label className="block text-[13px] text-muted-foreground mb-1">会计年度</label><select value={formYear} onChange={e => setFormYear(e.target.value)} className="bg-muted rounded-lg px-3 py-2 outline-none w-full"><option>2027</option><option>2028</option></select></div><div><label className="block text-[13px] text-muted-foreground mb-1">记账本位币</label><select value={formCurrency} onChange={e => setFormCurrency(e.target.value)} className="bg-muted rounded-lg px-3 py-2 outline-none w-full"><option>人民币</option></select></div></div>
        <div className="flex justify-end gap-3 pt-2"><button onClick={() => setShowAdd(false)} className="px-4 py-2 border border-border rounded-lg hover:bg-muted">取消</button><button onClick={handleAdd} className="px-4 py-2 bg-primary text-white rounded-lg hover:bg-primary/90">保存</button></div>
      </div></Modal>
      <Modal open={!!showEdit} onClose={() => setShowEdit(null)} title="编辑账套">{showEdit && (<div className="space-y-4">
        <div><label className="block text-[13px] text-muted-foreground mb-1">账套名称</label><input value={showEdit.name} onChange={e => setShowEdit({...showEdit, name: e.target.value})} className="bg-muted rounded-lg px-3 py-2 outline-none w-full" /></div>
        <div><label className="block text-[13px] text-muted-foreground mb-1">状态</label><select value={showEdit.status} onChange={e => setShowEdit({...showEdit, status: e.target.value})} className="bg-muted rounded-lg px-3 py-2 outline-none w-full"><option>当前使用</option><option>未启用</option><option>已归档</option></select></div>
        <div className="flex justify-end gap-3 pt-2"><button onClick={() => setShowEdit(null)} className="px-4 py-2 border border-border rounded-lg hover:bg-muted">取消</button><button onClick={handleEditSave} className="px-4 py-2 bg-primary text-white rounded-lg hover:bg-primary/90">保存</button></div>
      </div>)}</Modal>
    </div>
  );
}

function SubjectsPage({ goBack }: { goBack: () => void }) {
  const [subjects, setSubjects] = useState([
    { code: "1001", name: "库存现金", type: "资产", direction: "借", level: 1 },{ code: "1002", name: "银行存款", type: "资产", direction: "借", level: 1 },{ code: "1131", name: "应收款", type: "资产", direction: "借", level: 1 },{ code: "1501", name: "固定资产", type: "资产", direction: "借", level: 1 },{ code: "1601", name: "在建工程", type: "资产", direction: "借", level: 1 },{ code: "2101", name: "应付款", type: "负债", direction: "贷", level: 1 },{ code: "2151", name: "应付工资", type: "负债", direction: "贷", level: 1 },{ code: "3101", name: "资本", type: "所有者权益", direction: "贷", level: 1 },{ code: "5001", name: "经营收入", type: "损益", direction: "贷", level: 1 },{ code: "5101", name: "补助收入", type: "损益", direction: "贷", level: 1 },{ code: "5301", name: "管理费用", type: "损益", direction: "借", level: 1 },
  ]);
  const [showAdd, setShowAdd] = useState(false); const [showEdit, setShowEdit] = useState<typeof subjects[0] | null>(null);
  const [formCode, setFormCode] = useState(""); const [formName, setFormName] = useState(""); const [formType, setFormType] = useState("资产"); const [formDir, setFormDir] = useState("借");
  const [searchText, setSearchText] = useState("");
  const resetForm = () => { setFormCode(""); setFormName(""); setFormType("资产"); setFormDir("借"); };
  const handleAdd = () => { if (!formCode || !formName) { toast.error("请填写科目编码和名称"); return; } if (subjects.some(s => s.code === formCode)) { toast.error("科目编码已存在"); return; } setSubjects(p => [...p, { code: formCode, name: formName, type: formType, direction: formDir, level: 1 }].sort((a, b) => a.code.localeCompare(b.code))); setShowAdd(false); resetForm(); toast.success("科目添加成功", { description: `${formCode} ${formName}` }); };
  const handleEditSave = () => { if (!showEdit) return; setSubjects(p => p.map(s => s.code === showEdit.code ? { ...showEdit } : s)); toast.success("科目已更新", { description: `${showEdit.code} ${showEdit.name}` }); setShowEdit(null); };
  const filtered = subjects.filter(s => !searchText || s.code.includes(searchText) || s.name.includes(searchText));
  const bb = <button onClick={goBack} className="flex items-center gap-1 px-3 py-1.5 border border-border rounded-lg hover:bg-muted text-[13px]"><ChevronRight className="w-4 h-4 rotate-180" /> 返回设置</button>;
  return (
    <div className="space-y-4"><div className="flex items-center text-muted-foreground text-[13px]"><span>财务中心</span><ChevronRight className="w-4 h-4 mx-1" /><span>财务设置</span><ChevronRight className="w-4 h-4 mx-1" /><span className="text-foreground">会计科目</span></div>
      <div className="flex items-center gap-3">{bb}<h2>会计科目</h2></div>
      <div className="bg-white rounded-xl border border-border shadow-sm p-5">
        <div className="flex justify-between mb-4"><div className="relative"><Search className="w-4 h-4 absolute left-3 top-1/2 -translate-y-1/2 text-muted-foreground" /><input placeholder="搜索科目..." value={searchText} onChange={e=>setSearchText(e.target.value)} className="pl-9 pr-4 py-2 bg-muted rounded-lg w-[200px] outline-none" /></div><button onClick={()=>{resetForm();setShowAdd(true);}} className="flex items-center gap-1.5 px-4 py-2 bg-primary text-white rounded-lg hover:bg-primary/90"><Plus className="w-4 h-4" /> 新增科目</button></div>
        <div className="overflow-x-auto border border-border rounded-lg"><table className="w-full text-[13px]"><thead className="bg-muted/60"><tr><th className="py-3 px-3 text-left text-muted-foreground" style={{fontWeight:500}}>科目编码</th><th className="py-3 px-3 text-left text-muted-foreground" style={{fontWeight:500}}>科目名称</th><th className="py-3 px-3 text-center text-muted-foreground" style={{fontWeight:500}}>类型</th><th className="py-3 px-3 text-center text-muted-foreground" style={{fontWeight:500}}>余额方向</th><th className="py-3 px-3 text-center text-muted-foreground" style={{fontWeight:500}}>级次</th><th className="py-3 px-3 text-center text-muted-foreground" style={{fontWeight:500}}>操作</th></tr></thead>
        <tbody>{filtered.map(s => (<tr key={s.code} className="border-t border-border/50 hover:bg-green-50/30"><td className="py-2.5 px-3 text-primary">{s.code}</td><td className="py-2.5 px-3">{s.name}</td><td className="py-2.5 px-3 text-center"><span className={`px-2 py-0.5 rounded text-[12px] ${s.type==="资产"?"bg-blue-50 text-blue-600":s.type==="负债"?"bg-red-50 text-red-500":s.type==="损益"?"bg-amber-50 text-amber-600":"bg-green-50 text-green-600"}`}>{s.type}</span></td><td className="py-2.5 px-3 text-center"><span className={`px-2 py-0.5 rounded text-[12px] ${s.direction==="借"?"bg-blue-50 text-blue-600":"bg-green-50 text-green-600"}`}>{s.direction}</span></td><td className="py-2.5 px-3 text-center">{s.level}级</td><td className="py-2.5 px-3 text-center"><button onClick={()=>setShowEdit({...s})} className="px-3 py-1 border border-border rounded text-[12px] hover:bg-muted">编辑</button></td></tr>))}</tbody></table></div>
        <div className="flex items-center justify-between mt-4"><span className="text-[13px] text-muted-foreground">共 {filtered.length} 个科目</span><button onClick={()=>toast.success("科目表已保存")} className="px-4 py-2 bg-primary text-white rounded-lg hover:bg-primary/90">保存</button></div>
      </div>
      <Modal open={showAdd} onClose={() => setShowAdd(false)} title="新增会计科目"><div className="space-y-4">
        <div className="grid grid-cols-2 gap-4"><div><label className="block text-[13px] text-muted-foreground mb-1">科目编码 *</label><input value={formCode} onChange={e => setFormCode(e.target.value)} placeholder="如：1201" className="bg-muted rounded-lg px-3 py-2 outline-none w-full" /></div><div><label className="block text-[13px] text-muted-foreground mb-1">科目名称 *</label><input value={formName} onChange={e => setFormName(e.target.value)} placeholder="如：短期投资" className="bg-muted rounded-lg px-3 py-2 outline-none w-full" /></div></div>
        <div className="grid grid-cols-2 gap-4"><div><label className="block text-[13px] text-muted-foreground mb-1">科目类型</label><select value={formType} onChange={e => setFormType(e.target.value)} className="bg-muted rounded-lg px-3 py-2 outline-none w-full"><option>资产</option><option>负债</option><option>所有者权益</option><option>损益</option></select></div><div><label className="block text-[13px] text-muted-foreground mb-1">余额方向</label><select value={formDir} onChange={e => setFormDir(e.target.value)} className="bg-muted rounded-lg px-3 py-2 outline-none w-full"><option>借</option><option>贷</option></select></div></div>
        <div className="flex justify-end gap-3 pt-2"><button onClick={() => setShowAdd(false)} className="px-4 py-2 border border-border rounded-lg hover:bg-muted">取消</button><button onClick={handleAdd} className="px-4 py-2 bg-primary text-white rounded-lg hover:bg-primary/90">保存</button></div>
      </div></Modal>
      <Modal open={!!showEdit} onClose={() => setShowEdit(null)} title="编辑会计科目">{showEdit && (<div className="space-y-4">
        <div className="grid grid-cols-2 gap-4"><div><label className="block text-[13px] text-muted-foreground mb-1">科目编码</label><input value={showEdit.code} disabled className="bg-muted/50 rounded-lg px-3 py-2 outline-none w-full text-muted-foreground" /></div><div><label className="block text-[13px] text-muted-foreground mb-1">科目名称</label><input value={showEdit.name} onChange={e => setShowEdit({...showEdit, name: e.target.value})} className="bg-muted rounded-lg px-3 py-2 outline-none w-full" /></div></div>
        <div className="grid grid-cols-2 gap-4"><div><label className="block text-[13px] text-muted-foreground mb-1">科目类型</label><select value={showEdit.type} onChange={e => setShowEdit({...showEdit, type: e.target.value})} className="bg-muted rounded-lg px-3 py-2 outline-none w-full"><option>资产</option><option>负债</option><option>所有者权益</option><option>损益</option></select></div><div><label className="block text-[13px] text-muted-foreground mb-1">余额方向</label><select value={showEdit.direction} onChange={e => setShowEdit({...showEdit, direction: e.target.value})} className="bg-muted rounded-lg px-3 py-2 outline-none w-full"><option>借</option><option>贷</option></select></div></div>
        <div className="flex justify-end gap-3 pt-2"><button onClick={() => setShowEdit(null)} className="px-4 py-2 border border-border rounded-lg hover:bg-muted">取消</button><button onClick={handleEditSave} className="px-4 py-2 bg-primary text-white rounded-lg hover:bg-primary/90">保存</button></div>
      </div>)}</Modal>
    </div>
  );
}

function TemplatesPage({ goBack }: { goBack: () => void }) {
  const [templates, setTemplates] = useState([
    { id: 1, name: "工资发放", ds: "5301 管理费用", cs: "1002 银行存款", usage: 12 },{ id: 2, name: "承包费收入", ds: "1002 银行存款", cs: "5001 经营收入", usage: 8 },{ id: 3, name: "补助款入账", ds: "1002 银行存款", cs: "5101 补助收入", usage: 5 },{ id: 4, name: "工程款支付", ds: "1601 在建工程", cs: "1002 银行存款", usage: 4 },{ id: 5, name: "水电费支出", ds: "5301 管理费用", cs: "1002 银行存款", usage: 6 },
  ]);
  const [showAdd, setShowAdd] = useState(false); const [showEdit, setShowEdit] = useState<typeof templates[0] | null>(null);
  const [formName, setFormName] = useState(""); const [formDs, setFormDs] = useState(""); const [formCs, setFormCs] = useState("");
  const resetForm = () => { setFormName(""); setFormDs(""); setFormCs(""); };
  const handleAdd = () => { if (!formName || !formDs || !formCs) { toast.error("请填写模板名称、借方和贷方科目"); return; } setTemplates(p => [...p, { id: Math.max(...p.map(t => t.id), 0) + 1, name: formName, ds: formDs, cs: formCs, usage: 0 }]); setShowAdd(false); resetForm(); toast.success("凭证模板创建成功", { description: formName }); };
  const handleEditSave = () => { if (!showEdit) return; setTemplates(p => p.map(t => t.id === showEdit.id ? { ...showEdit } : t)); toast.success("模板已更新", { description: showEdit.name }); setShowEdit(null); };
  const handleDelete = (id: number) => { const t = templates.find(t => t.id === id); setTemplates(p => p.filter(t => t.id !== id)); toast.success("模板已删除", { description: t?.name }); };
  const bb = <button onClick={goBack} className="flex items-center gap-1 px-3 py-1.5 border border-border rounded-lg hover:bg-muted text-[13px]"><ChevronRight className="w-4 h-4 rotate-180" /> 返回设置</button>;
  return (
    <div className="space-y-4"><div className="flex items-center text-muted-foreground text-[13px]"><span>财务中心</span><ChevronRight className="w-4 h-4 mx-1" /><span>财务设置</span><ChevronRight className="w-4 h-4 mx-1" /><span className="text-foreground">凭证模板</span></div>
      <div className="flex items-center gap-3">{bb}<h2>凭证模板</h2></div>
      <div className="bg-white rounded-xl border border-border shadow-sm p-5">
        <div className="flex justify-end mb-4"><button onClick={()=>{resetForm();setShowAdd(true);}} className="flex items-center gap-1.5 px-4 py-2 bg-primary text-white rounded-lg hover:bg-primary/90"><Plus className="w-4 h-4" /> 新增模板</button></div>
        <div className="overflow-x-auto border border-border rounded-lg"><table className="w-full text-[13px]"><thead className="bg-muted/60"><tr><th className="py-3 px-3 text-left text-muted-foreground" style={{fontWeight:500}}>模板名称</th><th className="py-3 px-3 text-left text-muted-foreground" style={{fontWeight:500}}>借方科目</th><th className="py-3 px-3 text-left text-muted-foreground" style={{fontWeight:500}}>贷方科目</th><th className="py-3 px-3 text-center text-muted-foreground" style={{fontWeight:500}}>使用次数</th><th className="py-3 px-3 text-center text-muted-foreground" style={{fontWeight:500}}>操作</th></tr></thead>
        <tbody>{templates.map(t => (<tr key={t.id} className="border-t border-border/50 hover:bg-green-50/30"><td className="py-2.5 px-3" style={{fontWeight:500}}>{t.name}</td><td className="py-2.5 px-3 text-muted-foreground">{t.ds}</td><td className="py-2.5 px-3 text-muted-foreground">{t.cs}</td><td className="py-2.5 px-3 text-center">{t.usage}次</td><td className="py-2.5 px-3 text-center"><button onClick={()=>setShowEdit({...t})} className="px-3 py-1 border border-border rounded text-[12px] hover:bg-muted mr-1">编辑</button><button onClick={()=>handleDelete(t.id)} className="px-3 py-1 border border-red-200 text-red-500 rounded text-[12px] hover:bg-red-50">删除</button></td></tr>))}</tbody></table></div>
        <div className="flex justify-end mt-4"><button onClick={()=>toast.success("模板配置已保存")} className="px-4 py-2 bg-primary text-white rounded-lg hover:bg-primary/90">保存</button></div>
      </div>
      <Modal open={showAdd} onClose={() => setShowAdd(false)} title="新增凭证模板"><div className="space-y-4">
        <div><label className="block text-[13px] text-muted-foreground mb-1">模板名称 *</label><input value={formName} onChange={e => setFormName(e.target.value)} placeholder="如：固定资产购入" className="bg-muted rounded-lg px-3 py-2 outline-none w-full" /></div>
        <div><label className="block text-[13px] text-muted-foreground mb-1">借方科目 *</label><input value={formDs} onChange={e => setFormDs(e.target.value)} placeholder="如：1501 固定资产" className="bg-muted rounded-lg px-3 py-2 outline-none w-full" /></div>
        <div><label className="block text-[13px] text-muted-foreground mb-1">贷方科目 *</label><input value={formCs} onChange={e => setFormCs(e.target.value)} placeholder="如：1002 银行存款" className="bg-muted rounded-lg px-3 py-2 outline-none w-full" /></div>
        <div className="flex justify-end gap-3 pt-2"><button onClick={() => setShowAdd(false)} className="px-4 py-2 border border-border rounded-lg hover:bg-muted">取消</button><button onClick={handleAdd} className="px-4 py-2 bg-primary text-white rounded-lg hover:bg-primary/90">保存</button></div>
      </div></Modal>
      <Modal open={!!showEdit} onClose={() => setShowEdit(null)} title="编辑凭证模板">{showEdit && (<div className="space-y-4">
        <div><label className="block text-[13px] text-muted-foreground mb-1">模板名称</label><input value={showEdit.name} onChange={e => setShowEdit({...showEdit, name: e.target.value})} className="bg-muted rounded-lg px-3 py-2 outline-none w-full" /></div>
        <div><label className="block text-[13px] text-muted-foreground mb-1">借方科目</label><input value={showEdit.ds} onChange={e => setShowEdit({...showEdit, ds: e.target.value})} className="bg-muted rounded-lg px-3 py-2 outline-none w-full" /></div>
        <div><label className="block text-[13px] text-muted-foreground mb-1">贷方科目</label><input value={showEdit.cs} onChange={e => setShowEdit({...showEdit, cs: e.target.value})} className="bg-muted rounded-lg px-3 py-2 outline-none w-full" /></div>
        <div className="flex justify-end gap-3 pt-2"><button onClick={() => setShowEdit(null)} className="px-4 py-2 border border-border rounded-lg hover:bg-muted">取消</button><button onClick={handleEditSave} className="px-4 py-2 bg-primary text-white rounded-lg hover:bg-primary/90">保存</button></div>
      </div>)}</Modal>
    </div>
  );
}

function ReportsPage({ goBack }: { goBack: () => void }) {
  const [reports, setReports] = useState([
    { id: 1, name: "资产负债表", format: "标准", formula: "系统预设", status: "启用" },{ id: 2, name: "收益及收益分配表", format: "标准", formula: "系统预设", status: "启用" },{ id: 3, name: "现金流量表", format: "自定义", formula: "自定义公式", status: "启用" },{ id: 4, name: "村级财务公开表", format: "自定义", formula: "自定义公式", status: "草稿" },
  ]);
  const [showAdd, setShowAdd] = useState(false); const [showEdit, setShowEdit] = useState<typeof reports[0] | null>(null);
  const [formName, setFormName] = useState(""); const [formFormat, setFormFormat] = useState("标准"); const [formFormula, setFormFormula] = useState("系统预设");
  const resetForm = () => { setFormName(""); setFormFormat("标准"); setFormFormula("系统预设"); };
  const handleAdd = () => { if (!formName) { toast.error("请填写报表名称"); return; } setReports(p => [...p, { id: Math.max(...p.map(r => r.id), 0) + 1, name: formName, format: formFormat, formula: formFormula, status: "草稿" }]); setShowAdd(false); resetForm(); toast.success("报表创建成功", { description: formName }); };
  const handleEditSave = () => { if (!showEdit) return; setReports(p => p.map(r => r.id === showEdit.id ? { ...showEdit } : r)); toast.success("报表配置已更新", { description: showEdit.name }); setShowEdit(null); };
  const bb = <button onClick={goBack} className="flex items-center gap-1 px-3 py-1.5 border border-border rounded-lg hover:bg-muted text-[13px]"><ChevronRight className="w-4 h-4 rotate-180" /> 返回设置</button>;
  return (
    <div className="space-y-4"><div className="flex items-center text-muted-foreground text-[13px]"><span>财务中心</span><ChevronRight className="w-4 h-4 mx-1" /><span>财务设置</span><ChevronRight className="w-4 h-4 mx-1" /><span className="text-foreground">自定义报表</span></div>
      <div className="flex items-center gap-3">{bb}<h2>自定义报表</h2></div>
      <div className="bg-white rounded-xl border border-border shadow-sm p-5">
        <div className="flex justify-end mb-4"><button onClick={()=>{resetForm();setShowAdd(true);}} className="flex items-center gap-1.5 px-4 py-2 bg-primary text-white rounded-lg hover:bg-primary/90"><Plus className="w-4 h-4" /> 新建报表</button></div>
        <div className="overflow-x-auto border border-border rounded-lg"><table className="w-full text-[13px]"><thead className="bg-muted/60"><tr><th className="py-3 px-3 text-left text-muted-foreground" style={{fontWeight:500}}>报表名称</th><th className="py-3 px-3 text-center text-muted-foreground" style={{fontWeight:500}}>格式</th><th className="py-3 px-3 text-left text-muted-foreground" style={{fontWeight:500}}>计算公式</th><th className="py-3 px-3 text-center text-muted-foreground" style={{fontWeight:500}}>状态</th><th className="py-3 px-3 text-center text-muted-foreground" style={{fontWeight:500}}>操作</th></tr></thead>
        <tbody>{reports.map(r => (<tr key={r.id} className="border-t border-border/50 hover:bg-green-50/30"><td className="py-2.5 px-3" style={{fontWeight:500}}>{r.name}</td><td className="py-2.5 px-3 text-center"><span className={`px-2 py-0.5 rounded text-[12px] ${r.format==="标准"?"bg-blue-50 text-blue-600":"bg-purple-50 text-purple-600"}`}>{r.format}</span></td><td className="py-2.5 px-3 text-muted-foreground">{r.formula}</td><td className="py-2.5 px-3 text-center"><span className={`px-2 py-0.5 rounded-full text-[12px] ${r.status==="启用"?"bg-green-50 text-green-600":"bg-gray-100 text-gray-500"}`}>{r.status}</span></td><td className="py-2.5 px-3 text-center"><button onClick={()=>setShowEdit({...r})} className="px-3 py-1 border border-border rounded text-[12px] hover:bg-muted">编辑</button></td></tr>))}</tbody></table></div>
        <div className="flex justify-end mt-4"><button onClick={()=>toast.success("报表配置已保存")} className="px-4 py-2 bg-primary text-white rounded-lg hover:bg-primary/90">保存</button></div>
      </div>
      <Modal open={showAdd} onClose={() => setShowAdd(false)} title="新建报表"><div className="space-y-4">
        <div><label className="block text-[13px] text-muted-foreground mb-1">报表名称 *</label><input value={formName} onChange={e => setFormName(e.target.value)} placeholder="如：专项资金使用报表" className="bg-muted rounded-lg px-3 py-2 outline-none w-full" /></div>
        <div className="grid grid-cols-2 gap-4"><div><label className="block text-[13px] text-muted-foreground mb-1">格式</label><select value={formFormat} onChange={e => setFormFormat(e.target.value)} className="bg-muted rounded-lg px-3 py-2 outline-none w-full"><option>标准</option><option>自定义</option></select></div><div><label className="block text-[13px] text-muted-foreground mb-1">计算公式</label><select value={formFormula} onChange={e => setFormFormula(e.target.value)} className="bg-muted rounded-lg px-3 py-2 outline-none w-full"><option>系统预设</option><option>自定义公式</option></select></div></div>
        <div className="flex justify-end gap-3 pt-2"><button onClick={() => setShowAdd(false)} className="px-4 py-2 border border-border rounded-lg hover:bg-muted">取消</button><button onClick={handleAdd} className="px-4 py-2 bg-primary text-white rounded-lg hover:bg-primary/90">保存</button></div>
      </div></Modal>
      <Modal open={!!showEdit} onClose={() => setShowEdit(null)} title="编辑报表">{showEdit && (<div className="space-y-4">
        <div><label className="block text-[13px] text-muted-foreground mb-1">报表名称</label><input value={showEdit.name} onChange={e => setShowEdit({...showEdit, name: e.target.value})} className="bg-muted rounded-lg px-3 py-2 outline-none w-full" /></div>
        <div className="grid grid-cols-2 gap-4"><div><label className="block text-[13px] text-muted-foreground mb-1">格式</label><select value={showEdit.format} onChange={e => setShowEdit({...showEdit, format: e.target.value})} className="bg-muted rounded-lg px-3 py-2 outline-none w-full"><option>标准</option><option>自定义</option></select></div><div><label className="block text-[13px] text-muted-foreground mb-1">状态</label><select value={showEdit.status} onChange={e => setShowEdit({...showEdit, status: e.target.value})} className="bg-muted rounded-lg px-3 py-2 outline-none w-full"><option>启用</option><option>草稿</option><option>停用</option></select></div></div>
        <div className="flex justify-end gap-3 pt-2"><button onClick={() => setShowEdit(null)} className="px-4 py-2 border border-border rounded-lg hover:bg-muted">取消</button><button onClick={handleEditSave} className="px-4 py-2 bg-primary text-white rounded-lg hover:bg-primary/90">保存</button></div>
      </div>)}</Modal>
    </div>
  );
}

function InitialBalancePage({ goBack }: { goBack: () => void }) {
  const [balances, setBalances] = useState([
    { code: "1001", name: "库存现金", debit: 12500, credit: 0 },{ code: "1002", name: "银行存款", debit: 1687650, credit: 0 },{ code: "1131", name: "应收款", debit: 45000, credit: 0 },{ code: "1501", name: "固定资产", debit: 3200000, credit: 0 },{ code: "2101", name: "应付款", debit: 0, credit: 85000 },{ code: "3101", name: "资本", debit: 0, credit: 4800000 },
  ]);
  const [editingCode, setEditingCode] = useState<string | null>(null);
  const [editDebit, setEditDebit] = useState(""); const [editCredit, setEditCredit] = useState("");
  const totalDebit = balances.reduce((s, b) => s + b.debit, 0); const totalCredit = balances.reduce((s, b) => s + b.credit, 0);
  const startEdit = (b: typeof balances[0]) => { setEditingCode(b.code); setEditDebit(String(b.debit)); setEditCredit(String(b.credit)); };
  const saveEdit = () => { if (!editingCode) return; setBalances(p => p.map(b => b.code === editingCode ? { ...b, debit: parseFloat(editDebit) || 0, credit: parseFloat(editCredit) || 0 } : b)); toast.success("已更新", { description: `${editingCode} 期初余额已修改` }); setEditingCode(null); };
  const bb = <button onClick={goBack} className="flex items-center gap-1 px-3 py-1.5 border border-border rounded-lg hover:bg-muted text-[13px]"><ChevronRight className="w-4 h-4 rotate-180" /> 返回设置</button>;
  return (
    <div className="space-y-4"><div className="flex items-center text-muted-foreground text-[13px]"><span>财务中心</span><ChevronRight className="w-4 h-4 mx-1" /><span>财务设置</span><ChevronRight className="w-4 h-4 mx-1" /><span className="text-foreground">期初设置</span></div>
      <div className="flex items-center gap-3">{bb}<h2>期初余额设置</h2></div>
      <div className="bg-amber-50 border border-amber-200 rounded-lg p-3 text-[13px] text-amber-700">提示：期初余额设置将影响所有报表的年初数据，请谨慎操作。当前会计期间：2026年1月。点击行内"编辑"按钮可修改金额。</div>
      <div className="bg-white rounded-xl border border-border shadow-sm p-5">
        <div className="overflow-x-auto border border-border rounded-lg"><table className="w-full text-[13px]"><thead className="bg-muted/60"><tr><th className="py-3 px-3 text-left text-muted-foreground" style={{fontWeight:500}}>科目编码</th><th className="py-3 px-3 text-left text-muted-foreground" style={{fontWeight:500}}>科目名称</th><th className="py-3 px-3 text-right text-muted-foreground" style={{fontWeight:500}}>期初借方</th><th className="py-3 px-3 text-right text-muted-foreground" style={{fontWeight:500}}>期初贷方</th><th className="py-3 px-3 text-center text-muted-foreground" style={{fontWeight:500}}>操作</th></tr></thead>
        <tbody>{balances.map(b => (
          <tr key={b.code} className="border-t border-border/50 hover:bg-green-50/30">
            <td className="py-2.5 px-3 text-primary">{b.code}</td><td className="py-2.5 px-3">{b.name}</td>
            {editingCode === b.code ? (<><td className="py-1.5 px-3 text-right"><input type="number" value={editDebit} onChange={e => setEditDebit(e.target.value)} className="bg-muted rounded px-2 py-1 w-32 text-right outline-none" /></td><td className="py-1.5 px-3 text-right"><input type="number" value={editCredit} onChange={e => setEditCredit(e.target.value)} className="bg-muted rounded px-2 py-1 w-32 text-right outline-none" /></td><td className="py-2.5 px-3 text-center"><button onClick={saveEdit} className="px-3 py-1 bg-primary text-white rounded text-[12px] hover:bg-primary/90 mr-1">确定</button><button onClick={() => setEditingCode(null)} className="px-3 py-1 border border-border rounded text-[12px] hover:bg-muted">取消</button></td></>) : (<><td className="py-2.5 px-3 text-right">{b.debit > 0 ? `¥ ${b.debit.toLocaleString()}` : "-"}</td><td className="py-2.5 px-3 text-right">{b.credit > 0 ? `¥ ${b.credit.toLocaleString()}` : "-"}</td><td className="py-2.5 px-3 text-center"><button onClick={() => startEdit(b)} className="px-3 py-1 border border-border rounded text-[12px] hover:bg-muted">编辑</button></td></>)}
          </tr>
        ))}</tbody>
        <tfoot className="bg-muted/30"><tr className="border-t border-border"><td colSpan={2} className="py-2.5 px-3 text-right" style={{fontWeight:500}}>合计</td><td className="py-2.5 px-3 text-right" style={{fontWeight:500}}>¥ {totalDebit.toLocaleString()}</td><td className="py-2.5 px-3 text-right" style={{fontWeight:500}}>¥ {totalCredit.toLocaleString()}</td><td></td></tr></tfoot></table></div>
        <div className="flex items-center justify-between mt-4 pt-4 border-t border-border">
          <span className="text-[13px]">{totalDebit === totalCredit ? <span className="text-green-600">✓ 借贷平衡</span> : <span className="text-red-500">✗ 借贷不平衡，差额 ¥{Math.abs(totalDebit - totalCredit).toLocaleString()}</span>}</span>
          <button onClick={() => toast.success("期初余额已保存", { description: `借方合计 ¥${totalDebit.toLocaleString()} | 贷方合计 ¥${totalCredit.toLocaleString()}` })} className="px-4 py-2 bg-primary text-white rounded-lg hover:bg-primary/90">保存</button>
        </div>
      </div>
    </div>
  );
}

// =============== FINANCE SETTINGS ===============

export function FinanceSettings() {
  const [activePage, setActivePage] = useState<string | null>(null);
  const [basicInfo, setBasicInfo] = useState({ orgName: "椰林村集体经济组织", code: "469002106201", address: "海南省琼海市博鳌镇椰林村", legalPerson: "符国强", phone: "0898-62921000", accountant: "符会计", cashier: "王出纳" });

  const settingCards = [
    { title: "基础信息", desc: "设置村集体基本信息、编制单位等", icon: Settings, key: "basic" },
    { title: "账套管理", desc: "管理账套名称、会计期间、记账本位币", icon: BookOpen, key: "accountSet" },
    { title: "会计科目", desc: "设置科目编码、名称、类型、余额方向", icon: FileSpreadsheet, key: "subjects" },
    { title: "凭证模板", desc: "预设常见业务类型的凭证模板", icon: FileText, key: "templates" },
    { title: "自定义报表", desc: "自定义报表格式、内容和计算公式", icon: BarChart3, key: "reports" },
    { title: "期初设置", desc: "录入资产、负债、权益等期初余额", icon: ArrowRightLeft, key: "initialBalance" },
  ];

  const backBtn = <button onClick={() => setActivePage(null)} className="flex items-center gap-1 px-3 py-1.5 border border-border rounded-lg hover:bg-muted text-[13px]"><ChevronRight className="w-4 h-4 rotate-180" /> 返回设置</button>;
  const crumb = (sub: string) => <div className="flex items-center text-muted-foreground text-[13px]"><span>财务中心</span><ChevronRight className="w-4 h-4 mx-1" /><span>财务设置</span><ChevronRight className="w-4 h-4 mx-1" /><span className="text-foreground">{sub}</span></div>;

  if (activePage === "basic") return (
    <div className="space-y-4">{crumb("基础信息")}<div className="flex items-center gap-3">{backBtn}<h2>基础信息</h2></div>
      <div className="bg-white rounded-xl border border-border shadow-sm p-6 max-w-3xl">
        <div className="grid grid-cols-1 md:grid-cols-2 gap-5">
          {([["orgName","单位名称"],["code","统一社会信用代码"],["address","单位地址"],["legalPerson","法定代表人"],["phone","联系电话"],["accountant","会计"],["cashier","出纳"]] as const).map(([k,l]) => (
            <div key={k}><label className="block text-[13px] text-muted-foreground mb-1">{l}</label><input value={basicInfo[k]} onChange={e => setBasicInfo({...basicInfo,[k]:e.target.value})} className="bg-muted rounded-lg px-3 py-2 outline-none w-full" /></div>
          ))}
        </div>
        <div className="flex justify-end gap-3 mt-6 pt-4 border-t border-border">
          <button onClick={() => setActivePage(null)} className="px-4 py-2 border border-border rounded-lg hover:bg-muted">取消</button>
          <button onClick={() => toast.success("基础信息已保存")} className="px-4 py-2 bg-primary text-white rounded-lg hover:bg-primary/90">保存</button>
        </div>
      </div>
    </div>
  );

  if (activePage === "accountSet") return <AccountSetPage goBack={() => setActivePage(null)} />;
  if (activePage === "subjects") return <SubjectsPage goBack={() => setActivePage(null)} />;
  if (activePage === "templates") return <TemplatesPage goBack={() => setActivePage(null)} />;
  if (activePage === "reports") return <ReportsPage goBack={() => setActivePage(null)} />;
  if (activePage === "initialBalance") return <InitialBalancePage goBack={() => setActivePage(null)} />;

  /*
  DEAD CODE REMOVED - old inline sub-pages replaced by dedicated components above
  if (activePage === "subjects") return (
    <div className="space-y-4">{crumb("会计科目")}<div className="flex items-center gap-3">{backBtn}<h2>会计科目</h2></div>
      <div className="bg-white rounded-xl border border-border shadow-sm p-5">
        <div className="flex justify-between mb-4"><div className="relative"><Search className="w-4 h-4 absolute left-3 top-1/2 -translate-y-1/2 text-muted-foreground" /><input placeholder="搜索科目..." className="pl-9 pr-4 py-2 bg-muted rounded-lg w-[200px] outline-none" /></div><button onClick={()=>toast.success("新增科目���功")} className="flex items-center gap-1.5 px-4 py-2 bg-primary text-white rounded-lg hover:bg-primary/90"><Plus className="w-4 h-4" /> 新增科目</button></div>
        <div className="overflow-x-auto border border-border rounded-lg"><table className="w-full text-[13px]"><thead className="bg-muted/60"><tr><th className="py-3 px-3 text-left text-muted-foreground" style={{fontWeight:500}}>科目编码</th><th className="py-3 px-3 text-left text-muted-foreground" style={{fontWeight:500}}>科目名称</th><th className="py-3 px-3 text-center text-muted-foreground" style={{fontWeight:500}}>类型</th><th className="py-3 px-3 text-center text-muted-foreground" style={{fontWeight:500}}>余额方向</th><th className="py-3 px-3 text-center text-muted-foreground" style={{fontWeight:500}}>级次</th><th className="py-3 px-3 text-center text-muted-foreground" style={{fontWeight:500}}>操作</th></tr></thead>
        <tbody>{subjectsList.map(s => (<tr key={s.code} className="border-t border-border/50 hover:bg-green-50/30"><td className="py-2.5 px-3 text-primary">{s.code}</td><td className="py-2.5 px-3">{s.name}</td><td className="py-2.5 px-3 text-center"><span className={`px-2 py-0.5 rounded text-[12px] ${s.type==="资产"?"bg-blue-50 text-blue-600":s.type==="负债"?"bg-red-50 text-red-500":s.type==="损益"?"bg-amber-50 text-amber-600":"bg-green-50 text-green-600"}`}>{s.type}</span></td><td className="py-2.5 px-3 text-center"><span className={`px-2 py-0.5 rounded text-[12px] ${s.direction==="借"?"bg-blue-50 text-blue-600":"bg-green-50 text-green-600"}`}>{s.direction}</span></td><td className="py-2.5 px-3 text-center">{s.level}级</td><td className="py-2.5 px-3 text-center"><button onClick={()=>toast.info("编辑科目",{description:`${s.code} ${s.name}`})} className="px-3 py-1 border border-border rounded text-[12px] hover:bg-muted">编辑</button></td></tr>))}</tbody></table></div>
      </div>
    </div>
  );

  if (activePage === "templates") return (
    <div className="space-y-4">{crumb("凭证模板")}<div className="flex items-center gap-3">{backBtn}<h2>凭证模板</h2></div>
      <div className="bg-white rounded-xl border border-border shadow-sm p-5">
        <div className="flex justify-end mb-4"><button onClick={()=>toast.success("模板创建成功")} className="flex items-center gap-1.5 px-4 py-2 bg-primary text-white rounded-lg hover:bg-primary/90"><Plus className="w-4 h-4" /> 新增模板</button></div>
        <div className="overflow-x-auto border border-border rounded-lg"><table className="w-full text-[13px]"><thead className="bg-muted/60"><tr><th className="py-3 px-3 text-left text-muted-foreground" style={{fontWeight:500}}>模板名称</th><th className="py-3 px-3 text-left text-muted-foreground" style={{fontWeight:500}}>借方科目</th><th className="py-3 px-3 text-left text-muted-foreground" style={{fontWeight:500}}>贷方科目</th><th className="py-3 px-3 text-center text-muted-foreground" style={{fontWeight:500}}>使用次数</th><th className="py-3 px-3 text-center text-muted-foreground" style={{fontWeight:500}}>操作</th></tr></thead>
        <tbody>{templatesList.map(t => (<tr key={t.id} className="border-t border-border/50 hover:bg-green-50/30"><td className="py-2.5 px-3" style={{fontWeight:500}}>{t.name}</td><td className="py-2.5 px-3 text-muted-foreground">{t.ds}</td><td className="py-2.5 px-3 text-muted-foreground">{t.cs}</td><td className="py-2.5 px-3 text-center">{t.usage}次</td><td className="py-2.5 px-3 text-center"><button onClick={()=>toast.info("编辑模板",{description:t.name})} className="px-3 py-1 border border-border rounded text-[12px] hover:bg-muted mr-1">编辑</button><button onClick={()=>toast.success("模板已删除")} className="px-3 py-1 border border-red-200 text-red-500 rounded text-[12px] hover:bg-red-50">删除</button></td></tr>))}</tbody></table></div>
      </div>
    </div>
  );

  if (activePage === "reports") return (
    <div className="space-y-4">{crumb("自定义报表")}<div className="flex items-center gap-3">{backBtn}<h2>自定义报表</h2></div>
      <div className="bg-white rounded-xl border border-border shadow-sm p-5">
        <div className="flex justify-end mb-4"><button onClick={()=>toast.success("报表创建成功")} className="flex items-center gap-1.5 px-4 py-2 bg-primary text-white rounded-lg hover:bg-primary/90"><Plus className="w-4 h-4" /> 新建报表</button></div>
        <div className="overflow-x-auto border border-border rounded-lg"><table className="w-full text-[13px]"><thead className="bg-muted/60"><tr><th className="py-3 px-3 text-left text-muted-foreground" style={{fontWeight:500}}>报表名称</th><th className="py-3 px-3 text-center text-muted-foreground" style={{fontWeight:500}}>格式</th><th className="py-3 px-3 text-left text-muted-foreground" style={{fontWeight:500}}>计算公式</th><th className="py-3 px-3 text-center text-muted-foreground" style={{fontWeight:500}}>状态</th><th className="py-3 px-3 text-center text-muted-foreground" style={{fontWeight:500}}>操作</th></tr></thead>
        <tbody>{reportsList.map(r => (<tr key={r.id} className="border-t border-border/50 hover:bg-green-50/30"><td className="py-2.5 px-3" style={{fontWeight:500}}>{r.name}</td><td className="py-2.5 px-3 text-center"><span className={`px-2 py-0.5 rounded text-[12px] ${r.format==="标准"?"bg-blue-50 text-blue-600":"bg-purple-50 text-purple-600"}`}>{r.format}</span></td><td className="py-2.5 px-3 text-muted-foreground">{r.formula}</td><td className="py-2.5 px-3 text-center"><span className={`px-2 py-0.5 rounded-full text-[12px] ${r.status==="启用"?"bg-green-50 text-green-600":"bg-gray-100 text-gray-500"}`}>{r.status}</span></td><td className="py-2.5 px-3 text-center"><button onClick={()=>toast.info("编辑报表",{description:r.name})} className="px-3 py-1 border border-border rounded text-[12px] hover:bg-muted">编辑</button></td></tr>))}</tbody></table></div>
      </div>
    </div>
  );

  if (activePage === "initialBalance") return (
    <div className="space-y-4">{crumb("期初设置")}<div className="flex items-center gap-3">{backBtn}<h2>期初余额设置</h2></div>
      <div className="bg-amber-50 border border-amber-200 rounded-lg p-3 text-[13px] text-amber-700">提示：期初余额设置将影响所有报表的年初数据，请谨慎操作。当前会计期间：2026年1月。</div>
      <div className="bg-white rounded-xl border border-border shadow-sm p-5">
        <div className="overflow-x-auto border border-border rounded-lg"><table className="w-full text-[13px]"><thead className="bg-muted/60"><tr><th className="py-3 px-3 text-left text-muted-foreground" style={{fontWeight:500}}>科目编码</th><th className="py-3 px-3 text-left text-muted-foreground" style={{fontWeight:500}}>科目名称</th><th className="py-3 px-3 text-right text-muted-foreground" style={{fontWeight:500}}>期初借方</th><th className="py-3 px-3 text-right text-muted-foreground" style={{fontWeight:500}}>期初贷方</th></tr></thead>
        <tbody>{initBalances.map(b => (<tr key={b.code} className="border-t border-border/50 hover:bg-green-50/30"><td className="py-2.5 px-3 text-primary">{b.code}</td><td className="py-2.5 px-3">{b.name}</td><td className="py-2.5 px-3 text-right">{b.debit>0?`¥ ${b.debit.toLocaleString()}`:"-"}</td><td className="py-2.5 px-3 text-right">{b.credit>0?`¥ ${b.credit.toLocaleString()}`:"-"}</td></tr>))}</tbody>
        <tfoot className="bg-muted/30"><tr className="border-t border-border"><td colSpan={2} className="py-2.5 px-3 text-right" style={{fontWeight:500}}>合计</td><td className="py-2.5 px-3 text-right" style={{fontWeight:500}}>¥ {initBalances.reduce((s,b)=>s+b.debit,0).toLocaleString()}</td><td className="py-2.5 px-3 text-right" style={{fontWeight:500}}>¥ {initBalances.reduce((s,b)=>s+b.credit,0).toLocaleString()}</td></tr></tfoot></table></div>
        <div className="flex items-center justify-between mt-4 pt-4 border-t border-border">
          <span className="text-[13px]">{initBalances.reduce((s,b)=>s+b.debit,0)===initBalances.reduce((s,b)=>s+b.credit,0)?<span className="text-green-600">✓ 借贷平衡</span>:<span className="text-red-500">✗ 借贷不平衡</span>}</span>
          <button onClick={()=>toast.success("期初余额已保存")} className="px-4 py-2 bg-primary text-white rounded-lg hover:bg-primary/90">保存</button>
        </div>
      </div>
    </div>
  );
  END DEAD CODE */

  return (
    <div className="space-y-4">
      <div className="flex items-center text-muted-foreground text-[13px]">
        <span>财务中心</span><ChevronRight className="w-4 h-4 mx-1" /><span className="text-foreground">财务设置</span>
      </div>
      <h2>财务设置</h2>
      <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-4">
        {settingCards.map(card => {
          const Icon = card.icon;
          return (
            <div key={card.title} className="bg-white rounded-xl p-5 border border-border shadow-sm hover:shadow-md hover:border-primary/30 transition-all cursor-pointer group" onClick={() => setActivePage(card.key)}>
              <div className="flex items-start gap-4">
                <div className="w-12 h-12 rounded-xl bg-primary/5 flex items-center justify-center group-hover:bg-primary/10 transition-colors"><Icon className="w-6 h-6 text-primary" /></div>
                <div><h3>{card.title}</h3><p className="text-[13px] text-muted-foreground mt-1">{card.desc}</p></div>
              </div>
            </div>
          );
        })}
      </div>
    </div>
  );
}