import { useMemo } from 'react';
import { memberEndpoints, memberService } from '@/app/services/memberService';
import { usePageData } from '@/app/hooks/usePageData';
import { useQueryContext } from '@/app/store/QueryContext';
import { MetricGrid } from '@/app/components/MetricGrid';
import { SectionCard } from '@/app/components/SectionCard';
import { DonutChart } from '@/app/components/Charts';
import { DataTable } from '@/app/components/DataTable';
import { ApiPanel } from '@/app/components/ApiPanel';
import { StatusBox } from '@/app/components/StatusBox';

export function MemberPage() {
  const { query } = useQueryContext();
  const deps = useMemo(() => [query.regionCode, query.yearMonth], [query.regionCode, query.yearMonth]);
  const { data, loading, refreshing, error } = usePageData({
    cacheKey: `members:${query.regionCode}:${query.yearMonth}`,
    loader: () => memberService.getPageData(query),
    deps,
  });

  if (loading) return <StatusBox state="loading" message="正在加载成员一张图…" />;
  if (error || !data) return <StatusBox state="error" message={`成员页加载失败：${error || '未知错误'}`} />;

  return (
    <div className="page-shell">
      <div className="page-header">
        <div>
          <h1 className="page-title">成员一张图</h1>
          <div className="page-description">成员页要承担成员结构、区域统计和台账查询三类职责，并为股权页提供统一主数据。</div>
        </div>
        <div className="tag">{refreshing ? '后台刷新中' : `当前区划：${query.regionName}`}</div>
      </div>
      <MetricGrid items={data.kpis} />
      <div className="content-grid">
        <SectionCard title="成员结构" subtitle="性别、年龄和成员类别分布。">
          <DonutChart data={data.structureStats} />
        </SectionCard>
        <SectionCard title="区划统计" subtitle="从汇总进入区划和村级成员信息。">
          <DataTable data={data.districtStats} />
        </SectionCard>
      </div>
      <SectionCard title="成员台账" subtitle="用于核对成员主数据和股权映射关系。">
        <DataTable data={data.memberTable} />
      </SectionCard>
      <ApiPanel title="成员一张图接口基线" endpoints={memberEndpoints} />
    </div>
  );
}
