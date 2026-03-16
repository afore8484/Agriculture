import { useMemo } from 'react';
import { useQueryContext } from '@/app/store/QueryContext';
import type { GisRegionMetric } from '@/app/types/modules';

export function GisPanel({ items }: { items: GisRegionMetric[] }) {
  const { query, setRegion } = useQueryContext();

  const active = useMemo(() => items.find((item) => item.regionCode === query.regionCode) || items[0], [items, query.regionCode]);

  return (
    <div className="gis-layout">
      <div className="region-list">
        {items.map((item) => (
          <button
            type="button"
            key={item.regionCode}
            className={`region-card${item.regionCode === query.regionCode ? ' active' : ''}`}
            onClick={() => setRegion(item.regionCode)}
          >
            <div className="nav-title">{item.regionName}</div>
            <div className="nav-note">{item.summary}</div>
            <div className="small-note">{item.highlight}</div>
          </button>
        ))}
      </div>
      <div className="gis-stage">
        {items.map((item) => (
          <button
            type="button"
            key={item.regionCode}
            className={`gis-point${item.regionCode === query.regionCode ? ' active' : ''}`}
            style={{ left: `${item.x}%`, top: `${item.y}%` }}
            onClick={() => setRegion(item.regionCode)}
          >
            <div className="gis-point-name">{item.regionName}</div>
            <div className="gis-point-stat">{item.summary}</div>
            <div className="small-note">{item.highlight}</div>
          </button>
        ))}
        {active ? (
          <div style={{ position: 'absolute', right: 16, bottom: 16, width: 260 }} className="panel">
            <div className="section-title" style={{ fontSize: 16 }}>{active.regionName} 当前高亮</div>
            <div className="section-subtitle" style={{ marginTop: 8 }}>{active.summary}</div>
            <div className="small-note" style={{ marginTop: 10 }}>{active.highlight}</div>
            <div className="small-note" style={{ marginTop: 12 }}>说明：点击地图节点会把区划条件写回全局筛选，并联动总览和专题页。</div>
          </div>
        ) : null}
      </div>
    </div>
  );
}
