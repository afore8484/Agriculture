import { Outlet, useLocation, useNavigate } from 'react-router';
import { useEffect, useMemo, useState } from 'react';
import { MODULE_NAV } from '@/app/constants/navigation';
import { routePrefetchMap } from '@/app/routes';
import { QueryBar } from './QueryBar';

export function AppLayout() {
  const navigate = useNavigate();
  const location = useLocation();
  const [now, setNow] = useState(new Date());

  useEffect(() => {
    const timer = window.setInterval(() => setNow(new Date()), 1000);
    return () => window.clearInterval(timer);
  }, []);

  const currentLabel = useMemo(() => MODULE_NAV.find((item) => item.path === location.pathname)?.name || '总览页', [location.pathname]);

  return (
    <div className="app-shell">
      <header className="topbar">
        <div>
          <div className="brand-title">农经一张图</div>
          <div className="brand-subtitle">统一查询、统一联动、统一钻取。当前页面：{currentLabel}</div>
        </div>
        <div className="clock-box">
          <div className="clock-time">{now.toLocaleTimeString('zh-CN', { hour12: false })}</div>
          <div className="brand-subtitle">{now.toLocaleDateString('zh-CN')} · 海南省农村集体经济金融数据总览</div>
        </div>
      </header>

      <nav className="nav-row">
        {MODULE_NAV.map((item) => (
          <button
            type="button"
            key={item.code}
            className={`nav-card${location.pathname === item.path ? ' active' : ''}`}
            onClick={() => navigate(item.path)}
            onMouseEnter={() => routePrefetchMap[item.path]?.()}
            onFocus={() => routePrefetchMap[item.path]?.()}
          >
            <span className="nav-title">{item.name}</span>
            <span className="nav-note">{item.focus}</span>
          </button>
        ))}
      </nav>

      <QueryBar />

      <main>
        <Outlet />
      </main>
    </div>
  );
}
