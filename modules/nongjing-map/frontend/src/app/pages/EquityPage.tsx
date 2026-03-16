import { useMemo } from 'react';
import { equityEndpoints, equityService } from '@/app/services/equityService';
import { usePageData } from '@/app/hooks/usePageData';
import { useQueryContext } from '@/app/store/QueryContext';
import { MetricGrid } from '@/app/components/MetricGrid';
import { SectionCard } from '@/app/components/SectionCard';
import { DonutChart, TrendLineChart } from '@/app/components/Charts';
import { DataTable } from '@/app/components/DataTable';
import { ApiPanel } from '@/app/components/ApiPanel';
import { StatusBox } from '@/app/components/StatusBox';

export function EquityPage() {
  const { query } = useQueryContext();
  const deps = useMemo(() => [query.regionCode, query.yearMonth], [query.regionCode, query.yearMonth]);
  const { data, loading, refreshing, error } = usePageData({
    cacheKey: `equity:${query.regionCode}:${query.yearMonth}`,
    loader: () => equityService.getPageData(query),
    deps,
  });

  if (loading) return <StatusBox state="loading" message="正在加载股权一张图…" />;
  if (error || !data) return <StatusBox state="error" message={`股权页加载失败：${error || '未知错误'}`} />;

  return (
    <div className="page-shell">
      <div className="page-header">
        <div>
          <h1 className="page-title">股权一张图</h1>
          <div className="page-description">股权页的核心是股权结构、成员映射关系和年度分红，不是单纯展示一个排行表。</div>
        </div>
        <div className="tag">{refreshing ? '后台刷新中' : `当前区划：${query.regionName}`}</div>
      </div>
      <MetricGrid items={data.kpis} />
      <div className="content-grid">
        <SectionCard title="股权结构" subtitle="按人口股、劳龄股、土地股等类型展示。">
          <DonutChart data={data.equityStructure} />
        </SectionCard>
        <SectionCard title="年度分红趋势" subtitle="用于查看股权价值和分红变化。">
          <TrendLineChart data={data.dividendTrend} firstLabel="分红金额" secondLabel="持股值" thirdLabel="覆盖人数" />
        </SectionCard>
      </div>
      <SectionCard title="成员与股权映射台账" subtitle="必须能从成员维度钻取到股权维度。">
        <DataTable data={data.mappingTable} />
      </SectionCard>
      <ApiPanel title="股权一张图接口基线" endpoints={equityEndpoints} />
    </div>
  );
}
