import { useState } from "react";
import { toast } from "sonner";
import { Modal, ConfirmDialog } from "./ui/Modal";
import {
  ChevronRight, ChevronDown, Plus, Search, Edit, Eye, Download, Upload,
  Users, User, BookOpen, GraduationCap, FileText, Star, Clock, CheckCircle,
  MessageSquare, BarChart3, ArrowRightLeft, Trash2, ArrowLeft
} from "lucide-react";

// Party Organization
export function PartyOrg() {
  const [expanded, setExpanded] = useState<string[]>(["root", "branch1"]);
  const [showAddOrg, setShowAddOrg] = useState(false);
  const [newOrgName, setNewOrgName] = useState("");
  const [newOrgParent, setNewOrgParent] = useState("椰林村党支部");
  const [showOrgDetail, setShowOrgDetail] = useState<any | null>(null);
  const [showEditOrg, setShowEditOrg] = useState<any | null>(null);
  const [showDeleteOrg, setShowDeleteOrg] = useState<any | null>(null);
  const toggle = (key: string) => setExpanded((prev) => prev.includes(key) ? prev.filter((k) => k !== key) : [...prev, key]);

  const orgTree = {
    name: "博鳌镇党委", key: "root", members: 256, completeness: 98,
    children: [
      {
        name: "椰林村党支部", key: "branch1", members: 42, completeness: 95,
        children: [
          { name: "第一党小组", key: "group1", members: 15, completeness: 100 },
          { name: "第二党小组", key: "group2", members: 14, completeness: 92 },
          { name: "第三党小组", key: "group3", members: 13, completeness: 88 },
        ],
      },
      { name: "南强村党支部", key: "branch2", members: 38, completeness: 96 },
      { name: "排港村党支部", key: "branch3", members: 52, completeness: 90 },
      { name: "沙美村党支部", key: "branch4", members: 30, completeness: 94 },
      { name: "北仍村党支部", key: "branch5", members: 41, completeness: 97 },
    ],
  };

  const renderNode = (node: any, level: number = 0) => {
    const hasChildren = node.children && node.children.length > 0;
    const isExpanded = expanded.includes(node.key);
    return (
      <div key={node.key}>
        <div
          className={`flex items-center gap-2 py-2.5 px-3 hover:bg-blue-50/30 cursor-pointer rounded transition-colors ${level > 0 ? "ml-" + (level * 6) : ""}`}
          style={{ marginLeft: `${level * 24}px` }}
          onClick={() => hasChildren ? toggle(node.key) : setShowOrgDetail(node)}
        >
          {hasChildren ? (
            isExpanded ? <ChevronDown className="w-4 h-4 text-muted-foreground" /> : <ChevronRight className="w-4 h-4 text-muted-foreground" />
          ) : (
            <div className="w-4" />
          )}
          <div className={`w-2 h-2 rounded-full ${level === 0 ? "bg-red-500" : level === 1 ? "bg-primary" : "bg-green-500"}`} />
          <span className={level === 0 ? "" : ""}>{node.name}</span>
          <span className="text-[12px] text-muted-foreground ml-2">({node.members}人)</span>
          <div className="flex-1" />
          <div className="flex items-center gap-2 text-[12px]">
            <span className="text-muted-foreground">完整度</span>
            <div className="w-16 bg-muted rounded-full h-1.5">
              <div className={`h-1.5 rounded-full ${node.completeness >= 95 ? "bg-green-500" : node.completeness >= 90 ? "bg-amber-500" : "bg-red-500"}`} style={{ width: `${node.completeness}%` }} />
            </div>
            <span className={node.completeness >= 95 ? "text-green-600" : node.completeness >= 90 ? "text-amber-600" : "text-red-500"}>{node.completeness}%</span>
          </div>
          <div className="flex items-center gap-0.5 ml-2" onClick={e => e.stopPropagation()}>
            <button onClick={() => setShowOrgDetail(node)} className="p-1 hover:bg-muted rounded" title="详情"><Eye className="w-3.5 h-3.5 text-muted-foreground" /></button>
            <button onClick={() => setShowEditOrg({ ...node })} className="p-1 hover:bg-muted rounded" title="编辑"><Edit className="w-3.5 h-3.5 text-muted-foreground" /></button>
            {level > 0 && <button onClick={() => setShowDeleteOrg(node)} className="p-1 hover:bg-red-50 rounded" title="删除"><Trash2 className="w-3.5 h-3.5 text-red-400" /></button>}
          </div>
        </div>
        {hasChildren && isExpanded && node.children.map((child: any) => renderNode(child, level + 1))}
      </div>
    );
  };

  return (
    <div className="space-y-4">
      <div className="flex items-center text-muted-foreground text-[13px]">
        <span>基层党建</span><ChevronRight className="w-4 h-4 mx-1" /><span className="text-foreground">党组织管理</span>
      </div>
      <div className="flex items-center justify-between">
        <h2>党组织管理</h2>
        <button onClick={() => setShowAddOrg(true)} className="flex items-center gap-1.5 px-4 py-2 bg-primary text-white rounded-lg hover:bg-primary/90"><Plus className="w-4 h-4" /> 新增组织</button>
      </div>

      <div className="grid grid-cols-1 md:grid-cols-4 gap-4">
        {[
          { label: "党组织总数", value: "8", icon: Users, color: "#dc2626" },
          { label: "党员总数", value: "256", icon: User, color: "#1a56db" },
          { label: "预备党员", value: "12", icon: Star, color: "#f59e0b" },
          { label: "平均完整度", value: "94.6%", icon: BarChart3, color: "#10b981" },
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
        <h3 className="mb-3">组织架构树</h3>
        <div className="border border-border rounded-lg p-3">
          {renderNode(orgTree)}
        </div>
      </div>

      {/* Add Organization Modal */}
      <Modal open={showAddOrg} onClose={() => setShowAddOrg(false)} title="新增党组织">
        <div className="space-y-4">
          <div><label className="block text-[13px] text-muted-foreground mb-1">组织名称 *</label><input value={newOrgName} onChange={e => setNewOrgName(e.target.value)} placeholder="请输入党组织名称" className="bg-muted rounded-lg px-3 py-2 outline-none w-full" /></div>
          <div><label className="block text-[13px] text-muted-foreground mb-1">上级组织</label><select value={newOrgParent} onChange={e => setNewOrgParent(e.target.value)} className="bg-muted rounded-lg px-3 py-2 outline-none w-full"><option>博鳌镇党委</option><option>椰林村党支部</option><option>南强村党支部</option></select></div>
          <div className="flex justify-end gap-3 pt-2">
            <button onClick={() => setShowAddOrg(false)} className="px-4 py-2 border border-border rounded-lg hover:bg-muted">取消</button>
            <button onClick={() => { if (!newOrgName) { toast.error("请填写组织名称"); return; } toast.success("组织创建成功", { description: newOrgName }); setShowAddOrg(false); setNewOrgName(""); }} className="px-4 py-2 bg-primary text-white rounded-lg hover:bg-primary/90">保存</button>
          </div>
        </div>
      </Modal>

      {/* Organization Detail Modal */}
      <Modal open={!!showOrgDetail} onClose={() => setShowOrgDetail(null)} title="组织详情">
        {showOrgDetail && (
          <div className="space-y-3 text-[14px]">
            {[
              ["组织名称", showOrgDetail.name],
              ["党员人数", `${showOrgDetail.members}人`],
              ["信息完整度", `${showOrgDetail.completeness}%`],
              ["下级组织", showOrgDetail.children ? `${showOrgDetail.children.length}个` : "无"],
              ["创建时间", "2020-01-01"],
              ["负责人", showOrgDetail.key === "root" ? "镇党委书记" : showOrgDetail.key === "branch1" ? "符国强" : "待指定"],
            ].map(([label, value]) => (
              <div key={label} className="flex"><span className="text-muted-foreground w-24 flex-shrink-0">{label}</span><span>{value}</span></div>
            ))}
            <div className="pt-3 border-t border-border flex gap-2">
              <button onClick={() => { setShowOrgDetail(null); setShowEditOrg({ ...showOrgDetail }); }} className="px-4 py-2 border border-border rounded-lg hover:bg-muted text-[13px]">编辑组织</button>
              <button onClick={() => toast.info("调整上下级关系", { description: `${showOrgDetail.name} 的上下级关系调整功能` })} className="px-4 py-2 border border-border rounded-lg hover:bg-muted text-[13px]">调整层级</button>
            </div>
          </div>
        )}
      </Modal>

      {/* Edit Organization Modal */}
      <Modal open={!!showEditOrg} onClose={() => setShowEditOrg(null)} title="编辑组织">
        {showEditOrg && (
          <div className="space-y-4">
            <div><label className="block text-[13px] text-muted-foreground mb-1">组织名称</label><input value={showEditOrg.name} onChange={e => setShowEditOrg({ ...showEditOrg, name: e.target.value })} className="bg-muted rounded-lg px-3 py-2 outline-none w-full" /></div>
            <div><label className="block text-[13px] text-muted-foreground mb-1">上级组织</label><select className="bg-muted rounded-lg px-3 py-2 outline-none w-full"><option>博鳌镇党委</option><option>椰林村党支部</option></select></div>
            <div className="flex justify-end gap-3 pt-2">
              <button onClick={() => setShowEditOrg(null)} className="px-4 py-2 border border-border rounded-lg hover:bg-muted">取消</button>
              <button onClick={() => { toast.success("组织信息已更新", { description: showEditOrg.name }); setShowEditOrg(null); }} className="px-4 py-2 bg-primary text-white rounded-lg hover:bg-primary/90">保存</button>
            </div>
          </div>
        )}
      </Modal>

      {/* Delete Organization Confirm */}
      <ConfirmDialog open={!!showDeleteOrg} onClose={() => setShowDeleteOrg(null)} onConfirm={() => { toast.success("组织已删除", { description: showDeleteOrg?.name }); setShowDeleteOrg(null); }} title="删除组织" message={`确定要删除「${showDeleteOrg?.name}」吗？删除后该组织下的党员将移入上级组织。`} confirmText="删除" type="danger" />
    </div>
  );
}

// Party Member
export function PartyMember() {
  const [tab, setTab] = useState("list");
  const tabs = [
    { key: "list", label: "党员列表" },
    { key: "relation", label: "组织关系" },
  ];

  const members = [
    { id: 1, name: "符国强", gender: "男", age: 51, joinDate: "1998-07-01", education: "大专", position: "支部书记", status: "正式党员", group: "第一党小组" },
    { id: 2, name: "王海燕", gender: "女", age: 46, joinDate: "2003-12-15", education: "本科", position: "支委委员", status: "正式党员", group: "第一党小组" },
    { id: 3, name: "黄志明", gender: "男", age: 48, joinDate: "2001-06-30", education: "大专", position: "组织委员", status: "正式党员", group: "第二党小组" },
    { id: 4, name: "陈大文", gender: "男", age: 44, joinDate: "2005-07-01", education: "中专", position: "党小组长", status: "正式党员", group: "第三党小组" },
    { id: 5, name: "符永昌", gender: "男", age: 58, joinDate: "1990-10-01", education: "高中", position: "-", status: "正式党员", group: "第一党小组" },
    { id: 6, name: "王秀兰", gender: "女", age: 41, joinDate: "2010-07-01", education: "大专", position: "妇联主任", status: "正式党员", group: "第二党小组" },
    { id: 7, name: "林海涛", gender: "男", age: 34, joinDate: "2018-12-01", education: "本科", position: "-", status: "正式党员", group: "第三党小组" },
    { id: 8, name: "吴春花", gender: "女", age: 31, joinDate: "2020-06-30", education: "本科", position: "-", status: "预备党员", group: "第一党小组" },
  ];

  const relationRecords = [
    { id: 1, name: "林海涛", type: "转入", from: "海口市秀英区石山镇党支部", to: "椰林村党支部", date: "2018-11-15", status: "已完成", reason: "工作调动" },
    { id: 2, name: "吴春花", type: "转入", from: "海南大学学生党支部", to: "椰林村党支部", date: "2020-06-20", status: "已完成", reason: "毕业返乡" },
    { id: 3, name: "张文斌", type: "转出", from: "椰林村党支部", to: "琼海市嘉积镇党委", date: "2025-08-10", status: "已完成", reason: "工作调动" },
    { id: 4, name: "李春梅", type: "转出", from: "椰林村党支部", to: "三亚市天涯区党委", date: "2025-12-01", status: "已完成", reason: "随迁转出" },
    { id: 5, name: "符志豪", type: "转入", from: "博鳌镇南强村党支部", to: "椰林村党支部", date: "2026-01-15", status: "审核中", reason: "村级合并调整" },
    { id: 6, name: "陈小琴", type: "预备转正", from: "-", to: "椰林村党支部", date: "2026-03-01", status: "公示中", reason: "预备期满考察合格" },
  ];

  const [showAddMember, setShowAddMember] = useState(false);
  const [showMemberDetail, setShowMemberDetail] = useState<typeof members[0] | null>(null);
  const [showEditMember, setShowEditMember] = useState<typeof members[0] | null>(null);
  const [newMember, setNewMember] = useState({ name: "", gender: "男", education: "大专", group: "第一党小组" });
  const [relationFilter, setRelationFilter] = useState("全部");

  const filteredRelations = relationFilter === "全部" ? relationRecords : relationRecords.filter(r => r.type === relationFilter);

  return (
    <div className="space-y-4">
      <div className="flex items-center text-muted-foreground text-[13px]">
        <span>基层党建</span><ChevronRight className="w-4 h-4 mx-1" /><span className="text-foreground">党员管理</span>
      </div>
      <h2>党员管理</h2>

      <div className="bg-white rounded-xl border border-border shadow-sm">
        <div className="flex border-b border-border">
          {tabs.map((t) => (
            <button key={t.key} className={`px-5 py-3 border-b-2 transition-colors ${tab === t.key ? "border-primary text-primary" : "border-transparent text-muted-foreground"}`} onClick={() => setTab(t.key)}>
              {t.label}
            </button>
          ))}
        </div>

        {tab === "list" && (
        <div className="p-5">
          <div className="flex flex-wrap gap-3 mb-4">
            <div className="relative">
              <Search className="w-4 h-4 absolute left-3 top-1/2 -translate-y-1/2 text-muted-foreground" />
              <input type="text" placeholder="搜索党员姓名..." className="pl-9 pr-4 py-2 bg-muted rounded-lg w-[200px] outline-none" />
            </div>
            <select className="bg-muted rounded-lg px-3 py-2 outline-none"><option>全部状态</option><option>正式党员</option><option>预备党员</option></select>
            <select className="bg-muted rounded-lg px-3 py-2 outline-none"><option>全部党小组</option><option>第一党小组</option><option>第二党小组</option><option>第三党小组</option></select>
            <div className="flex-1" />
            <button onClick={() => setShowAddMember(true)} className="flex items-center gap-1.5 px-4 py-2 bg-primary text-white rounded-lg hover:bg-primary/90"><Plus className="w-4 h-4" /> 新增</button>
            <button onClick={() => toast.info("请选择 Excel 文件上传")} className="flex items-center gap-1 px-3 py-2 border border-border rounded-lg hover:bg-muted text-[13px]"><Upload className="w-4 h-4" /> 导入</button>
            <button onClick={() => toast.success("导出成功", { description: "党员信息已导出" })} className="flex items-center gap-1 px-3 py-2 border border-border rounded-lg hover:bg-muted text-[13px]"><Download className="w-4 h-4" /> 导出</button>
          </div>

          <div className="overflow-x-auto border border-border rounded-lg">
            <table className="w-full text-[13px]">
              <thead className="bg-muted/60">
                <tr>
                  <th className="py-3 px-3 text-left text-muted-foreground" style={{ fontWeight: 500 }}>姓名</th>
                  <th className="py-3 px-3 text-center text-muted-foreground" style={{ fontWeight: 500 }}>性别</th>
                  <th className="py-3 px-3 text-center text-muted-foreground" style={{ fontWeight: 500 }}>年龄</th>
                  <th className="py-3 px-3 text-left text-muted-foreground" style={{ fontWeight: 500 }}>入党时间</th>
                  <th className="py-3 px-3 text-left text-muted-foreground" style={{ fontWeight: 500 }}>学历</th>
                  <th className="py-3 px-3 text-left text-muted-foreground" style={{ fontWeight: 500 }}>职务</th>
                  <th className="py-3 px-3 text-left text-muted-foreground" style={{ fontWeight: 500 }}>党小组</th>
                  <th className="py-3 px-3 text-center text-muted-foreground" style={{ fontWeight: 500 }}>状态</th>
                  <th className="py-3 px-3 text-center text-muted-foreground" style={{ fontWeight: 500 }}>操作</th>
                </tr>
              </thead>
              <tbody>
                {members.map((row) => (
                  <tr key={row.id} className="border-t border-border/50 hover:bg-blue-50/30">
                    <td className="py-2.5 px-3">{row.name}</td>
                    <td className="py-2.5 px-3 text-center">{row.gender}</td>
                    <td className="py-2.5 px-3 text-center">{row.age}</td>
                    <td className="py-2.5 px-3 text-muted-foreground">{row.joinDate}</td>
                    <td className="py-2.5 px-3">{row.education}</td>
                    <td className="py-2.5 px-3">{row.position}</td>
                    <td className="py-2.5 px-3 text-muted-foreground">{row.group}</td>
                    <td className="py-2.5 px-3 text-center">
                      <span className={`px-2 py-0.5 rounded-full text-[12px] ${row.status === "正式党员" ? "bg-red-50 text-red-600" : "bg-amber-50 text-amber-600"}`}>{row.status}</span>
                    </td>
                    <td className="py-2.5 px-3">
                      <div className="flex items-center justify-center gap-1">
                        <button onClick={() => setShowMemberDetail(row)} className="p-1 hover:bg-muted rounded"><Eye className="w-4 h-4 text-muted-foreground" /></button>
                        <button onClick={() => setShowEditMember({ ...row })} className="p-1 hover:bg-muted rounded"><Edit className="w-4 h-4 text-muted-foreground" /></button>
                      </div>
                    </td>
                  </tr>
                ))}
              </tbody>
            </table>
          </div>
        </div>
        )}

        {tab === "relation" && (
        <div className="p-5">
          {/* Summary cards */}
          <div className="grid grid-cols-1 md:grid-cols-4 gap-4 mb-5">
            {[
              { label: "转入记录", value: "3", color: "#10b981", icon: ArrowRightLeft },
              { label: "转出记录", value: "2", color: "#f59e0b", icon: ArrowRightLeft },
              { label: "预备转正", value: "1", color: "#dc2626", icon: Star },
              { label: "审核中", value: "1", color: "#0ea5e9", icon: Clock },
            ].map(card => {
              const Icon = card.icon;
              return (
                <div key={card.label} className="bg-white rounded-lg p-3 border border-border">
                  <div className="flex items-center gap-2">
                    <div className="w-8 h-8 rounded-lg flex items-center justify-center" style={{ backgroundColor: `${card.color}15` }}>
                      <Icon className="w-4 h-4" style={{ color: card.color }} />
                    </div>
                    <div>
                      <p className="text-[16px]" style={{ fontWeight: 600 }}>{card.value}</p>
                      <p className="text-[11px] text-muted-foreground">{card.label}</p>
                    </div>
                  </div>
                </div>
              );
            })}
          </div>

          <div className="flex flex-wrap gap-3 mb-4">
            <div className="flex gap-1">
              {["全部", "转入", "转出", "预备转正"].map(f => (
                <button key={f} className={`px-3 py-1.5 rounded-lg text-[13px] ${relationFilter === f ? "bg-primary text-white" : "bg-muted text-muted-foreground hover:text-foreground"}`} onClick={() => setRelationFilter(f)}>{f}</button>
              ))}
            </div>
            <div className="flex-1" />
            <button onClick={() => toast.info("发起组织关系转接", { description: "请填写转接信息" })} className="flex items-center gap-1.5 px-4 py-2 bg-primary text-white rounded-lg hover:bg-primary/90"><Plus className="w-4 h-4" /> 发起转接</button>
            <button onClick={() => toast.success("导出成功", { description: "组织关系记录已导出" })} className="flex items-center gap-1 px-3 py-2 border border-border rounded-lg hover:bg-muted text-[13px]"><Download className="w-4 h-4" /> 导出</button>
          </div>

          <div className="overflow-x-auto border border-border rounded-lg">
            <table className="w-full text-[13px]">
              <thead className="bg-muted/60">
                <tr>
                  <th className="py-3 px-3 text-left text-muted-foreground" style={{ fontWeight: 500 }}>姓名</th>
                  <th className="py-3 px-3 text-center text-muted-foreground" style={{ fontWeight: 500 }}>类型</th>
                  <th className="py-3 px-3 text-left text-muted-foreground" style={{ fontWeight: 500 }}>转出单位</th>
                  <th className="py-3 px-3 text-left text-muted-foreground" style={{ fontWeight: 500 }}>转入单位</th>
                  <th className="py-3 px-3 text-left text-muted-foreground" style={{ fontWeight: 500 }}>日期</th>
                  <th className="py-3 px-3 text-left text-muted-foreground" style={{ fontWeight: 500 }}>原因</th>
                  <th className="py-3 px-3 text-center text-muted-foreground" style={{ fontWeight: 500 }}>状态</th>
                  <th className="py-3 px-3 text-center text-muted-foreground" style={{ fontWeight: 500 }}>操作</th>
                </tr>
              </thead>
              <tbody>
                {filteredRelations.length === 0 ? (
                  <tr><td colSpan={8} className="py-12 text-center text-muted-foreground">暂无匹配记录</td></tr>
                ) : filteredRelations.map(row => (
                  <tr key={row.id} className="border-t border-border/50 hover:bg-blue-50/30">
                    <td className="py-2.5 px-3" style={{ fontWeight: 500 }}>{row.name}</td>
                    <td className="py-2.5 px-3 text-center">
                      <span className={`px-2 py-0.5 rounded-full text-[12px] ${
                        row.type === "转入" ? "bg-green-50 text-green-600" :
                        row.type === "转出" ? "bg-amber-50 text-amber-600" :
                        "bg-red-50 text-red-600"
                      }`}>{row.type}</span>
                    </td>
                    <td className="py-2.5 px-3 text-muted-foreground text-[12px]">{row.from === "-" ? "-" : row.from}</td>
                    <td className="py-2.5 px-3 text-muted-foreground text-[12px]">{row.to}</td>
                    <td className="py-2.5 px-3 text-muted-foreground">{row.date}</td>
                    <td className="py-2.5 px-3 text-[12px]">{row.reason}</td>
                    <td className="py-2.5 px-3 text-center">
                      <span className={`px-2 py-0.5 rounded-full text-[12px] ${
                        row.status === "已完成" ? "bg-green-50 text-green-600" :
                        row.status === "审核中" ? "bg-blue-50 text-blue-600" :
                        "bg-amber-50 text-amber-600"
                      }`}>{row.status}</span>
                    </td>
                    <td className="py-2.5 px-3">
                      <div className="flex items-center justify-center gap-1">
                        <button onClick={() => toast.info("查看详情", { description: `${row.name} ${row.type}记录` })} className="p-1 hover:bg-muted rounded"><Eye className="w-4 h-4 text-muted-foreground" /></button>
                        {row.status !== "已完成" && (
                          <button onClick={() => toast.success("审核通过", { description: `${row.name} 的组织关系${row.type}已审核通过` })} className="p-1 hover:bg-green-50 rounded"><CheckCircle className="w-4 h-4 text-green-500" /></button>
                        )}
                      </div>
                    </td>
                  </tr>
                ))}
              </tbody>
            </table>
          </div>
          <div className="flex items-center justify-between mt-4 text-[13px]">
            <span className="text-muted-foreground">共 {filteredRelations.length} 条记录</span>
          </div>
        </div>
        )}

      </div>

      {/* Add Member Modal */}
      <Modal open={showAddMember} onClose={() => setShowAddMember(false)} title="新增党员">
        <div className="space-y-4">
          <div><label className="block text-[13px] text-muted-foreground mb-1">姓名 *</label><input value={newMember.name} onChange={e => setNewMember({ ...newMember, name: e.target.value })} placeholder="请输入姓名" className="bg-muted rounded-lg px-3 py-2 outline-none w-full" /></div>
          <div className="grid grid-cols-2 gap-4">
            <div><label className="block text-[13px] text-muted-foreground mb-1">性别</label><select value={newMember.gender} onChange={e => setNewMember({ ...newMember, gender: e.target.value })} className="bg-muted rounded-lg px-3 py-2 outline-none w-full"><option>男</option><option>女</option></select></div>
            <div><label className="block text-[13px] text-muted-foreground mb-1">学历</label><select value={newMember.education} onChange={e => setNewMember({ ...newMember, education: e.target.value })} className="bg-muted rounded-lg px-3 py-2 outline-none w-full"><option>高中</option><option>中专</option><option>大专</option><option>本科</option><option>硕士</option></select></div>
          </div>
          <div><label className="block text-[13px] text-muted-foreground mb-1">党小组</label><select value={newMember.group} onChange={e => setNewMember({ ...newMember, group: e.target.value })} className="bg-muted rounded-lg px-3 py-2 outline-none w-full"><option>第一党小组</option><option>第二党小组</option><option>第三党小组</option></select></div>
          <div className="flex justify-end gap-3 pt-2">
            <button onClick={() => setShowAddMember(false)} className="px-4 py-2 border border-border rounded-lg hover:bg-muted">取消</button>
            <button onClick={() => { if (!newMember.name) { toast.error("请填写姓名"); return; } toast.success("党员添加成功", { description: newMember.name }); setShowAddMember(false); setNewMember({ name: "", gender: "男", education: "大专", group: "第一党小组" }); }} className="px-4 py-2 bg-primary text-white rounded-lg hover:bg-primary/90">保存</button>
          </div>
        </div>
      </Modal>

      {/* Member Detail Modal */}
      <Modal open={!!showMemberDetail} onClose={() => setShowMemberDetail(null)} title="党员详情">
        {showMemberDetail && (
          <div className="space-y-3 text-[14px]">
            {[
              ["姓名", showMemberDetail.name],
              ["性别", showMemberDetail.gender],
              ["年龄", `${showMemberDetail.age}岁`],
              ["入党时间", showMemberDetail.joinDate],
              ["学历", showMemberDetail.education],
              ["职务", showMemberDetail.position],
              ["党小组", showMemberDetail.group],
              ["状态", showMemberDetail.status],
            ].map(([label, value]) => (
              <div key={label} className="flex"><span className="text-muted-foreground w-24 flex-shrink-0">{label}</span><span>{value}</span></div>
            ))}
          </div>
        )}
      </Modal>

      {/* Edit Member Modal */}
      <Modal open={!!showEditMember} onClose={() => setShowEditMember(null)} title="编辑党员信息">
        {showEditMember && (
          <div className="space-y-4">
            <div><label className="block text-[13px] text-muted-foreground mb-1">姓名</label><input value={showEditMember.name} onChange={e => setShowEditMember({ ...showEditMember, name: e.target.value })} className="bg-muted rounded-lg px-3 py-2 outline-none w-full" /></div>
            <div className="grid grid-cols-2 gap-4">
              <div><label className="block text-[13px] text-muted-foreground mb-1">职务</label><input value={showEditMember.position} onChange={e => setShowEditMember({ ...showEditMember, position: e.target.value })} className="bg-muted rounded-lg px-3 py-2 outline-none w-full" /></div>
              <div><label className="block text-[13px] text-muted-foreground mb-1">党小组</label><select value={showEditMember.group} onChange={e => setShowEditMember({ ...showEditMember, group: e.target.value })} className="bg-muted rounded-lg px-3 py-2 outline-none w-full"><option>第一党小组</option><option>第二党小组</option><option>第三党小组</option></select></div>
            </div>
            <div className="flex justify-end gap-3 pt-2">
              <button onClick={() => setShowEditMember(null)} className="px-4 py-2 border border-border rounded-lg hover:bg-muted">取消</button>
              <button onClick={() => { toast.success("党员信息已更新", { description: showEditMember.name }); setShowEditMember(null); }} className="px-4 py-2 bg-primary text-white rounded-lg hover:bg-primary/90">保存</button>
            </div>
          </div>
        )}
      </Modal>
    </div>
  );
}

// Party Study
export function PartyStudy() {
  const courses = [
    { id: 1, title: "习近平新时代中国特色社会主义思想", type: "必修", hours: 16, enrolled: 42, completed: 38, status: "进行中" },
    { id: 2, title: "海南自由贸易港建设政策解读", type: "必修", hours: 8, enrolled: 42, completed: 42, status: "已结束" },
    { id: 3, title: "乡村振兴战略与实践", type: "必修", hours: 12, enrolled: 42, completed: 35, status: "进行中" },
    { id: 4, title: "热带农业技术培训", type: "选修", hours: 6, enrolled: 28, completed: 25, status: "已结束" },
    { id: 5, title: "基层党组织建设规范化", type: "必修", hours: 10, enrolled: 42, completed: 20, status: "进���中" },
    { id: 6, title: "美丽乡村建设经验交流", type: "选修", hours: 4, enrolled: 35, completed: 0, status: "未开始" },
  ];

  const [showAddCourse, setShowAddCourse] = useState(false);
  const [showStudyModal, setShowStudyModal] = useState<typeof courses[0] | null>(null);
  const [showNotesModal, setShowNotesModal] = useState<typeof courses[0] | null>(null);
  const [showEvalModal, setShowEvalModal] = useState<typeof courses[0] | null>(null);
  const [newCourse, setNewCourse] = useState({ title: "", type: "必修", hours: "" });

  return (
    <div className="space-y-4">
      <div className="flex items-center text-muted-foreground text-[13px]">
        <span>基层党建</span><ChevronRight className="w-4 h-4 mx-1" /><span className="text-foreground">学习管理</span>
      </div>
      <h2>学习管理</h2>

      <div className="grid grid-cols-1 md:grid-cols-4 gap-4">
        {[
          { label: "课程总数", value: "6", icon: BookOpen, color: "#1a56db" },
          { label: "总学习时长", value: "44小时", icon: Clock, color: "#10b981" },
          { label: "平均完成率", value: "75%", icon: BarChart3, color: "#f59e0b" },
          { label: "学习笔记", value: "128篇", icon: FileText, color: "#8b5cf6" },
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
        <div className="flex items-center justify-between mb-4">
          <h3>课程列表</h3>
          <button onClick={() => setShowAddCourse(true)} className="flex items-center gap-1.5 px-4 py-2 bg-primary text-white rounded-lg hover:bg-primary/90"><Plus className="w-4 h-4" /> 发布课程</button>
        </div>
        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-4">
          {courses.map((course) => (
            <div key={course.id} className="border border-border rounded-xl p-4 hover:shadow-md hover:border-primary/30 transition-all cursor-pointer">
              <div className="flex items-start justify-between mb-2">
                <span className={`px-2 py-0.5 rounded text-[11px] ${
                  course.type === "必修" ? "bg-red-50 text-red-600" :
                  course.type === "选修" ? "bg-blue-50 text-blue-600" :
                  "bg-purple-50 text-purple-600"
                }`}>{course.type}</span>
                <span className="text-[12px] text-muted-foreground">{course.hours}小时</span>
              </div>
              <h4 className="mb-2">{course.title}</h4>
              <div className="flex items-center gap-4 text-[12px] text-muted-foreground mb-3">
                <span>{course.enrolled} 人参与</span>
                <span>{course.completed} 人完成</span>
              </div>
              {(() => {
                const rate = course.enrolled ? Math.round((course.completed / course.enrolled) * 100) : 0;
                return (
                  <div className="flex items-center gap-2">
                    <div className="flex-1 bg-muted rounded-full h-2">
                      <div className={`h-2 rounded-full ${rate >= 80 ? "bg-green-500" : rate >= 60 ? "bg-amber-500" : "bg-red-500"}`} style={{ width: `${rate}%` }} />
                    </div>
                    <span className="text-[12px] text-muted-foreground">{rate}%</span>
                  </div>
                );
              })()}
              <div className="flex gap-2 mt-3">
                <button onClick={() => setShowStudyModal(course)} className="flex-1 px-3 py-1.5 bg-primary text-white rounded-lg text-[12px] hover:bg-primary/90">进入学习</button>
                <button onClick={() => setShowNotesModal(course)} className="px-3 py-1.5 border border-border rounded-lg text-[12px] hover:bg-muted">笔记</button>
                <button onClick={() => setShowEvalModal(course)} className="px-3 py-1.5 border border-border rounded-lg text-[12px] hover:bg-muted">评价</button>
              </div>
            </div>
          ))}
        </div>
      </div>

      {/* Add Course Modal */}
      <Modal open={showAddCourse} onClose={() => setShowAddCourse(false)} title="发布课程">
        <div className="space-y-4">
          <div><label className="block text-[13px] text-muted-foreground mb-1">课程名称 *</label><input value={newCourse.title} onChange={e => setNewCourse({ ...newCourse, title: e.target.value })} placeholder="请输入课程名称" className="bg-muted rounded-lg px-3 py-2 outline-none w-full" /></div>
          <div className="grid grid-cols-2 gap-4">
            <div><label className="block text-[13px] text-muted-foreground mb-1">课程类型</label><select value={newCourse.type} onChange={e => setNewCourse({ ...newCourse, type: e.target.value })} className="bg-muted rounded-lg px-3 py-2 outline-none w-full"><option>必修</option><option>选修</option></select></div>
            <div><label className="block text-[13px] text-muted-foreground mb-1">学时</label><input type="number" value={newCourse.hours} onChange={e => setNewCourse({ ...newCourse, hours: e.target.value })} placeholder="0" className="bg-muted rounded-lg px-3 py-2 outline-none w-full" /></div>
          </div>
          <div><label className="block text-[13px] text-muted-foreground mb-1">课程描述</label><textarea placeholder="请输入课程描述..." className="bg-muted rounded-lg px-3 py-2 outline-none w-full h-20 resize-none" /></div>
          <div className="flex justify-end gap-3 pt-2">
            <button onClick={() => setShowAddCourse(false)} className="px-4 py-2 border border-border rounded-lg hover:bg-muted">取消</button>
            <button onClick={() => { if (!newCourse.title) { toast.error("请填写课程名称"); return; } toast.success("课程发布成功", { description: newCourse.title }); setShowAddCourse(false); setNewCourse({ title: "", type: "必修", hours: "" }); }} className="px-4 py-2 bg-primary text-white rounded-lg hover:bg-primary/90">发布</button>
          </div>
        </div>
      </Modal>

      {/* Study Modal */}
      <Modal open={!!showStudyModal} onClose={() => setShowStudyModal(null)} title="课程学习" width="max-w-xl">
        {showStudyModal && (
          <div className="space-y-4">
            <div className="bg-blue-50 rounded-lg p-4">
              <div className="flex items-center gap-2 mb-2"><span className={`px-2 py-0.5 rounded text-[11px] ${showStudyModal.type === "必修" ? "bg-red-50 text-red-600" : "bg-blue-50 text-blue-600"}`}>{showStudyModal.type}</span><span className="text-[12px] text-muted-foreground">{showStudyModal.hours}学时</span></div>
              <h4>{showStudyModal.title}</h4>
              <p className="text-[13px] text-muted-foreground mt-2">{showStudyModal.enrolled}人参与 · {showStudyModal.completed}人已完成</p>
            </div>
            <div className="border border-border rounded-lg p-4">
              <h4 className="text-[13px] text-muted-foreground mb-3">课程大纲</h4>
              <div className="space-y-2">
                {["第一章 理论基础", "第二章 实践探索", "第三章 案例分析", "第四章 学习总结"].map((ch, i) => (
                  <div key={ch} className="flex items-center gap-2 py-1.5"><CheckCircle className={`w-4 h-4 ${i < 2 ? "text-green-500" : "text-muted-foreground/30"}`} /><span className="text-[13px]">{ch}</span></div>
                ))}
              </div>
            </div>
            <div className="flex justify-end gap-3">
              <button onClick={() => { toast.success("学习记录已保存"); setShowStudyModal(null); }} className="px-4 py-2 bg-primary text-white rounded-lg hover:bg-primary/90">继续学习</button>
            </div>
          </div>
        )}
      </Modal>

      {/* Notes Modal */}
      <Modal open={!!showNotesModal} onClose={() => setShowNotesModal(null)} title="学习笔记">
        {showNotesModal && (
          <div className="space-y-4">
            <p className="text-[13px] text-muted-foreground">{showNotesModal.title}</p>
            <div className="space-y-3">
              {[
                { author: "符国强", date: "2026-03-08", content: "学习了理论基础部分，对核心概念有了更深的理解。" },
                { author: "王海燕", date: "2026-03-07", content: "案例分析部分很有启发，结合椰林村实际，可以在乡村振兴中借鉴。" },
              ].map(note => (
                <div key={note.author + note.date} className="border border-border rounded-lg p-3">
                  <div className="flex items-center justify-between text-[12px] text-muted-foreground mb-2"><span>{note.author}</span><span>{note.date}</span></div>
                  <p className="text-[13px]">{note.content}</p>
                </div>
              ))}
            </div>
            <div><textarea placeholder="写下你的学习笔记..." className="bg-muted rounded-lg px-3 py-2 outline-none w-full h-20 resize-none" /></div>
            <div className="flex justify-end gap-3">
              <button onClick={() => { toast.success("笔记已保存"); setShowNotesModal(null); }} className="px-4 py-2 bg-primary text-white rounded-lg hover:bg-primary/90">保存笔记</button>
            </div>
          </div>
        )}
      </Modal>

      {/* Evaluation Modal */}
      <Modal open={!!showEvalModal} onClose={() => setShowEvalModal(null)} title="课程评价">
        {showEvalModal && (
          <div className="space-y-4">
            <p className="text-[13px] text-muted-foreground">{showEvalModal.title}</p>
            <div><label className="block text-[13px] text-muted-foreground mb-1">评分</label>
              <div className="flex gap-1">{[1,2,3,4,5].map(s => (<button key={s} className="text-[20px] text-amber-400 hover:scale-110 transition-transform">★</button>))}</div>
            </div>
            <div><label className="block text-[13px] text-muted-foreground mb-1">评价内容</label><textarea placeholder="请输入您对课程的评价..." className="bg-muted rounded-lg px-3 py-2 outline-none w-full h-20 resize-none" /></div>
            <div className="flex justify-end gap-3">
              <button onClick={() => { toast.success("评价已提交"); setShowEvalModal(null); }} className="px-4 py-2 bg-primary text-white rounded-lg hover:bg-primary/90">提交评价</button>
            </div>
          </div>
        )}
      </Modal>
    </div>
  );
}

// Party Exam
type ExamQuestion = { id: number; question: string; options: string[]; answer: number };

const examQuestionBank: Record<string, ExamQuestion[]> = {
  "党章党规知识测试": [
    { id: 1, question: "中国共产党的最高理想和最终目标是什么？", options: ["实现共产主义", "实现社会主义现代化", "全面建成小康社会", "实现中华民族伟大复兴"], answer: 0 },
    { id: 2, question: "党的根本宗旨是什么？", options: ["为人民服务", "解放生产力", "消灭剥削", "实现共同富裕"], answer: 0 },
    { id: 3, question: "入党誓词中，'随时准备为党和人民牺牲一切'体现了什么精神？", options: ["集体主义精神", "奉献精神", "创新精神", "科学精神"], answer: 1 },
    { id: 4, question: "党章规定，党员必须履行的义务有多少条？", options: ["六条", "七条", "八条", "九条"], answer: 2 },
    { id: 5, question: "中国共产党的根本组织原则是什么？", options: ["集体领导", "民主集中制", "个人负责制", "少数服从多数"], answer: 1 },
  ],
  "廉政法规测试": [
    { id: 1, question: "《中国共产党廉洁自律准则》的适用对象是？", options: ["全体党员", "党员领导干部", "国家公务员", "全体党员和党员领导干部"], answer: 3 },
    { id: 2, question: "党员干部违反廉洁纪律的处分种类不包括以下哪项？", options: ["警告", "严重警告", "罚款", "开除党籍"], answer: 2 },
    { id: 3, question: "监察法规定，监察机关对公职人员涉嫌职务违法和职务犯罪进行什么？", options: ["调查", "侦查", "审查", "核查"], answer: 0 },
    { id: 4, question: "以下哪种行为属于违反中央八项规定精神？", options: ["正常公务接待", "公款旅游", "因公出差", "参加组织生活"], answer: 1 },
    { id: 5, question: "村级集体经济组织的财务公开制度要求多久公开一次？", options: ["每年", "每半年", "每季度", "每月"], answer: 3 },
  ],
};

export function PartyExam() {
  const [exams, setExams] = useState([
    { id: 1, title: "党章党规知识测试", date: "2026-03-15", duration: "60分钟", total: 42, submitted: 0, avgScore: null as number | null, status: "未开始" },
    { id: 2, title: "海南自贸港政策知识竞赛", date: "2026-02-28", duration: "45分钟", total: 42, submitted: 42, avgScore: 86.5, status: "已结束" },
    { id: 3, title: "乡村振兴理论考试", date: "2026-01-20", duration: "90分钟", total: 42, submitted: 40, avgScore: 78.2, status: "已结束" },
    { id: 4, title: "廉政法规测试", date: "2026-03-25", duration: "60分钟", total: 42, submitted: 0, avgScore: null, status: "未开始" },
  ]);

  const [showAddExam, setShowAddExam] = useState(false);
  const [showExamDetail, setShowExamDetail] = useState<typeof exams[0] | null>(null);
  const [showScoreDetail, setShowScoreDetail] = useState<typeof exams[0] | null>(null);
  const [newExam, setNewExam] = useState({ title: "", date: "", duration: "60分钟" });

  // Exam taking state
  const [takingExam, setTakingExam] = useState<typeof exams[0] | null>(null);
  const [answers, setAnswers] = useState<Record<number, number>>({});
  const [examResult, setExamResult] = useState<{ exam: typeof exams[0]; score: number; total: number; correct: number; answers: Record<number, number> } | null>(null);

  const handleStartExam = (id: number) => {
    const exam = exams.find(e => e.id === id);
    if (!exam) return;
    // Start the exam and open taking view
    setExams(exams.map(e => e.id === id ? { ...e, status: "进行中" } : e));
    setTakingExam({ ...exam, status: "进行中" });
    setAnswers({});
    setExamResult(null);
    toast.success("考试已开始", { description: `${exam.title} 开始作答` });
  };

  const handleSubmitExam = () => {
    if (!takingExam) return;
    const questions = examQuestionBank[takingExam.title] || examQuestionBank["党章党规知识测试"];
    let correct = 0;
    questions.forEach(q => { if (answers[q.id] === q.answer) correct++; });
    const score = Math.round((correct / questions.length) * 100);
    setExamResult({ exam: takingExam, score, total: questions.length, correct, answers });
    setTakingExam(null);

    // Update exam status
    const mockAvg = Math.round((70 + Math.random() * 15) * 10) / 10;
    setExams(prev => prev.map(e => e.id === takingExam.id ? { ...e, status: "已结束", avgScore: mockAvg, submitted: e.total } : e));
    toast.success("考试提交成功", { description: `得分：${score}分` });
  };

  const handleEndExam = (id: number) => {
    const exam = exams.find(e => e.id === id);
    const mockAvg = Math.round((70 + Math.random() * 20) * 10) / 10;
    setExams(exams.map(e => e.id === id ? { ...e, status: "已结束", avgScore: mockAvg, submitted: e.total } : e));
    toast.success("考试已结束", { description: `${exam?.title} 平均分 ${mockAvg}分` });
  };

  // ====== EXAM TAKING VIEW ======
  if (takingExam) {
    const questions = examQuestionBank[takingExam.title] || examQuestionBank["党章党规知识测试"];
    const answeredCount = Object.keys(answers).length;
    return (
      <div className="space-y-4">
        <div className="flex items-center text-muted-foreground text-[13px]">
          <span>基层党建</span><ChevronRight className="w-4 h-4 mx-1" /><span>在线考试</span><ChevronRight className="w-4 h-4 mx-1" /><span className="text-foreground">作答中</span>
        </div>
        <div className="flex items-center justify-between">
          <h2>{takingExam.title}</h2>
          <div className="flex items-center gap-3">
            <span className="text-[13px] text-muted-foreground"><Clock className="w-4 h-4 inline mr-1" />时长：{takingExam.duration}</span>
            <span className="text-[13px] px-3 py-1 bg-blue-50 text-blue-600 rounded-full">已答 {answeredCount}/{questions.length}</span>
          </div>
        </div>
        <div className="bg-amber-50 border border-amber-200 rounded-lg p-3 text-[13px] text-amber-700">
          请认真作答每道题目，选择正确答案后点击底部"提交试卷"按钮完成考试。共 {questions.length} 道单选题，每题 {Math.round(100 / questions.length)} 分。
        </div>
        <div className="space-y-4">
          {questions.map((q, idx) => (
            <div key={q.id} className="bg-white rounded-xl border border-border shadow-sm p-5">
              <div className="flex items-start gap-3 mb-4">
                <span className="flex-shrink-0 w-7 h-7 rounded-full bg-primary/10 text-primary flex items-center justify-center text-[13px]" style={{ fontWeight: 600 }}>{idx + 1}</span>
                <p className="text-[14px] pt-0.5">{q.question}</p>
              </div>
              <div className="space-y-2 ml-10">
                {q.options.map((opt, optIdx) => (
                  <label key={optIdx} className={`flex items-center gap-3 px-4 py-3 rounded-lg border cursor-pointer transition-colors ${answers[q.id] === optIdx ? "border-primary bg-primary/5" : "border-border hover:bg-muted/50"}`}>
                    <div className={`w-5 h-5 rounded-full border-2 flex items-center justify-center flex-shrink-0 ${answers[q.id] === optIdx ? "border-primary" : "border-gray-300"}`}>
                      {answers[q.id] === optIdx && <div className="w-2.5 h-2.5 rounded-full bg-primary" />}
                    </div>
                    <span className="text-[13px]">{String.fromCharCode(65 + optIdx)}. {opt}</span>
                    <input type="radio" name={`q-${q.id}`} className="hidden" checked={answers[q.id] === optIdx} onChange={() => setAnswers({ ...answers, [q.id]: optIdx })} />
                  </label>
                ))}
              </div>
            </div>
          ))}
        </div>
        <div className="bg-white rounded-xl border border-border shadow-sm p-5 flex items-center justify-between">
          <button onClick={() => { setTakingExam(null); toast.info("已退出考试"); }} className="px-4 py-2 border border-border rounded-lg hover:bg-muted text-[13px]"><ArrowLeft className="w-4 h-4 inline mr-1" />退出考试</button>
          <div className="flex items-center gap-3">
            <span className="text-[13px] text-muted-foreground">已完成 {answeredCount}/{questions.length} 题</span>
            <button onClick={() => { if (answeredCount < questions.length) { toast.error(`还有 ${questions.length - answeredCount} 题未作答，请完成所有题目`); return; } handleSubmitExam(); }} className="px-6 py-2.5 bg-primary text-white rounded-lg hover:bg-primary/90"><CheckCircle className="w-4 h-4 inline mr-1" />提交试卷</button>
          </div>
        </div>
      </div>
    );
  }

  // ====== EXAM RESULT VIEW ======
  if (examResult) {
    const questions = examQuestionBank[examResult.exam.title] || examQuestionBank["党章党规知识测试"];
    return (
      <div className="space-y-4">
        <div className="flex items-center text-muted-foreground text-[13px]">
          <span>基层党建</span><ChevronRight className="w-4 h-4 mx-1" /><span>在线考试</span><ChevronRight className="w-4 h-4 mx-1" /><span className="text-foreground">考试结果</span>
        </div>
        <div className="bg-white rounded-xl border border-border shadow-sm p-8 text-center">
          <div className={`w-24 h-24 rounded-full mx-auto flex items-center justify-center mb-4 ${examResult.score >= 80 ? "bg-green-100" : examResult.score >= 60 ? "bg-amber-100" : "bg-red-100"}`}>
            <span className="text-[32px]" style={{ fontWeight: 700, color: examResult.score >= 80 ? "#10b981" : examResult.score >= 60 ? "#f59e0b" : "#ef4444" }}>{examResult.score}</span>
          </div>
          <h2 className="mb-1">{examResult.score >= 80 ? "优秀" : examResult.score >= 60 ? "合格" : "不合格"}</h2>
          <p className="text-muted-foreground text-[14px]">{examResult.exam.title}</p>
          <div className="grid grid-cols-3 gap-4 mt-6 max-w-md mx-auto">
            <div className="bg-muted/30 rounded-lg p-3"><p className="text-[12px] text-muted-foreground">总题数</p><p className="text-[20px]" style={{ fontWeight: 600 }}>{examResult.total}</p></div>
            <div className="bg-green-50 rounded-lg p-3"><p className="text-[12px] text-muted-foreground">正确</p><p className="text-[20px] text-green-600" style={{ fontWeight: 600 }}>{examResult.correct}</p></div>
            <div className="bg-red-50 rounded-lg p-3"><p className="text-[12px] text-muted-foreground">错误</p><p className="text-[20px] text-red-500" style={{ fontWeight: 600 }}>{examResult.total - examResult.correct}</p></div>
          </div>
        </div>

        <div className="bg-white rounded-xl border border-border shadow-sm p-5">
          <h3 className="mb-4">答题详情</h3>
          <div className="space-y-3">
            {questions.map((q, idx) => {
              const userAns = examResult.answers[q.id];
              const isCorrect = userAns === q.answer;
              return (
                <div key={q.id} className={`rounded-lg border p-4 ${isCorrect ? "border-green-200 bg-green-50/30" : "border-red-200 bg-red-50/30"}`}>
                  <div className="flex items-start gap-2 mb-2">
                    <span className={`flex-shrink-0 w-6 h-6 rounded-full flex items-center justify-center text-[12px] text-white ${isCorrect ? "bg-green-500" : "bg-red-500"}`}>{idx + 1}</span>
                    <p className="text-[13px]">{q.question}</p>
                  </div>
                  <div className="ml-8 text-[13px] space-y-1">
                    <p><span className="text-muted-foreground">你的答案：</span><span className={isCorrect ? "text-green-600" : "text-red-500"}>{userAns !== undefined ? `${String.fromCharCode(65 + userAns)}. ${q.options[userAns]}` : "未作答"}</span></p>
                    {!isCorrect && <p><span className="text-muted-foreground">正确答案：</span><span className="text-green-600">{String.fromCharCode(65 + q.answer)}. {q.options[q.answer]}</span></p>}
                  </div>
                </div>
              );
            })}
          </div>
        </div>

        <div className="flex justify-center gap-3">
          <button onClick={() => setExamResult(null)} className="px-6 py-2.5 bg-primary text-white rounded-lg hover:bg-primary/90"><ArrowLeft className="w-4 h-4 inline mr-1" />返回考试列表</button>
          <button onClick={() => toast.success("成绩已导出")} className="px-6 py-2.5 border border-border rounded-lg hover:bg-muted text-[13px]"><Download className="w-4 h-4 inline mr-1" />导出成绩</button>
        </div>
      </div>
    );
  }

  return (
    <div className="space-y-4">
      <div className="flex items-center text-muted-foreground text-[13px]">
        <span>基层党建</span><ChevronRight className="w-4 h-4 mx-1" /><span className="text-foreground">在线考试</span>
      </div>
      <div className="flex items-center justify-between">
        <h2>在线考试</h2>
        <button onClick={() => setShowAddExam(true)} className="flex items-center gap-1.5 px-4 py-2 bg-primary text-white rounded-lg hover:bg-primary/90"><Plus className="w-4 h-4" /> 组织考试</button>
      </div>

      <div className="bg-white rounded-xl border border-border shadow-sm p-5">
        <div className="overflow-x-auto border border-border rounded-lg">
          <table className="w-full text-[13px]">
            <thead className="bg-muted/60">
              <tr>
                <th className="py-3 px-3 text-left text-muted-foreground" style={{ fontWeight: 500 }}>考试名称</th>
                <th className="py-3 px-3 text-center text-muted-foreground" style={{ fontWeight: 500 }}>考试日期</th>
                <th className="py-3 px-3 text-center text-muted-foreground" style={{ fontWeight: 500 }}>考试时长</th>
                <th className="py-3 px-3 text-center text-muted-foreground" style={{ fontWeight: 500 }}>参考人数</th>
                <th className="py-3 px-3 text-center text-muted-foreground" style={{ fontWeight: 500 }}>平均分</th>
                <th className="py-3 px-3 text-center text-muted-foreground" style={{ fontWeight: 500 }}>状态</th>
                <th className="py-3 px-3 text-center text-muted-foreground" style={{ fontWeight: 500 }}>操作</th>
              </tr>
            </thead>
            <tbody>
              {exams.map((row) => (
                <tr key={row.id} className="border-t border-border/50 hover:bg-blue-50/30">
                  <td className="py-2.5 px-3">{row.title}</td>
                  <td className="py-2.5 px-3 text-center">{row.date}</td>
                  <td className="py-2.5 px-3 text-center">{row.duration}</td>
                  <td className="py-2.5 px-3 text-center">{row.total}</td>
                  <td className="py-2.5 px-3 text-center" style={{ fontWeight: 500 }}>{row.avgScore == null ? "-" : `${row.avgScore}分`}</td>
                  <td className="py-2.5 px-3 text-center">
                    <span className={`px-2 py-0.5 rounded-full text-[12px] ${row.status === "已结束" ? "bg-gray-100 text-gray-500" : "bg-blue-50 text-blue-600"}`}>{row.status}</span>
                  </td>
                  <td className="py-2.5 px-3">
                    <div className="flex items-center justify-center gap-1">
                      <button onClick={() => setShowExamDetail(row)} className="p-1 hover:bg-muted rounded"><Eye className="w-4 h-4 text-muted-foreground" /></button>
                      {row.status === "未开始" && (
                        <button onClick={() => handleStartExam(row.id)} className="px-2 py-1 bg-primary text-white rounded text-[12px] hover:bg-primary/90">开始</button>
                      )}
                      {row.status === "进行中" && (
                        <button onClick={() => handleEndExam(row.id)} className="px-2 py-1 bg-red-500 text-white rounded text-[12px] hover:bg-red-600">结束</button>
                      )}
                      {row.status === "已结束" && (
                        <button onClick={() => setShowScoreDetail(row)} className="px-2 py-1 border border-border rounded text-[12px] hover:bg-muted">成绩</button>
                      )}
                    </div>
                  </td>
                </tr>
              ))}
            </tbody>
          </table>
        </div>
      </div>

      {/* Add Exam Modal */}
      <Modal open={showAddExam} onClose={() => setShowAddExam(false)} title="组织考试">
        <div className="space-y-4">
          <div><label className="block text-[13px] text-muted-foreground mb-1">考试名称 *</label><input value={newExam.title} onChange={e => setNewExam({ ...newExam, title: e.target.value })} placeholder="请输入考试名称" className="bg-muted rounded-lg px-3 py-2 outline-none w-full" /></div>
          <div className="grid grid-cols-2 gap-4">
            <div><label className="block text-[13px] text-muted-foreground mb-1">考试日期</label><input type="date" value={newExam.date} onChange={e => setNewExam({ ...newExam, date: e.target.value })} className="bg-muted rounded-lg px-3 py-2 outline-none w-full" /></div>
            <div><label className="block text-[13px] text-muted-foreground mb-1">考试时长</label><select value={newExam.duration} onChange={e => setNewExam({ ...newExam, duration: e.target.value })} className="bg-muted rounded-lg px-3 py-2 outline-none w-full"><option>30分钟</option><option>45分钟</option><option>60分钟</option><option>90分钟</option><option>120分钟</option></select></div>
          </div>
          <div><label className="block text-[13px] text-muted-foreground mb-1">参考人员</label><select className="bg-muted rounded-lg px-3 py-2 outline-none w-full"><option>全体党员（42人）</option><option>第一党小组（15人）</option><option>第二党小组（14人）</option><option>第三党小组（13人）</option></select></div>
          <div className="flex justify-end gap-3 pt-2">
            <button onClick={() => setShowAddExam(false)} className="px-4 py-2 border border-border rounded-lg hover:bg-muted">取消</button>
            <button onClick={() => { if (!newExam.title) { toast.error("请填写考试名称"); return; } setExams([{ id: exams.length + 10, title: newExam.title, date: newExam.date || "2026-04-01", duration: newExam.duration, total: 42, submitted: 0, avgScore: null, status: "未开始" }, ...exams]); toast.success("考试已创建", { description: newExam.title }); setShowAddExam(false); setNewExam({ title: "", date: "", duration: "60分钟" }); }} className="px-4 py-2 bg-primary text-white rounded-lg hover:bg-primary/90">创建</button>
          </div>
        </div>
      </Modal>

      {/* Exam Detail Modal */}
      <Modal open={!!showExamDetail} onClose={() => setShowExamDetail(null)} title="考试详情">
        {showExamDetail && (
          <div className="space-y-3 text-[14px]">
            {[
              ["考试名称", showExamDetail.title],
              ["考试日期", showExamDetail.date],
              ["考试时长", showExamDetail.duration],
              ["参考人数", `${showExamDetail.total}人`],
              ["已交卷", `${showExamDetail.submitted}人`],
              ["平均分", showExamDetail.avgScore != null ? `${showExamDetail.avgScore}分` : "-"],
              ["状态", showExamDetail.status],
            ].map(([label, value]) => (
              <div key={label} className="flex"><span className="text-muted-foreground w-24 flex-shrink-0">{label}</span><span>{value}</span></div>
            ))}
          </div>
        )}
      </Modal>

      {/* Score Detail Modal */}
      <Modal open={!!showScoreDetail} onClose={() => setShowScoreDetail(null)} title="成绩详情" width="max-w-xl">
        {showScoreDetail && (
          <div className="space-y-4">
            <div className="bg-blue-50 rounded-lg p-4">
              <h4>{showScoreDetail.title}</h4>
              <p className="text-[13px] text-muted-foreground mt-1">平均分：{showScoreDetail.avgScore}分 | 参考：{showScoreDetail.submitted}/{showScoreDetail.total}人</p>
            </div>
            <div className="overflow-x-auto border border-border rounded-lg">
              <table className="w-full text-[13px]">
                <thead className="bg-muted/60">
                  <tr>
                    <th className="py-2.5 px-3 text-left text-muted-foreground" style={{ fontWeight: 500 }}>姓名</th>
                    <th className="py-2.5 px-3 text-center text-muted-foreground" style={{ fontWeight: 500 }}>成绩</th>
                    <th className="py-2.5 px-3 text-center text-muted-foreground" style={{ fontWeight: 500 }}>排名</th>
                  </tr>
                </thead>
                <tbody>
                  {[
                    { name: "符国强", score: 95, rank: 1 },
                    { name: "王海燕", score: 92, rank: 2 },
                    { name: "黄志明", score: 88, rank: 3 },
                    { name: "陈大文", score: 85, rank: 4 },
                    { name: "林海涛", score: 82, rank: 5 },
                  ].map(s => (
                    <tr key={s.name} className="border-t border-border/50">
                      <td className="py-2 px-3">{s.name}</td>
                      <td className="py-2 px-3 text-center" style={{ fontWeight: 500, color: s.score >= 90 ? "#10b981" : s.score >= 80 ? "#f59e0b" : "#ef4444" }}>{s.score}分</td>
                      <td className="py-2 px-3 text-center text-muted-foreground">第{s.rank}名</td>
                    </tr>
                  ))}
                </tbody>
              </table>
            </div>
            <div className="flex justify-end gap-2">
              <button onClick={() => toast.success("成绩导出成功")} className="px-4 py-2 border border-border rounded-lg text-[13px] hover:bg-muted"><Download className="w-4 h-4 inline mr-1" />导出成绩</button>
            </div>
          </div>
        )}
      </Modal>
    </div>
  );
}