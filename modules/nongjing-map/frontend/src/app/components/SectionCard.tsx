import type { PropsWithChildren, ReactNode } from 'react';

interface SectionCardProps extends PropsWithChildren {
  title: string;
  subtitle?: string;
  extra?: ReactNode;
}

export function SectionCard({ title, subtitle, extra, children }: SectionCardProps) {
  return (
    <section className="panel">
      <div className="section-head">
        <div>
          <h2 className="section-title">{title}</h2>
          {subtitle ? <div className="section-subtitle">{subtitle}</div> : null}
        </div>
        {extra}
      </div>
      {children}
    </section>
  );
}
