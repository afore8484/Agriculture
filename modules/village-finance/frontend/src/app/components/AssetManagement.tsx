import { useState } from "react";
import { toast } from "sonner";
import { Modal, ConfirmDialog } from "./ui/Modal";
import {
  ChevronRight, Plus, Search, Download, Printer, Trash2, Edit, Eye, Filter,
  RefreshCw, CheckCircle, RotateCcw, Package, TrendingDown, BarChart3
} from "lucide-react";

// =============== ASSET LIST ===============

const initialAssets = [
  { id: 1, code: "ZC-2026-001", name: "办公电脑（联想ThinkPad）", category: "办公设备", spec: "i5/16G/512G", location: "村委办公室", purchaseDate: "2025-06-15", originalValue: 5800, netValue: 4640, status: "在用", responsible: "符会计" },
  { id: 2, code: "ZC-2026-002", name: "多功能打印机", category: "办公设备", spec: "HP M479", location: "村委办公室", purchaseDate: "2025-03-20", originalValue: 3200, netValue: 2400, status: "在用", responsible: "王出纳" },
  { id: 3, code: "ZC-2026-003", name: "椰子加工设备", category: "生产设备", spec: "CJY-500型", location: "椰林加工厂", purchaseDate: "2024-08-10", originalValue: 85000, netValue: 68000, status: "在用", responsible: "符国强" },
  { id: 4, code: "ZC-2026-004", name: "村道路灯（太阳能）", category: "基础设施", spec: "30W LED×20盏", location: "椰林大道", purchaseDate: "2025-01-15", originalValue: 36000, netValue: 30000, status: "在用", responsible: "王海燕" },
  { id: 5, code: "ZC-2026-005", name: "文化广场音响设备", category: "文体设备", spec: "专业音响套装", location: "椰林文化广场", purchaseDate: "2025-09-01", originalValue: 12000, netValue: 10800, status: "在用", responsible: "黄志明" },
  { id: 6, code: "ZC-2026-006", name: "旧办公桌椅（8套）", category: "办公家具", spec: "钢制办公桌+椅", location: "村委仓库", purchaseDate: "2020-05-10", originalValue: 9600, netValue: 960, status: "闲置", responsible: "符会计" },
  { id: 7, code: "ZC-2026-007", name: "监控摄像头（16路）", category: "安防设备", spec: "海康威视套装", location: "全村主要路口", purchaseDate: "2024-12-20", originalValue: 28000, netValue: 23800, status: "在用", responsible: "王海燕" },
];

export function AssetList() {
  const [assets, setAssets] = useState(initialAssets);
  const [searchText, setSearchText] = useState("");
  const [categoryFilter, setCategoryFilter] = useState("全部分类");
  const [statusFilter, setStatusFilter] = useState("全部状态");
  const [showAdd, setShowAdd] = useState(false);
  const [showDetail, setShowDetail] = useState<typeof initialAssets[0] | null>(null);
  const [showEdit, setShowEdit] = useState<typeof initialAssets[0] | null>(null);
  const [showDeleteConfirm, setShowDeleteConfirm] = useState<number | null>(null);

  // Form state
  const [formData, setFormData] = useState({ name: "", category: "办公设备", spec: "", location: "", originalValue: "", responsible: "" });

  const categories = ["全部分类", "办公设备", "生产设备", "基础设施", "文体设备", "办公家具", "安防设备"];
  const statuses = ["全部状态", "在用", "闲置", "报废"];

  const filtered = assets.filter(a => {
    const matchSearch = !searchText || a.name.includes(searchText) || a.code.includes(searchText);
    const matchCategory = categoryFilter === "全部分类" || a.category === categoryFilter;
    const matchStatus = statusFilter === "全部状态" || a.status === statusFilter;
    return matchSearch && matchCategory && matchStatus;
  });

  const totalOriginal = assets.reduce((s, a) => s + a.originalValue, 0);
  const totalNet = assets.reduce((s, a) => s + a.netValue, 0);

  const handleAddAsset = () => {
    if (!formData.name || !formData.originalValue) { toast.error("请填写资产名称和原值"); return; }
    const val = parseFloat(formData.originalValue) || 0;
    const newId = Math.max(...assets.map(a => a.id), 0) + 1;
    const code = `ZC-2026-${String(newId).padStart(3, "0")}`;
    const newAsset = { id: newId + 100, code, name: formData.name, category: formData.category, spec: formData.spec, location: formData.location, purchaseDate: "2026-03-09", originalValue: val, netValue: val, status: "在用", responsible: formData.responsible || "符会计" };
    setAssets([newAsset, ...assets]);
    setShowAdd(false);
    setFormData({ name: "", category: "办公设备", spec: "", location: "", originalValue: "", responsible: "" });
    toast.success("资产新增成功", { description: `${code} ${formData.name}` });
  };

  const handleEditAsset = () => {
    if (!showEdit) return;
    setAssets(assets.map(a => a.id === showEdit.id ? { ...showEdit } : a));
    toast.success("资产信息已更新", { description: showEdit.name });
    setShowEdit(null);
  };

  const handleDeleteAsset = () => {
    if (showDeleteConfirm !== null) {
      const item = assets.find(a => a.id === showDeleteConfirm);
      setAssets(prev => prev.filter(a => a.id !== showDeleteConfirm));
      toast.success("已删除资产", { description: item?.name });
      setShowDeleteConfirm(null);
    }
  };

  return (
    <div className="space-y-4">
      <div className="flex items-center text-muted-foreground text-[13px]">
        <span>资产管理</span><ChevronRight className="w-4 h-4 mx-1" /><span className="text-foreground">资产列表</span>
      </div>
      <div className="flex items-center justify-between">
        <h2>资产列表</h2>
        <div className="flex gap-2">
          <button onClick={() => setShowAdd(true)} className="flex items-center gap-1.5 px-4 py-2 bg-primary text-white rounded-lg hover:bg-primary/90"><Plus className="w-4 h-4" /> 新增资产</button>
          <button onClick={() => toast.success("导出成功", { description: "资产列表已导出为 Excel 文件" })} className="flex items-center gap-1.5 px-3 py-2 border border-border rounded-lg hover:bg-muted text-[13px]"><Download className="w-4 h-4" /> 导出</button>
          <button onClick={() => { toast.info("正在生成打印预览..."); setTimeout(() => toast.success("打印预览已生成"), 800); }} className="flex items-center gap-1.5 px-3 py-2 border border-border rounded-lg hover:bg-muted text-[13px]"><Printer className="w-4 h-4" /> 打印</button>
          <button onClick={() => { toast.info("正在生成资产凭证..."); setTimeout(() => toast.success("凭证生成完成", { description: "已从资产数据生成对应记账凭证" }), 800); }} className="flex items-center gap-1.5 px-3 py-2 border border-border rounded-lg hover:bg-muted text-[13px] text-green-600"><RefreshCw className="w-4 h-4" /> 生成凭证</button>
        </div>
      </div>

      {/* Stats */}
      <div className="grid grid-cols-1 md:grid-cols-4 gap-4">
        {[
          { label: "资产总数", value: assets.length, unit: "项", color: "#0d9448" },
          { label: "原值合计", value: `¥${(totalOriginal / 10000).toFixed(1)}万`, unit: "", color: "#1a56db" },
          { label: "净值合计", value: `¥${(totalNet / 10000).toFixed(1)}万`, unit: "", color: "#f59e0b" },
          { label: "在用资产", value: assets.filter(a => a.status === "在用").length, unit: "项", color: "#10b981" },
        ].map(item => (
          <div key={item.label} className="bg-white rounded-xl p-4 border border-border shadow-sm">
            <p className="text-[12px] text-muted-foreground">{item.label}</p>
            <p className="text-[22px] mt-1" style={{ fontWeight: 600, color: item.color }}>{item.value}{item.unit}</p>
          </div>
        ))}
      </div>

      <div className="bg-white rounded-xl border border-border shadow-sm p-5">
        <div className="flex flex-wrap items-center gap-3 mb-4">
          <div className="relative">
            <Search className="w-4 h-4 absolute left-3 top-1/2 -translate-y-1/2 text-muted-foreground" />
            <input type="text" placeholder="搜索资产编号/名称..." value={searchText} onChange={e => setSearchText(e.target.value)} className="pl-9 pr-4 py-2 bg-muted rounded-lg w-[220px] outline-none focus:ring-2 focus:ring-primary/30" />
          </div>
          <select className="bg-muted rounded-lg px-3 py-2 outline-none" value={categoryFilter} onChange={e => setCategoryFilter(e.target.value)}>
            {categories.map(c => <option key={c}>{c}</option>)}
          </select>
          <select className="bg-muted rounded-lg px-3 py-2 outline-none" value={statusFilter} onChange={e => setStatusFilter(e.target.value)}>
            {statuses.map(s => <option key={s}>{s}</option>)}
          </select>
        </div>

        <div className="overflow-x-auto border border-border rounded-lg">
          <table className="w-full text-[13px]">
            <thead className="bg-muted/60">
              <tr>
                <th className="py-3 px-3 text-left text-muted-foreground" style={{ fontWeight: 500 }}>资产编号</th>
                <th className="py-3 px-3 text-left text-muted-foreground" style={{ fontWeight: 500 }}>资产名称</th>
                <th className="py-3 px-3 text-left text-muted-foreground" style={{ fontWeight: 500 }}>分类</th>
                <th className="py-3 px-3 text-left text-muted-foreground" style={{ fontWeight: 500 }}>存放位置</th>
                <th className="py-3 px-3 text-right text-muted-foreground" style={{ fontWeight: 500 }}>原值</th>
                <th className="py-3 px-3 text-right text-muted-foreground" style={{ fontWeight: 500 }}>净值</th>
                <th className="py-3 px-3 text-center text-muted-foreground" style={{ fontWeight: 500 }}>状态</th>
                <th className="py-3 px-3 text-left text-muted-foreground" style={{ fontWeight: 500 }}>责任人</th>
                <th className="py-3 px-3 text-center text-muted-foreground" style={{ fontWeight: 500 }}>操作</th>
              </tr>
            </thead>
            <tbody>
              {filtered.length === 0 ? (
                <tr><td colSpan={9} className="py-12 text-center text-muted-foreground">暂无匹配的资产记录</td></tr>
              ) : filtered.map(row => (
                <tr key={row.id} className="border-t border-border/50 hover:bg-green-50/30">
                  <td className="py-2.5 px-3 text-primary">{row.code}</td>
                  <td className="py-2.5 px-3">{row.name}</td>
                  <td className="py-2.5 px-3"><span className="px-2 py-0.5 bg-blue-50 text-blue-600 rounded text-[12px]">{row.category}</span></td>
                  <td className="py-2.5 px-3 text-muted-foreground">{row.location}</td>
                  <td className="py-2.5 px-3 text-right">¥ {row.originalValue.toLocaleString()}</td>
                  <td className="py-2.5 px-3 text-right">¥ {row.netValue.toLocaleString()}</td>
                  <td className="py-2.5 px-3 text-center">
                    <span className={`px-2 py-0.5 rounded-full text-[12px] ${row.status === "在用" ? "bg-green-50 text-green-600" : row.status === "闲置" ? "bg-amber-50 text-amber-600" : "bg-red-50 text-red-500"}`}>{row.status}</span>
                  </td>
                  <td className="py-2.5 px-3">{row.responsible}</td>
                  <td className="py-2.5 px-3">
                    <div className="flex items-center justify-center gap-1">
                      <button onClick={() => setShowDetail(row)} className="p-1 hover:bg-muted rounded"><Eye className="w-4 h-4 text-muted-foreground" /></button>
                      <button onClick={() => setShowEdit({ ...row })} className="p-1 hover:bg-muted rounded"><Edit className="w-4 h-4 text-muted-foreground" /></button>
                      <button onClick={() => setShowDeleteConfirm(row.id)} className="p-1 hover:bg-muted rounded"><Trash2 className="w-4 h-4 text-red-400" /></button>
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

      {/* Add Asset Modal */}
      <Modal open={showAdd} onClose={() => setShowAdd(false)} title="新增资产" width="max-w-xl">
        <div className="space-y-4">
          <div><label className="block text-[13px] text-muted-foreground mb-1">资产名称 *</label><input type="text" value={formData.name} onChange={e => setFormData({ ...formData, name: e.target.value })} placeholder="请输入资产名称" className="bg-muted rounded-lg px-3 py-2 outline-none w-full focus:ring-2 focus:ring-primary/30" /></div>
          <div className="grid grid-cols-2 gap-4">
            <div><label className="block text-[13px] text-muted-foreground mb-1">资产分类</label><select value={formData.category} onChange={e => setFormData({ ...formData, category: e.target.value })} className="bg-muted rounded-lg px-3 py-2 outline-none w-full">{categories.filter(c => c !== "全部分类").map(c => <option key={c}>{c}</option>)}</select></div>
            <div><label className="block text-[13px] text-muted-foreground mb-1">规格型号</label><input type="text" value={formData.spec} onChange={e => setFormData({ ...formData, spec: e.target.value })} placeholder="规格型号" className="bg-muted rounded-lg px-3 py-2 outline-none w-full" /></div>
          </div>
          <div className="grid grid-cols-2 gap-4">
            <div><label className="block text-[13px] text-muted-foreground mb-1">存放位置</label><input type="text" value={formData.location} onChange={e => setFormData({ ...formData, location: e.target.value })} placeholder="存放位置" className="bg-muted rounded-lg px-3 py-2 outline-none w-full" /></div>
            <div><label className="block text-[13px] text-muted-foreground mb-1">原值（元）*</label><input type="number" value={formData.originalValue} onChange={e => setFormData({ ...formData, originalValue: e.target.value })} placeholder="0.00" className="bg-muted rounded-lg px-3 py-2 outline-none w-full text-right" /></div>
          </div>
          <div><label className="block text-[13px] text-muted-foreground mb-1">责任人</label><input type="text" value={formData.responsible} onChange={e => setFormData({ ...formData, responsible: e.target.value })} placeholder="责任人" className="bg-muted rounded-lg px-3 py-2 outline-none w-full" /></div>
          <div className="flex justify-end gap-3 pt-2">
            <button onClick={() => setShowAdd(false)} className="px-4 py-2 border border-border rounded-lg hover:bg-muted">取消</button>
            <button onClick={handleAddAsset} className="px-4 py-2 bg-primary text-white rounded-lg hover:bg-primary/90">保存</button>
          </div>
        </div>
      </Modal>

      {/* Detail Modal */}
      <Modal open={!!showDetail} onClose={() => setShowDetail(null)} title="资产详情" width="max-w-xl">
        {showDetail && (
          <div className="space-y-3 text-[14px]">
            {[
              ["资产编号", showDetail.code],
              ["资产名称", showDetail.name],
              ["分类", showDetail.category],
              ["规格型号", showDetail.spec],
              ["存放位置", showDetail.location],
              ["购置日期", showDetail.purchaseDate],
              ["原值", `¥ ${showDetail.originalValue.toLocaleString()}`],
              ["净值", `¥ ${showDetail.netValue.toLocaleString()}`],
              ["状态", showDetail.status],
              ["责任人", showDetail.responsible],
            ].map(([label, value]) => (
              <div key={label} className="flex"><span className="text-muted-foreground w-24 flex-shrink-0">{label}</span><span>{value}</span></div>
            ))}
          </div>
        )}
      </Modal>

      {/* Edit Modal */}
      <Modal open={!!showEdit} onClose={() => setShowEdit(null)} title="编辑资产" width="max-w-xl">
        {showEdit && (
          <div className="space-y-4">
            <div><label className="block text-[13px] text-muted-foreground mb-1">资产名称</label><input type="text" value={showEdit.name} onChange={e => setShowEdit({ ...showEdit, name: e.target.value })} className="bg-muted rounded-lg px-3 py-2 outline-none w-full" /></div>
            <div className="grid grid-cols-2 gap-4">
              <div><label className="block text-[13px] text-muted-foreground mb-1">分类</label><select value={showEdit.category} onChange={e => setShowEdit({ ...showEdit, category: e.target.value })} className="bg-muted rounded-lg px-3 py-2 outline-none w-full">{categories.filter(c => c !== "全部分类").map(c => <option key={c}>{c}</option>)}</select></div>
              <div><label className="block text-[13px] text-muted-foreground mb-1">存放位置</label><input type="text" value={showEdit.location} onChange={e => setShowEdit({ ...showEdit, location: e.target.value })} className="bg-muted rounded-lg px-3 py-2 outline-none w-full" /></div>
            </div>
            <div className="grid grid-cols-2 gap-4">
              <div><label className="block text-[13px] text-muted-foreground mb-1">状态</label><select value={showEdit.status} onChange={e => setShowEdit({ ...showEdit, status: e.target.value })} className="bg-muted rounded-lg px-3 py-2 outline-none w-full"><option>在用</option><option>闲置</option><option>报废</option></select></div>
              <div><label className="block text-[13px] text-muted-foreground mb-1">责任人</label><input type="text" value={showEdit.responsible} onChange={e => setShowEdit({ ...showEdit, responsible: e.target.value })} className="bg-muted rounded-lg px-3 py-2 outline-none w-full" /></div>
            </div>
            <div className="flex justify-end gap-3 pt-2">
              <button onClick={() => setShowEdit(null)} className="px-4 py-2 border border-border rounded-lg hover:bg-muted">取消</button>
              <button onClick={handleEditAsset} className="px-4 py-2 bg-primary text-white rounded-lg hover:bg-primary/90">保存</button>
            </div>
          </div>
        )}
      </Modal>

      {/* Delete Confirm */}
      <ConfirmDialog open={showDeleteConfirm !== null} onClose={() => setShowDeleteConfirm(null)} onConfirm={handleDeleteAsset} title="确认删除" message="确定要删除该资产记录吗？此操作不可撤销。" confirmText="删除" type="danger" />
    </div>
  );
}

// =============== ASSET DEPRECIATION ===============

export function AssetDepreciation() {
  const depreciationData = [
    { id: 1, code: "ZC-2026-001", name: "办公电脑（联想ThinkPad）", category: "办公设备", originalValue: 5800, totalDepreciation: 1160, monthlyDepreciation: 96.67, netValue: 4640, method: "直线法", years: 5 },
    { id: 2, code: "ZC-2026-002", name: "多功能打印机", category: "办公设备", originalValue: 3200, totalDepreciation: 800, monthlyDepreciation: 53.33, netValue: 2400, method: "直线法", years: 5 },
    { id: 3, code: "ZC-2026-003", name: "椰子加工设备", category: "生产设备", originalValue: 85000, totalDepreciation: 17000, monthlyDepreciation: 708.33, netValue: 68000, method: "直线法", years: 10 },
    { id: 4, code: "ZC-2026-004", name: "村道路灯（太阳能）", category: "基础设施", originalValue: 36000, totalDepreciation: 6000, monthlyDepreciation: 300, netValue: 30000, method: "直线法", years: 10 },
    { id: 5, code: "ZC-2026-005", name: "文化广场音响设备", category: "文体设备", originalValue: 12000, totalDepreciation: 1200, monthlyDepreciation: 200, netValue: 10800, method: "直线法", years: 5 },
    { id: 6, code: "ZC-2026-007", name: "监控摄像头（16路）", category: "安防设备", originalValue: 28000, totalDepreciation: 4200, monthlyDepreciation: 466.67, netValue: 23800, method: "直线法", years: 5 },
  ];

  const totalMonthly = depreciationData.reduce((s, d) => s + d.monthlyDepreciation, 0);

  return (
    <div className="space-y-4">
      <div className="flex items-center text-muted-foreground text-[13px]">
        <span>资产管理</span><ChevronRight className="w-4 h-4 mx-1" /><span className="text-foreground">折旧管理</span>
      </div>
      <div className="flex items-center justify-between">
        <h2>折旧管理</h2>
        <div className="flex gap-2">
          <button onClick={() => { toast.info("确认计提本月折旧？"); setTimeout(() => { toast.success("折旧计提完成", { description: `本月折旧额 ¥${totalMonthly.toFixed(2)} 已计提` }); }, 1000); }} className="flex items-center gap-1.5 px-4 py-2 bg-primary text-white rounded-lg hover:bg-primary/90"><CheckCircle className="w-4 h-4" /> 一键计提折旧</button>
          <button onClick={() => toast.success("凭证生成完成", { description: "已从折旧数据生成记账凭证" })} className="flex items-center gap-1.5 px-3 py-2 border border-border rounded-lg hover:bg-muted text-[13px] text-green-600"><RefreshCw className="w-4 h-4" /> 生成凭证</button>
          <button onClick={() => toast.success("导出成功", { description: "折旧明细已导出" })} className="flex items-center gap-1.5 px-3 py-2 border border-border rounded-lg hover:bg-muted text-[13px]"><Download className="w-4 h-4" /> 导出</button>
          <button onClick={() => { toast.info("正在生成打印预览..."); setTimeout(() => toast.success("打印预览已生成"), 800); }} className="flex items-center gap-1.5 px-3 py-2 border border-border rounded-lg hover:bg-muted text-[13px]"><Printer className="w-4 h-4" /> 打印</button>
        </div>
      </div>

      <div className="grid grid-cols-1 md:grid-cols-3 gap-4">
        <div className="bg-white rounded-xl p-4 border border-border shadow-sm">
          <p className="text-[12px] text-muted-foreground">计提资产数</p>
          <p className="text-[22px] mt-1" style={{ fontWeight: 600, color: "#0d9448" }}>{depreciationData.length} 项</p>
        </div>
        <div className="bg-white rounded-xl p-4 border border-border shadow-sm">
          <p className="text-[12px] text-muted-foreground">本月折旧额</p>
          <p className="text-[22px] mt-1" style={{ fontWeight: 600, color: "#f59e0b" }}>¥ {totalMonthly.toFixed(2)}</p>
        </div>
        <div className="bg-white rounded-xl p-4 border border-border shadow-sm">
          <p className="text-[12px] text-muted-foreground">累计折旧总额</p>
          <p className="text-[22px] mt-1" style={{ fontWeight: 600, color: "#ef4444" }}>¥ {depreciationData.reduce((s, d) => s + d.totalDepreciation, 0).toLocaleString()}</p>
        </div>
      </div>

      <div className="bg-white rounded-xl border border-border shadow-sm p-5">
        <div className="overflow-x-auto border border-border rounded-lg">
          <table className="w-full text-[13px]">
            <thead className="bg-muted/60">
              <tr>
                <th className="py-3 px-3 text-left text-muted-foreground" style={{ fontWeight: 500 }}>资产编号</th>
                <th className="py-3 px-3 text-left text-muted-foreground" style={{ fontWeight: 500 }}>资产名称</th>
                <th className="py-3 px-3 text-left text-muted-foreground" style={{ fontWeight: 500 }}>分类</th>
                <th className="py-3 px-3 text-right text-muted-foreground" style={{ fontWeight: 500 }}>原值</th>
                <th className="py-3 px-3 text-right text-muted-foreground" style={{ fontWeight: 500 }}>累计折旧</th>
                <th className="py-3 px-3 text-right text-muted-foreground" style={{ fontWeight: 500 }}>月折旧额</th>
                <th className="py-3 px-3 text-right text-muted-foreground" style={{ fontWeight: 500 }}>净值</th>
                <th className="py-3 px-3 text-center text-muted-foreground" style={{ fontWeight: 500 }}>折旧方法</th>
                <th className="py-3 px-3 text-center text-muted-foreground" style={{ fontWeight: 500 }}>使用年限</th>
              </tr>
            </thead>
            <tbody>
              {depreciationData.map(row => (
                <tr key={row.id} className="border-t border-border/50 hover:bg-green-50/30">
                  <td className="py-2.5 px-3 text-primary">{row.code}</td>
                  <td className="py-2.5 px-3">{row.name}</td>
                  <td className="py-2.5 px-3"><span className="px-2 py-0.5 bg-blue-50 text-blue-600 rounded text-[12px]">{row.category}</span></td>
                  <td className="py-2.5 px-3 text-right">¥ {row.originalValue.toLocaleString()}</td>
                  <td className="py-2.5 px-3 text-right text-red-500">¥ {row.totalDepreciation.toLocaleString()}</td>
                  <td className="py-2.5 px-3 text-right text-amber-600">¥ {row.monthlyDepreciation.toFixed(2)}</td>
                  <td className="py-2.5 px-3 text-right" style={{ fontWeight: 500 }}>¥ {row.netValue.toLocaleString()}</td>
                  <td className="py-2.5 px-3 text-center">{row.method}</td>
                  <td className="py-2.5 px-3 text-center">{row.years}年</td>
                </tr>
              ))}
            </tbody>
            <tfoot className="bg-muted/30">
              <tr className="border-t border-border">
                <td colSpan={5} className="py-2.5 px-3 text-right" style={{ fontWeight: 500 }}>合计</td>
                <td className="py-2.5 px-3 text-right text-amber-600" style={{ fontWeight: 500 }}>¥ {totalMonthly.toFixed(2)}</td>
                <td colSpan={3}></td>
              </tr>
            </tfoot>
          </table>
        </div>
      </div>
    </div>
  );
}

// =============== ASSET REPORT ===============

export function AssetReport() {
  const [activeReport, setActiveReport] = useState<string | null>(null);
  const [categoryFilter, setCategoryFilter] = useState("全部分类");
  const [periodFilter, setPeriodFilter] = useState("2026年3月");

  const reportCards = [
    { title: "资产总览报表", desc: "按分类统计资产数量、原值、净值等", icon: Package },
    { title: "折旧汇总表", desc: "各类资产折旧明细汇总", icon: TrendingDown },
    { title: "资产变动报表", desc: "资产新增、处置、调拨等变动记录", icon: RefreshCw },
    { title: "资产盘点报告", desc: "最近一次资产盘点结果", icon: CheckCircle },
  ];

  const overviewData = [
    { category: "办公设备", count: 3, originalTotal: 14800, netTotal: 11840, depRate: "20%", status: "正常" },
    { category: "生产设备", count: 1, originalTotal: 85000, netTotal: 68000, depRate: "10%", status: "正常" },
    { category: "基础设施", count: 1, originalTotal: 36000, netTotal: 30000, depRate: "10%", status: "正常" },
    { category: "文体设备", count: 1, originalTotal: 12000, netTotal: 10800, depRate: "20%", status: "正常" },
    { category: "办公家具", count: 1, originalTotal: 9600, netTotal: 960, depRate: "20%", status: "待处置" },
    { category: "安防设备", count: 1, originalTotal: 28000, netTotal: 23800, depRate: "20%", status: "正常" },
  ];

  const depSummaryData = [
    { code: "ZC-2026-001", name: "办公电脑（联想ThinkPad）", category: "办公设备", originalValue: 5800, method: "直线法", years: 5, monthlyDep: 96.67, totalDep: 1160, netValue: 4640 },
    { code: "ZC-2026-002", name: "多功能打印机", category: "办公设备", originalValue: 3200, method: "直线法", years: 5, monthlyDep: 53.33, totalDep: 800, netValue: 2400 },
    { code: "ZC-2026-003", name: "椰子加工设备", category: "生产设备", originalValue: 85000, method: "直线法", years: 10, monthlyDep: 708.33, totalDep: 17000, netValue: 68000 },
    { code: "ZC-2026-004", name: "村道路灯（太阳能）", category: "基础设施", originalValue: 36000, method: "直线法", years: 10, monthlyDep: 300, totalDep: 6000, netValue: 30000 },
    { code: "ZC-2026-005", name: "文化广场音响设备", category: "文体设备", originalValue: 12000, method: "直线法", years: 5, monthlyDep: 200, totalDep: 1200, netValue: 10800 },
    { code: "ZC-2026-007", name: "监控摄像头（16路）", category: "安防设备", originalValue: 28000, method: "直线法", years: 5, monthlyDep: 466.67, totalDep: 4200, netValue: 23800 },
  ];

  const changeData = [
    { date: "2026-03-05", code: "ZC-2026-008", name: "便携式投影仪", type: "新增", detail: "采购入库", operator: "符会计", amount: 4500 },
    { date: "2026-02-28", code: "ZC-2026-006", name: "旧办公桌椅（8套）", type: "处置", detail: "报废处理，残值回收 ¥200", operator: "王出纳", amount: -9400 },
    { date: "2026-02-15", code: "ZC-2026-003", name: "椰子加工设备", type: "调拨", detail: "从村委仓库调至椰林加工厂", operator: "符国强", amount: 0 },
    { date: "2026-01-20", code: "ZC-2026-004", name: "村道路灯（太阳能）", type: "维修", detail: "更换3盏灯头，维修费 ¥1,200", operator: "王海燕", amount: -1200 },
    { date: "2026-01-10", code: "ZC-2026-007", name: "监控摄像头（16路）", type: "新增", detail: "安装完成验收", operator: "符会计", amount: 28000 },
  ];

  const inventoryData = [
    { code: "ZC-2026-001", name: "办公电脑（联想ThinkPad）", location: "村委办公室", bookValue: 4640, actualStatus: "在用", result: "账实相符", remark: "" },
    { code: "ZC-2026-002", name: "多功能打印机", location: "村委办公室", bookValue: 2400, actualStatus: "在用", result: "账实相符", remark: "" },
    { code: "ZC-2026-003", name: "椰子加工设备", location: "椰林加工厂", bookValue: 68000, actualStatus: "在用", result: "账实相符", remark: "" },
    { code: "ZC-2026-004", name: "村道路灯（太阳能）", location: "椰林大道", bookValue: 30000, actualStatus: "在用", result: "账实相符", remark: "3盏待更换" },
    { code: "ZC-2026-005", name: "文化广场音响设备", location: "椰林文化广场", bookValue: 10800, actualStatus: "在用", result: "账实相符", remark: "" },
    { code: "ZC-2026-006", name: "旧办公桌椅（8套）", location: "村委仓库", bookValue: 960, actualStatus: "闲置", result: "盘亏", remark: "实存6套，2套已损坏丢失" },
    { code: "ZC-2026-007", name: "监控摄像头（16路）", location: "全村主要路口", bookValue: 23800, actualStatus: "在用", result: "账实相符", remark: "" },
  ];

  const categories = ["全部分类", "办公设备", "生产设备", "基础设施", "文体设备", "办公家具", "安防设备"];
  const filteredDep = categoryFilter === "全部分类" ? depSummaryData : depSummaryData.filter(d => d.category === categoryFilter);

  if (activeReport) {
    return (
      <div className="space-y-4">
        <div className="flex items-center text-muted-foreground text-[13px]">
          <span>资产管理</span><ChevronRight className="w-4 h-4 mx-1" /><span className="cursor-pointer hover:text-primary" onClick={() => setActiveReport(null)}>资产报表</span><ChevronRight className="w-4 h-4 mx-1" /><span className="text-foreground">{activeReport}</span>
        </div>
        <div className="flex items-center justify-between">
          <h2>{activeReport}</h2>
          <div className="flex gap-2">
            <button onClick={() => setActiveReport(null)} className="flex items-center gap-1.5 px-3 py-2 border border-border rounded-lg hover:bg-muted text-[13px]"><RotateCcw className="w-4 h-4" /> 返回</button>
            <button onClick={() => toast.success("导出成功", { description: `${activeReport}已导出` })} className="flex items-center gap-1.5 px-3 py-2 border border-border rounded-lg hover:bg-muted text-[13px]"><Download className="w-4 h-4" /> 导出</button>
            <button onClick={() => { toast.info("正在生成打印预览..."); setTimeout(() => toast.success("打印预览已生成"), 800); }} className="flex items-center gap-1.5 px-3 py-2 border border-border rounded-lg hover:bg-muted text-[13px]"><Printer className="w-4 h-4" /> 打印</button>
          </div>
        </div>

        {activeReport === "资产总览报表" && (<>
          <div className="bg-blue-50/50 border border-blue-100 rounded-lg p-3 text-[13px] text-blue-700">报表期间：{periodFilter} | 统计单位：博鳌镇椰林村 | 生成时间：2026-03-10</div>
          <div className="grid grid-cols-1 md:grid-cols-4 gap-4">
            {[
              { label: "资产分类数", value: overviewData.length, unit: "类", color: "#0d9448" },
              { label: "资产总数", value: overviewData.reduce((s, d) => s + d.count, 0), unit: "项", color: "#1a56db" },
              { label: "原值合计", value: `¥${(overviewData.reduce((s, d) => s + d.originalTotal, 0) / 10000).toFixed(1)}万`, unit: "", color: "#f59e0b" },
              { label: "净值合计", value: `¥${(overviewData.reduce((s, d) => s + d.netTotal, 0) / 10000).toFixed(1)}万`, unit: "", color: "#10b981" },
            ].map(item => (
              <div key={item.label} className="bg-white rounded-xl p-4 border border-border shadow-sm">
                <p className="text-[12px] text-muted-foreground">{item.label}</p>
                <p className="text-[22px] mt-1" style={{ fontWeight: 600, color: item.color }}>{item.value}{item.unit}</p>
              </div>
            ))}
          </div>
          <div className="bg-white rounded-xl border border-border shadow-sm p-5">
            <div className="overflow-x-auto border border-border rounded-lg">
              <table className="w-full text-[13px]">
                <thead className="bg-muted/60"><tr>
                  <th className="py-3 px-3 text-left text-muted-foreground" style={{ fontWeight: 500 }}>资产分类</th>
                  <th className="py-3 px-3 text-right text-muted-foreground" style={{ fontWeight: 500 }}>数量（项）</th>
                  <th className="py-3 px-3 text-right text-muted-foreground" style={{ fontWeight: 500 }}>原值合计</th>
                  <th className="py-3 px-3 text-right text-muted-foreground" style={{ fontWeight: 500 }}>净值合计</th>
                  <th className="py-3 px-3 text-right text-muted-foreground" style={{ fontWeight: 500 }}>折旧率</th>
                  <th className="py-3 px-3 text-center text-muted-foreground" style={{ fontWeight: 500 }}>状态</th>
                </tr></thead>
                <tbody>
                  {overviewData.map(row => (
                    <tr key={row.category} className="border-t border-border/50 hover:bg-green-50/30">
                      <td className="py-2.5 px-3" style={{ fontWeight: 500 }}>{row.category}</td>
                      <td className="py-2.5 px-3 text-right">{row.count}</td>
                      <td className="py-2.5 px-3 text-right">¥ {row.originalTotal.toLocaleString()}</td>
                      <td className="py-2.5 px-3 text-right">¥ {row.netTotal.toLocaleString()}</td>
                      <td className="py-2.5 px-3 text-right text-amber-600">{row.depRate}</td>
                      <td className="py-2.5 px-3 text-center"><span className={`px-2 py-0.5 rounded-full text-[12px] ${row.status === "正常" ? "bg-green-50 text-green-600" : "bg-amber-50 text-amber-600"}`}>{row.status}</span></td>
                    </tr>
                  ))}
                </tbody>
                <tfoot className="bg-muted/30"><tr className="border-t border-border">
                  <td className="py-2.5 px-3" style={{ fontWeight: 500 }}>合计</td>
                  <td className="py-2.5 px-3 text-right" style={{ fontWeight: 500 }}>{overviewData.reduce((s, d) => s + d.count, 0)}</td>
                  <td className="py-2.5 px-3 text-right" style={{ fontWeight: 500 }}>¥ {overviewData.reduce((s, d) => s + d.originalTotal, 0).toLocaleString()}</td>
                  <td className="py-2.5 px-3 text-right" style={{ fontWeight: 500 }}>¥ {overviewData.reduce((s, d) => s + d.netTotal, 0).toLocaleString()}</td>
                  <td colSpan={2}></td>
                </tr></tfoot>
              </table>
            </div>
          </div>
        </>)}

        {activeReport === "折旧汇总表" && (<>
          <div className="flex flex-wrap items-center gap-3">
            <select className="bg-muted rounded-lg px-3 py-2 outline-none text-[13px]" value={categoryFilter} onChange={e => setCategoryFilter(e.target.value)}>
              {categories.map(c => <option key={c}>{c}</option>)}
            </select>
            <select className="bg-muted rounded-lg px-3 py-2 outline-none text-[13px]" value={periodFilter} onChange={e => setPeriodFilter(e.target.value)}>
              <option>2026年3月</option><option>2026年2月</option><option>2026年1月</option>
            </select>
            <div className="text-[13px] text-muted-foreground">期间：{periodFilter} | 椰林村</div>
          </div>
          <div className="grid grid-cols-1 md:grid-cols-3 gap-4">
            <div className="bg-white rounded-xl p-4 border border-border shadow-sm"><p className="text-[12px] text-muted-foreground">计提资产数</p><p className="text-[22px] mt-1" style={{ fontWeight: 600, color: "#0d9448" }}>{filteredDep.length} 项</p></div>
            <div className="bg-white rounded-xl p-4 border border-border shadow-sm"><p className="text-[12px] text-muted-foreground">本月折旧额</p><p className="text-[22px] mt-1" style={{ fontWeight: 600, color: "#f59e0b" }}>¥ {filteredDep.reduce((s, d) => s + d.monthlyDep, 0).toFixed(2)}</p></div>
            <div className="bg-white rounded-xl p-4 border border-border shadow-sm"><p className="text-[12px] text-muted-foreground">累计折旧</p><p className="text-[22px] mt-1" style={{ fontWeight: 600, color: "#ef4444" }}>¥ {filteredDep.reduce((s, d) => s + d.totalDep, 0).toLocaleString()}</p></div>
          </div>
          <div className="bg-white rounded-xl border border-border shadow-sm p-5">
            <div className="overflow-x-auto border border-border rounded-lg">
              <table className="w-full text-[13px]">
                <thead className="bg-muted/60"><tr>
                  <th className="py-3 px-3 text-left text-muted-foreground" style={{ fontWeight: 500 }}>资产编号</th>
                  <th className="py-3 px-3 text-left text-muted-foreground" style={{ fontWeight: 500 }}>资产名称</th>
                  <th className="py-3 px-3 text-left text-muted-foreground" style={{ fontWeight: 500 }}>分类</th>
                  <th className="py-3 px-3 text-right text-muted-foreground" style={{ fontWeight: 500 }}>原值</th>
                  <th className="py-3 px-3 text-center text-muted-foreground" style={{ fontWeight: 500 }}>折旧方法</th>
                  <th className="py-3 px-3 text-center text-muted-foreground" style={{ fontWeight: 500 }}>使用年限</th>
                  <th className="py-3 px-3 text-right text-muted-foreground" style={{ fontWeight: 500 }}>月折旧额</th>
                  <th className="py-3 px-3 text-right text-muted-foreground" style={{ fontWeight: 500 }}>累计折旧</th>
                  <th className="py-3 px-3 text-right text-muted-foreground" style={{ fontWeight: 500 }}>净值</th>
                </tr></thead>
                <tbody>
                  {filteredDep.map(row => (
                    <tr key={row.code} className="border-t border-border/50 hover:bg-green-50/30">
                      <td className="py-2.5 px-3 text-primary">{row.code}</td>
                      <td className="py-2.5 px-3">{row.name}</td>
                      <td className="py-2.5 px-3"><span className="px-2 py-0.5 bg-blue-50 text-blue-600 rounded text-[12px]">{row.category}</span></td>
                      <td className="py-2.5 px-3 text-right">¥ {row.originalValue.toLocaleString()}</td>
                      <td className="py-2.5 px-3 text-center">{row.method}</td>
                      <td className="py-2.5 px-3 text-center">{row.years}年</td>
                      <td className="py-2.5 px-3 text-right text-amber-600">¥ {row.monthlyDep.toFixed(2)}</td>
                      <td className="py-2.5 px-3 text-right text-red-500">¥ {row.totalDep.toLocaleString()}</td>
                      <td className="py-2.5 px-3 text-right" style={{ fontWeight: 500 }}>¥ {row.netValue.toLocaleString()}</td>
                    </tr>
                  ))}
                </tbody>
                <tfoot className="bg-muted/30"><tr className="border-t border-border">
                  <td colSpan={6} className="py-2.5 px-3 text-right" style={{ fontWeight: 500 }}>合计</td>
                  <td className="py-2.5 px-3 text-right text-amber-600" style={{ fontWeight: 500 }}>¥ {filteredDep.reduce((s, d) => s + d.monthlyDep, 0).toFixed(2)}</td>
                  <td className="py-2.5 px-3 text-right text-red-500" style={{ fontWeight: 500 }}>¥ {filteredDep.reduce((s, d) => s + d.totalDep, 0).toLocaleString()}</td>
                  <td className="py-2.5 px-3 text-right" style={{ fontWeight: 500 }}>¥ {filteredDep.reduce((s, d) => s + d.netValue, 0).toLocaleString()}</td>
                </tr></tfoot>
              </table>
            </div>
          </div>
        </>)}

        {activeReport === "资产变动报表" && (<>
          <div className="bg-amber-50/50 border border-amber-100 rounded-lg p-3 text-[13px] text-amber-700">报表期间：2026年1月 - 2026年3月 | 统计单位：博鳌镇椰林村</div>
          <div className="grid grid-cols-1 md:grid-cols-4 gap-4">
            {[
              { label: "新增", value: changeData.filter(d => d.type === "新增").length, unit: "项", color: "#0d9448" },
              { label: "处置", value: changeData.filter(d => d.type === "处置").length, unit: "项", color: "#ef4444" },
              { label: "调拨", value: changeData.filter(d => d.type === "调拨").length, unit: "项", color: "#0ea5e9" },
              { label: "维修", value: changeData.filter(d => d.type === "维修").length, unit: "项", color: "#f59e0b" },
            ].map(item => (
              <div key={item.label} className="bg-white rounded-xl p-4 border border-border shadow-sm">
                <p className="text-[12px] text-muted-foreground">{item.label}</p>
                <p className="text-[22px] mt-1" style={{ fontWeight: 600, color: item.color }}>{item.value}{item.unit}</p>
              </div>
            ))}
          </div>
          <div className="bg-white rounded-xl border border-border shadow-sm p-5">
            <div className="overflow-x-auto border border-border rounded-lg">
              <table className="w-full text-[13px]">
                <thead className="bg-muted/60"><tr>
                  <th className="py-3 px-3 text-left text-muted-foreground" style={{ fontWeight: 500 }}>变动日期</th>
                  <th className="py-3 px-3 text-left text-muted-foreground" style={{ fontWeight: 500 }}>资产编号</th>
                  <th className="py-3 px-3 text-left text-muted-foreground" style={{ fontWeight: 500 }}>资产名称</th>
                  <th className="py-3 px-3 text-center text-muted-foreground" style={{ fontWeight: 500 }}>变动类型</th>
                  <th className="py-3 px-3 text-left text-muted-foreground" style={{ fontWeight: 500 }}>变动说明</th>
                  <th className="py-3 px-3 text-right text-muted-foreground" style={{ fontWeight: 500 }}>涉及金额</th>
                  <th className="py-3 px-3 text-left text-muted-foreground" style={{ fontWeight: 500 }}>操作人</th>
                </tr></thead>
                <tbody>
                  {changeData.map((row, idx) => (
                    <tr key={idx} className="border-t border-border/50 hover:bg-green-50/30">
                      <td className="py-2.5 px-3 text-muted-foreground">{row.date}</td>
                      <td className="py-2.5 px-3 text-primary">{row.code}</td>
                      <td className="py-2.5 px-3">{row.name}</td>
                      <td className="py-2.5 px-3 text-center"><span className={`px-2 py-0.5 rounded-full text-[12px] ${row.type === "新增" ? "bg-green-50 text-green-600" : row.type === "处置" ? "bg-red-50 text-red-500" : row.type === "调拨" ? "bg-blue-50 text-blue-600" : "bg-amber-50 text-amber-600"}`}>{row.type}</span></td>
                      <td className="py-2.5 px-3 text-muted-foreground">{row.detail}</td>
                      <td className="py-2.5 px-3 text-right" style={{ fontWeight: 500 }}>{row.amount === 0 ? "-" : row.amount > 0 ? <span className="text-green-600">+¥ {row.amount.toLocaleString()}</span> : <span className="text-red-500">-¥ {Math.abs(row.amount).toLocaleString()}</span>}</td>
                      <td className="py-2.5 px-3">{row.operator}</td>
                    </tr>
                  ))}
                </tbody>
              </table>
            </div>
          </div>
        </>)}

        {activeReport === "资产盘点报告" && (<>
          <div className="bg-green-50/50 border border-green-100 rounded-lg p-3 text-[13px] text-green-700">盘点日期：2026年3月1日 | 盘点单位：博鳌镇椰林村 | 盘点人员：符会计、王出纳 | 监盘人：黄志明</div>
          <div className="grid grid-cols-1 md:grid-cols-4 gap-4">
            {[
              { label: "盘点资产数", value: inventoryData.length, unit: "项", color: "#0d9448" },
              { label: "账实相符", value: inventoryData.filter(d => d.result === "账实相符").length, unit: "项", color: "#10b981" },
              { label: "盘亏", value: inventoryData.filter(d => d.result === "盘亏").length, unit: "项", color: "#ef4444" },
              { label: "盘盈", value: inventoryData.filter(d => d.result === "盘盈").length, unit: "项", color: "#0ea5e9" },
            ].map(item => (
              <div key={item.label} className="bg-white rounded-xl p-4 border border-border shadow-sm">
                <p className="text-[12px] text-muted-foreground">{item.label}</p>
                <p className="text-[22px] mt-1" style={{ fontWeight: 600, color: item.color }}>{item.value}{item.unit}</p>
              </div>
            ))}
          </div>
          <div className="bg-white rounded-xl border border-border shadow-sm p-5">
            <div className="overflow-x-auto border border-border rounded-lg">
              <table className="w-full text-[13px]">
                <thead className="bg-muted/60"><tr>
                  <th className="py-3 px-3 text-left text-muted-foreground" style={{ fontWeight: 500 }}>资产编号</th>
                  <th className="py-3 px-3 text-left text-muted-foreground" style={{ fontWeight: 500 }}>资产名称</th>
                  <th className="py-3 px-3 text-left text-muted-foreground" style={{ fontWeight: 500 }}>存放位置</th>
                  <th className="py-3 px-3 text-right text-muted-foreground" style={{ fontWeight: 500 }}>账面净值</th>
                  <th className="py-3 px-3 text-center text-muted-foreground" style={{ fontWeight: 500 }}>实际状态</th>
                  <th className="py-3 px-3 text-center text-muted-foreground" style={{ fontWeight: 500 }}>��点结果</th>
                  <th className="py-3 px-3 text-left text-muted-foreground" style={{ fontWeight: 500 }}>备注</th>
                </tr></thead>
                <tbody>
                  {inventoryData.map(row => (
                    <tr key={row.code} className="border-t border-border/50 hover:bg-green-50/30">
                      <td className="py-2.5 px-3 text-primary">{row.code}</td>
                      <td className="py-2.5 px-3">{row.name}</td>
                      <td className="py-2.5 px-3 text-muted-foreground">{row.location}</td>
                      <td className="py-2.5 px-3 text-right">¥ {row.bookValue.toLocaleString()}</td>
                      <td className="py-2.5 px-3 text-center"><span className={`px-2 py-0.5 rounded-full text-[12px] ${row.actualStatus === "在用" ? "bg-green-50 text-green-600" : "bg-amber-50 text-amber-600"}`}>{row.actualStatus}</span></td>
                      <td className="py-2.5 px-3 text-center"><span className={`px-2 py-0.5 rounded-full text-[12px] ${row.result === "账实相符" ? "bg-green-50 text-green-600" : row.result === "盘亏" ? "bg-red-50 text-red-500" : "bg-blue-50 text-blue-600"}`}>{row.result}</span></td>
                      <td className="py-2.5 px-3 text-muted-foreground">{row.remark || "-"}</td>
                    </tr>
                  ))}
                </tbody>
              </table>
            </div>
            <div className="mt-4 p-3 bg-muted/30 rounded-lg text-[13px]">
              <p style={{ fontWeight: 500 }}>盘点结论：</p>
              <p className="text-muted-foreground mt-1">本次盘点共核查资产 {inventoryData.length} 项，其中账实相符 {inventoryData.filter(d => d.result === "账实相符").length} 项，盘亏 {inventoryData.filter(d => d.result === "盘亏").length} 项。盘亏资产为旧办公桌椅，建议做报废处理并调整账面记录。</p>
            </div>
          </div>
        </>)}
      </div>
    );
  }

  return (
    <div className="space-y-4">
      <div className="flex items-center text-muted-foreground text-[13px]">
        <span>资产管理</span><ChevronRight className="w-4 h-4 mx-1" /><span className="text-foreground">资产报表</span>
      </div>
      <h2>资产报表</h2>
      <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
        {reportCards.map(card => {
          const Icon = card.icon;
          return (
            <div key={card.title} className="bg-white rounded-xl p-5 border border-border shadow-sm hover:shadow-md transition-shadow">
              <div className="flex items-start gap-4">
                <div className="w-12 h-12 rounded-xl bg-primary/5 flex items-center justify-center"><Icon className="w-6 h-6 text-primary" /></div>
                <div className="flex-1">
                  <h3>{card.title}</h3>
                  <p className="text-[13px] text-muted-foreground mt-1">{card.desc}</p>
                  <div className="flex gap-2 mt-3">
                    <button onClick={() => setActiveReport(card.title)} className="flex items-center gap-1 px-3 py-1.5 bg-primary text-white rounded-lg text-[13px] hover:bg-primary/90"><Eye className="w-3.5 h-3.5" /> 查看</button>
                    <button onClick={() => toast.success("导出成功", { description: `${card.title}已导出` })} className="flex items-center gap-1 px-3 py-1.5 border border-border rounded-lg text-[13px] hover:bg-muted"><Download className="w-3.5 h-3.5" /> 导出</button>
                    <button onClick={() => { toast.info("正在生成打印预览..."); setTimeout(() => toast.success("打印预览已生成"), 800); }} className="flex items-center gap-1 px-3 py-1.5 border border-border rounded-lg text-[13px] hover:bg-muted"><Printer className="w-3.5 h-3.5" /> 打印</button>
                  </div>
                </div>
              </div>
            </div>
          );
        })}
      </div>
    </div>
  );
}

// =============== ASSET SETTLE ===============

export function AssetSettle() {
  const [settleData, setSettleData] = useState([
    { period: "2026年1月", status: "已结账", date: "2026-02-01", operator: "符会计" },
    { period: "2026年2月", status: "已结账", date: "2026-03-01", operator: "符会计" },
    { period: "2026年3月", status: "未结账", date: "-", operator: "-" },
  ]);
  const [showSettleConfirm, setShowSettleConfirm] = useState<string | null>(null);
  const [showUnsettleConfirm, setShowUnsettleConfirm] = useState<string | null>(null);

  const handleSettle = () => {
    if (!showSettleConfirm) return;
    const period = showSettleConfirm;
    toast.info("正在执行资产结账...");
    setTimeout(() => {
      setSettleData(prev => prev.map(s => s.period === period ? { ...s, status: "已结账", date: "2026-03-09", operator: "符会计" } : s));
      toast.success("资产结账完成", { description: `${period} 已成功结账` });
    }, 1000);
    setShowSettleConfirm(null);
  };

  const handleUnsettle = () => {
    if (!showUnsettleConfirm) return;
    const period = showUnsettleConfirm;
    setSettleData(prev => prev.map(s => s.period === period ? { ...s, status: "未结账", date: "-", operator: "-" } : s));
    toast.success("反结账完成", { description: `${period} 已恢复为未结账状态` });
    setShowUnsettleConfirm(null);
  };

  return (
    <div className="space-y-4">
      <div className="flex items-center text-muted-foreground text-[13px]">
        <span>资产管理</span><ChevronRight className="w-4 h-4 mx-1" /><span className="text-foreground">资产结账</span>
      </div>
      <h2>资产结账</h2>
      <div className="bg-white rounded-xl border border-border shadow-sm p-5">
        <div className="overflow-x-auto border border-border rounded-lg">
          <table className="w-full text-[13px]">
            <thead className="bg-muted/60">
              <tr>
                <th className="py-3 px-4 text-left text-muted-foreground" style={{ fontWeight: 500 }}>会计期间</th>
                <th className="py-3 px-4 text-center text-muted-foreground" style={{ fontWeight: 500 }}>状态</th>
                <th className="py-3 px-4 text-left text-muted-foreground" style={{ fontWeight: 500 }}>结账日期</th>
                <th className="py-3 px-4 text-left text-muted-foreground" style={{ fontWeight: 500 }}>操作人</th>
                <th className="py-3 px-4 text-center text-muted-foreground" style={{ fontWeight: 500 }}>操作</th>
              </tr>
            </thead>
            <tbody>
              {settleData.map(row => (
                <tr key={row.period} className="border-t border-border/50 hover:bg-green-50/30">
                  <td className="py-3 px-4">{row.period}</td>
                  <td className="py-3 px-4 text-center">
                    <span className={`px-2 py-0.5 rounded-full text-[12px] ${row.status === "已结账" ? "bg-green-50 text-green-600" : "bg-amber-50 text-amber-600"}`}>{row.status}</span>
                  </td>
                  <td className="py-3 px-4 text-muted-foreground">{row.date}</td>
                  <td className="py-3 px-4">{row.operator}</td>
                  <td className="py-3 px-4 text-center">
                    {row.status === "已结账" ? (
                      <button onClick={() => setShowUnsettleConfirm(row.period)} className="px-3 py-1 border border-border rounded text-[12px] hover:bg-muted"><RotateCcw className="w-3 h-3 inline mr-1" />反结账</button>
                    ) : (
                      <button onClick={() => setShowSettleConfirm(row.period)} className="px-3 py-1 bg-primary text-white rounded text-[12px] hover:bg-primary/90"><CheckCircle className="w-3 h-3 inline mr-1" />结账</button>
                    )}
                  </td>
                </tr>
              ))}
            </tbody>
          </table>
        </div>
      </div>
      <ConfirmDialog open={!!showSettleConfirm} onClose={() => setShowSettleConfirm(null)} onConfirm={handleSettle} title="确认资产结账" message={`确认对 ${showSettleConfirm || ""} 执行资产结账？\n\n结账后将锁定本期资产数据，不可修改。`} confirmText="确认结账" type="warning" />
      <ConfirmDialog open={!!showUnsettleConfirm} onClose={() => setShowUnsettleConfirm(null)} onConfirm={handleUnsettle} title="确认反结账" message={`确认对 ${showUnsettleConfirm || ""} 执行反结账？\n\n反结账后本期资产数据将可以修改。`} confirmText="确认反结账" type="info" />
    </div>
  );
}