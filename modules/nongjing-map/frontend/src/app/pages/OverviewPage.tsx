import { useMemo } from 'react';
import { useNavigate } from 'react-router';
import { overviewEndpoints, overviewService } from '@/app/services/overviewService';
import { usePageData } from '@/app/hooks/usePageData';
import { useQueryContext } from '@/app/store/QueryContext';
import { MetricGrid } from '@/app/components/MetricGrid';
import { SectionCard } from '@/app/components/SectionCard';
import { TrendLineChart } from '@/app/components/Charts';
import { ApiPanel } from '@/app/components/ApiPanel';
import { GisPanel } from '@/app/components/GisPanel';
import { StatusBox } from '@/app/components/StatusBox';

export function OverviewPage() {
  const { query } = useQueryContext();
  const navigate = useNavigate();
  const deps = useMemo(() => [query.regionCode, query.year, query.quarter, query.yearMonth], [query.regionCode, query.year, query.quarter, query.yearMonth]);
  const { data, loading, refreshing, error } = usePageData({
    cacheKey: `overview:${query.regionCode}:${query.yearMonth}`,
    loader: () => overviewService.getPageData(query),
    deps,
  });

  if (loading) return <StatusBox state="loading" message="正在加载总览页数据…" />;
  if (error || !data) return <StatusBox state="error" message={`总览页加载失败：${error || '未知错误'}`} />;

  return (
    <div className="page-shell">
      <div className="page-header">
        <div>
          <h1 className="page-title">总览页理解与入口</h1>
          <div className="page-description">总览页负责统一筛选、统一入口和 GIS 联动，不承担单个专题的全部明细。</div>
        </div>
        <div className="tag">{refreshing ? '后台刷新中' : `天气：${data.weather.weatherType} · ${data.weather.temperatureRange}`}</div>
      </div>

      <MetricGrid items={data.cards} />

      <div className="content-grid">
        <SectionCard title="GIS 联动区划总览" subtitle="点击区划节点后，会把筛选条件写回全局上下文并联动专题页。">
          <GisPanel items={data.mapRegions} />
        </SectionCard>
        <SectionCard title="总览趋势与重点理解" subtitle="重点用于判断总览页是否承担了正确的业务入口职责。">
          <TrendLineChart data={data.trends} firstLabel="总收入" secondLabel="合同金额" thirdLabel="预警事件" />
          <div style={{ display: 'grid', gap: 10, marginTop: 14 }}>
            {data.focusList.map((item) => (
              <div className="tag" key={item}>{item}</div>
            ))}
          </div>
        </SectionCard>
      </div>

      <SectionCard title="7 个专题入口" subtitle="严格沿用需求中的 7 个二级专题，GIS 仅作为横切能力，不单列为主题模块。">
        <div className="overview-modules">
          {data.moduleEntries.map((item) => (
            <button type="button" key={item.code} className="module-card" onClick={() => navigate(item.path)}>
              <div className="nav-title">{item.name}</div>
              <div className="module-count">{item.requirementCount}</div>
              <div className="nav-note">{item.focus}</div>
              <div className="small-note">进入该专题页时，沿用当前区划和时间条件。</div>
            </button>
          ))}
        </div>
      </SectionCard>

      <ApiPanel title="总览页接口基线" endpoints={overviewEndpoints} />
    </div>
  );
}
