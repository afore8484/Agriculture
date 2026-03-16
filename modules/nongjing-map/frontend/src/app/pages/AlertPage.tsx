import { useMemo } from 'react';
import { warningEndpoints, warningService } from '@/app/services/warningService';
import { usePageData } from '@/app/hooks/usePageData';
import { useQueryContext } from '@/app/store/QueryContext';
import { MetricGrid } from '@/app/components/MetricGrid';
import { SectionCard } from '@/app/components/SectionCard';
import { DonutChart } from '@/app/components/Charts';
import { DataTable } from '@/app/components/DataTable';
import { ApiPanel } from '@/app/components/ApiPanel';
import { StatusBox } from '@/app/components/StatusBox';

export function AlertPage() {
  const { query } = useQueryContext();
  const deps = useMemo(() => [query.regionCode, query.yearMonth], [query.regionCode, query.yearMonth]);
  const { data, loading, refreshing, error } = usePageData({
    cacheKey: `alerts:${query.regionCode}:${query.yearMonth}`,
    loader: () => warningService.getPageData(query),
    deps,
  });

  if (loading) return <StatusBox state="loading" message="正在加载预警监督…" />;
  if (error || !data) return <StatusBox state="error" message={`预警页加载失败：${error || '未知错误'}`} />;

  return (
    <div className="page-shell">
      <div className="page-header">
        <div>
          <h1 className="page-title">预警监督</h1>
          <div className="page-description">必须形成“规则到通知、送办、受理、办结、效能统计”的完整闭环。</div>
        </div>
        <div className="tag">{refreshing ? '后台刷新中' : `当前区划：${query.regionName}`}</div>
      </div>
      <MetricGrid items={data.kpis} />
      <div className="content-grid">
        <SectionCard title="预警分类统计" subtitle="用于查看当前风险结构。">
          <DonutChart data={data.categoryStats} />
        </SectionCard>
        <SectionCard title="规则配置" subtitle="重点检查通知方式是否明确落到页面。">
          <DataTable data={data.ruleTable} />
        </SectionCard>
      </div>
      <SectionCard title="预警事件列表" subtitle="展示待送办、待受理、处理中和已办结状态。">
        <DataTable data={data.eventTable} />
      </SectionCard>
      <SectionCard title="处理效能" subtitle="受理员和村会计效能必须有落点。">
        <DataTable data={data.efficiencyTable} />
      </SectionCard>
      <ApiPanel title="预警监督接口基线" endpoints={warningEndpoints} />
    </div>
  );
}
