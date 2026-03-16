import { useMemo } from 'react';
import { contractEndpoints, contractService } from '@/app/services/contractService';
import { usePageData } from '@/app/hooks/usePageData';
import { useQueryContext } from '@/app/store/QueryContext';
import { MetricGrid } from '@/app/components/MetricGrid';
import { SectionCard } from '@/app/components/SectionCard';
import { CompareBarChart, DonutChart } from '@/app/components/Charts';
import { DataTable } from '@/app/components/DataTable';
import { ApiPanel } from '@/app/components/ApiPanel';
import { StatusBox } from '@/app/components/StatusBox';

export function ContractPage() {
  const { query } = useQueryContext();
  const deps = useMemo(() => [query.regionCode, query.yearMonth], [query.regionCode, query.yearMonth]);
  const { data, loading, refreshing, error } = usePageData({
    cacheKey: `contracts:${query.regionCode}:${query.yearMonth}`,
    loader: () => contractService.getPageData(query),
    deps,
  });

  if (loading) return <StatusBox state="loading" message="正在加载合同一张图…" />;
  if (error || !data) return <StatusBox state="error" message={`合同页加载失败：${error || '未知错误'}`} />;

  return (
    <div className="page-shell">
      <div className="page-header">
        <div>
          <h1 className="page-title">合同一张图</h1>
          <div className="page-description">当前重点校验 7 条合同需求是否全部落位，尤其是累计应收和累计应付。</div>
        </div>
        <div className="tag">{refreshing ? '后台刷新中' : `当前区划：${query.regionName}`}</div>
      </div>
      <MetricGrid items={data.kpis} />
      <div className="content-grid">
        <SectionCard title="合同类型统计" subtitle="同时承载数量与金额口径。">
          <DonutChart data={data.typeStats} />
        </SectionCard>
        <SectionCard title="本期应收 / 本期应付" subtitle="按来源、项目和期限查看当前态势。">
          <CompareBarChart data={data.currentReceivablePayable} firstLabel="本期应收" secondLabel="本期应付" />
        </SectionCard>
      </div>
      <SectionCard title="累计应收 / 累计应付" subtitle="这是合同页必须补齐的历史累计口径。">
        <CompareBarChart data={data.accumulativeReceivablePayable} firstLabel="累计应收" secondLabel="累计应付" />
      </SectionCard>
      <SectionCard title="合同明细列表" subtitle="从汇总钻取到合同名称、相对方、金额、应收应付和到期日。">
        <DataTable data={data.contractTable} />
      </SectionCard>
      <ApiPanel title="合同一张图接口基线" endpoints={contractEndpoints} />
    </div>
  );
}
