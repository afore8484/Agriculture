import type { MetricCard as MetricCardType } from '@/app/types/modules';

export function MetricGrid({ items }: { items: MetricCardType[] }) {
  return (
    <div className="metric-grid">
      {items.map((item) => (
        <article className="metric-card" key={`${item.label}-${item.value}`}>
          <div className="metric-label">{item.label}</div>
          <div className={`metric-value${item.status ? ` metric-status-${item.status}` : ''}`}>{item.value}</div>
          {item.hint ? <div className="metric-hint">{item.hint}</div> : null}
        </article>
      ))}
    </div>
  );
}
