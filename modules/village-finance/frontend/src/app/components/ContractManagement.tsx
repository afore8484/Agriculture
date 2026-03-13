import { useState } from "react";
import { toast } from "sonner";
import { Modal, ConfirmDialog } from "./ui/Modal";
import {
  ChevronRight, Plus, Search, Download, Upload, Printer, Trash2, Edit, Eye, Filter,
  FileText, CheckCircle, XCircle, Clock, RefreshCw, DollarSign, AlertCircle
} from "lucide-react";
import { BarChart, Bar, XAxis, YAxis, CartesianGrid, Tooltip, ResponsiveContainer, Legend, PieChart, Pie, Cell } from "recharts";

const contractData = [
  { id: 1, no: "HT-2026-001", name: "美丽乡村建设工程合同", party: "琼海宏达建设有限公司", signDate: "2026-01-15", amount: 480000, period: "2026-01-15至2026-12-31", status: "履行中", paid: 144000 },
  { id: 2, no: "HT-2026-002", name: "椰林大道绿化养护合同", party: "海南绿源园林公司", signDate: "2026-02-01", amount: 95000, period: "2026-02-01至2027-01-31", status: "履行中", paid: 23750 },
  { id: 3, no: "HT-2025-015", name: "槟榔园承包经营权合同", party: "符永昌", signDate: "2025-03-01", amount: 144000, period: "2025-03-01至2028-02-28", status: "履行中", paid: 48000 },
  { id: 4, no: "HT-2025-012", name: "办公设备采购合同", party: "琼海科信电脑城", signDate: "2025-09-20", amount: 32000, period: "2025-09-20至2025-10-20", status: "已完成", paid: 32000 },
  { id: 5, no: "HT-2025-010", name: "民宿合作经营合同", party: "陈大文", signDate: "2025-06-01", amount: 67200, period: "2025-06-01至2026-05-31", status: "履行中", paid: 50400 },
  { id: 6, no: "HT-2024-008", name: "农村污水处理工程合同", party: "海南碧水环保科技", signDate: "2024-08-10", amount: 220000, period: "2024-08-10至2025-08-10", status: "已终止", paid: 154000 },
];

export function ContractList() {
  const [contracts, setContracts] = useState(contractData);
  const [showAdd, setShowAdd] = useState(false);
  const [showDetail, setShowDetail] = useState<typeof contractData[0] | null>(null);
  const [showEdit, setShowEdit] = useState<typeof contractData[0] | null>(null);
  const [showPayment, setShowPayment] = useState<typeof contractData[0] | null>(null);
  const [showTerminate, setShowTerminate] = useState<typeof contractData[0] | null>(null);
  const [showRenew, setShowRenew] = useState<typeof contractData[0] | null>(null);
  const [showAcceptConfirm, setShowAcceptConfirm] = useState<typeof contractData[0] | null>(null);
  const [formData, setFormData] = useState({ name: "", party: "", amount: "", period: "" });
  const [payAmount, setPayAmount] = useState("");
  const [searchText, setSearchText] = useState("");
  const [statusFilter, setStatusFilter] = useState("全部状态");

  const filteredContracts = contracts.filter(c => {
    const matchSearch = !searchText || c.name.includes(searchText) || c.no.includes(searchText);
    const matchStatus = statusFilter === "全部状态" || c.status === statusFilter;
    return matchSearch && matchStatus;
  });

  const handleAddContract = () => {
    if (!formData.name || !formData.party || !formData.amount) { toast.error("请填写合同名称、签约方和金额"); return; }
    const newId = Math.max(...contracts.map(c => c.id), 0) + 1;
    const no = `HT-2026-${String(newId).padStart(3, "0")}`;
    const newContract = { id: newId + 100, no, name: formData.name, party: formData.party, signDate: "2026-03-09", amount: parseFloat(formData.amount) || 0, period: formData.period || "2026-03-09至2027-03-08", status: "履行中", paid: 0 };
    setContracts([newContract, ...contracts]);
    setShowAdd(false);
    setFormData({ name: "", party: "", amount: "", period: "" });
    toast.success("合同新增成功", { description: `${no} ${formData.name}` });
  };

  const handleEditContract = () => {
    if (!showEdit) return;
    setContracts(contracts.map(c => c.id === showEdit.id ? { ...showEdit } : c));
    toast.success("合同信息已更新", { description: showEdit.name });
    setShowEdit(null);
  };

  const handlePayment = () => {
    if (!showPayment || !payAmount) { toast.error("请输入收付款金额"); return; }
    const amount = parseFloat(payAmount) || 0;
    setContracts(contracts.map(c => c.id === showPayment.id ? { ...c, paid: c.paid + amount } : c));
    toast.success("收付款操作成功", { description: `${showPayment.name} 本次收付 ¥${amount.toLocaleString()}` });
    setShowPayment(null);
    setPayAmount("");
  };

  return (
    <div className="space-y-4">
      <div className="flex items-center text-muted-foreground text-[13px]">
        <span>合同管理</span><ChevronRight className="w-4 h-4 mx-1" /><span className="text-foreground">合同列表</span>
      </div>
      <div className="flex items-center justify-between">
        <h2>合同列表</h2>
        <div className="flex gap-2">
          <button onClick={() => setShowAdd(true)} className="flex items-center gap-1.5 px-4 py-2 bg-primary text-white rounded-lg hover:bg-primary/90"><Plus className="w-4 h-4" /> 新增合同</button>
          <button onClick={() => toast.info("请选择 Excel 文件上传")} className="flex items-center gap-1.5 px-3 py-2 border border-border rounded-lg hover:bg-muted text-[13px]"><Upload className="w-4 h-4" /> 导入</button>
          <button onClick={() => toast.success("导出成功", { description: "合同列表已导出为 Excel 文件" })} className="flex items-center gap-1.5 px-3 py-2 border border-border rounded-lg hover:bg-muted text-[13px]"><Download className="w-4 h-4" /> 导出</button>
        </div>
      </div>

      <div className="grid grid-cols-1 md:grid-cols-4 gap-4">
        {[
          { label: "合同总数", value: "6", icon: FileText, color: "#1a56db" },
          { label: "履行中", value: "4", icon: Clock, color: "#10b981" },
          { label: "合同总金额", value: "¥ 759,800", icon: DollarSign, color: "#f59e0b" },
          { label: "待收付款", value: "¥ 436,200", icon: AlertCircle, color: "#ef4444" },
        ].map((card) => {
          const Icon = card.icon;
          return (
            <div key={card.label} className="bg-white rounded-xl p-4 border border-border shadow-sm">
              <div className="flex items-center gap-3">
                <div className="w-10 h-10 rounded-lg flex items-center justify-center" style={{ backgroundColor: `${card.color}15` }}>
                  <Icon className="w-5 h-5" style={{ color: card.color }} />
                </div>
                <div>
                  <p className="text-[18px]" style={{ fontWeight: 600 }}>{card.value}</p>
                  <p className="text-[12px] text-muted-foreground">{card.label}</p>
                </div>
              </div>
            </div>
          );
        })}
      </div>

      <div className="bg-white rounded-xl border border-border shadow-sm p-5">
        <div className="flex flex-wrap gap-3 mb-4">
          <div className="relative">
            <Search className="w-4 h-4 absolute left-3 top-1/2 -translate-y-1/2 text-muted-foreground" />
            <input type="text" placeholder="搜索合同编号/名称..." value={searchText} onChange={e => setSearchText(e.target.value)} className="pl-9 pr-4 py-2 bg-muted rounded-lg w-[220px] outline-none" />
          </div>
          <select className="bg-muted rounded-lg px-3 py-2 outline-none" value={statusFilter} onChange={e => setStatusFilter(e.target.value)}><option>全部状态</option><option>履行中</option><option>已完成</option><option>已终止</option></select>
          <input type="date" className="bg-muted rounded-lg px-3 py-2 outline-none" />
          <button onClick={() => toast.info("已刷新筛选结果")} className="flex items-center gap-1.5 px-3 py-2 bg-primary text-white rounded-lg"><Filter className="w-4 h-4" /> 筛选</button>
        </div>

        <div className="overflow-x-auto border border-border rounded-lg">
          <table className="w-full text-[13px]">
            <thead className="bg-muted/60">
              <tr>
                <th className="py-3 px-3 text-left text-muted-foreground" style={{ fontWeight: 500 }}>合同编号</th>
                <th className="py-3 px-3 text-left text-muted-foreground" style={{ fontWeight: 500 }}>合同名称</th>
                <th className="py-3 px-3 text-left text-muted-foreground" style={{ fontWeight: 500 }}>签约方</th>
                <th className="py-3 px-3 text-left text-muted-foreground" style={{ fontWeight: 500 }}>签订日期</th>
                <th className="py-3 px-3 text-right text-muted-foreground" style={{ fontWeight: 500 }}>合同金额</th>
                <th className="py-3 px-3 text-right text-muted-foreground" style={{ fontWeight: 500 }}>已付/收</th>
                <th className="py-3 px-3 text-left text-muted-foreground" style={{ fontWeight: 500 }}>合同期限</th>
                <th className="py-3 px-3 text-center text-muted-foreground" style={{ fontWeight: 500 }}>状态</th>
                <th className="py-3 px-3 text-center text-muted-foreground" style={{ fontWeight: 500 }}>操作</th>
              </tr>
            </thead>
            <tbody>
              {filteredContracts.length === 0 ? (
                <tr><td colSpan={9} className="py-12 text-center text-muted-foreground">暂无匹配的合同记录</td></tr>
              ) : filteredContracts.map((row) => (
                <tr key={row.id} className="border-t border-border/50 hover:bg-blue-50/30">
                  <td className="py-2.5 px-3 text-primary cursor-pointer hover:underline" onClick={() => setShowDetail(row)}>{row.no}</td>
                  <td className="py-2.5 px-3">{row.name}</td>
                  <td className="py-2.5 px-3">{row.party}</td>
                  <td className="py-2.5 px-3 text-muted-foreground">{row.signDate}</td>
                  <td className="py-2.5 px-3 text-right" style={{ fontWeight: 500 }}>¥ {row.amount.toLocaleString()}</td>
                  <td className="py-2.5 px-3 text-right text-green-600">¥ {row.paid.toLocaleString()}</td>
                  <td className="py-2.5 px-3 text-[12px] text-muted-foreground">{row.period}</td>
                  <td className="py-2.5 px-3 text-center">
                    <span className={`px-2 py-0.5 rounded-full text-[12px] ${
                      row.status === "履行中" ? "bg-blue-50 text-blue-600" :
                      row.status === "已完成" ? "bg-green-50 text-green-600" :
                      "bg-gray-100 text-gray-500"
                    }`}>{row.status}</span>
                  </td>
                  <td className="py-2.5 px-3">
                    <div className="flex items-center justify-center gap-1">
                      <button onClick={() => setShowDetail(row)} className="p-1 hover:bg-muted rounded" title="查看"><Eye className="w-4 h-4 text-muted-foreground" /></button>
                      <button onClick={() => setShowEdit({ ...row })} className="p-1 hover:bg-muted rounded" title="编辑"><Edit className="w-4 h-4 text-muted-foreground" /></button>
                      <button onClick={() => setShowPayment(row)} className="p-1 hover:bg-muted rounded" title="收付款"><DollarSign className="w-4 h-4 text-green-500" /></button>
                      <button onClick={() => setShowAcceptConfirm(row)} className="p-1 hover:bg-muted rounded" title="验收"><CheckCircle className="w-4 h-4 text-blue-500" /></button>
                      <button onClick={() => setShowRenew(row)} className="p-1 hover:bg-muted rounded" title="续签"><RefreshCw className="w-3.5 h-3.5 text-amber-500" /></button>
                      <button onClick={() => setShowTerminate(row)} className="p-1 hover:bg-muted rounded" title="终止"><XCircle className="w-4 h-4 text-red-400" /></button>
                    </div>
                  </td>
                </tr>
              ))}
            </tbody>
          </table>
        </div>
      </div>

      {/* Add Contract Modal */}
      <Modal open={showAdd} onClose={() => setShowAdd(false)} title="新增合同" width="max-w-xl">
        <div className="space-y-4">
          <div><label className="block text-[13px] text-muted-foreground mb-1">合同名称 *</label><input type="text" value={formData.name} onChange={e => setFormData({ ...formData, name: e.target.value })} placeholder="请输入合同名称" className="bg-muted rounded-lg px-3 py-2 outline-none w-full" /></div>
          <div><label className="block text-[13px] text-muted-foreground mb-1">签约方 *</label><input type="text" value={formData.party} onChange={e => setFormData({ ...formData, party: e.target.value })} placeholder="签约单位或个人" className="bg-muted rounded-lg px-3 py-2 outline-none w-full" /></div>
          <div className="grid grid-cols-2 gap-4">
            <div><label className="block text-[13px] text-muted-foreground mb-1">合同金额 *</label><input type="number" value={formData.amount} onChange={e => setFormData({ ...formData, amount: e.target.value })} placeholder="0.00" className="bg-muted rounded-lg px-3 py-2 outline-none w-full text-right" /></div>
            <div><label className="block text-[13px] text-muted-foreground mb-1">合同期限</label><input type="text" value={formData.period} onChange={e => setFormData({ ...formData, period: e.target.value })} placeholder="如：2026-01-01至2026-12-31" className="bg-muted rounded-lg px-3 py-2 outline-none w-full" /></div>
          </div>
          <div className="flex justify-end gap-3 pt-2">
            <button onClick={() => setShowAdd(false)} className="px-4 py-2 border border-border rounded-lg hover:bg-muted">取消</button>
            <button onClick={handleAddContract} className="px-4 py-2 bg-primary text-white rounded-lg hover:bg-primary/90">保存</button>
          </div>
        </div>
      </Modal>

      {/* Detail Modal */}
      <Modal open={!!showDetail} onClose={() => setShowDetail(null)} title="合同详情" width="max-w-xl">
        {showDetail && (
          <div className="space-y-3 text-[14px]">
            {[
              ["合同编号", showDetail.no],
              ["合同名称", showDetail.name],
              ["签约方", showDetail.party],
              ["签订日期", showDetail.signDate],
              ["合同金额", `¥ ${showDetail.amount.toLocaleString()}`],
              ["已付/收", `¥ ${showDetail.paid.toLocaleString()}`],
              ["未付/收", `¥ ${(showDetail.amount - showDetail.paid).toLocaleString()}`],
              ["合同期限", showDetail.period],
              ["状态", showDetail.status],
            ].map(([label, value]) => (
              <div key={label} className="flex"><span className="text-muted-foreground w-24 flex-shrink-0">{label}</span><span>{value}</span></div>
            ))}
            <div className="w-full bg-muted rounded-full h-2 mt-2">
              <div className="h-2 rounded-full bg-primary" style={{ width: `${Math.min(100, (showDetail.paid / showDetail.amount) * 100)}%` }} />
            </div>
            <p className="text-[12px] text-muted-foreground text-right">执行进度 {Math.round((showDetail.paid / showDetail.amount) * 100)}%</p>
          </div>
        )}
      </Modal>

      {/* Edit Modal */}
      <Modal open={!!showEdit} onClose={() => setShowEdit(null)} title="编辑合同" width="max-w-xl">
        {showEdit && (
          <div className="space-y-4">
            <div><label className="block text-[13px] text-muted-foreground mb-1">合同名称</label><input type="text" value={showEdit.name} onChange={e => setShowEdit({ ...showEdit, name: e.target.value })} className="bg-muted rounded-lg px-3 py-2 outline-none w-full" /></div>
            <div><label className="block text-[13px] text-muted-foreground mb-1">签约方</label><input type="text" value={showEdit.party} onChange={e => setShowEdit({ ...showEdit, party: e.target.value })} className="bg-muted rounded-lg px-3 py-2 outline-none w-full" /></div>
            <div><label className="block text-[13px] text-muted-foreground mb-1">状态</label><select value={showEdit.status} onChange={e => setShowEdit({ ...showEdit, status: e.target.value })} className="bg-muted rounded-lg px-3 py-2 outline-none w-full"><option>履行中</option><option>已完成</option><option>已终止</option></select></div>
            <div className="flex justify-end gap-3 pt-2">
              <button onClick={() => setShowEdit(null)} className="px-4 py-2 border border-border rounded-lg hover:bg-muted">取消</button>
              <button onClick={handleEditContract} className="px-4 py-2 bg-primary text-white rounded-lg hover:bg-primary/90">保存</button>
            </div>
          </div>
        )}
      </Modal>

      {/* Payment Modal */}
      <Modal open={!!showPayment} onClose={() => { setShowPayment(null); setPayAmount(""); }} title="收付款管理">
        {showPayment && (
          <div className="space-y-4">
            <div className="bg-blue-50 rounded-lg p-4 text-[14px]">
              <p style={{ fontWeight: 500 }}>{showPayment.name}</p>
              <p className="text-muted-foreground mt-1">合同金额：¥ {showPayment.amount.toLocaleString()} | 已付：¥ {showPayment.paid.toLocaleString()}</p>
              <p className="text-blue-600 mt-1">剩余未付：¥ {(showPayment.amount - showPayment.paid).toLocaleString()}</p>
            </div>
            <div><label className="block text-[13px] text-muted-foreground mb-1">本次收/付金额 *</label><input type="number" value={payAmount} onChange={e => setPayAmount(e.target.value)} placeholder="0.00" className="bg-muted rounded-lg px-3 py-2 outline-none w-full text-right" /></div>
            <div className="flex justify-end gap-3 pt-2">
              <button onClick={() => { setShowPayment(null); setPayAmount(""); }} className="px-4 py-2 border border-border rounded-lg hover:bg-muted">取消</button>
              <button onClick={handlePayment} className="px-4 py-2 bg-primary text-white rounded-lg hover:bg-primary/90">确认</button>
            </div>
          </div>
        )}
      </Modal>

      {/* Accept Confirm */}
      <ConfirmDialog open={!!showAcceptConfirm} onClose={() => setShowAcceptConfirm(null)} onConfirm={() => { if (showAcceptConfirm) { setContracts(contracts.map(c => c.id === showAcceptConfirm.id ? { ...c, status: "已完成" } : c)); toast.success("验收完成", { description: showAcceptConfirm.name }); setShowAcceptConfirm(null); } }} title="合同验收" message={showAcceptConfirm ? `确认对「${showAcceptConfirm.name}」进行验收？验收通过后合同状态将变为已完成。` : ""} confirmText="确认验收" type="info" />

      {/* Renew Modal */}
      <Modal open={!!showRenew} onClose={() => setShowRenew(null)} title="合同续签">
        {showRenew && (
          <div className="space-y-4">
            <div className="bg-amber-50 rounded-lg p-4 text-[14px]">
              <p style={{ fontWeight: 500 }}>{showRenew.name}</p>
              <p className="text-muted-foreground mt-1">签约方：{showRenew.party}</p>
              <p className="text-muted-foreground mt-1">当前期限：{showRenew.period}</p>
            </div>
            <div><label className="block text-[13px] text-muted-foreground mb-1">续签期限</label><input type="text" placeholder="如：2027-01-01至2027-12-31" className="bg-muted rounded-lg px-3 py-2 outline-none w-full" /></div>
            <div><label className="block text-[13px] text-muted-foreground mb-1">续签金额</label><input type="number" placeholder="0.00" className="bg-muted rounded-lg px-3 py-2 outline-none w-full text-right" /></div>
            <div className="flex justify-end gap-3 pt-2">
              <button onClick={() => setShowRenew(null)} className="px-4 py-2 border border-border rounded-lg hover:bg-muted">取消</button>
              <button onClick={() => { toast.success("续签成功", { description: showRenew.name }); setShowRenew(null); }} className="px-4 py-2 bg-primary text-white rounded-lg hover:bg-primary/90">确认续签</button>
            </div>
          </div>
        )}
      </Modal>

      {/* Terminate Confirm */}
      <ConfirmDialog open={!!showTerminate} onClose={() => setShowTerminate(null)} onConfirm={() => { if (showTerminate) { setContracts(contracts.map(c => c.id === showTerminate.id ? { ...c, status: "已终止" } : c)); toast.success("合同已终止", { description: showTerminate.name }); setShowTerminate(null); } }} title="终止合同" message={showTerminate ? `确定要终止「${showTerminate.name}」吗？\n签约方：${showTerminate.party}\n合同金额：¥ ${showTerminate.amount.toLocaleString()}\n\n终止后不可恢复。` : ""} confirmText="确认终止" type="danger" />
    </div>
  );
}

// Contract Change
export function ContractChange() {
  const [changes, setChanges] = useState([
    { id: 1, contractNo: "HT-2026-001", contractName: "美丽乡村建设工程合同", changeDate: "2026-02-20", content: "变更施工范围，增加椰风路段200米", reason: "村民代表大会决议", operator: "符国强" },
    { id: 2, contractNo: "HT-2025-015", contractName: "槟榔园承包经营权合同", changeDate: "2025-12-10", content: "调整承包面积，增加2亩", reason: "土地重新测量", operator: "王海燕" },
  ]);
  const [showAdd, setShowAdd] = useState(false);
  const [showDetail, setShowDetail] = useState<typeof changes[0] | null>(null);
  const [showEdit, setShowEdit] = useState<typeof changes[0] | null>(null);
  const [formData, setFormData] = useState({ contractNo: "", contractName: "", content: "", reason: "" });

  const handleAddChange = () => {
    if (!formData.contractNo || !formData.content) { toast.error("请填写合同编号和变更内容"); return; }
    const newChange = { id: changes.length + 10, contractNo: formData.contractNo, contractName: formData.contractName || formData.contractNo, changeDate: "2026-03-09", content: formData.content, reason: formData.reason, operator: "符会计" };
    setChanges([newChange, ...changes]);
    setShowAdd(false);
    setFormData({ contractNo: "", contractName: "", content: "", reason: "" });
    toast.success("变更记录已添加", { description: formData.contractNo });
  };

  return (
    <div className="space-y-4">
      <div className="flex items-center text-muted-foreground text-[13px]">
        <span>合同管理</span><ChevronRight className="w-4 h-4 mx-1" /><span className="text-foreground">合同变更</span>
      </div>
      <h2>合同变更管理</h2>
      <div className="bg-white rounded-xl border border-border shadow-sm p-5">
        <div className="flex gap-3 mb-4">
          <div className="relative">
            <Search className="w-4 h-4 absolute left-3 top-1/2 -translate-y-1/2 text-muted-foreground" />
            <input type="text" placeholder="搜索合同编号..." className="pl-9 pr-4 py-2 bg-muted rounded-lg w-[220px] outline-none" />
          </div>
          <button onClick={() => setShowAdd(true)} className="flex items-center gap-1.5 px-4 py-2 bg-primary text-white rounded-lg hover:bg-primary/90"><Plus className="w-4 h-4" /> 新增变更</button>
        </div>
        <div className="overflow-x-auto border border-border rounded-lg">
          <table className="w-full text-[13px]">
            <thead className="bg-muted/60">
              <tr>
                <th className="py-3 px-3 text-left text-muted-foreground" style={{ fontWeight: 500 }}>合同编号</th>
                <th className="py-3 px-3 text-left text-muted-foreground" style={{ fontWeight: 500 }}>合同名称</th>
                <th className="py-3 px-3 text-left text-muted-foreground" style={{ fontWeight: 500 }}>变更日期</th>
                <th className="py-3 px-3 text-left text-muted-foreground" style={{ fontWeight: 500 }}>变更内容</th>
                <th className="py-3 px-3 text-left text-muted-foreground" style={{ fontWeight: 500 }}>变更原因</th>
                <th className="py-3 px-3 text-left text-muted-foreground" style={{ fontWeight: 500 }}>操作人</th>
                <th className="py-3 px-3 text-center text-muted-foreground" style={{ fontWeight: 500 }}>操作</th>
              </tr>
            </thead>
            <tbody>
              {changes.map((row) => (
                <tr key={row.id} className="border-t border-border/50 hover:bg-blue-50/30">
                  <td className="py-2.5 px-3 text-primary">{row.contractNo}</td>
                  <td className="py-2.5 px-3">{row.contractName}</td>
                  <td className="py-2.5 px-3 text-muted-foreground">{row.changeDate}</td>
                  <td className="py-2.5 px-3">{row.content}</td>
                  <td className="py-2.5 px-3 text-muted-foreground">{row.reason}</td>
                  <td className="py-2.5 px-3">{row.operator}</td>
                  <td className="py-2.5 px-3">
                    <div className="flex items-center justify-center gap-1">
                      <button onClick={() => setShowDetail(row)} className="p-1 hover:bg-muted rounded"><Eye className="w-4 h-4 text-muted-foreground" /></button>
                      <button onClick={() => setShowEdit({ ...row })} className="p-1 hover:bg-muted rounded"><Edit className="w-4 h-4 text-muted-foreground" /></button>
                    </div>
                  </td>
                </tr>
              ))}
            </tbody>
          </table>
        </div>
      </div>

      {/* Add Change Modal */}
      <Modal open={showAdd} onClose={() => setShowAdd(false)} title="新增合同变更">
        <div className="space-y-4">
          <div><label className="block text-[13px] text-muted-foreground mb-1">合同编号 *</label><select value={formData.contractNo} onChange={e => setFormData({ ...formData, contractNo: e.target.value })} className="bg-muted rounded-lg px-3 py-2 outline-none w-full"><option value="">请选择合同</option><option value="HT-2026-001">HT-2026-001 美丽乡村建设工程合同</option><option value="HT-2026-002">HT-2026-002 椰林大道绿化养护合同</option><option value="HT-2025-015">HT-2025-015 槟榔园承包经营权合同</option></select></div>
          <div><label className="block text-[13px] text-muted-foreground mb-1">变更内容 *</label><textarea value={formData.content} onChange={e => setFormData({ ...formData, content: e.target.value })} placeholder="请描述变更内容" className="bg-muted rounded-lg px-3 py-2 outline-none w-full h-20 resize-none" /></div>
          <div><label className="block text-[13px] text-muted-foreground mb-1">变更原因</label><input type="text" value={formData.reason} onChange={e => setFormData({ ...formData, reason: e.target.value })} placeholder="变更原因" className="bg-muted rounded-lg px-3 py-2 outline-none w-full" /></div>
          <div className="flex justify-end gap-3 pt-2">
            <button onClick={() => setShowAdd(false)} className="px-4 py-2 border border-border rounded-lg hover:bg-muted">取消</button>
            <button onClick={handleAddChange} className="px-4 py-2 bg-primary text-white rounded-lg hover:bg-primary/90">保存</button>
          </div>
        </div>
      </Modal>

      {/* Detail Modal */}
      <Modal open={!!showDetail} onClose={() => setShowDetail(null)} title="变更详情">
        {showDetail && (
          <div className="space-y-3 text-[14px]">
            {[
              ["合同编号", showDetail.contractNo],
              ["合同名称", showDetail.contractName],
              ["变更日期", showDetail.changeDate],
              ["变更内容", showDetail.content],
              ["变更原因", showDetail.reason],
              ["操作人", showDetail.operator],
            ].map(([label, value]) => (
              <div key={label} className="flex"><span className="text-muted-foreground w-24 flex-shrink-0">{label}</span><span>{value}</span></div>
            ))}
          </div>
        )}
      </Modal>

      {/* Edit Modal */}
      <Modal open={!!showEdit} onClose={() => setShowEdit(null)} title="编辑变更记录">
        {showEdit && (
          <div className="space-y-4">
            <div><label className="block text-[13px] text-muted-foreground mb-1">变更内容</label><textarea value={showEdit.content} onChange={e => setShowEdit({ ...showEdit, content: e.target.value })} className="bg-muted rounded-lg px-3 py-2 outline-none w-full h-20 resize-none" /></div>
            <div><label className="block text-[13px] text-muted-foreground mb-1">变更原因</label><input type="text" value={showEdit.reason} onChange={e => setShowEdit({ ...showEdit, reason: e.target.value })} className="bg-muted rounded-lg px-3 py-2 outline-none w-full" /></div>
            <div className="flex justify-end gap-3 pt-2">
              <button onClick={() => setShowEdit(null)} className="px-4 py-2 border border-border rounded-lg hover:bg-muted">取消</button>
              <button onClick={() => { setChanges(changes.map(c => c.id === showEdit.id ? { ...showEdit } : c)); toast.success("变更记录已更新"); setShowEdit(null); }} className="px-4 py-2 bg-primary text-white rounded-lg hover:bg-primary/90">保存</button>
            </div>
          </div>
        )}
      </Modal>
    </div>
  );
}

// Contract Report
export function ContractReport() {
  const [tab, setTab] = useState("collection");
  const tabs = [
    { key: "collection", label: "收款报表" },
    { key: "payment", label: "付款报表" },
    { key: "overview", label: "收付款总览" },
  ];

  const paymentChartData = [
    { name: "道路工程", 合同金额: 35, 已付: 10.5, 未付: 24.5 },
    { name: "绿化养护", 合同金额: 8, 已付: 2, 未付: 6 },
    { name: "设备采购", 合同金额: 2.5, 已付: 2.5, 未付: 0 },
  ];

  const statusData = [
    { name: "履行中", value: 4, color: "#1a56db" },
    { name: "已完成", value: 1, color: "#10b981" },
    { name: "已终止", value: 1, color: "#9ca3af" },
  ];

  return (
    <div className="space-y-4">
      <div className="flex items-center text-muted-foreground text-[13px]">
        <span>合同管理</span><ChevronRight className="w-4 h-4 mx-1" /><span className="text-foreground">合同报表</span>
      </div>
      <h2>合同报表</h2>

      <div className="bg-white rounded-xl border border-border shadow-sm">
        <div className="flex border-b border-border">
          {tabs.map((t) => (
            <button key={t.key} className={`px-5 py-3 border-b-2 transition-colors ${tab === t.key ? "border-primary text-primary" : "border-transparent text-muted-foreground"}`} onClick={() => setTab(t.key)}>
              {t.label}
            </button>
          ))}
          <div className="flex-1" />
          <div className="flex items-center gap-2 px-4">
            <button onClick={() => toast.success("导出成功", { description: "合同报表已导出" })} className="flex items-center gap-1 px-3 py-1.5 border border-border rounded-lg hover:bg-muted text-[13px]"><Download className="w-3.5 h-3.5" /> 导出</button>
            <button onClick={() => { toast.info("正在生成打印预览..."); setTimeout(() => toast.success("打印预览已生成"), 800); }} className="flex items-center gap-1 px-3 py-1.5 border border-border rounded-lg hover:bg-muted text-[13px]"><Printer className="w-3.5 h-3.5" /> 打印</button>
          </div>
        </div>
        <div className="p-5">
          <div className="grid grid-cols-1 lg:grid-cols-3 gap-4 mb-6">
            <div className="lg:col-span-2">
              <h3 className="mb-4">合同收付款对比（万元）</h3>
              <ResponsiveContainer width="100%" height={280}>
                <BarChart data={paymentChartData}>
                  <CartesianGrid strokeDasharray="3 3" stroke="#f0f0f0" />
                  <XAxis dataKey="name" axisLine={false} tickLine={false} />
                  <YAxis axisLine={false} tickLine={false} />
                  <Tooltip />
                  <Legend />
                  <Bar dataKey="合同金额" fill="#1a56db" barSize={20} radius={[4, 4, 0, 0]} />
                  <Bar dataKey="已付" fill="#10b981" barSize={20} radius={[4, 4, 0, 0]} />
                  <Bar dataKey="未付" fill="#f59e0b" barSize={20} radius={[4, 4, 0, 0]} />
                </BarChart>
              </ResponsiveContainer>
            </div>
            <div>
              <h3 className="mb-4">合同状态分布</h3>
              <ResponsiveContainer width="100%" height={200}>
                <PieChart>
                  <Pie data={statusData} cx="50%" cy="50%" innerRadius={40} outerRadius={70} dataKey="value" stroke="none">
                    {statusData.map((entry) => <Cell key={entry.name} fill={entry.color} />)}
                  </Pie>
                  <Tooltip />
                </PieChart>
              </ResponsiveContainer>
              <div className="space-y-2 mt-2">
                {statusData.map((item) => (
                  <div key={item.name} className="flex items-center justify-between text-[13px]">
                    <div className="flex items-center gap-2">
                      <div className="w-3 h-3 rounded-sm" style={{ backgroundColor: item.color }} />
                      <span>{item.name}</span>
                    </div>
                    <span>{item.value} 份</span>
                  </div>
                ))}
              </div>
            </div>
          </div>

          {/* Table Details */}
          <h3 className="mb-3">{tab === "collection" ? "收款明细" : tab === "payment" ? "付款明细" : "收付款总览"}</h3>
          <div className="overflow-x-auto border border-border rounded-lg">
            {tab === "collection" && (
              <table className="w-full text-[13px]"><thead className="bg-muted/60"><tr><th className="py-3 px-3 text-left text-muted-foreground" style={{ fontWeight: 500 }}>合同编号</th><th className="py-3 px-3 text-left text-muted-foreground" style={{ fontWeight: 500 }}>合同名称</th><th className="py-3 px-3 text-left text-muted-foreground" style={{ fontWeight: 500 }}>付款方</th><th className="py-3 px-3 text-right text-muted-foreground" style={{ fontWeight: 500 }}>应收金额</th><th className="py-3 px-3 text-right text-muted-foreground" style={{ fontWeight: 500 }}>已收金额</th><th className="py-3 px-3 text-right text-muted-foreground" style={{ fontWeight: 500 }}>未收金额</th></tr></thead>
              <tbody>{[{ no: "HT-2025-015", name: "槟榔园承包经营权合同", party: "符永昌", total: 144000, paid: 48000 },{ no: "HT-2025-010", name: "民宿合作经营合同", party: "陈大文", total: 67200, paid: 50400 }].map(r => (<tr key={r.no} className="border-t border-border/50 hover:bg-green-50/30"><td className="py-2.5 px-3 text-primary">{r.no}</td><td className="py-2.5 px-3">{r.name}</td><td className="py-2.5 px-3">{r.party}</td><td className="py-2.5 px-3 text-right">¥ {r.total.toLocaleString()}</td><td className="py-2.5 px-3 text-right text-green-600">¥ {r.paid.toLocaleString()}</td><td className="py-2.5 px-3 text-right text-amber-600">¥ {(r.total - r.paid).toLocaleString()}</td></tr>))}</tbody></table>
            )}
            {tab === "payment" && (
              <table className="w-full text-[13px]"><thead className="bg-muted/60"><tr><th className="py-3 px-3 text-left text-muted-foreground" style={{ fontWeight: 500 }}>合同编号</th><th className="py-3 px-3 text-left text-muted-foreground" style={{ fontWeight: 500 }}>合同名称</th><th className="py-3 px-3 text-left text-muted-foreground" style={{ fontWeight: 500 }}>收款方</th><th className="py-3 px-3 text-right text-muted-foreground" style={{ fontWeight: 500 }}>应付金额</th><th className="py-3 px-3 text-right text-muted-foreground" style={{ fontWeight: 500 }}>已付金额</th><th className="py-3 px-3 text-right text-muted-foreground" style={{ fontWeight: 500 }}>未付金额</th></tr></thead>
              <tbody>{[{ no: "HT-2026-001", name: "美丽乡村建设工程合同", party: "琼海宏达建设有限公司", total: 480000, paid: 144000 },{ no: "HT-2026-002", name: "椰林大道绿化养护合同", party: "海南绿源园林公司", total: 95000, paid: 23750 },{ no: "HT-2025-012", name: "办公设备采购合同", party: "琼海科信电脑城", total: 32000, paid: 32000 }].map(r => (<tr key={r.no} className="border-t border-border/50 hover:bg-green-50/30"><td className="py-2.5 px-3 text-primary">{r.no}</td><td className="py-2.5 px-3">{r.name}</td><td className="py-2.5 px-3">{r.party}</td><td className="py-2.5 px-3 text-right">¥ {r.total.toLocaleString()}</td><td className="py-2.5 px-3 text-right text-green-600">¥ {r.paid.toLocaleString()}</td><td className="py-2.5 px-3 text-right text-red-500">¥ {(r.total - r.paid).toLocaleString()}</td></tr>))}</tbody></table>
            )}
            {tab === "overview" && (
              <table className="w-full text-[13px]"><thead className="bg-muted/60"><tr><th className="py-3 px-3 text-left text-muted-foreground" style={{ fontWeight: 500 }}>合同编号</th><th className="py-3 px-3 text-left text-muted-foreground" style={{ fontWeight: 500 }}>合同名称</th><th className="py-3 px-3 text-left text-muted-foreground" style={{ fontWeight: 500 }}>签约方</th><th className="py-3 px-3 text-right text-muted-foreground" style={{ fontWeight: 500 }}>合同金额</th><th className="py-3 px-3 text-right text-muted-foreground" style={{ fontWeight: 500 }}>已收付</th><th className="py-3 px-3 text-center text-muted-foreground" style={{ fontWeight: 500 }}>执行率</th><th className="py-3 px-3 text-center text-muted-foreground" style={{ fontWeight: 500 }}>状态</th></tr></thead>
              <tbody>{[{ no: "HT-2026-001", name: "美丽乡村建设工程合同", party: "琼海宏达建设有限公司", total: 480000, paid: 144000, status: "履行中" },{ no: "HT-2026-002", name: "椰林大道绿化养护合同", party: "海南绿源园林公司", total: 95000, paid: 23750, status: "履行中" },{ no: "HT-2025-015", name: "槟榔园承包经营权合同", party: "符永昌", total: 144000, paid: 48000, status: "履行中" },{ no: "HT-2025-012", name: "办公设备采购合同", party: "琼海科信电脑城", total: 32000, paid: 32000, status: "已完成" },{ no: "HT-2025-010", name: "民宿合作经营合同", party: "陈大文", total: 67200, paid: 50400, status: "履行中" },{ no: "HT-2024-008", name: "农村污水处理工程合同", party: "海南碧水环保科技", total: 220000, paid: 154000, status: "已终止" }].map(r => (<tr key={r.no} className="border-t border-border/50 hover:bg-green-50/30"><td className="py-2.5 px-3 text-primary">{r.no}</td><td className="py-2.5 px-3">{r.name}</td><td className="py-2.5 px-3">{r.party}</td><td className="py-2.5 px-3 text-right">¥ {r.total.toLocaleString()}</td><td className="py-2.5 px-3 text-right text-green-600">¥ {r.paid.toLocaleString()}</td><td className="py-2.5 px-3 text-center">{Math.round((r.paid / r.total) * 100)}%</td><td className="py-2.5 px-3 text-center"><span className={`px-2 py-0.5 rounded-full text-[12px] ${r.status === "履行中" ? "bg-blue-50 text-blue-600" : r.status === "已完成" ? "bg-green-50 text-green-600" : "bg-gray-100 text-gray-500"}`}>{r.status}</span></td></tr>))}</tbody></table>
            )}
          </div>
        </div>
      </div>
    </div>
  );
}