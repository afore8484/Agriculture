import type { ApiEndpointDescriptor } from '@/app/types/api';

export function ApiPanel({ title, endpoints }: { title: string; endpoints: ApiEndpointDescriptor[] }) {
  if (import.meta.env.VITE_ENABLE_API_PANEL !== 'true') {
    return null;
  }

  return (
    <section className="api-panel">
      <div className="section-head">
        <div>
          <h2 className="section-title">{title}</h2>
          <div className="section-subtitle">开发辅助视图，仅在 VITE_ENABLE_API_PANEL=true 时显示。</div>
        </div>
      </div>
      <div className="api-list">
        {endpoints.map((item) => (
          <div className="api-item" key={`${item.method}-${item.path}`}>
            <div className="api-method">{item.method}</div>
            <div>{item.path}</div>
            <div className="subtle">{item.summary}</div>
            <div className="small-note">参数：{item.params.join(' / ') || '无'}</div>
          </div>
        ))}
      </div>
    </section>
  );
}
