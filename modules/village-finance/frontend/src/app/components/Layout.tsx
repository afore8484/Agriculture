import { useState } from "react";
import { Outlet, useNavigate, useLocation } from "react-router";
import { Toaster } from "sonner";
import {
  LayoutDashboard,
  Landmark,
  BarChart3,
  Package,
  FileText,
  CheckSquare,
  Building2,
  Users,
  ChevronDown,
  ChevronRight,
  Bell,
  Search,
  User,
  LogOut,
  Settings,
  Menu,
  X,
} from "lucide-react";

const menuItems = [
  {
    key: "dashboard",
    label: "工作台",
    icon: LayoutDashboard,
    path: "/",
  },
  {
    key: "finance",
    label: "财务中心",
    icon: Landmark,
    children: [
      { key: "cashier", label: "出纳管理", path: "/finance/cashier" },
      { key: "voucher", label: "凭证管理", path: "/finance/voucher" },
      { key: "ledger", label: "账簿管理", path: "/finance/ledger" },
      { key: "period-end", label: "期末处理", path: "/finance/period-end" },
      { key: "finance-settings", label: "财务设置", path: "/finance/settings" },
    ],
  },
  {
    key: "report",
    label: "报表中心",
    icon: BarChart3,
    children: [
      { key: "balance-sheet", label: "资产负债表", path: "/report/balance-sheet" },
      { key: "income-statement", label: "收益分配表", path: "/report/income" },
      { key: "progress", label: "做账进度", path: "/report/progress" },
      { key: "statistics", label: "统计报表", path: "/report/statistics" },
    ],
  },
  {
    key: "asset",
    label: "资产管理",
    icon: Package,
    children: [
      { key: "asset-list", label: "资产列表", path: "/asset/list" },
      { key: "depreciation", label: "资产折旧", path: "/asset/depreciation" },
      { key: "asset-report", label: "资产报表", path: "/asset/report" },
      { key: "asset-settle", label: "资产结账", path: "/asset/settle" },
    ],
  },
  {
    key: "contract",
    label: "合同管理",
    icon: FileText,
    children: [
      { key: "contract-list", label: "合同列表", path: "/contract/list" },
      { key: "contract-change", label: "合同变更", path: "/contract/change" },
      { key: "contract-report", label: "合同报表", path: "/contract/report" },
    ],
  },
  {
    key: "approval",
    label: "在线审批",
    icon: CheckSquare,
    children: [
      { key: "approval-center", label: "审批中心", path: "/approval/center" },
      { key: "payment-mgmt", label: "支付管理", path: "/approval/payment" },
      { key: "approval-config", label: "审批配置", path: "/approval/config" },
      { key: "approval-history", label: "历史审批", path: "/approval/history" },
    ],
  },
  {
    key: "bank",
    label: "银农直联",
    icon: Building2,
    children: [
      { key: "bank-setting", label: "银行设置", path: "/bank/setting" },
      { key: "bank-account", label: "账户管理", path: "/bank/account" },
      { key: "bank-partner", label: "往来管理", path: "/bank/partner" },
    ],
  },
  {
    key: "party",
    label: "基层党建",
    icon: Users,
    children: [
      { key: "party-org", label: "党组织管理", path: "/party/org" },
      { key: "party-member", label: "党员管理", path: "/party/member" },
      { key: "party-study", label: "学习管理", path: "/party/study" },
      { key: "party-exam", label: "在线考试", path: "/party/exam" },
    ],
  },
];

export function Layout() {
  const [collapsed, setCollapsed] = useState(false);
  const [expandedKeys, setExpandedKeys] = useState<string[]>(["finance"]);
  const navigate = useNavigate();
  const location = useLocation();

  const toggleExpand = (key: string) => {
    setExpandedKeys((prev) =>
      prev.includes(key) ? prev.filter((k) => k !== key) : [...prev, key]
    );
  };

  const isActive = (path: string) => location.pathname === path;
  const isParentActive = (children: { path: string }[]) =>
    children.some((c) => location.pathname.startsWith(c.path));

  return (
    <div className="flex h-screen w-full overflow-hidden">
      <Toaster position="top-right" richColors closeButton />
      {/* Sidebar */}
      <aside
        className={`${
          collapsed ? "w-[60px]" : "w-[240px]"
        } flex-shrink-0 bg-sidebar text-sidebar-foreground flex flex-col transition-all duration-300 overflow-hidden`}
      >
        {/* Logo */}
        <div className="h-[56px] flex items-center px-4 border-b border-sidebar-border flex-shrink-0">
          {!collapsed && (
            <div className="flex items-center gap-2">
              <div className="w-8 h-8 rounded-lg bg-white/20 flex items-center justify-center">
                <Landmark className="w-5 h-5 text-white" />
              </div>
              <span className="text-white whitespace-nowrap">琼海村委财务系统</span>
            </div>
          )}
          {collapsed && (
            <div className="w-8 h-8 rounded-lg bg-white/20 flex items-center justify-center mx-auto">
              <Landmark className="w-5 h-5 text-white" />
            </div>
          )}
        </div>

        {/* Menu */}
        <nav className="flex-1 overflow-y-auto py-2 scrollbar-thin">
          {menuItems.map((item) => {
            const Icon = item.icon;
            const hasChildren = item.children && item.children.length > 0;
            const isExpanded = expandedKeys.includes(item.key);
            const parentActive = hasChildren && isParentActive(item.children!);

            return (
              <div key={item.key}>
                <button
                  className={`w-full flex items-center gap-3 px-4 py-2.5 transition-colors hover:bg-sidebar-accent ${
                    item.path && isActive(item.path)
                      ? "bg-sidebar-accent text-white"
                      : parentActive
                      ? "text-white"
                      : "text-sidebar-foreground/80"
                  }`}
                  onClick={() => {
                    if (hasChildren) {
                      toggleExpand(item.key);
                    } else if (item.path) {
                      navigate(item.path);
                    }
                  }}
                >
                  <Icon className="w-[18px] h-[18px] flex-shrink-0" />
                  {!collapsed && (
                    <>
                      <span className="flex-1 text-left whitespace-nowrap">{item.label}</span>
                      {hasChildren &&
                        (isExpanded ? (
                          <ChevronDown className="w-4 h-4" />
                        ) : (
                          <ChevronRight className="w-4 h-4" />
                        ))}
                    </>
                  )}
                </button>
                {hasChildren && isExpanded && !collapsed && (
                  <div className="bg-black/10">
                    {item.children!.map((child) => (
                      <button
                        key={child.key}
                        className={`w-full flex items-center pl-11 pr-4 py-2 transition-colors hover:bg-sidebar-accent ${
                          isActive(child.path)
                            ? "bg-sidebar-accent text-white"
                            : "text-sidebar-foreground/70"
                        }`}
                        onClick={() => navigate(child.path)}
                      >
                        <span className="whitespace-nowrap">{child.label}</span>
                      </button>
                    ))}
                  </div>
                )}
              </div>
            );
          })}
        </nav>
      </aside>

      {/* Main Area */}
      <div className="flex-1 flex flex-col min-w-0 overflow-hidden">
        {/* Header */}
        <header className="h-[56px] bg-white border-b border-border flex items-center justify-between px-4 flex-shrink-0">
          <div className="flex items-center gap-3">
            <button
              onClick={() => setCollapsed(!collapsed)}
              className="p-1.5 rounded hover:bg-muted transition-colors"
            >
              {collapsed ? <Menu className="w-5 h-5" /> : <X className="w-5 h-5" />}
            </button>
            <div className="relative">
              <Search className="w-4 h-4 absolute left-3 top-1/2 -translate-y-1/2 text-muted-foreground" />
              <input
                type="text"
                placeholder="搜索功能模块..."
                className="pl-9 pr-4 py-1.5 bg-muted rounded-lg w-[240px] outline-none focus:ring-2 focus:ring-primary/30"
              />
            </div>
          </div>
          <div className="flex items-center gap-4">
            <button className="relative p-1.5 rounded hover:bg-muted transition-colors">
              <Bell className="w-5 h-5 text-muted-foreground" />
              <span className="absolute -top-0.5 -right-0.5 w-4 h-4 bg-destructive text-white rounded-full flex items-center justify-center" style={{ fontSize: "10px" }}>
                5
              </span>
            </button>
            <div className="h-6 w-px bg-border" />
            <div className="flex items-center gap-2 cursor-pointer hover:bg-muted px-2 py-1 rounded">
              <div className="w-8 h-8 rounded-full bg-primary flex items-center justify-center">
                <User className="w-4 h-4 text-white" />
              </div>
              <span className="text-foreground">管理员</span>
              <ChevronDown className="w-4 h-4 text-muted-foreground" />
            </div>
          </div>
        </header>

        {/* Content */}
        <main className="flex-1 overflow-y-auto p-6 bg-background">
          <Outlet />
        </main>
      </div>
    </div>
  );
}