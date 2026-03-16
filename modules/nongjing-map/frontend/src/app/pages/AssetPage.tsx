import { useMemo } from 'react';
import { assetEndpoints, assetService } from '@/app/services/assetService';
import { usePageData } from '@/app/hooks/usePageData';
import { useQueryContext } from '@/app/store/QueryContext';
import { MetricGrid } from '@/app/components/MetricGrid';
import { SectionCard } from '@/app/components/SectionCard';
import { DonutChart } from '@/app/components/Charts';
import { DataTable } from '@/app/components/DataTable';
import { ApiPanel } from '@/app/components/ApiPanel';
import { StatusBox } from '@/app/components/StatusBox';

export function AssetPage() {
  const { query } = useQueryContext();
  const deps = useMemo(() => [query.regionCode, query.yearMonth], [query.regionCode, query.yearMonth]);
  const { data, loading, refreshing, error } = usePageData({
    cacheKey: `assets:${query.regionCode}:${query.yearMonth}`,
    loader: () => assetService.getPageData(query),
    deps,
  });

  if (loading) return <StatusBox state="loading" message="正在加载资产一张图…" />;
  if (error || !data) return <StatusBox state="error" message={`资产页加载失败：${error || '未知错误'}`} />;

  return (
    <div className="page-shell">
      <div className="page-header">
        <div>
          <h1 className="page-title">资产一张图</h1>
          <div className="page-description">本页重点不是只看总量，而是看资产分类、区域价值排名、台账和经营状态。</div>
        </div>
        <div className="tag">{refreshing ? '后台刷新中' : `当前区划：${query.regionName}`}</div>
      </div>
      <MetricGrid items={data.kpis} />
      <div className="content-grid">
        <SectionCard title="资产分类结构" subtitle="区分资源性资产、经营性固定资产、公益性资产与在建工程。">
          <DonutChart data={data.categoryStats} />
        </SectionCard>
        <SectionCard title="经营状态分布" subtitle="突出闲置资产占比和盘活状态。">
          <DonutChart data={data.operationStats} />
        </SectionCard>
      </div>
      <SectionCard title="各区域资产价值排名前 5" subtitle="这是原型校验时必须重点检查的落点。">
        <DataTable data={data.regionRanking} />
      </SectionCard>
      <SectionCard title="资产台账" subtitle="从汇总钻取到资产名称、类型、区划、账面价值和经营状态。">
        <DataTable data={data.ledgerTable} />
      </SectionCard>
      <ApiPanel title="资产一张图接口基线" endpoints={assetEndpoints} />
    </div>
  );
}
