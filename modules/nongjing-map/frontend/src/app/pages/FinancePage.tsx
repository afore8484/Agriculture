import { useMemo } from 'react';
import { financeEndpoints, financeService } from '@/app/services/financeService';
import { usePageData } from '@/app/hooks/usePageData';
import { useQueryContext } from '@/app/store/QueryContext';
import { MetricGrid } from '@/app/components/MetricGrid';
import { SectionCard } from '@/app/components/SectionCard';
import { CompareBarChart, DonutChart, TrendLineChart } from '@/app/components/Charts';
import { DataTable } from '@/app/components/DataTable';
import { ApiPanel } from '@/app/components/ApiPanel';
import { StatusBox } from '@/app/components/StatusBox';

export function FinancePage() {
  const { query } = useQueryContext();
  const deps = useMemo(() => [query.regionCode, query.year, query.quarter, query.yearMonth], [query.regionCode, query.year, query.quarter, query.yearMonth]);
  const { data, loading, refreshing, error } = usePageData({
    cacheKey: `finance:${query.regionCode}:${query.yearMonth}:${query.quarter}`,
    loader: () => financeService.getPageData(query),
    deps,
  });

  if (loading) return <StatusBox state="loading" message="正在加载财务一张图…" />;
  if (error || !data) return <StatusBox state="error" message={`财务页加载失败：${error || '未知错误'}`} />;

  return (
    <div className="page-shell">
      <div className="page-header">
        <div>
          <h1 className="page-title">财务一张图</h1>
          <div className="page-description">围绕收入分档、财务指标、资产负债分析和收益分配展开，覆盖“未建账套”“高低阈值明细”“资产负债表钻取”三条主线。</div>
        </div>
        <div className="tag">{refreshing ? '后台刷新中' : `当前区划：${query.regionName} · 当前月份：${query.yearMonth}`}</div>
      </div>

      <MetricGrid items={data.kpis} />

      <div className="content-grid">
        <SectionCard title="收入分档统计" subtitle="按 5 万、10 万、20 万阈值识别高收入村与薄弱村。">
          <DonutChart data={data.incomeBands} />
        </SectionCard>
        <SectionCard title="财务趋势" subtitle="同步观察收入、应收应付与收益分配变化。">
          <TrendLineChart data={data.trend} firstLabel="总收入" secondLabel="应收款" thirdLabel="未分配收益" />
        </SectionCard>
      </div>

      <SectionCard title="高于阈值村明细" subtitle="从汇总进入下辖区划，查看经营收入、补助收入、投资收益和其他收入。">
        <DataTable data={data.highThresholdTable} />
      </SectionCard>

      <SectionCard title="低于阈值村明细" subtitle="用于识别经济薄弱村并形成针对性督办。">
        <DataTable data={data.lowThresholdTable} />
      </SectionCard>

      <div className="content-grid">
        <SectionCard title="财务指标明细" subtitle="货币资金、应收账款、存货、固定资产、应付账款等核心指标。">
          <DataTable data={data.subjectTable} />
        </SectionCard>
        <SectionCard title="收益分配结构" subtitle="经营收入、补助收入、投资收益和其他收入的结构分布。">
          <DonutChart data={data.distribution} />
        </SectionCard>
      </div>

      <SectionCard title="资产负债分析" subtitle="围绕流动资产、非流动资产、负债和所有者权益形成结构化分析。">
        <DataTable data={data.balanceTable} />
      </SectionCard>

      <ApiPanel title="财务一张图接口基线" endpoints={financeEndpoints} />
    </div>
  );
}
