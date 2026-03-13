import { useState } from "react";
import { toast } from "sonner";
import { Modal, ConfirmDialog } from "./ui/Modal";
import {
  ChevronRight, Plus, Search, Edit, Trash2, Eye, Settings, Building2,
  CreditCard, Users, User, Download, RefreshCw, CheckCircle, ArrowRight
} from "lucide-react";

// =============== BANK SETTING ===============

export function BankSetting() {
  const [bankInterfaces, setBankInterfaces] = useState([
    { id: 1, bankType: "海南农商银行", ip: "192.168.1.100", port: "8443", serviceUrl: "https://api.hnrcb.com/v2", ftpAddr: "ftp.hnrcb.com", contractNo: "E202601001", status: "已连接" },
    { id: 2, bankType: "中国农业银行", ip: "192.168.1.101", port: "8444", serviceUrl: "https://api.abc.com/v3", ftpAddr: "ftp.abc.com", contractNo: "E202601002", status: "已连接" },
    { id: 3, bankType: "海南银行", ip: "192.168.1.102", port: "8445", serviceUrl: "https://api.hnbank.com/v2", ftpAddr: "ftp.hnbank.com", contractNo: "-", status: "未连接" },
  ]);
  const [showDelete, setShowDelete] = useState<number | null>(null);
  const [showAddInterface, setShowAddInterface] = useState(false);
  const [newInterface, setNewInterface] = useState({ bankType: "", ip: "", port: "8443", serviceUrl: "", ftpAddr: "", contractNo: "-" });
  const [selectedBank, setSelectedBank] = useState("海南农商银行");
  const [queryType, setQueryType] = useState<null | "balance" | "transaction">(null);
  const [queryLoading, setQueryLoading] = useState(false);
  const [balanceResult, setBalanceResult] = useState<null | { account: string; name: string; balance: number; available: number; time: string }>(null);
  const [transactionResults, setTransactionResults] = useState<null | { date: string; summary: string; debit: number; credit: number; balance: number; counterparty: string }[]>(null);

  const handleQueryBalance = () => {
    setQueryLoading(true);
    setQueryType("balance");
    setTransactionResults(null);
    toast.info("正在查询银行余额...", { description: `通过银农直联接口连接 ${selectedBank}` });
    setTimeout(() => {
      const result = selectedBank === "海南农商银行"
        ? { account: "6228****1234", name: "椰林村基本账户", balance: 1685600, available: 1620600, time: "2026-03-09 14:30:25" }
        : { account: "6225****5678", name: "椰林村专用账户", balance: 356000, available: 356000, time: "2026-03-09 14:30:28" };
      setBalanceResult(result);
      setQueryLoading(false);
      toast.success("余额查询成功", { description: `${result.name} 余额 ¥${result.balance.toLocaleString()}` });
    }, 1500);
  };

  const handleQueryTransaction = () => {
    setQueryLoading(true);
    setQueryType("transaction");
    setBalanceResult(null);
    toast.info("正在查询交易记录...", { description: `通过银农直联接口连接 ${selectedBank}` });
    setTimeout(() => {
      setTransactionResults([
        { date: "2026-03-09 10:15", summary: "美丽乡村建设工程款", debit: 56000, credit: 0, balance: 1685600, counterparty: "琼海宏达建设公司" },
        { date: "2026-03-08 16:30", summary: "槟榔园承包费", debit: 0, credit: 12000, balance: 1741600, counterparty: "符永昌" },
        { date: "2026-03-08 09:45", summary: "水电费", debit: 4500, credit: 0, balance: 1729600, counterparty: "海南电网琼海供电局" },
        { date: "2026-03-07 14:20", summary: "乡村振兴补助款", debit: 0, credit: 80000, balance: 1734100, counterparty: "博鳌镇财政所" },
        { date: "2026-03-07 11:00", summary: "办公用品采购", debit: 3150, credit: 0, balance: 1654100, counterparty: "琼海文华办公" },
        { date: "2026-03-06 15:30", summary: "村道硬化修缮费", debit: 38000, credit: 0, balance: 1657250, counterparty: "海南中路建设公司" },
      ]);
      setQueryLoading(false);
      toast.success("交易记录查询完成", { description: "共查询到 6 条交易记录" });
    }, 1800);
  };

  const handleTestConnection = (id: number) => {
    const bank = bankInterfaces.find(b => b.id === id);
    toast.info(`正在测试 ${bank?.bankType} 连接...`);
    setTimeout(() => {
      if (bank?.status === "未连接") {
        setBankInterfaces(bankInterfaces.map(b => b.id === id ? { ...b, status: "已连接", contractNo: `E2026${String(id).padStart(5, "0")}` } : b));
        toast.success("连接成功", { description: `${bank?.bankType} 银农直联接口已建立连接` });
      } else {
        toast.success("连接正常", { description: `${bank?.bankType} 接口连接正常，响应时间 85ms` });
      }
    }, 1200);
  };

  const handleDeleteInterface = () => {
    if (showDelete !== null) {
      const bank = bankInterfaces.find(b => b.id === showDelete);
      setBankInterfaces(bankInterfaces.filter(b => b.id !== showDelete));
      toast.success("接口已删除", { description: bank?.bankType });
      setShowDelete(null);
    }
  };

  return (
    <div className="space-y-4">
      <div className="flex items-center text-muted-foreground text-[13px]">
        <span>银农直联</span><ChevronRight className="w-4 h-4 mx-1" /><span className="text-foreground">银行设置</span>
      </div>
      <div className="flex items-center justify-between">
        <h2>银行接口设置</h2>
        <button onClick={() => setShowAddInterface(true)} className="flex items-center gap-1.5 px-4 py-2 bg-primary text-white rounded-lg hover:bg-primary/90"><Plus className="w-4 h-4" /> 新增接口</button>
      </div>

      <div className="bg-white rounded-xl border border-border shadow-sm p-5">
        <div className="overflow-x-auto border border-border rounded-lg">
          <table className="w-full text-[13px]">
            <thead className="bg-muted/60">
              <tr>
                <th className="py-3 px-3 text-left text-muted-foreground" style={{ fontWeight: 500 }}>银行类型</th>
                <th className="py-3 px-3 text-left text-muted-foreground" style={{ fontWeight: 500 }}>银行IP</th>
                <th className="py-3 px-3 text-left text-muted-foreground" style={{ fontWeight: 500 }}>服务地址</th>
                <th className="py-3 px-3 text-left text-muted-foreground" style={{ fontWeight: 500 }}>电子银行合约号</th>
                <th className="py-3 px-3 text-center text-muted-foreground" style={{ fontWeight: 500 }}>状态</th>
                <th className="py-3 px-3 text-center text-muted-foreground" style={{ fontWeight: 500 }}>操作</th>
              </tr>
            </thead>
            <tbody>
              {bankInterfaces.map(row => (
                <tr key={row.id} className="border-t border-border/50 hover:bg-green-50/30">
                  <td className="py-2.5 px-3" style={{ fontWeight: 500 }}>{row.bankType}</td>
                  <td className="py-2.5 px-3 text-muted-foreground">{row.ip}:{row.port}</td>
                  <td className="py-2.5 px-3 text-[12px] text-primary">{row.serviceUrl}</td>
                  <td className="py-2.5 px-3">{row.contractNo}</td>
                  <td className="py-2.5 px-3 text-center">
                    <span className={`px-2 py-0.5 rounded-full text-[12px] ${row.status === "已连接" ? "bg-green-50 text-green-600" : "bg-gray-100 text-gray-500"}`}>{row.status}</span>
                  </td>
                  <td className="py-2.5 px-3">
                    <div className="flex items-center justify-center gap-1">
                      <button onClick={() => handleTestConnection(row.id)} className="p-1 hover:bg-muted rounded" title="测试连接"><RefreshCw className="w-4 h-4 text-blue-500" /></button>
                      <button onClick={() => toast.info("编辑接口", { description: row.bankType })} className="p-1 hover:bg-muted rounded" title="编辑"><Edit className="w-4 h-4 text-muted-foreground" /></button>
                      <button onClick={() => setShowDelete(row.id)} className="p-1 hover:bg-muted rounded" title="删除"><Trash2 className="w-4 h-4 text-red-400" /></button>
                    </div>
                  </td>
                </tr>
              ))}
            </tbody>
          </table>
        </div>
      </div>

      {/* Transaction Query */}
      <div className="bg-white rounded-xl border border-border shadow-sm p-5">
        <h3 className="mb-4">交易查询</h3>
        <div className="flex flex-wrap gap-3 mb-4">
          <select className="bg-muted rounded-lg px-3 py-2 outline-none" value={selectedBank} onChange={e => { setSelectedBank(e.target.value); setBalanceResult(null); setTransactionResults(null); setQueryType(null); }}>
            <option>海南农商银行</option><option>中国农业银行</option>
          </select>
          <input type="date" defaultValue="2026-03-01" className="bg-muted rounded-lg px-3 py-2 outline-none" />
          <span className="leading-[36px] text-muted-foreground">至</span>
          <input type="date" defaultValue="2026-03-09" className="bg-muted rounded-lg px-3 py-2 outline-none" />
          <button onClick={handleQueryBalance} disabled={queryLoading} className="flex items-center gap-1.5 px-4 py-2 bg-primary text-white rounded-lg hover:bg-primary/90 disabled:opacity-50">
            {queryLoading && queryType === "balance" ? <RefreshCw className="w-4 h-4 animate-spin" /> : <Search className="w-4 h-4" />} 查询余额
          </button>
          <button onClick={handleQueryTransaction} disabled={queryLoading} className="flex items-center gap-1.5 px-4 py-2 border border-border rounded-lg hover:bg-muted disabled:opacity-50">
            {queryLoading && queryType === "transaction" ? <RefreshCw className="w-4 h-4 animate-spin" /> : <Search className="w-4 h-4" />} 查询交易
          </button>
        </div>

        {/* Balance Result */}
        {balanceResult && (
          <div className="border border-green-200 bg-green-50/30 rounded-xl p-5 mb-4">
            <div className="flex items-center gap-2 mb-3">
              <CheckCircle className="w-5 h-5 text-green-600" />
              <span className="text-green-700" style={{ fontWeight: 500 }}>余额查询结果</span>
              <span className="text-[12px] text-muted-foreground ml-auto">查询时间：{balanceResult.time}</span>
            </div>
            <div className="grid grid-cols-2 md:grid-cols-4 gap-4">
              {[
                ["账号", balanceResult.account],
                ["账户名称", balanceResult.name],
                ["账户余额", `¥ ${balanceResult.balance.toLocaleString()}`],
                ["可用余额", `¥ ${balanceResult.available.toLocaleString()}`],
              ].map(([label, value]) => (
                <div key={label} className="bg-white rounded-lg p-3 border border-green-100">
                  <p className="text-[12px] text-muted-foreground">{label}</p>
                  <p className="mt-1" style={{ fontWeight: 600 }}>{value}</p>
                </div>
              ))}
            </div>
            <div className="flex gap-2 mt-3">
              <button onClick={() => toast.success("导出成功", { description: "余额查询结果已导出" })} className="flex items-center gap-1 px-3 py-1.5 border border-border rounded-lg text-[12px] hover:bg-white"><Download className="w-3.5 h-3.5" /> 导出</button>
              <button onClick={() => { toast.info("正在生成打印预览..."); setTimeout(() => toast.success("打印预览已生成"), 800); }} className="text-[12px] text-primary hover:underline">打印</button>
            </div>
          </div>
        )}

        {/* Transaction Results */}
        {transactionResults && (
          <div className="border border-blue-200 bg-blue-50/10 rounded-xl p-5">
            <div className="flex items-center justify-between mb-3">
              <div className="flex items-center gap-2">
                <CheckCircle className="w-5 h-5 text-blue-600" />
                <span className="text-blue-700" style={{ fontWeight: 500 }}>交易记录查询结果</span>
                <span className="text-[12px] text-muted-foreground">共 {transactionResults.length} 条</span>
              </div>
              <button onClick={() => toast.success("导出成功", { description: `已导出 ${transactionResults.length} 条交易记录` })} className="flex items-center gap-1 px-3 py-1.5 border border-border rounded-lg text-[12px] hover:bg-white"><Download className="w-3.5 h-3.5" /> 导出Excel</button>
            </div>
            <div className="overflow-x-auto border border-border rounded-lg bg-white">
              <table className="w-full text-[13px]">
                <thead className="bg-muted/60">
                  <tr>
                    <th className="py-2.5 px-3 text-left text-muted-foreground" style={{ fontWeight: 500 }}>交易时间</th>
                    <th className="py-2.5 px-3 text-left text-muted-foreground" style={{ fontWeight: 500 }}>摘要</th>
                    <th className="py-2.5 px-3 text-left text-muted-foreground" style={{ fontWeight: 500 }}>对方</th>
                    <th className="py-2.5 px-3 text-right text-muted-foreground" style={{ fontWeight: 500 }}>支出</th>
                    <th className="py-2.5 px-3 text-right text-muted-foreground" style={{ fontWeight: 500 }}>收入</th>
                    <th className="py-2.5 px-3 text-right text-muted-foreground" style={{ fontWeight: 500 }}>余额</th>
                  </tr>
                </thead>
                <tbody>
                  {transactionResults.map((t, i) => (
                    <tr key={i} className="border-t border-border/50 hover:bg-green-50/30">
                      <td className="py-2 px-3 text-muted-foreground">{t.date}</td>
                      <td className="py-2 px-3">{t.summary}</td>
                      <td className="py-2 px-3 text-muted-foreground">{t.counterparty}</td>
                      <td className="py-2 px-3 text-right text-red-500">{t.debit > 0 ? `¥ ${t.debit.toLocaleString()}` : "-"}</td>
                      <td className="py-2 px-3 text-right text-green-600">{t.credit > 0 ? `¥ ${t.credit.toLocaleString()}` : "-"}</td>
                      <td className="py-2 px-3 text-right" style={{ fontWeight: 500 }}>¥ {t.balance.toLocaleString()}</td>
                    </tr>
                  ))}
                </tbody>
              </table>
            </div>
          </div>
        )}

        {/* Empty State */}
        {!balanceResult && !transactionResults && !queryLoading && (
          <div className="bg-muted/30 rounded-lg p-6 text-center">
            <Building2 className="w-12 h-12 text-muted-foreground/30 mx-auto mb-2" />
            <p className="text-muted-foreground">请选择银行并点击查询按钮获取实时数据</p>
            <p className="text-[12px] text-muted-foreground/60 mt-1">系统将通过银农直联接口获取账户余额和交易记录</p>
          </div>
        )}

        {queryLoading && (
          <div className="bg-muted/30 rounded-lg p-8 text-center">
            <RefreshCw className="w-8 h-8 text-primary animate-spin mx-auto mb-3" />
            <p className="text-muted-foreground">正在通过银农直联接口查询数据...</p>
            <p className="text-[12px] text-muted-foreground/60 mt-1">连接 {selectedBank} 中，请稍候</p>
          </div>
        )}
      </div>

      <ConfirmDialog open={showDelete !== null} onClose={() => setShowDelete(null)} onConfirm={handleDeleteInterface} title="删除银行接口" message="确定要删除该银行接口配置吗？删除后需要重新配置才能使用。" confirmText="删除" type="danger" />
      <Modal open={showAddInterface} onClose={() => setShowAddInterface(false)} title="新增银行接口">
        <div className="space-y-4">
          <div><label className="block text-[13px] text-muted-foreground mb-1">银行类型 *</label><input className="bg-muted rounded-lg px-3 py-2 outline-none w-full" placeholder="如：工商银行" value={newInterface.bankType} onChange={e => setNewInterface({ ...newInterface, bankType: e.target.value })} /></div>
          <div className="grid grid-cols-2 gap-4">
            <div><label className="block text-[13px] text-muted-foreground mb-1">银行IP</label><input className="bg-muted rounded-lg px-3 py-2 outline-none w-full" placeholder="192.168.1.x" value={newInterface.ip} onChange={e => setNewInterface({ ...newInterface, ip: e.target.value })} /></div>
            <div><label className="block text-[13px] text-muted-foreground mb-1">端口</label><input className="bg-muted rounded-lg px-3 py-2 outline-none w-full" placeholder="8443" value={newInterface.port} onChange={e => setNewInterface({ ...newInterface, port: e.target.value })} /></div>
          </div>
          <div><label className="block text-[13px] text-muted-foreground mb-1">服务地址</label><input className="bg-muted rounded-lg px-3 py-2 outline-none w-full" placeholder="https://api.xxx.com/v2" value={newInterface.serviceUrl} onChange={e => setNewInterface({ ...newInterface, serviceUrl: e.target.value })} /></div>
          <div><label className="block text-[13px] text-muted-foreground mb-1">FTP地址</label><input className="bg-muted rounded-lg px-3 py-2 outline-none w-full" placeholder="ftp.xxx.com" value={newInterface.ftpAddr} onChange={e => setNewInterface({ ...newInterface, ftpAddr: e.target.value })} /></div>
          <div className="flex justify-end gap-3 pt-2">
            <button onClick={() => setShowAddInterface(false)} className="px-4 py-2 border border-border rounded-lg hover:bg-muted">取消</button>
            <button onClick={() => { setShowAddInterface(false); const ni = { id: bankInterfaces.length + 10, ...newInterface, status: "未连接" }; setBankInterfaces([...bankInterfaces, ni]); toast.success("接口已添加", { description: `${ni.bankType} 接口已保存，请测试连接` }); setNewInterface({ bankType: "", ip: "", port: "8443", serviceUrl: "", ftpAddr: "", contractNo: "-" }); }} className="px-4 py-2 bg-primary text-white rounded-lg hover:bg-primary/90">保存</button>
          </div>
        </div>
      </Modal>
    </div>
  );
}

// =============== BALANCE QUERY TAB ===============

function BalanceQueryTab() {
  const [selectedAccount, setSelectedAccount] = useState("6228****1234");
  const [queryDate, setQueryDate] = useState("2026-03-10");
  const [querying, setQuerying] = useState(false);
  const [queried, setQueried] = useState(false);
  const [result, setResult] = useState({
    accountNo: "6228****1234", accountName: "椰林村基本账户", bank: "海南农商银行琼海支行",
    balance: 1685600, available: 1620600, frozen: 65000, lastTx: "2026-03-09 16:45:30",
    queryTime: "", status: "正常"
  });

  const accountOptions = [
    { no: "6228****1234", name: "椰林村基本账户", bank: "海南农商银行琼海支行", balance: 1685600, available: 1620600, frozen: 65000 },
    { no: "6225****5678", name: "椰林村专用账户", bank: "中国农业银行琼海支行", balance: 356000, available: 356000, frozen: 0 },
    { no: "6221****9012", name: "椰林村保证金账户", bank: "海南银行琼海支行", balance: 65000, available: 0, frozen: 65000 },
  ];

  const handleQuery = () => {
    setQuerying(true);
    toast.info("正在通过银农直联查询余额...", { description: `连接 ${accountOptions.find(a => a.no === selectedAccount)?.bank}` });
    setTimeout(() => {
      const acc = accountOptions.find(a => a.no === selectedAccount)!;
      setResult({
        accountNo: acc.no, accountName: acc.name, bank: acc.bank,
        balance: acc.balance + Math.round((Math.random() - 0.3) * 5000),
        available: acc.available + Math.round((Math.random() - 0.3) * 3000),
        frozen: acc.frozen,
        lastTx: "2026-03-09 16:45:30",
        queryTime: new Date().toLocaleString("zh-CN"), status: "正常"
      });
      setQuerying(false);
      setQueried(true);
      toast.success("余额查询成功");
    }, 1500);
  };

  return (
    <div className="space-y-5">
      {/* Query Form */}
      <div className="bg-muted/30 rounded-xl p-5 border border-border/50">
        <h3 className="mb-4 flex items-center gap-2"><Search className="w-4 h-4 text-primary" /> 余额查询条件</h3>
        <div className="grid grid-cols-1 md:grid-cols-3 gap-4">
          <div>
            <label className="block text-[13px] text-muted-foreground mb-1">选择账户</label>
            <select className="bg-white rounded-lg px-3 py-2.5 outline-none w-full border border-border focus:ring-2 focus:ring-primary/30" value={selectedAccount} onChange={e => { setSelectedAccount(e.target.value); setQueried(false); }}>
              {accountOptions.map(a => <option key={a.no} value={a.no}>{a.name} ({a.no})</option>)}
            </select>
          </div>
          <div>
            <label className="block text-[13px] text-muted-foreground mb-1">查询日期</label>
            <input type="date" value={queryDate} onChange={e => setQueryDate(e.target.value)} className="bg-white rounded-lg px-3 py-2.5 outline-none w-full border border-border focus:ring-2 focus:ring-primary/30" />
          </div>
          <div className="flex items-end">
            <button onClick={handleQuery} disabled={querying} className="flex items-center gap-1.5 px-6 py-2.5 bg-primary text-white rounded-lg hover:bg-primary/90 disabled:opacity-50 w-full justify-center">
              {querying ? <RefreshCw className="w-4 h-4 animate-spin" /> : <Search className="w-4 h-4" />} {querying ? "查询中..." : "查询余额"}
            </button>
          </div>
        </div>
      </div>

      {/* Query Result */}
      {queried && (
        <div className="border border-green-200 bg-green-50/20 rounded-xl p-5">
          <div className="flex items-center justify-between mb-4">
            <div className="flex items-center gap-2">
              <CheckCircle className="w-5 h-5 text-green-600" />
              <span className="text-green-700" style={{ fontWeight: 500 }}>余额查询结果</span>
            </div>
            <div className="flex items-center gap-2">
              <span className="text-[12px] text-muted-foreground">查询时间：{result.queryTime}</span>
              <button onClick={() => toast.success("导出成功", { description: "余额查询结果已导出" })} className="flex items-center gap-1 px-3 py-1.5 border border-border rounded-lg text-[12px] hover:bg-white"><Download className="w-3.5 h-3.5" /> 导出</button>
            </div>
          </div>

          {/* Account Info */}
          <div className="bg-white rounded-lg p-4 border border-green-100 mb-4">
            <div className="grid grid-cols-2 md:grid-cols-4 gap-3 text-[13px]">
              {[
                ["账户名称", result.accountName],
                ["账号", result.accountNo],
                ["开户银行", result.bank],
                ["账户状态", result.status],
              ].map(([l, v]) => (
                <div key={l}><span className="text-muted-foreground">{l}</span><p style={{ fontWeight: 500 }} className="mt-0.5">{v}</p></div>
              ))}
            </div>
          </div>

          {/* Balance Cards */}
          <div className="grid grid-cols-1 md:grid-cols-3 gap-4 mb-4">
            <div className="bg-white rounded-lg p-4 border border-green-100">
              <p className="text-[12px] text-muted-foreground">账户余额</p>
              <p className="text-[26px] mt-1" style={{ fontWeight: 600, color: "#0d9448" }}>¥ {result.balance.toLocaleString()}</p>
              <p className="text-[11px] text-muted-foreground mt-1">含冻结金额在内的总余额</p>
            </div>
            <div className="bg-white rounded-lg p-4 border border-green-100">
              <p className="text-[12px] text-muted-foreground">可用余额</p>
              <p className="text-[26px] mt-1" style={{ fontWeight: 600, color: "#0ea5e9" }}>¥ {result.available.toLocaleString()}</p>
              <p className="text-[11px] text-muted-foreground mt-1">扣除冻结金额后的可用资金</p>
            </div>
            <div className="bg-white rounded-lg p-4 border border-green-100">
              <p className="text-[12px] text-muted-foreground">冻结金额</p>
              <p className="text-[26px] mt-1" style={{ fontWeight: 600, color: "#f59e0b" }}>¥ {result.frozen.toLocaleString()}</p>
              <p className="text-[11px] text-muted-foreground mt-1">{result.frozen > 0 ? "含保证金等冻结资金" : "无冻结资金"}</p>
            </div>
          </div>

          <div className="text-[12px] text-muted-foreground bg-muted/30 rounded-lg p-3">
            <p>数据来源：{result.bank} 银农直联接口 | 最后交易时间：{result.lastTx}</p>
            <p className="mt-1">说明：余额数据为实时查询结果，以银行系统数据为准。冻结金额包含保证金、司法冻结等不可支配资金。</p>
          </div>
        </div>
      )}

      {!queried && !querying && (
        <div className="bg-muted/20 rounded-xl p-8 text-center border border-border/30">
          <CreditCard className="w-12 h-12 text-muted-foreground/30 mx-auto mb-3" />
          <p className="text-muted-foreground">请选择账户并点击"查询余额"获取实时账户余额信息</p>
          <p className="text-[12px] text-muted-foreground/60 mt-1">系统将通过银农直联接口实时获取银行账户余额数据</p>
        </div>
      )}

      {querying && (
        <div className="bg-muted/20 rounded-xl p-8 text-center border border-border/30">
          <RefreshCw className="w-8 h-8 text-primary animate-spin mx-auto mb-3" />
          <p className="text-muted-foreground">正在通过银农直联接口查询余额...</p>
        </div>
      )}
    </div>
  );
}

// =============== OPENING BANK TAB ===============

function OpeningBankTab() {
  const [banks, setBanks] = useState([
    { id: 1, bankName: "海南农商银行", branchName: "琼海支行", accountNo: "622848201026001234", openDate: "2020-03-15", accountType: "基本户", contactCode: "314685000", address: "琼海市嘉积镇银海路18号", tel: "0898-62921234", status: "正常" },
    { id: 2, bankName: "中国农业银行", branchName: "琼海支行", accountNo: "622502201026005678", openDate: "2021-06-20", accountType: "专用户", contactCode: "103685001", address: "琼海市嘉积镇东风路56号", tel: "0898-62935678", status: "正常" },
    { id: 3, bankName: "海南银行", branchName: "琼海支行", accountNo: "622101201026009012", openDate: "2023-11-08", accountType: "专用户", contactCode: "313685002", address: "琼海市嘉积镇人民路88号", tel: "0898-62948901", status: "冻结" },
  ]);
  const [showAdd, setShowAdd] = useState(false);
  const [showEdit, setShowEdit] = useState<typeof banks[0] | null>(null);
  const [formData, setFormData] = useState({ bankName: "", branchName: "", accountNo: "", openDate: "2026-03-10", accountType: "基本户", contactCode: "", address: "", tel: "" });

  const handleAdd = () => {
    if (!formData.bankName || !formData.accountNo) { toast.error("请填写银行名称和账号"); return; }
    const newId = Math.max(...banks.map(b => b.id), 0) + 1;
    setBanks(prev => [...prev, { id: newId, ...formData, status: "正常" }]);
    setShowAdd(false);
    setFormData({ bankName: "", branchName: "", accountNo: "", openDate: "2026-03-10", accountType: "基本户", contactCode: "", address: "", tel: "" });
    toast.success("开户银行添加成功", { description: `${formData.bankName} ${formData.branchName}` });
  };

  const handleEditSave = () => {
    if (!showEdit) return;
    setBanks(prev => prev.map(b => b.id === showEdit.id ? { ...showEdit } : b));
    toast.success("银行信息已更新", { description: showEdit.bankName });
    setShowEdit(null);
  };

  return (
    <div className="space-y-4">
      <div className="flex items-center justify-between">
        <p className="text-[13px] text-muted-foreground">椰林村已开户银行信息，共 {banks.length} 个银行账户</p>
        <button onClick={() => setShowAdd(true)} className="flex items-center gap-1.5 px-4 py-2 bg-primary text-white rounded-lg hover:bg-primary/90"><Plus className="w-4 h-4" /> 新增开户银行</button>
      </div>
      <div className="overflow-x-auto border border-border rounded-lg">
        <table className="w-full text-[13px]">
          <thead className="bg-muted/60">
            <tr>
              <th className="py-3 px-3 text-left text-muted-foreground" style={{ fontWeight: 500 }}>银行名称</th>
              <th className="py-3 px-3 text-left text-muted-foreground" style={{ fontWeight: 500 }}>银行账号</th>
              <th className="py-3 px-3 text-left text-muted-foreground" style={{ fontWeight: 500 }}>开户日期</th>
              <th className="py-3 px-3 text-center text-muted-foreground" style={{ fontWeight: 500 }}>账户类型</th>
              <th className="py-3 px-3 text-left text-muted-foreground" style={{ fontWeight: 500 }}>联行号</th>
              <th className="py-3 px-3 text-left text-muted-foreground" style={{ fontWeight: 500 }}>地址</th>
              <th className="py-3 px-3 text-center text-muted-foreground" style={{ fontWeight: 500 }}>状态</th>
              <th className="py-3 px-3 text-center text-muted-foreground" style={{ fontWeight: 500 }}>操作</th>
            </tr>
          </thead>
          <tbody>
            {banks.map(row => (
              <tr key={row.id} className="border-t border-border/50 hover:bg-green-50/30">
                <td className="py-2.5 px-3"><div><span style={{ fontWeight: 500 }}>{row.bankName}</span><p className="text-[11px] text-muted-foreground">{row.branchName}</p></div></td>
                <td className="py-2.5 px-3 text-primary">{row.accountNo}</td>
                <td className="py-2.5 px-3 text-muted-foreground">{row.openDate}</td>
                <td className="py-2.5 px-3 text-center"><span className={`px-2 py-0.5 rounded text-[12px] ${row.accountType === "基本户" ? "bg-green-50 text-green-600" : "bg-blue-50 text-blue-600"}`}>{row.accountType}</span></td>
                <td className="py-2.5 px-3 text-muted-foreground">{row.contactCode}</td>
                <td className="py-2.5 px-3 text-muted-foreground text-[12px]">{row.address}</td>
                <td className="py-2.5 px-3 text-center"><span className={`px-2 py-0.5 rounded-full text-[12px] ${row.status === "正常" ? "bg-green-50 text-green-600" : "bg-red-50 text-red-500"}`}>{row.status}</span></td>
                <td className="py-2.5 px-3">
                  <div className="flex items-center justify-center gap-1">
                    <button onClick={() => setShowEdit({ ...row })} className="p-1 hover:bg-muted rounded" title="编辑"><Edit className="w-4 h-4 text-muted-foreground" /></button>
                    <button onClick={() => toast.info("银行详情", { description: `${row.bankName} ${row.branchName}\n账号：${row.accountNo}\n电话：${row.tel}` })} className="p-1 hover:bg-muted rounded" title="查看"><Eye className="w-4 h-4 text-muted-foreground" /></button>
                  </div>
                </td>
              </tr>
            ))}
          </tbody>
        </table>
      </div>

      {/* Add Modal */}
      <Modal open={showAdd} onClose={() => setShowAdd(false)} title="新增开户银行" width="max-w-xl">
        <div className="space-y-4">
          <div className="grid grid-cols-2 gap-4">
            <div><label className="block text-[13px] text-muted-foreground mb-1">银行名称 *</label><input value={formData.bankName} onChange={e => setFormData({ ...formData, bankName: e.target.value })} placeholder="如：中国工商银行" className="bg-muted rounded-lg px-3 py-2 outline-none w-full" /></div>
            <div><label className="block text-[13px] text-muted-foreground mb-1">支行名称</label><input value={formData.branchName} onChange={e => setFormData({ ...formData, branchName: e.target.value })} placeholder="如：琼海支行" className="bg-muted rounded-lg px-3 py-2 outline-none w-full" /></div>
          </div>
          <div><label className="block text-[13px] text-muted-foreground mb-1">银行账号 *</label><input value={formData.accountNo} onChange={e => setFormData({ ...formData, accountNo: e.target.value })} placeholder="请输入完整银行账号" className="bg-muted rounded-lg px-3 py-2 outline-none w-full" /></div>
          <div className="grid grid-cols-2 gap-4">
            <div><label className="block text-[13px] text-muted-foreground mb-1">开户日期</label><input type="date" value={formData.openDate} onChange={e => setFormData({ ...formData, openDate: e.target.value })} className="bg-muted rounded-lg px-3 py-2 outline-none w-full" /></div>
            <div><label className="block text-[13px] text-muted-foreground mb-1">账户类型</label><select value={formData.accountType} onChange={e => setFormData({ ...formData, accountType: e.target.value })} className="bg-muted rounded-lg px-3 py-2 outline-none w-full"><option>基本户</option><option>专用户</option></select></div>
          </div>
          <div className="grid grid-cols-2 gap-4">
            <div><label className="block text-[13px] text-muted-foreground mb-1">联行号</label><input value={formData.contactCode} onChange={e => setFormData({ ...formData, contactCode: e.target.value })} placeholder="联行号" className="bg-muted rounded-lg px-3 py-2 outline-none w-full" /></div>
            <div><label className="block text-[13px] text-muted-foreground mb-1">联系电话</label><input value={formData.tel} onChange={e => setFormData({ ...formData, tel: e.target.value })} placeholder="联系电话" className="bg-muted rounded-lg px-3 py-2 outline-none w-full" /></div>
          </div>
          <div><label className="block text-[13px] text-muted-foreground mb-1">银行地址</label><input value={formData.address} onChange={e => setFormData({ ...formData, address: e.target.value })} placeholder="银行地址" className="bg-muted rounded-lg px-3 py-2 outline-none w-full" /></div>
          <div className="flex justify-end gap-3 pt-2">
            <button onClick={() => setShowAdd(false)} className="px-4 py-2 border border-border rounded-lg hover:bg-muted">取消</button>
            <button onClick={handleAdd} className="px-4 py-2 bg-primary text-white rounded-lg hover:bg-primary/90">保存</button>
          </div>
        </div>
      </Modal>

      {/* Edit Modal */}
      <Modal open={!!showEdit} onClose={() => setShowEdit(null)} title="编辑开户银行" width="max-w-xl">
        {showEdit && (
          <div className="space-y-4">
            <div className="grid grid-cols-2 gap-4">
              <div><label className="block text-[13px] text-muted-foreground mb-1">银行名称</label><input value={showEdit.bankName} onChange={e => setShowEdit({ ...showEdit, bankName: e.target.value })} className="bg-muted rounded-lg px-3 py-2 outline-none w-full" /></div>
              <div><label className="block text-[13px] text-muted-foreground mb-1">支行名称</label><input value={showEdit.branchName} onChange={e => setShowEdit({ ...showEdit, branchName: e.target.value })} className="bg-muted rounded-lg px-3 py-2 outline-none w-full" /></div>
            </div>
            <div><label className="block text-[13px] text-muted-foreground mb-1">银行账号</label><input value={showEdit.accountNo} onChange={e => setShowEdit({ ...showEdit, accountNo: e.target.value })} className="bg-muted rounded-lg px-3 py-2 outline-none w-full" /></div>
            <div className="grid grid-cols-2 gap-4">
              <div><label className="block text-[13px] text-muted-foreground mb-1">开户日期</label><input type="date" value={showEdit.openDate} onChange={e => setShowEdit({ ...showEdit, openDate: e.target.value })} className="bg-muted rounded-lg px-3 py-2 outline-none w-full" /></div>
              <div><label className="block text-[13px] text-muted-foreground mb-1">账户类型</label><select value={showEdit.accountType} onChange={e => setShowEdit({ ...showEdit, accountType: e.target.value })} className="bg-muted rounded-lg px-3 py-2 outline-none w-full"><option>基本户</option><option>专用户</option></select></div>
            </div>
            <div className="grid grid-cols-2 gap-4">
              <div><label className="block text-[13px] text-muted-foreground mb-1">联行号</label><input value={showEdit.contactCode} onChange={e => setShowEdit({ ...showEdit, contactCode: e.target.value })} className="bg-muted rounded-lg px-3 py-2 outline-none w-full" /></div>
              <div><label className="block text-[13px] text-muted-foreground mb-1">联系电话</label><input value={showEdit.tel} onChange={e => setShowEdit({ ...showEdit, tel: e.target.value })} className="bg-muted rounded-lg px-3 py-2 outline-none w-full" /></div>
            </div>
            <div><label className="block text-[13px] text-muted-foreground mb-1">银行地址</label><input value={showEdit.address} onChange={e => setShowEdit({ ...showEdit, address: e.target.value })} className="bg-muted rounded-lg px-3 py-2 outline-none w-full" /></div>
            <div className="flex justify-end gap-3 pt-2">
              <button onClick={() => setShowEdit(null)} className="px-4 py-2 border border-border rounded-lg hover:bg-muted">取消</button>
              <button onClick={handleEditSave} className="px-4 py-2 bg-primary text-white rounded-lg hover:bg-primary/90">保存</button>
            </div>
          </div>
        )}
      </Modal>
    </div>
  );
}

// =============== BANK ACCOUNT ===============

export function BankAccount() {
  const [tab, setTab] = useState("basic");
  const tabs = [
    { key: "basic", label: "基本账户" },
    { key: "balance", label: "余额查询" },
    { key: "opening", label: "开户银行" },
  ];
  const [accounts, setAccounts] = useState([
    { id: 1, no: "6228****1234", name: "椰林村基本账户", bank: "海南农商银行琼海支行", balance: 1685600, type: "基本户", status: "正常" },
    { id: 2, no: "6225****5678", name: "椰林村专用账户", bank: "中国农业银行琼海支行", balance: 356000, type: "专用户", status: "正常" },
    { id: 3, no: "6221****9012", name: "椰林村保证金账户", bank: "海南银行琼海支行", balance: 65000, type: "专用户", status: "冻结" },
  ]);
  const [showAdd, setShowAdd] = useState(false);
  const [newAccount, setNewAccount] = useState({ name: "", bank: "海南农商银行琼海支行", no: "", type: "基本户" });

  const handleRefreshBalance = () => {
    toast.info("正在查询实时余额...");
    setTimeout(() => {
      setAccounts(accounts.map(a => ({
        ...a,
        balance: a.balance + Math.round((Math.random() - 0.3) * 10000),
      })));
      toast.success("余额已刷新", { description: "已通过银农直联获取最新余额" });
    }, 1200);
  };

  return (
    <div className="space-y-4">
      <div className="flex items-center text-muted-foreground text-[13px]">
        <span>银农直联</span><ChevronRight className="w-4 h-4 mx-1" /><span className="text-foreground">账户管理</span>
      </div>
      <h2>账户管理</h2>
      <div className="bg-white rounded-xl border border-border shadow-sm">
        <div className="flex border-b border-border">
          {tabs.map(t => (
            <button key={t.key} className={`px-5 py-3 border-b-2 transition-colors ${tab === t.key ? "border-primary text-primary" : "border-transparent text-muted-foreground"}`} onClick={() => setTab(t.key)}>{t.label}</button>
          ))}
        </div>
        <div className="p-5">
          {tab === "basic" && (<>
          <div className="flex justify-end gap-2 mb-4">
            <button onClick={handleRefreshBalance} className="flex items-center gap-1.5 px-4 py-2 border border-border rounded-lg hover:bg-muted"><RefreshCw className="w-4 h-4" /> 刷新余额</button>
            <button onClick={() => setShowAdd(true)} className="flex items-center gap-1.5 px-4 py-2 bg-primary text-white rounded-lg hover:bg-primary/90"><Plus className="w-4 h-4" /> 新增账户</button>
          </div>
          <div className="overflow-x-auto border border-border rounded-lg">
            <table className="w-full text-[13px]">
              <thead className="bg-muted/60">
                <tr>
                  <th className="py-3 px-3 text-left text-muted-foreground" style={{ fontWeight: 500 }}>账号</th>
                  <th className="py-3 px-3 text-left text-muted-foreground" style={{ fontWeight: 500 }}>账户名称</th>
                  <th className="py-3 px-3 text-left text-muted-foreground" style={{ fontWeight: 500 }}>开户银行</th>
                  <th className="py-3 px-3 text-right text-muted-foreground" style={{ fontWeight: 500 }}>余额</th>
                  <th className="py-3 px-3 text-center text-muted-foreground" style={{ fontWeight: 500 }}>类型</th>
                  <th className="py-3 px-3 text-center text-muted-foreground" style={{ fontWeight: 500 }}>状态</th>
                  <th className="py-3 px-3 text-center text-muted-foreground" style={{ fontWeight: 500 }}>操作</th>
                </tr>
              </thead>
              <tbody>
                {accounts.map(row => (
                  <tr key={row.id} className="border-t border-border/50 hover:bg-green-50/30">
                    <td className="py-2.5 px-3 text-primary">{row.no}</td>
                    <td className="py-2.5 px-3">{row.name}</td>
                    <td className="py-2.5 px-3 text-muted-foreground">{row.bank}</td>
                    <td className="py-2.5 px-3 text-right" style={{ fontWeight: 500 }}>¥ {row.balance.toLocaleString()}</td>
                    <td className="py-2.5 px-3 text-center"><span className="px-2 py-0.5 bg-green-50 text-green-600 rounded text-[12px]">{row.type}</span></td>
                    <td className="py-2.5 px-3 text-center">
                      <span className={`px-2 py-0.5 rounded-full text-[12px] ${row.status === "正常" ? "bg-green-50 text-green-600" : "bg-red-50 text-red-500"}`}>{row.status}</span>
                    </td>
                    <td className="py-2.5 px-3">
                      <div className="flex items-center justify-center gap-1">
                        <button className="p-1 hover:bg-muted rounded" onClick={() => toast.info("账户详情", { description: `${row.name} - ${row.bank}` })}><Eye className="w-4 h-4 text-muted-foreground" /></button>
                        <button className="p-1 hover:bg-muted rounded" onClick={() => toast.info("编辑账户", { description: row.name })}><Edit className="w-4 h-4 text-muted-foreground" /></button>
                      </div>
                    </td>
                  </tr>
                ))}
              </tbody>
            </table>
          </div>
          </>)}

          {tab === "balance" && (
            <BalanceQueryTab />
          )}

          {tab === "opening" && (
            <OpeningBankTab />
          )}
        </div>
      </div>
      <Modal open={showAdd} onClose={() => setShowAdd(false)} title="新增银行账户">
        <div className="space-y-4">
          <div><label className="block text-[13px] text-muted-foreground mb-1">账户名称</label><input className="bg-muted rounded-lg px-3 py-2 outline-none w-full" placeholder="如：椰林村专项资金账户" value={newAccount.name} onChange={e => setNewAccount({ ...newAccount, name: e.target.value })} /></div>
          <div><label className="block text-[13px] text-muted-foreground mb-1">开户银行</label><select className="bg-muted rounded-lg px-3 py-2 outline-none w-full" value={newAccount.bank} onChange={e => setNewAccount({ ...newAccount, bank: e.target.value })}><option>海南农商银行琼海支行</option><option>中国农业银行琼海支行</option><option>海南银行琼海支行</option></select></div>
          <div><label className="block text-[13px] text-muted-foreground mb-1">银行账号</label><input className="bg-muted rounded-lg px-3 py-2 outline-none w-full" placeholder="请输入银行账号" value={newAccount.no} onChange={e => setNewAccount({ ...newAccount, no: e.target.value })} /></div>
          <div><label className="block text-[13px] text-muted-foreground mb-1">账户类型</label><select className="bg-muted rounded-lg px-3 py-2 outline-none w-full" value={newAccount.type} onChange={e => setNewAccount({ ...newAccount, type: e.target.value })}><option>基本户</option><option>专用户</option></select></div>
          <div className="flex justify-end gap-3 pt-2">
            <button onClick={() => setShowAdd(false)} className="px-4 py-2 border border-border rounded-lg hover:bg-muted">取消</button>
            <button onClick={() => { setShowAdd(false); toast.success("账户创建成功"); setAccounts([...accounts, { id: accounts.length + 1, ...newAccount, balance: 0, status: "正常" }]); setNewAccount({ name: "", bank: "海南农商银行琼海支行", no: "", type: "基本户" }); }} className="px-4 py-2 bg-primary text-white rounded-lg hover:bg-primary/90">保存</button>
          </div>
        </div>
      </Modal>
    </div>
  );
}

// =============== RECEIPT TAB ===============

function ReceiptTab() {
  const [dateFrom, setDateFrom] = useState("2026-03-01");
  const [dateTo, setDateTo] = useState("2026-03-10");
  const [accountFilter, setAccountFilter] = useState("全部账户");
  const [typeFilter, setTypeFilter] = useState("全部类型");
  const [querying, setQuerying] = useState(false);
  const [queried, setQueried] = useState(false);
  const [showDetail, setShowDetail] = useState<typeof receiptData[0] | null>(null);

  const receiptData = [
    { id: 1, no: "HD20260309001", downloadDate: "2026-03-09 15:30", downloader: "符会计", bankAccount: "6228****1234", receiptType: "支出回单", receiptDate: "2026-03-09", amount: 56000, counterparty: "琼海宏达建设公司", summary: "美丽乡村建设工程款", bank: "海南农商银行", status: "已下载" },
    { id: 2, no: "HD20260308001", downloadDate: "2026-03-08 17:20", downloader: "王出纳", bankAccount: "6228****1234", receiptType: "收入回单", receiptDate: "2026-03-08", amount: 12000, counterparty: "符永昌", summary: "槟榔园承包费", bank: "海南农商银行", status: "已下载" },
    { id: 3, no: "HD20260308002", downloadDate: "2026-03-08 16:45", downloader: "符会计", bankAccount: "6228****1234", receiptType: "支出回单", receiptDate: "2026-03-08", amount: 4500, counterparty: "海南电网琼海供电局", summary: "水电费", bank: "海南农商银行", status: "已下载" },
    { id: 4, no: "HD20260307001", downloadDate: "2026-03-07 14:55", downloader: "符会计", bankAccount: "6228****1234", receiptType: "收入回单", receiptDate: "2026-03-07", amount: 80000, counterparty: "博鳌镇财政所", summary: "省级乡村振兴补助款", bank: "海南农商银行", status: "已下载" },
    { id: 5, no: "HD20260307002", downloadDate: "2026-03-07 11:30", downloader: "王出纳", bankAccount: "6228****1234", receiptType: "支出回单", receiptDate: "2026-03-07", amount: 3150, counterparty: "琼海文华办公", summary: "办公用品采购", bank: "海南农商银行", status: "已下载" },
    { id: 6, no: "HD20260306001", downloadDate: "2026-03-06 16:10", downloader: "符会计", bankAccount: "6225****5678", receiptType: "支出回单", receiptDate: "2026-03-06", amount: 38000, counterparty: "海南中路建设公司", summary: "村道硬化修缮费", bank: "中国农业银行", status: "已下载" },
    { id: 7, no: "HD20260305001", downloadDate: "2026-03-05 09:40", downloader: "王出纳", bankAccount: "6228****1234", receiptType: "转账回单", receiptDate: "2026-03-05", amount: 18000, counterparty: "王秀兰等6人", summary: "保洁人员工资", bank: "海南农商银行", status: "待下载" },
  ];

  const [receipts, setReceipts] = useState<typeof receiptData>([]);

  const handleQuery = () => {
    setQuerying(true);
    toast.info("正在通过银农直联查询电子回单...");
    setTimeout(() => {
      let filtered = receiptData;
      if (accountFilter !== "全部账户") filtered = filtered.filter(r => r.bankAccount === accountFilter);
      if (typeFilter !== "全部类型") filtered = filtered.filter(r => r.receiptType === typeFilter);
      setReceipts(filtered);
      setQuerying(false);
      setQueried(true);
      toast.success("查询完成", { description: `共查询到 ${filtered.length} 张电子回单` });
    }, 1200);
  };

  const handleDownload = (item: typeof receiptData[0]) => {
    toast.info(`正在下载 ${item.no}...`);
    setTimeout(() => {
      setReceipts(prev => prev.map(r => r.id === item.id ? { ...r, status: "已下载" } : r));
      toast.success("下载成功", { description: `${item.no}.pdf 已保存至本地` });
    }, 800);
  };

  return (
    <div className="space-y-5">
      {/* Query Section */}
      <div className="bg-muted/30 rounded-xl p-5 border border-border/50">
        <h3 className="mb-4 flex items-center gap-2"><Search className="w-4 h-4 text-primary" /> 电子回单查询</h3>
        <div className="grid grid-cols-2 md:grid-cols-5 gap-3">
          <div>
            <label className="block text-[12px] text-muted-foreground mb-1">开始日期</label>
            <input type="date" value={dateFrom} onChange={e => setDateFrom(e.target.value)} className="bg-white rounded-lg px-3 py-2 outline-none w-full border border-border text-[13px]" />
          </div>
          <div>
            <label className="block text-[12px] text-muted-foreground mb-1">结束日期</label>
            <input type="date" value={dateTo} onChange={e => setDateTo(e.target.value)} className="bg-white rounded-lg px-3 py-2 outline-none w-full border border-border text-[13px]" />
          </div>
          <div>
            <label className="block text-[12px] text-muted-foreground mb-1">银行账号</label>
            <select value={accountFilter} onChange={e => setAccountFilter(e.target.value)} className="bg-white rounded-lg px-3 py-2 outline-none w-full border border-border text-[13px]">
              <option>全部账户</option><option>6228****1234</option><option>6225****5678</option>
            </select>
          </div>
          <div>
            <label className="block text-[12px] text-muted-foreground mb-1">回单类型</label>
            <select value={typeFilter} onChange={e => setTypeFilter(e.target.value)} className="bg-white rounded-lg px-3 py-2 outline-none w-full border border-border text-[13px]">
              <option>全部类型</option><option>收入回单</option><option>支出回单</option><option>转账回单</option>
            </select>
          </div>
          <div className="flex items-end">
            <button onClick={handleQuery} disabled={querying} className="flex items-center gap-1.5 px-5 py-2 bg-primary text-white rounded-lg hover:bg-primary/90 disabled:opacity-50 w-full justify-center text-[13px]">
              {querying ? <RefreshCw className="w-4 h-4 animate-spin" /> : <Search className="w-4 h-4" />} 查询
            </button>
          </div>
        </div>
      </div>

      {/* Results */}
      {queried && receipts.length > 0 && (
        <div>
          <div className="flex items-center justify-between mb-3">
            <div className="flex items-center gap-2 text-[13px]">
              <CheckCircle className="w-4 h-4 text-green-600" />
              <span style={{ fontWeight: 500 }}>查询结果</span>
              <span className="text-muted-foreground">共 {receipts.length} 张回单</span>
            </div>
            <div className="flex gap-2">
              <button onClick={() => { receipts.forEach(r => { if (r.status === "待下载") handleDownload(r); }); if (receipts.every(r => r.status === "已下载")) toast.info("所有回单均已下载"); }} className="flex items-center gap-1 px-3 py-1.5 bg-primary text-white rounded-lg text-[12px] hover:bg-primary/90"><Download className="w-3.5 h-3.5" /> 批量下载</button>
              <button onClick={() => toast.success("导出成功", { description: `已导出 ${receipts.length} 条回单记录` })} className="flex items-center gap-1 px-3 py-1.5 border border-border rounded-lg text-[12px] hover:bg-muted"><Download className="w-3.5 h-3.5" /> 导出Excel</button>
            </div>
          </div>
          <div className="overflow-x-auto border border-border rounded-lg">
            <table className="w-full text-[13px]">
              <thead className="bg-muted/60">
                <tr>
                  <th className="py-3 px-3 text-left text-muted-foreground" style={{ fontWeight: 500 }}>回单编号</th>
                  <th className="py-3 px-3 text-left text-muted-foreground" style={{ fontWeight: 500 }}>下载日期</th>
                  <th className="py-3 px-3 text-left text-muted-foreground" style={{ fontWeight: 500 }}>下载人员</th>
                  <th className="py-3 px-3 text-left text-muted-foreground" style={{ fontWeight: 500 }}>银行账号</th>
                  <th className="py-3 px-3 text-center text-muted-foreground" style={{ fontWeight: 500 }}>回单类型</th>
                  <th className="py-3 px-3 text-left text-muted-foreground" style={{ fontWeight: 500 }}>回单日期</th>
                  <th className="py-3 px-3 text-right text-muted-foreground" style={{ fontWeight: 500 }}>金额</th>
                  <th className="py-3 px-3 text-center text-muted-foreground" style={{ fontWeight: 500 }}>状态</th>
                  <th className="py-3 px-3 text-center text-muted-foreground" style={{ fontWeight: 500 }}>操作</th>
                </tr>
              </thead>
              <tbody>
                {receipts.map(r => (
                  <tr key={r.id} className="border-t border-border/50 hover:bg-green-50/30">
                    <td className="py-2.5 px-3 text-primary cursor-pointer hover:underline" onClick={() => setShowDetail(r)}>{r.no}</td>
                    <td className="py-2.5 px-3 text-muted-foreground text-[12px]">{r.downloadDate}</td>
                    <td className="py-2.5 px-3">{r.downloader}</td>
                    <td className="py-2.5 px-3 text-muted-foreground">{r.bankAccount}</td>
                    <td className="py-2.5 px-3 text-center"><span className={`px-2 py-0.5 rounded text-[12px] ${r.receiptType === "收入回单" ? "bg-green-50 text-green-600" : r.receiptType === "支出回单" ? "bg-red-50 text-red-500" : "bg-blue-50 text-blue-600"}`}>{r.receiptType}</span></td>
                    <td className="py-2.5 px-3">{r.receiptDate}</td>
                    <td className="py-2.5 px-3 text-right" style={{ fontWeight: 500 }}>¥ {r.amount.toLocaleString()}</td>
                    <td className="py-2.5 px-3 text-center"><span className={`px-2 py-0.5 rounded-full text-[12px] ${r.status === "已下载" ? "bg-green-50 text-green-600" : "bg-amber-50 text-amber-600"}`}>{r.status}</span></td>
                    <td className="py-2.5 px-3">
                      <div className="flex items-center justify-center gap-1">
                        <button onClick={() => setShowDetail(r)} className="p-1 hover:bg-muted rounded" title="查看"><Eye className="w-4 h-4 text-muted-foreground" /></button>
                        <button onClick={() => handleDownload(r)} className="p-1 hover:bg-muted rounded" title="下载"><Download className="w-4 h-4 text-primary" /></button>
                      </div>
                    </td>
                  </tr>
                ))}
              </tbody>
            </table>
          </div>
          <div className="flex items-center justify-between mt-3 text-[13px]">
            <span className="text-muted-foreground">共 {receipts.length} 条记录</span>
            <span className="text-muted-foreground">已下载 {receipts.filter(r => r.status === "已下载").length} 张 | 待下载 {receipts.filter(r => r.status === "待下载").length} 张</span>
          </div>
        </div>
      )}

      {queried && receipts.length === 0 && (
        <div className="text-center py-12 bg-muted/20 rounded-xl border border-border/30">
          <Download className="w-10 h-10 text-muted-foreground/30 mx-auto mb-3" />
          <p className="text-muted-foreground">未查询到符合条件的电子回单</p>
          <p className="text-[12px] text-muted-foreground/60 mt-1">请调整查询条件后重新查询</p>
        </div>
      )}

      {!queried && !querying && (
        <div className="text-center py-12 bg-muted/20 rounded-xl border border-border/30">
          <CreditCard className="w-10 h-10 text-muted-foreground/30 mx-auto mb-3" />
          <p className="text-muted-foreground">请设置查询条件并点击"查询"获取电子回单</p>
          <p className="text-[12px] text-muted-foreground/60 mt-1">系统将通过银农直联接口获取银行电子回单数据</p>
        </div>
      )}

      {querying && (
        <div className="text-center py-12 bg-muted/20 rounded-xl border border-border/30">
          <RefreshCw className="w-8 h-8 text-primary animate-spin mx-auto mb-3" />
          <p className="text-muted-foreground">正在通过银农直联接口查询电子回单...</p>
        </div>
      )}

      {/* Detail Modal */}
      <Modal open={!!showDetail} onClose={() => setShowDetail(null)} title="电子回单详情" width="max-w-xl">
        {showDetail && (
          <div className="space-y-4">
            <div className="border border-primary/20 bg-primary/5 rounded-lg p-4">
              <div className="flex items-center justify-between mb-2">
                <span style={{ fontWeight: 500 }}>电子银行交易回单</span>
                <span className="text-[12px] text-muted-foreground">{showDetail.bank}</span>
              </div>
              <p className="text-[12px] text-muted-foreground">回单编号：{showDetail.no}</p>
            </div>
            <div className="grid grid-cols-2 gap-3 text-[14px]">
              {[
                ["交易日期", showDetail.receiptDate],
                ["回单类型", showDetail.receiptType],
                ["交易金额", `¥ ${showDetail.amount.toLocaleString()}`],
                ["对方单位", showDetail.counterparty],
                ["我方账号", showDetail.bankAccount],
                ["摘要", showDetail.summary],
                ["下载人员", showDetail.downloader],
                ["下载时间", showDetail.downloadDate],
              ].map(([l, v]) => (
                <div key={l}><span className="text-muted-foreground text-[12px]">{l}</span><p style={{ fontWeight: 500 }} className="mt-0.5">{v}</p></div>
              ))}
            </div>
            <div className="flex justify-end gap-2 pt-2 border-t border-border">
              <button onClick={() => { toast.success("打印预览已生成"); }} className="px-4 py-2 border border-border rounded-lg text-[13px] hover:bg-muted">打印</button>
              <button onClick={() => handleDownload(showDetail)} className="px-4 py-2 bg-primary text-white rounded-lg text-[13px] hover:bg-primary/90"><Download className="w-4 h-4 inline mr-1" />下载PDF</button>
            </div>
          </div>
        )}
      </Modal>
    </div>
  );
}

// =============== BANK PARTNER ===============

export function BankPartner() {
  const [tab, setTab] = useState("unit");
  const tabs = [{ key: "unit", label: "往来单位" }, { key: "person", label: "往来个人" }, { key: "receipt", label: "电子回单" }];

  const [units, setUnits] = useState([
    { id: 1, name: "琼海宏达建设有限公司", contact: "吴经理", phone: "138****5678", account: "6222****5678", type: "供应商" },
    { id: 2, name: "海南绿源园林公司", contact: "陈经理", phone: "139****9012", account: "6223****7890", type: "供应商" },
    { id: 3, name: "琼海科信电脑城", contact: "赵店长", phone: "137****3456", account: "6225****9012", type: "供应商" },
    { id: 4, name: "海南碧水环保科技", contact: "孙总", phone: "136****7890", account: "6226****3456", type: "供应商" },
    { id: 5, name: "博鳌镇财政所", contact: "周主任", phone: "135****2345", account: "6227****6789", type: "政府机构" },
  ]);
  const [persons, setPersons] = useState([
    { id: 1, name: "符永昌", phone: "158****1234", type: "承包户", amount: "¥ 144,000" },
    { id: 2, name: "陈大文", phone: "159****5678", type: "经营户", amount: "¥ 67,200" },
    { id: 3, name: "王秀兰", phone: "157****9012", type: "职工", amount: "¥ 3,000/月" },
  ]);
  const [showAddUnit, setShowAddUnit] = useState(false);
  const [showDeleteUnit, setShowDeleteUnit] = useState<number | null>(null);
  const [showDeletePerson, setShowDeletePerson] = useState<number | null>(null);
  const [newUnit, setNewUnit] = useState({ name: "", contact: "", phone: "", account: "", type: "供应商" });
  const [showAddPerson, setShowAddPerson] = useState(false);
  const [newPerson, setNewPerson] = useState({ name: "", phone: "", type: "职工", amount: "" });
  const handleDeleteUnit = () => {
    if (showDeleteUnit !== null) {
      const u = units.find(u => u.id === showDeleteUnit);
      setUnits(prev => prev.filter(u => u.id !== showDeleteUnit));
      toast.success("已删除往来单位", { description: u?.name });
      setShowDeleteUnit(null);
    }
  };

  const handleDeletePerson = () => {
    if (showDeletePerson !== null) {
      const targetId = showDeletePerson;
      const p = persons.find(p => p.id === targetId);
      setPersons(prev => prev.filter(p => p.id !== targetId));
      toast.success("已删除往来个人", { description: p?.name });
      setShowDeletePerson(null);
    }
  };

  return (
    <div className="space-y-4">
      <div className="flex items-center text-muted-foreground text-[13px]">
        <span>银农直联</span><ChevronRight className="w-4 h-4 mx-1" /><span className="text-foreground">往来管理</span>
      </div>
      <h2>往来管理</h2>
      <div className="bg-white rounded-xl border border-border shadow-sm">
        <div className="flex border-b border-border">
          {tabs.map(t => (
            <button key={t.key} className={`px-5 py-3 border-b-2 transition-colors ${tab === t.key ? "border-primary text-primary" : "border-transparent text-muted-foreground"}`} onClick={() => setTab(t.key)}>{t.label}</button>
          ))}
        </div>
        <div className="p-5">
          {tab !== "receipt" && (
          <div className="flex gap-3 mb-4">
            <div className="relative">
              <Search className="w-4 h-4 absolute left-3 top-1/2 -translate-y-1/2 text-muted-foreground" />
              <input type="text" placeholder="搜索..." className="pl-9 pr-4 py-2 bg-muted rounded-lg w-[220px] outline-none" />
            </div>
            <div className="flex-1" />
            <button onClick={() => tab === "unit" ? setShowAddUnit(true) : setShowAddPerson(true)} className="flex items-center gap-1.5 px-4 py-2 bg-primary text-white rounded-lg hover:bg-primary/90"><Plus className="w-4 h-4" /> 新增</button>
            <button onClick={() => toast.success("导出成功")} className="flex items-center gap-1 px-3 py-2 border border-border rounded-lg hover:bg-muted text-[13px]"><Download className="w-4 h-4" /> 导出</button>
          </div>
          )}

          {tab === "unit" && (
            <div className="overflow-x-auto border border-border rounded-lg">
              <table className="w-full text-[13px]">
                <thead className="bg-muted/60">
                  <tr>
                    <th className="py-3 px-3 text-left text-muted-foreground" style={{ fontWeight: 500 }}>序号</th>
                    <th className="py-3 px-3 text-left text-muted-foreground" style={{ fontWeight: 500 }}>单位名称</th>
                    <th className="py-3 px-3 text-left text-muted-foreground" style={{ fontWeight: 500 }}>联系人</th>
                    <th className="py-3 px-3 text-left text-muted-foreground" style={{ fontWeight: 500 }}>联系方式</th>
                    <th className="py-3 px-3 text-left text-muted-foreground" style={{ fontWeight: 500 }}>账号</th>
                    <th className="py-3 px-3 text-center text-muted-foreground" style={{ fontWeight: 500 }}>类型</th>
                    <th className="py-3 px-3 text-center text-muted-foreground" style={{ fontWeight: 500 }}>操作</th>
                  </tr>
                </thead>
                <tbody>
                  {units.length === 0 ? (
                    <tr><td colSpan={7} className="py-12 text-center text-muted-foreground">暂无往来单位数据</td></tr>
                  ) : units.map((row, idx) => (
                    <tr key={row.id} className="border-t border-border/50 hover:bg-green-50/30">
                      <td className="py-2.5 px-3 text-muted-foreground">{idx + 1}</td>
                      <td className="py-2.5 px-3">{row.name}</td>
                      <td className="py-2.5 px-3">{row.contact}</td>
                      <td className="py-2.5 px-3 text-muted-foreground">{row.phone}</td>
                      <td className="py-2.5 px-3 text-muted-foreground">{row.account}</td>
                      <td className="py-2.5 px-3 text-center"><span className="px-2 py-0.5 bg-green-50 text-green-600 rounded text-[12px]">{row.type}</span></td>
                      <td className="py-2.5 px-3">
                        <div className="flex items-center justify-center gap-1">
                          <button onClick={() => toast.info("编辑单位", { description: row.name })} className="p-1 hover:bg-muted rounded"><Edit className="w-4 h-4 text-muted-foreground" /></button>
                          <button onClick={() => setShowDeleteUnit(row.id)} className="p-1 hover:bg-muted rounded"><Trash2 className="w-4 h-4 text-red-400" /></button>
                        </div>
                      </td>
                    </tr>
                  ))}
                </tbody>
              </table>
            </div>
          )}

          {tab === "person" && (
            <div className="overflow-x-auto border border-border rounded-lg">
              <table className="w-full text-[13px]">
                <thead className="bg-muted/60">
                  <tr>
                    <th className="py-3 px-3 text-left text-muted-foreground" style={{ fontWeight: 500 }}>序号</th>
                    <th className="py-3 px-3 text-left text-muted-foreground" style={{ fontWeight: 500 }}>姓名</th>
                    <th className="py-3 px-3 text-left text-muted-foreground" style={{ fontWeight: 500 }}>联系方式</th>
                    <th className="py-3 px-3 text-center text-muted-foreground" style={{ fontWeight: 500 }}>业务类型</th>
                    <th className="py-3 px-3 text-right text-muted-foreground" style={{ fontWeight: 500 }}>金额</th>
                    <th className="py-3 px-3 text-center text-muted-foreground" style={{ fontWeight: 500 }}>操作</th>
                  </tr>
                </thead>
                <tbody>
                  {persons.map((row, idx) => (
                    <tr key={row.id} className="border-t border-border/50 hover:bg-green-50/30">
                      <td className="py-2.5 px-3 text-muted-foreground">{idx + 1}</td>
                      <td className="py-2.5 px-3">{row.name}</td>
                      <td className="py-2.5 px-3 text-muted-foreground">{row.phone}</td>
                      <td className="py-2.5 px-3 text-center"><span className="px-2 py-0.5 bg-green-50 text-green-600 rounded text-[12px]">{row.type}</span></td>
                      <td className="py-2.5 px-3 text-right" style={{ fontWeight: 500 }}>{row.amount}</td>
                      <td className="py-2.5 px-3">
                        <div className="flex items-center justify-center gap-1">
                          <button onClick={() => toast.info("编辑", { description: row.name })} className="p-1 hover:bg-muted rounded"><Edit className="w-4 h-4 text-muted-foreground" /></button>
                          <button onClick={() => setShowDeletePerson(row.id)} className="p-1 hover:bg-muted rounded"><Trash2 className="w-4 h-4 text-red-400" /></button>
                        </div>
                      </td>
                    </tr>
                  ))}
                </tbody>
              </table>
            </div>
          )}

          {tab === "receipt" && (
            <ReceiptTab />
          )}
        </div>
      </div>
      <Modal open={showAddUnit} onClose={() => setShowAddUnit(false)} title="新增往来单位">
        <div className="space-y-4">
          <div><label className="block text-[13px] text-muted-foreground mb-1">单位名称 *</label><input className="bg-muted rounded-lg px-3 py-2 outline-none w-full" placeholder="请输入单位名称" value={newUnit.name} onChange={e => setNewUnit({ ...newUnit, name: e.target.value })} /></div>
          <div className="grid grid-cols-2 gap-4">
            <div><label className="block text-[13px] text-muted-foreground mb-1">联系人</label><input className="bg-muted rounded-lg px-3 py-2 outline-none w-full" placeholder="联系人姓名" value={newUnit.contact} onChange={e => setNewUnit({ ...newUnit, contact: e.target.value })} /></div>
            <div><label className="block text-[13px] text-muted-foreground mb-1">联系电话</label><input className="bg-muted rounded-lg px-3 py-2 outline-none w-full" placeholder="联系电话" value={newUnit.phone} onChange={e => setNewUnit({ ...newUnit, phone: e.target.value })} /></div>
          </div>
          <div><label className="block text-[13px] text-muted-foreground mb-1">银行账号</label><input className="bg-muted rounded-lg px-3 py-2 outline-none w-full" placeholder="银行账号" value={newUnit.account} onChange={e => setNewUnit({ ...newUnit, account: e.target.value })} /></div>
          <div><label className="block text-[13px] text-muted-foreground mb-1">类型</label><select className="bg-muted rounded-lg px-3 py-2 outline-none w-full" value={newUnit.type} onChange={e => setNewUnit({ ...newUnit, type: e.target.value })}><option>供应商</option><option>政府机构</option><option>合作方</option></select></div>
          <div className="flex justify-end gap-3 pt-2">
            <button onClick={() => setShowAddUnit(false)} className="px-4 py-2 border border-border rounded-lg hover:bg-muted">取消</button>
            <button onClick={() => { setShowAddUnit(false); toast.success("往来单位已添加"); setUnits([...units, { id: units.length + 1, ...newUnit }]); setNewUnit({ name: "", contact: "", phone: "", account: "", type: "供应商" }); }} className="px-4 py-2 bg-primary text-white rounded-lg hover:bg-primary/90">保存</button>
          </div>
        </div>
      </Modal>
      <ConfirmDialog open={showDeleteUnit !== null} onClose={() => setShowDeleteUnit(null)} onConfirm={handleDeleteUnit} title="删除往来单位" message="确定要删除该往来单位吗？" confirmText="删除" type="danger" />
      <ConfirmDialog open={showDeletePerson !== null} onClose={() => setShowDeletePerson(null)} onConfirm={handleDeletePerson} title="删除往来个人" message="确定要删除该往来个人吗？" confirmText="删除" type="danger" />

      {/* Add Person Modal */}
      <Modal open={showAddPerson} onClose={() => setShowAddPerson(false)} title="新增往来个人">
        <div className="space-y-4">
          <div><label className="block text-[13px] text-muted-foreground mb-1">姓名 *</label><input className="bg-muted rounded-lg px-3 py-2 outline-none w-full" placeholder="请输入姓名" value={newPerson.name} onChange={e => setNewPerson({ ...newPerson, name: e.target.value })} /></div>
          <div><label className="block text-[13px] text-muted-foreground mb-1">联系电话</label><input className="bg-muted rounded-lg px-3 py-2 outline-none w-full" placeholder="联系电话" value={newPerson.phone} onChange={e => setNewPerson({ ...newPerson, phone: e.target.value })} /></div>
          <div className="grid grid-cols-2 gap-4">
            <div><label className="block text-[13px] text-muted-foreground mb-1">业务类型</label><select className="bg-muted rounded-lg px-3 py-2 outline-none w-full" value={newPerson.type} onChange={e => setNewPerson({ ...newPerson, type: e.target.value })}><option>职工</option><option>承包户</option><option>经营户</option><option>其他</option></select></div>
            <div><label className="block text-[13px] text-muted-foreground mb-1">金额</label><input className="bg-muted rounded-lg px-3 py-2 outline-none w-full" placeholder="如：¥ 3,000/月" value={newPerson.amount} onChange={e => setNewPerson({ ...newPerson, amount: e.target.value })} /></div>
          </div>
          <div className="flex justify-end gap-3 pt-2">
            <button onClick={() => setShowAddPerson(false)} className="px-4 py-2 border border-border rounded-lg hover:bg-muted">取消</button>
            <button onClick={() => { if (!newPerson.name) { toast.error("请填写姓名"); return; } setPersons([...persons, { id: persons.length + 10, name: newPerson.name, phone: newPerson.phone || "-", type: newPerson.type, amount: newPerson.amount || "-" }]); setShowAddPerson(false); toast.success("往来个人已添加", { description: newPerson.name }); setNewPerson({ name: "", phone: "", type: "职工", amount: "" }); }} className="px-4 py-2 bg-primary text-white rounded-lg hover:bg-primary/90">保存</button>
          </div>
        </div>
      </Modal>
    </div>
  );
}