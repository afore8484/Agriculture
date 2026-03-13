import {
  ChevronRight,
  Download, Printer, Eye,
  TrendingDown,
  BarChart3, PieChart as PieChartIcon, ArrowLeft,
} from "lucide-react";
import {
  BarChart, Bar, XAxis, YAxis, CartesianGrid, Tooltip,
  ResponsiveContainer, PieChart, Pie, Cell, Legend,
} from "recharts";

/* ============================================================= */
/*  Balance Sheet                                                  */
/* ============================================================= */

export function BalanceSheet() {
  const [detailView, setDetailView] = useState<null | { group: string; item: any }>(null);

  const assets = [
    { name: "流动资产", items: [
      { code: "1001", name: "库存现金", beginBalance: 15600, endBalance: 12800 },
      { code: "1002", name: "银行存款", beginBalance: 1285600, endBalance: 1320600 },
      { code: "1131", name: "应收款", beginBalance: 45000, endBalance: 38500 },
      { code: "1151", name: "存货", beginBalance: 28000, endBalance: 32000 },
    ]},
    { name: "非流动资产", items: [
      { code: "1501", name: "固定资产", beginBalance: 3200000, endBalance: 3185000 },
      { code: "1502", name: "累计折旧", beginBalance: -320000, endBalance: -335000 },
      { code: "1601", name: "在建工程", beginBalance: 650000, endBalance: 662500 },
      { code: "1701", name: "无形资产", beginBalance: 450000, endBalance: 445000 },
    ]},
  ];
  const liabilities = [
    { name: "流动负债", items: [
      { code: "2101", name: "应付款", beginBalance: 85000, endBalance: 78000 },
      { code: "2151", name: "应付工资", beginBalance: 45000, endBalance: 42000 },
      { code: "2171", name: "应交税金", beginBalance: 12500, endBalance: 15800 },
    ]},
    { name: "所有者权益", items: [
      { code: "3101", name: "资本", beginBalance: 4800000, endBalance: 4800000 },
      { code: "3111", name: "公积公益金", beginBalance: 250000, endBalance: 268000 },
      { code: "3121", name: "本年收益", beginBalance: 162700, endBalance: 158600 },
    ]},
  ];

  const detailRecords: Record<string, { date: string; no: string; summary: string; debit: number; credit: number }[]> = {
    "1001": [
      { date: "2026-03-06", no: "记-0296", summary: "收取村民活动中心场地租赁收入", debit: 800, credit: 0 },
      { date: "2026-03-07", no: "现付-0023", summary: "购买清洁用品", debit: 0, credit: 260 },
      { date: "2026-03-08", no: "记-0299", summary: "收取小卖部零售收入", debit: 1200, credit: 0 },
    ],
    "1002": [
      { date: "2026-03-07", no: "记-0298", summary: "收到省级乡村振兴补助款", debit: 80000, credit: 0 },
      { date: "2026-03-08", no: "记-0300", summary: "支付村道硬化修缮费", debit: 0, credit: 38000 },
      { date: "2026-03-08", no: "记-0299", summary: "槟榔园承包收入", debit: 12000, credit: 0 },
      { date: "2026-03-09", no: "记-0301", summary: "支付美丽乡村建设工程款", debit: 0, credit: 56000 },
    ],
    "1131": [
      { date: "2026-03-05", no: "记-0294", summary: "应收承包费-符永昌", debit: 0, credit: 3500 },
      { date: "2026-03-08", no: "记-0299", summary: "应收民宿分成-陈大文", debit: 0, credit: 3000 },
    ],
  };

  if (detailView) {
    const item = detailView.item;
    const records = detailRecords[item.code] || [
      { date: "2026-03-01", no: "记-0290", summary: `${item.name}期初调整`, debit: Math.abs(item.beginBalance) > 0 ? 0 : 0, credit: 0 },
    ];
    return (
      <div className="space-y-4">
        <div className="flex items-center text-muted-foreground text-[13px]">
          <span>报表中心</span><ChevronRight className="w-4 h-4 mx-1" /><span>资产负债表</span><ChevronRight className="w-4 h-4 mx-1" /><span className="text-foreground">{item.name} 明细</span>
        </div>
        <div className="flex items-center gap-3">
          <button onClick={() => setDetailView(null)} className="flex items-center gap-1 px-3 py-1.5 border border-border rounded-lg hover:bg-muted text-[13px]"><ArrowLeft className="w-4 h-4" /> 返回</button>
          <h2>{item.code} {item.name} - 明细账</h2>
        </div>
        <div className="grid grid-cols-1 md:grid-cols-3 gap-4">
          <div className="bg-white rounded-xl p-4 border border-border shadow-sm">
            <p className="text-[12px] text-muted-foreground">年初余额</p>
            <p className="text-[20px] mt-1" style={{ fontWeight: 600 }}>¥ {item.beginBalance.toLocaleString()}</p>
          </div>
          <div className="bg-white rounded-xl p-4 border border-border shadow-sm">
            <p className="text-[12px] text-muted-foreground">期末余额</p>
            <p className="text-[20px] mt-1" style={{ fontWeight: 600, color: "#0d9448" }}>¥ {item.endBalance.toLocaleString()}</p>
          </div>
          <div className="bg-white rounded-xl p-4 border border-border shadow-sm">
            <p className="text-[12px] text-muted-foreground">本期变动</p>
            <p className="text-[20px] mt-1" style={{ fontWeight: 600, color: item.endBalance - item.beginBalance >= 0 ? "#0d9448" : "#ef4444" }}>
              {item.endBalance - item.beginBalance >= 0 ? "+" : ""}{(item.endBalance - item.beginBalance).toLocaleString()}
            </p>
          </div>
        </div>
        <div className="bg-white rounded-xl border border-border shadow-sm p-5">
          <div className="flex items-center justify-between mb-4">
            <h3>明细记录</h3>
            <button onClick={() => toast.success("导出成功", { description: `${item.name}明细已导出` })} className="flex items-center gap-1 px-3 py-1.5 border border-border rounded-lg hover:bg-muted text-[13px]"><Download className="w-4 h-4" /> 导出</button>
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
                {records.map((r, i) => (
                  <tr key={i} className="border-t border-border/50 hover:bg-blue-50/20">
                    <td className="py-2.5 px-3 text-muted-foreground">{r.date}</td>
                    <td className="py-2.5 px-3 text-primary">{r.no}</td>
                    <td className="py-2.5 px-3">{r.summary}</td>
                    <td className="py-2.5 px-3 text-right">{r.debit > 0 ? `¥ ${r.debit.toLocaleString()}` : "-"}</td>
                    <td className="py-2.5 px-3 text-right">{r.credit > 0 ? `¥ ${r.credit.toLocaleString()}` : "-"}</td>
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
      <div className="flex items-center text-muted-foreground text-[13px]">
        <span>报表中心</span><ChevronRight className="w-4 h-4 mx-1" /><span className="text-foreground">资产负债表</span>
      </div>
      <div className="flex items-center justify-between">
        <h2>资产负债表</h2>
        <div className="flex gap-2">
          <select className="bg-white border border-border rounded-lg px-3 py-1.5 outline-none"><option>2026年3月</option><option>2026年2月</option></select>
          <button onClick={() => toast.success("导出成功", { description: "资产负债表已导出为 Excel 文件" })} className="flex items-center gap-1.5 px-3 py-1.5 border border-border rounded-lg hover:bg-muted text-[13px]"><Download className="w-4 h-4" /> 导出</button>
          <button onClick={() => { toast.info("正在生成打印预览..."); setTimeout(() => toast.success("打印预览已生成"), 800); }} className="flex items-center gap-1.5 px-3 py-1.5 border border-border rounded-lg hover:bg-muted text-[13px]"><Printer className="w-4 h-4" /> 打印</button>
        </div>
      </div>
      <div className="bg-white rounded-xl border border-border shadow-sm p-5">
        <div className="text-center mb-4">
          <h3>椰林村集体经济组织</h3>
          <p className="text-muted-foreground text-[13px]">资产负债表 &nbsp; 会计期间：2026年3月 &nbsp; 单位：元</p>
        </div>
        <div className="grid grid-cols-2 gap-4">
          <div>
            <div className="border border-border rounded-lg overflow-hidden">
              <table className="w-full text-[13px]">
                <thead className="bg-blue-50">
                  <tr>
                    <th className="py-2.5 px-3 text-left" style={{ fontWeight: 500 }}>资产</th>
                    <th className="py-2.5 px-3 text-right" style={{ fontWeight: 500 }}>年初数</th>
                    <th className="py-2.5 px-3 text-right" style={{ fontWeight: 500 }}>期末数</th>
                    <th className="py-2.5 px-3 text-center" style={{ fontWeight: 500 }}>明细</th>
                  </tr>
                </thead>
                <tbody>
                  {assets.map((group) => (
                    <Fragment key={group.name}>
                      <tr className="bg-muted/30">
                        <td colSpan={4} className="py-2 px-3" style={{ fontWeight: 500 }}>{group.name}</td>
                      </tr>
                      {group.items.map((item) => (
                        <tr key={item.code} className="border-t border-border/30 hover:bg-blue-50/20">
                          <td className="py-2 px-3 pl-6">{item.name}</td>
                          <td className="py-2 px-3 text-right">{item.beginBalance.toLocaleString()}</td>
                          <td className="py-2 px-3 text-right">{item.endBalance.toLocaleString()}</td>
                          <td className="py-2 px-3 text-center">
                            <button onClick={() => setDetailView({ group: group.name, item })} className="p-1 hover:bg-blue-100 rounded" title="查看明细"><Eye className="w-3.5 h-3.5 text-primary" /></button>
                          </td>
                        </tr>
                      ))}
                    </Fragment>
                  ))}
                  <tr className="border-t-2 border-border bg-blue-50/50">
                    <td className="py-2.5 px-3" style={{ fontWeight: 600 }}>资产合计</td>
                    <td className="py-2.5 px-3 text-right" style={{ fontWeight: 600 }}>5,354,200</td>
                    <td className="py-2.5 px-3 text-right" style={{ fontWeight: 600 }}>5,361,400</td>
                    <td />
                  </tr>
                </tbody>
              </table>
            </div>
          </div>
          <div>
            <div className="border border-border rounded-lg overflow-hidden">
              <table className="w-full text-[13px]">
                <thead className="bg-green-50">
                  <tr>
                    <th className="py-2.5 px-3 text-left" style={{ fontWeight: 500 }}>负债及所有者权益</th>
                    <th className="py-2.5 px-3 text-right" style={{ fontWeight: 500 }}>年初数</th>
                    <th className="py-2.5 px-3 text-right" style={{ fontWeight: 500 }}>期末数</th>
                    <th className="py-2.5 px-3 text-center" style={{ fontWeight: 500 }}>明细</th>
                  </tr>
                </thead>
                <tbody>
                  {liabilities.map((group) => (
                    <Fragment key={group.name}>
                      <tr className="bg-muted/30">
                        <td colSpan={4} className="py-2 px-3" style={{ fontWeight: 500 }}>{group.name}</td>
                      </tr>
                      {group.items.map((item) => (
                        <tr key={item.code} className="border-t border-border/30 hover:bg-green-50/20">
                          <td className="py-2 px-3 pl-6">{item.name}</td>
                          <td className="py-2 px-3 text-right">{item.beginBalance.toLocaleString()}</td>
                          <td className="py-2 px-3 text-right">{item.endBalance.toLocaleString()}</td>
                          <td className="py-2 px-3 text-center">
                            <button onClick={() => setDetailView({ group: group.name, item })} className="p-1 hover:bg-green-100 rounded" title="查看明细"><Eye className="w-3.5 h-3.5 text-primary" /></button>
                          </td>
                        </tr>
                      ))}
                    </Fragment>
                  ))}
                  <tr className="border-t-2 border-border bg-green-50/50">
                    <td className="py-2.5 px-3" style={{ fontWeight: 600 }}>负债及权益合计</td>
                    <td className="py-2.5 px-3 text-right" style={{ fontWeight: 600 }}>5,354,200</td>
                    <td className="py-2.5 px-3 text-right" style={{ fontWeight: 600 }}>5,361,400</td>
                    <td />
                  </tr>
                </tbody>
              </table>
            </div>
          </div>
        </div>
      </div>
    </div>
  );
}

/* ============================================================= */
/*  Income Statement                                               */
/* ============================================================= */

export function IncomeStatement() {
  const [detailItem, setDetailItem] = useState<null | { name: string; current: number; cumulative: number }>(null);

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

  const pieData = [
    { name: "经营收入", value: 528000, color: "#1a56db" },
    { name: "补助收入", value: 150000, color: "#10b981" },
    { name: "投资收益", value: 12000, color: "#f59e0b" },
    { name: "其他收入", value: 8500, color: "#8b5cf6" },
  ];

  const detailRecords: Record<string, { date: string; summary: string; amount: number; source: string }[]> = {
    "经营收入": [
      { date: "2026-03-06", summary: "民宿经营收入分成", amount: 5600, source: "陈大文" },
      { date: "2026-03-08", summary: "槟榔园承包费", amount: 12000, source: "符永昌" },
      { date: "2026-03-05", summary: "村委小卖部零售收入", amount: 1200, source: "自营" },
      { date: "2026-02-28", summary: "鱼塘承包收入", amount: 8000, source: "林海涛" },
    ],
    "补助收入": [
      { date: "2026-03-07", summary: "省级乡村振兴补助款", amount: 80000, source: "博鳌镇财政所" },
      { date: "2026-02-15", summary: "美丽乡村建设补助", amount: 50000, source: "琼海市住建局" },
      { date: "2026-01-20", summary: "农村人居环境整治补助", amount: 20000, source: "博鳌镇财政所" },
    ],
    "管理费用": [
      { date: "2026-03-07", summary: "办公用品采购", amount: 3150, source: "琼海文华办公" },
      { date: "2026-03-08", summary: "水电费", amount: 4500, source: "海南电网" },
      { date: "2026-03-05", summary: "保洁人员工资", amount: 18000, source: "王秀兰等6人" },
    ],
  };

  return (
    <div className="space-y-4">
      <div className="flex items-center text-muted-foreground text-[13px]">
        <span>报表中心</span><ChevronRight className="w-4 h-4 mx-1" /><span className="text-foreground">收益分配表</span>
      </div>
      <div className="flex items-center justify-between">
        <h2>收益及收益分配表</h2>
        <div className="flex gap-2">
          <select className="bg-white border border-border rounded-lg px-3 py-1.5 outline-none"><option>2026年3月</option></select>
          <button onClick={() => toast.success("导出成功", { description: "收益分配表已导出为 Excel 文件" })} className="flex items-center gap-1.5 px-3 py-1.5 border border-border rounded-lg hover:bg-muted text-[13px]"><Download className="w-4 h-4" /> 导出</button>
          <button onClick={() => { toast.info("正在生成打印预览..."); setTimeout(() => toast.success("打印预览已生成"), 800); }} className="flex items-center gap-1.5 px-3 py-1.5 border border-border rounded-lg hover:bg-muted text-[13px]"><Printer className="w-4 h-4" /> 打印</button>
        </div>
      </div>

      <div className="grid grid-cols-1 lg:grid-cols-3 gap-4">
        <div className="lg:col-span-2 bg-white rounded-xl border border-border shadow-sm p-5">
          <div className="text-center mb-4">
            <h3>椰林村集体经济组织</h3>
            <p className="text-muted-foreground text-[13px]">收益及收益分配表 &nbsp; 会计期间：2026年3月 &nbsp; 单位：元</p>
          </div>
          <div className="border border-border rounded-lg overflow-hidden text-[13px]">
            <table className="w-full">
              <thead className="bg-muted/60">
                <tr>
                  <th className="py-2.5 px-4 text-left" style={{ fontWeight: 500 }}>项目</th>
                  <th className="py-2.5 px-4 text-right" style={{ fontWeight: 500 }}>本月数</th>
                  <th className="py-2.5 px-4 text-right" style={{ fontWeight: 500 }}>累计数</th>
                  <th className="py-2.5 px-4 text-center" style={{ fontWeight: 500 }}>明细</th>
                </tr>
              </thead>
              <tbody>
                <tr className="bg-blue-50/30"><td colSpan={4} className="py-2 px-4" style={{ fontWeight: 500 }}>一、收入</td></tr>
                {incomeData.map((r) => (
                  <tr key={r.name} className="border-t border-border/30 hover:bg-blue-50/20">
                    <td className="py-2 px-4 pl-8">{r.name}</td>
                    <td className="py-2 px-4 text-right text-green-600">+{r.current.toLocaleString()}</td>
                    <td className="py-2 px-4 text-right">{r.cumulative.toLocaleString()}</td>
                    <td className="py-2 px-4 text-center">
                      <button onClick={() => setDetailItem(r)} className="p-1 hover:bg-blue-100 rounded"><Eye className="w-3.5 h-3.5 text-primary" /></button>
                    </td>
                  </tr>
                ))}
                <tr className="border-t border-border bg-blue-50/50">
                  <td className="py-2 px-4" style={{ fontWeight: 500 }}>收入合计</td>
                  <td className="py-2 px-4 text-right" style={{ fontWeight: 500 }}>238,000</td>
                  <td className="py-2 px-4 text-right" style={{ fontWeight: 500 }}>698,500</td>
                  <td />
                </tr>
                <tr className="bg-red-50/30"><td colSpan={4} className="py-2 px-4" style={{ fontWeight: 500 }}>二、支出</td></tr>
                {expenseData.map((r) => (
                  <tr key={r.name} className="border-t border-border/30 hover:bg-red-50/20">
                    <td className="py-2 px-4 pl-8">{r.name}</td>
                    <td className="py-2 px-4 text-right text-red-500">-{r.current.toLocaleString()}</td>
                    <td className="py-2 px-4 text-right">{r.cumulative.toLocaleString()}</td>
                    <td className="py-2 px-4 text-center">
                      <button onClick={() => setDetailItem(r)} className="p-1 hover:bg-red-100 rounded"><Eye className="w-3.5 h-3.5 text-primary" /></button>
                    </td>
                  </tr>
                ))}
                <tr className="border-t border-border bg-red-50/50">
                  <td className="py-2 px-4" style={{ fontWeight: 500 }}>支出合计</td>
                  <td className="py-2 px-4 text-right" style={{ fontWeight: 500 }}>89,450</td>
                  <td className="py-2 px-4 text-right" style={{ fontWeight: 500 }}>275,900</td>
                  <td />
                </tr>
                <tr className="border-t-2 border-border bg-amber-50/50">
                  <td className="py-2.5 px-4" style={{ fontWeight: 600 }}>三、本年收益</td>
                  <td className="py-2.5 px-4 text-right" style={{ fontWeight: 600 }}>148,550</td>
                  <td className="py-2.5 px-4 text-right" style={{ fontWeight: 600 }}>422,600</td>
                  <td />
                </tr>
              </tbody>
            </table>
          </div>
        </div>
        <div className="bg-white rounded-xl border border-border shadow-sm p-5">
          <h3 className="mb-4">收入结构分析</h3>
          <ResponsiveContainer width="100%" height={220}>
            <PieChart>
              <Pie data={pieData} cx="50%" cy="50%" innerRadius={45} outerRadius={75} dataKey="value" stroke="none">
                {pieData.map((entry) => <Cell key={entry.name} fill={entry.color} />)}
              </Pie>
              <Tooltip formatter={(value: number) => `¥ ${value.toLocaleString()}`} />
            </PieChart>
          </ResponsiveContainer>
          <div className="space-y-2">
            {pieData.map((item) => (
              <div key={item.name} className="flex items-center justify-between text-[13px] cursor-pointer hover:bg-muted/50 px-2 py-1 rounded" onClick={() => setDetailItem(incomeData.find(d => d.name === item.name) || null)}>
                <div className="flex items-center gap-2">
                  <div className="w-3 h-3 rounded-sm" style={{ backgroundColor: item.color }} />
                  <span>{item.name}</span>
                </div>
                <span className="text-muted-foreground">{((item.value / 698500) * 100).toFixed(1)}%</span>
              </div>
            ))}
          </div>
        </div>
      </div>

      {/* Detail Modal */}
      <Modal open={!!detailItem} onClose={() => setDetailItem(null)} title={`${detailItem?.name || ""} 分项明细`} width="max-w-xl">
        {detailItem && (
          <div className="space-y-4">
            <div className="grid grid-cols-2 gap-4">
              <div className="bg-muted/30 rounded-lg p-3 border border-border/50">
                <p className="text-[12px] text-muted-foreground">本月金额</p>
                <p className="text-[18px] mt-1" style={{ fontWeight: 600 }}>¥ {detailItem.current.toLocaleString()}</p>
              </div>
              <div className="bg-muted/30 rounded-lg p-3 border border-border/50">
                <p className="text-[12px] text-muted-foreground">累计金额</p>
                <p className="text-[18px] mt-1" style={{ fontWeight: 600 }}>¥ {detailItem.cumulative.toLocaleString()}</p>
              </div>
            </div>
            <div className="overflow-x-auto border border-border rounded-lg">
              <table className="w-full text-[13px]">
                <thead className="bg-muted/60">
                  <tr>
                    <th className="py-2.5 px-3 text-left text-muted-foreground" style={{ fontWeight: 500 }}>日期</th>
                    <th className="py-2.5 px-3 text-left text-muted-foreground" style={{ fontWeight: 500 }}>摘要</th>
                    <th className="py-2.5 px-3 text-right text-muted-foreground" style={{ fontWeight: 500 }}>金额</th>
                    <th className="py-2.5 px-3 text-left text-muted-foreground" style={{ fontWeight: 500 }}>来源/对方</th>
                  </tr>
                </thead>
                <tbody>
                  {(detailRecords[detailItem.name] || [{ date: "2026-03-01", summary: `${detailItem.name}汇总`, amount: detailItem.current, source: "-" }]).map((r, i) => (
                    <tr key={i} className="border-t border-border/50 hover:bg-blue-50/20">
                      <td className="py-2 px-3 text-muted-foreground">{r.date}</td>
                      <td className="py-2 px-3">{r.summary}</td>
                      <td className="py-2 px-3 text-right" style={{ fontWeight: 500 }}>¥ {r.amount.toLocaleString()}</td>
                      <td className="py-2 px-3 text-muted-foreground">{r.source}</td>
                    </tr>
                  ))}
                </tbody>
              </table>
            </div>
            <div className="flex justify-end">
              <button onClick={() => { toast.success("导出成功", { description: `${detailItem.name}明细已导出` }); }} className="flex items-center gap-1 px-3 py-1.5 border border-border rounded-lg text-[13px] hover:bg-muted"><Download className="w-4 h-4" /> 导出明细</button>
            </div>
          </div>
        )}
      </Modal>
    </div>
  );
}

/* ============================================================= */
/*  Progress Report                                                */
/* ============================================================= */

export function ProgressReport() {
  const [detailVillage, setDetailVillage] = useState<null | typeof progressData[0]>(null);

  const progressData = [
    { village: "椰林村", total: 45, done: 42, reviewed: 40, status: "进行中" },
    { village: "南强村", total: 38, done: 38, reviewed: 38, status: "已完成" },
    { village: "排港村", total: 52, done: 35, reviewed: 30, status: "进行中" },
    { village: "沙美村", total: 30, done: 28, reviewed: 25, status: "进行中" },
    { village: "北仍村", total: 41, done: 41, reviewed: 41, status: "已完成" },
  ];

  const villageDetail: Record<string, { no: string; date: string; summary: string; amount: number; entryStatus: string; reviewStatus: string }[]> = {
    "椰林村": [
      { no: "记-0301", date: "2026-03-09", summary: "收到省级乡村振兴补助款", amount: 80000, entryStatus: "已录入", reviewStatus: "已审核" },
      { no: "记-0300", date: "2026-03-08", summary: "支付村道硬化修缮费", amount: 38000, entryStatus: "已录入", reviewStatus: "待审核" },
      { no: "记-0299", date: "2026-03-08", summary: "槟榔园承包收入", amount: 12000, entryStatus: "已录入", reviewStatus: "已审核" },
      { no: "记-0298", date: "2026-03-07", summary: "办公用品采购", amount: 3150, entryStatus: "已录入", reviewStatus: "待审核" },
      { no: "-", date: "2026-03-10", summary: "文化广场维修费", amount: 5600, entryStatus: "未录入", reviewStatus: "未审核" },
      { no: "-", date: "2026-03-10", summary: "民宿收入分成3月", amount: 8500, entryStatus: "未录入", reviewStatus: "未审核" },
      { no: "-", date: "2026-03-11", summary: "保洁人员3月工资", amount: 18000, entryStatus: "未录入", reviewStatus: "未审核" },
    ],
    "排港村": [
      { no: "记-0145", date: "2026-03-09", summary: "鱼塘承包费收入", amount: 15000, entryStatus: "已录入", reviewStatus: "已审核" },
      { no: "记-0144", date: "2026-03-08", summary: "道路维修支出", amount: 25000, entryStatus: "已录入", reviewStatus: "待审核" },
      { no: "-", date: "2026-03-10", summary: "待录入凭证", amount: 0, entryStatus: "未录入", reviewStatus: "未审核" },
    ],
  };

  if (detailVillage) {
    const details = villageDetail[detailVillage.village] || [
      { no: "记-0001", date: "2026-03-01", summary: "示例凭证", amount: 10000, entryStatus: "已录入", reviewStatus: "已审核" },
    ];
    const entryPct = Math.round((detailVillage.done / detailVillage.total) * 100);
    const reviewPct = Math.round((detailVillage.reviewed / detailVillage.total) * 100);

    return (
      <div className="space-y-4">
        <div className="flex items-center text-muted-foreground text-[13px]">
          <span>报表中心</span><ChevronRight className="w-4 h-4 mx-1" /><span>做账进度</span><ChevronRight className="w-4 h-4 mx-1" /><span className="text-foreground">{detailVillage.village}</span>
        </div>
        <div className="flex items-center gap-3">
          <button onClick={() => setDetailVillage(null)} className="flex items-center gap-1 px-3 py-1.5 border border-border rounded-lg hover:bg-muted text-[13px]"><ArrowLeft className="w-4 h-4" /> 返回汇总</button>
          <h2>{detailVillage.village} - 做账进度明细</h2>
        </div>

        <div className="grid grid-cols-1 md:grid-cols-4 gap-4">
          <div className="bg-white rounded-xl p-4 border border-border shadow-sm">
            <p className="text-[12px] text-muted-foreground">凭证总数</p>
            <p className="text-[22px] mt-1" style={{ fontWeight: 600 }}>{detailVillage.total}</p>
          </div>
          <div className="bg-white rounded-xl p-4 border border-border shadow-sm">
            <p className="text-[12px] text-muted-foreground">已录入</p>
            <p className="text-[22px] mt-1" style={{ fontWeight: 600, color: "#1a56db" }}>{detailVillage.done}</p>
          </div>
          <div className="bg-white rounded-xl p-4 border border-border shadow-sm">
            <p className="text-[12px] text-muted-foreground">录入进度</p>
            <div className="flex items-center gap-2 mt-2"><div className="flex-1 bg-muted rounded-full h-2.5"><div className="bg-primary rounded-full h-2.5" style={{ width: `${entryPct}%` }} /></div><span className="text-[13px]">{entryPct}%</span></div>
          </div>
          <div className="bg-white rounded-xl p-4 border border-border shadow-sm">
            <p className="text-[12px] text-muted-foreground">审核进度</p>
            <div className="flex items-center gap-2 mt-2"><div className="flex-1 bg-muted rounded-full h-2.5"><div className="bg-green-500 rounded-full h-2.5" style={{ width: `${reviewPct}%` }} /></div><span className="text-[13px]">{reviewPct}%</span></div>
          </div>
        </div>

        <div className="bg-white rounded-xl border border-border shadow-sm p-5">
          <h3 className="mb-3">凭证明细（录入与审核差异）</h3>
          <div className="overflow-x-auto border border-border rounded-lg">
            <table className="w-full text-[13px]">
              <thead className="bg-muted/60">
                <tr>
                  <th className="py-3 px-3 text-left text-muted-foreground" style={{ fontWeight: 500 }}>凭证号</th>
                  <th className="py-3 px-3 text-left text-muted-foreground" style={{ fontWeight: 500 }}>日期</th>
                  <th className="py-3 px-3 text-left text-muted-foreground" style={{ fontWeight: 500 }}>摘要</th>
                  <th className="py-3 px-3 text-right text-muted-foreground" style={{ fontWeight: 500 }}>金额</th>
                  <th className="py-3 px-3 text-center text-muted-foreground" style={{ fontWeight: 500 }}>录入状态</th>
                  <th className="py-3 px-3 text-center text-muted-foreground" style={{ fontWeight: 500 }}>审核状态</th>
                </tr>
              </thead>
              <tbody>
                {details.map((r, i) => (
                  <tr key={i} className="border-t border-border/50 hover:bg-blue-50/20">
                    <td className="py-2.5 px-3 text-primary">{r.no}</td>
                    <td className="py-2.5 px-3 text-muted-foreground">{r.date}</td>
                    <td className="py-2.5 px-3">{r.summary}</td>
                    <td className="py-2.5 px-3 text-right">{r.amount > 0 ? `¥ ${r.amount.toLocaleString()}` : "-"}</td>
                    <td className="py-2.5 px-3 text-center">
                      <span className={`px-2 py-0.5 rounded-full text-[12px] ${r.entryStatus === "已录入" ? "bg-green-50 text-green-600" : "bg-gray-100 text-gray-500"}`}>{r.entryStatus}</span>
                    </td>
                    <td className="py-2.5 px-3 text-center">
                      <span className={`px-2 py-0.5 rounded-full text-[12px] ${r.reviewStatus === "已审核" ? "bg-green-50 text-green-600" : r.reviewStatus === "待审核" ? "bg-amber-50 text-amber-600" : "bg-gray-100 text-gray-500"}`}>{r.reviewStatus}</span>
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

  return (
    <div className="space-y-4">
      <div className="flex items-center text-muted-foreground text-[13px]">
        <span>报表中心</span><ChevronRight className="w-4 h-4 mx-1" /><span className="text-foreground">做账进度</span>
      </div>
      <div className="flex items-center justify-between">
        <h2>做账进度</h2>
        <div className="flex gap-2">
          <select className="bg-white border border-border rounded-lg px-3 py-1.5 outline-none"><option>2026年3月</option></select>
          <select className="bg-white border border-border rounded-lg px-3 py-1.5 outline-none"><option>全部行政区划</option><option>东区</option><option>西区</option></select>
          <button onClick={() => toast.success("导出成功", { description: "做账进度报表已导出" })} className="flex items-center gap-1.5 px-3 py-1.5 border border-border rounded-lg hover:bg-muted text-[13px]"><Download className="w-4 h-4" /> 导出</button>
          <button onClick={() => { toast.info("正在生成打印预览..."); setTimeout(() => toast.success("打印预览已生成"), 800); }} className="flex items-center gap-1.5 px-3 py-1.5 border border-border rounded-lg hover:bg-muted text-[13px]"><Printer className="w-4 h-4" /> 打印</button>
        </div>
      </div>
      <div className="bg-white rounded-xl border border-border shadow-sm p-5">
        <div className="overflow-x-auto border border-border rounded-lg">
          <table className="w-full text-[13px]">
            <thead className="bg-muted/60">
              <tr>
                <th className="py-3 px-4 text-left text-muted-foreground" style={{ fontWeight: 500 }}>行政村</th>
                <th className="py-3 px-4 text-center text-muted-foreground" style={{ fontWeight: 500 }}>凭证总数</th>
                <th className="py-3 px-4 text-center text-muted-foreground" style={{ fontWeight: 500 }}>已录入</th>
                <th className="py-3 px-4 text-center text-muted-foreground" style={{ fontWeight: 500 }}>已审核</th>
                <th className="py-3 px-4 text-center text-muted-foreground" style={{ fontWeight: 500 }}>录入进度</th>
                <th className="py-3 px-4 text-center text-muted-foreground" style={{ fontWeight: 500 }}>审核进度</th>
                <th className="py-3 px-4 text-center text-muted-foreground" style={{ fontWeight: 500 }}>状态</th>
                <th className="py-3 px-4 text-center text-muted-foreground" style={{ fontWeight: 500 }}>操作</th>
              </tr>
            </thead>
            <tbody>
              {progressData.map((row) => {
                const entryPct = Math.round((row.done / row.total) * 100);
                const reviewPct = Math.round((row.reviewed / row.total) * 100);
                return (
                  <tr key={row.village} className="border-t border-border/50 hover:bg-blue-50/30 cursor-pointer" onClick={() => setDetailVillage(row)}>
                    <td className="py-3 px-4 text-primary hover:underline">{row.village}</td>
                    <td className="py-3 px-4 text-center">{row.total}</td>
                    <td className="py-3 px-4 text-center">{row.done}</td>
                    <td className="py-3 px-4 text-center">{row.reviewed}</td>
                    <td className="py-3 px-4">
                      <div className="flex items-center gap-2">
                        <div className="flex-1 bg-muted rounded-full h-2"><div className="bg-primary rounded-full h-2" style={{ width: `${entryPct}%` }} /></div>
                        <span className="text-[12px] text-muted-foreground w-10">{entryPct}%</span>
                      </div>
                    </td>
                    <td className="py-3 px-4">
                      <div className="flex items-center gap-2">
                        <div className="flex-1 bg-muted rounded-full h-2"><div className="bg-green-500 rounded-full h-2" style={{ width: `${reviewPct}%` }} /></div>
                        <span className="text-[12px] text-muted-foreground w-10">{reviewPct}%</span>
                      </div>
                    </td>
                    <td className="py-3 px-4 text-center">
                      <span className={`px-2 py-0.5 rounded-full text-[12px] ${row.status === "已完成" ? "bg-green-50 text-green-600" : "bg-blue-50 text-blue-600"}`}>{row.status}</span>
                    </td>
                    <td className="py-3 px-4 text-center">
                      <button onClick={(e) => { e.stopPropagation(); setDetailVillage(row); }} className="p-1 hover:bg-muted rounded"><Eye className="w-4 h-4 text-muted-foreground" /></button>
                    </td>
                  </tr>
                );
              })}
            </tbody>
          </table>
        </div>
      </div>
    </div>
  );
}

/* ============================================================= */
/*  Statistics                                                     */
/* ============================================================= */

export function StatisticsReport() {
  const [drillView, setDrillView] = useState<null | string>(null);

  const barData = [
    { name: "椰林村", 资产: 7236, 负债: 186 },
    { name: "南强村", 资产: 5480, 负债: 240 },
    { name: "排港村", 资产: 8350, 负债: 220 },
    { name: "沙美村", 资产: 4680, 负债: 125 },
    { name: "北仍村", 资产: 6120, 负债: 175 },
  ];

  const subjectSummary = [
    { code: "1001", name: "库存现金", d: 5600, c: 3200 },
    { code: "1002", name: "银行存款", d: 97600, c: 99650 },
    { code: "1501", name: "固定资产", d: 0, c: 0 },
    { code: "1601", name: "在建工程", d: 38000, c: 0 },
    { code: "5001", name: "经营收入", d: 0, c: 17600 },
    { code: "5101", name: "补助收入", d: 0, c: 80000 },
    { code: "5301", name: "管理费用", d: 5350, c: 0 },
  ];

  const unclosedSubjects = [
    { code: "5001", name: "经营收入", balance: 17600, direction: "贷" },
    { code: "5101", name: "补助收入", balance: 80000, direction: "贷" },
    { code: "5301", name: "管理费用", balance: 5350, direction: "借" },
  ];

  const cards = [
    { label: "资产负债表（已生成）", count: 5, icon: BarChart3, color: "#1a56db", drill: "balance" },
    { label: "收益分配表（已生成）", count: 5, icon: PieChartIcon, color: "#10b981", drill: "income" },
    { label: "科目汇总表（已生成）", count: 5, icon: BarChart3, color: "#f59e0b", drill: "summary" },
    { label: "未结账科目", count: 3, icon: TrendingDown, color: "#ef4444", drill: "unclosed" },
  ];

  if (drillView === "summary") {
    return (
      <div className="space-y-4">
        <div className="flex items-center text-muted-foreground text-[13px]">
          <span>报表中心</span><ChevronRight className="w-4 h-4 mx-1" /><span>统计报表</span><ChevronRight className="w-4 h-4 mx-1" /><span className="text-foreground">科目汇总表</span>
        </div>
        <div className="flex items-center gap-3">
          <button onClick={() => setDrillView(null)} className="flex items-center gap-1 px-3 py-1.5 border border-border rounded-lg hover:bg-muted text-[13px]"><ArrowLeft className="w-4 h-4" /> 返回</button>
          <h2>科目汇总表明细</h2>
        </div>
        <div className="bg-white rounded-xl border border-border shadow-sm p-5">
          <div className="flex justify-end mb-4">
            <button onClick={() => toast.success("导出成功")} className="flex items-center gap-1 px-3 py-1.5 border border-border rounded-lg hover:bg-muted text-[13px]"><Download className="w-4 h-4" /> 导出</button>
          </div>
          <div className="overflow-x-auto border border-border rounded-lg">
            <table className="w-full text-[13px]">
              <thead className="bg-muted/60">
                <tr>
                  <th className="py-3 px-3 text-left text-muted-foreground" style={{ fontWeight: 500 }}>科目编码</th>
                  <th className="py-3 px-3 text-left text-muted-foreground" style={{ fontWeight: 500 }}>科目名称</th>
                  <th className="py-3 px-3 text-right text-muted-foreground" style={{ fontWeight: 500 }}>本期借方发生额</th>
                  <th className="py-3 px-3 text-right text-muted-foreground" style={{ fontWeight: 500 }}>本期贷方发生额</th>
                  <th className="py-3 px-3 text-right text-muted-foreground" style={{ fontWeight: 500 }}>差额</th>
                </tr>
              </thead>
              <tbody>
                {subjectSummary.map(r => (
                  <tr key={r.code} className="border-t border-border/50 hover:bg-green-50/30">
                    <td className="py-2.5 px-3 text-primary">{r.code}</td>
                    <td className="py-2.5 px-3">{r.name}</td>
                    <td className="py-2.5 px-3 text-right">{r.d > 0 ? `¥ ${r.d.toLocaleString()}` : "-"}</td>
                    <td className="py-2.5 px-3 text-right">{r.c > 0 ? `¥ ${r.c.toLocaleString()}` : "-"}</td>
                    <td className="py-2.5 px-3 text-right" style={{ fontWeight: 500, color: r.d - r.c >= 0 ? "#0d9448" : "#ef4444" }}>
                      {r.d - r.c !== 0 ? `¥ ${Math.abs(r.d - r.c).toLocaleString()}` : "-"}
                    </td>
                  </tr>
                ))}
              </tbody>
              <tfoot className="bg-muted/30">
                <tr className="border-t border-border">
                  <td colSpan={2} className="py-2.5 px-3 text-right" style={{ fontWeight: 500 }}>合计</td>
                  <td className="py-2.5 px-3 text-right" style={{ fontWeight: 500 }}>¥ {subjectSummary.reduce((s,r)=>s+r.d,0).toLocaleString()}</td>
                  <td className="py-2.5 px-3 text-right" style={{ fontWeight: 500 }}>¥ {subjectSummary.reduce((s,r)=>s+r.c,0).toLocaleString()}</td>
                  <td />
                </tr>
              </tfoot>
            </table>
          </div>
        </div>
      </div>
    );
  }

  if (drillView === "unclosed") {
    return (
      <div className="space-y-4">
        <div className="flex items-center text-muted-foreground text-[13px]">
          <span>报表中心</span><ChevronRight className="w-4 h-4 mx-1" /><span>统计报表</span><ChevronRight className="w-4 h-4 mx-1" /><span className="text-foreground">未结账科目</span>
        </div>
        <div className="flex items-center gap-3">
          <button onClick={() => setDrillView(null)} className="flex items-center gap-1 px-3 py-1.5 border border-border rounded-lg hover:bg-muted text-[13px]"><ArrowLeft className="w-4 h-4" /> 返回</button>
          <h2>未结账科目明细</h2>
        </div>
        <div className="bg-amber-50 border border-amber-200 rounded-lg p-4 text-[13px] text-amber-700">
          以下科目尚未在本期结转，请在期末处理中执行结转损益操作。
        </div>
        <div className="bg-white rounded-xl border border-border shadow-sm p-5">
          <div className="overflow-x-auto border border-border rounded-lg">
            <table className="w-full text-[13px]">
              <thead className="bg-muted/60">
                <tr>
                  <th className="py-3 px-3 text-left text-muted-foreground" style={{ fontWeight: 500 }}>科目编码</th>
                  <th className="py-3 px-3 text-left text-muted-foreground" style={{ fontWeight: 500 }}>科目名称</th>
                  <th className="py-3 px-3 text-right text-muted-foreground" style={{ fontWeight: 500 }}>未结转余额</th>
                  <th className="py-3 px-3 text-center text-muted-foreground" style={{ fontWeight: 500 }}>余额方向</th>
                  <th className="py-3 px-3 text-center text-muted-foreground" style={{ fontWeight: 500 }}>状态</th>
                </tr>
              </thead>
              <tbody>
                {unclosedSubjects.map(r => (
                  <tr key={r.code} className="border-t border-border/50 hover:bg-red-50/20">
                    <td className="py-2.5 px-3 text-primary">{r.code}</td>
                    <td className="py-2.5 px-3">{r.name}</td>
                    <td className="py-2.5 px-3 text-right" style={{ fontWeight: 500 }}>¥ {r.balance.toLocaleString()}</td>
                    <td className="py-2.5 px-3 text-center"><span className={`px-2 py-0.5 rounded text-[12px] ${r.direction === "借" ? "bg-blue-50 text-blue-600" : "bg-green-50 text-green-600"}`}>{r.direction}</span></td>
                    <td className="py-2.5 px-3 text-center"><span className="px-2 py-0.5 bg-red-50 text-red-500 rounded-full text-[12px]">待结转</span></td>
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
      <div className="flex items-center text-muted-foreground text-[13px]">
        <span>报表中心</span><ChevronRight className="w-4 h-4 mx-1" /><span className="text-foreground">统计报表</span>
      </div>
      <h2>统计报表</h2>

      <div className="grid grid-cols-1 md:grid-cols-4 gap-4">
        {cards.map((item) => {
          const Icon = item.icon;
          return (
            <div key={item.label} className="bg-white rounded-xl p-4 border border-border shadow-sm hover:shadow-md hover:border-primary/30 transition-all cursor-pointer" onClick={() => setDrillView(item.drill)}>
              <div className="flex items-center gap-3">
                <div className="w-10 h-10 rounded-lg flex items-center justify-center" style={{ backgroundColor: `${item.color}15` }}>
                  <Icon className="w-5 h-5" style={{ color: item.color }} />
                </div>
                <div>
                  <p className="text-[20px]" style={{ fontWeight: 600 }}>{item.count}</p>
                  <p className="text-[12px] text-muted-foreground">{item.label}</p>
                </div>
              </div>
            </div>
          );
        })}
      </div>

      <div className="bg-white rounded-xl border border-border shadow-sm p-5">
        <div className="flex items-center justify-between mb-4">
          <h3>各村资产负债对比（万元）</h3>
          <span className="text-[12px] text-muted-foreground">点击柱状图可查看该村详情</span>
        </div>
        <ResponsiveContainer width="100%" height={320}>
          <BarChart data={barData} onClick={(data) => {
            if (data?.activeLabel) {
              toast.info(`${data.activeLabel} 详情`, { description: `资产 ${barData.find(b => b.name === data.activeLabel)?.资产}万元 / 负债 ${barData.find(b => b.name === data.activeLabel)?.负债}万元` });
            }
          }}>
            <CartesianGrid strokeDasharray="3 3" stroke="#f0f0f0" />
            <XAxis dataKey="name" axisLine={false} tickLine={false} />
            <YAxis axisLine={false} tickLine={false} />
            <Tooltip />
            <Legend />
            <Bar dataKey="资产" fill="#1a56db" radius={[4, 4, 0, 0]} barSize={28} />
            <Bar dataKey="负债" fill="#ef4444" radius={[4, 4, 0, 0]} barSize={28} />
          </BarChart>
        </ResponsiveContainer>
      </div>
    </div>
  );
}