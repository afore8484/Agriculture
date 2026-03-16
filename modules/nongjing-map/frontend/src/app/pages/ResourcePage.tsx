import { useMemo } from 'react';
import { resourceEndpoints, resourceService } from '@/app/services/resourceService';
import { usePageData } from '@/app/hooks/usePageData';
import { useQueryContext } from '@/app/store/QueryContext';
import { MetricGrid } from '@/app/components/MetricGrid';
import { SectionCard } from '@/app/components/SectionCard';
import { DonutChart } from '@/app/components/Charts';
import { DataTable } from '@/app/components/DataTable';
import { ApiPanel } from '@/app/components/ApiPanel';
import { StatusBox } from '@/app/components/StatusBox';

export function ResourcePage() {
  const { query } = useQueryContext();
  const deps = useMemo(() => [query.regionCode, query.yearMonth], [query.regionCode, query.yearMonth]);
  const { data, loading, refreshing, error } = usePageData({
    cacheKey: `resources:${query.regionCode}:${query.yearMonth}`,
    loader: () => resourceService.getPageData(query),
    deps,
  });

  if (loading) return <StatusBox state="loading" message="正在加载资源一张图…" />;
  if (error || !data) return <StatusBox state="error" message={`资源页加载失败：${error || '未知错误'}`} />;

  return (
    <div className="page-shell">
      <div className="page-header">
        <div>
          <h1 className="page-title">资源一张图</h1>
          <div className="page-description">重点验证资源面积、分类、区域分布和“资源信息调取接口”的页面落点是否完整。</div>
        </div>
        <div className="tag">{refreshing ? '后台刷新中' : `当前区划：${query.regionName}`}</div>
      </div>
      <MetricGrid items={data.kpis} />
      <div className="content-grid">
        <SectionCard title="资源分类结构" subtitle="耕地、林地、园地、建设用地、未利用地。">
          <DonutChart data={data.typeStats} />
        </SectionCard>
        <SectionCard title="GIS 图层理解" subtitle="资源页不只是图表页，还要体现资源图层和数据调取任务。">
          <div style={{ display: 'grid', gap: 10 }}>
            {data.layerTips.map((item) => <div className="tag" key={item}>{item}</div>)}
          </div>
        </SectionCard>
      </div>
      <SectionCard title="资源区域统计" subtitle="用于查看不同区划的农用地、建设用地和未利用地分布。">
        <DataTable data={data.districtStats} />
      </SectionCard>
      <SectionCard title="资源信息调取任务" subtitle="这里是资源页区别于普通展示页的关键能力落点。">
        <DataTable data={data.dispatchTable} />
      </SectionCard>
      <ApiPanel title="资源一张图接口基线" endpoints={resourceEndpoints} />
    </div>
  );
}
