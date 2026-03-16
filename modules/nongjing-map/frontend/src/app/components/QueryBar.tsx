import { useQueryContext } from '@/app/store/QueryContext';

export function QueryBar() {
  const { query, regionOptions, yearOptions, quarterOptions, monthOptions, setRegion, setYear, setQuarter, setYearMonth, setDateRange } = useQueryContext();

  return (
    <section className="filter-card">
      <div className="filter-item">
        <label>行政区划</label>
        <select className="select-box" value={query.regionCode} onChange={(event) => setRegion(event.target.value)}>
          {regionOptions.map((item) => (
            <option key={item.regionCode} value={item.regionCode}>{item.regionName}</option>
          ))}
        </select>
      </div>
      <div className="filter-item">
        <label>统计年度</label>
        <select className="select-box" value={query.year} onChange={(event) => setYear(event.target.value)}>
          {yearOptions.map((item) => (
            <option key={item} value={item}>{item}</option>
          ))}
        </select>
      </div>
      <div className="filter-item">
        <label>统计季度</label>
        <select className="select-box" value={query.quarter} onChange={(event) => setQuarter(event.target.value)}>
          {quarterOptions.map((item) => (
            <option key={item} value={item}>{item}</option>
          ))}
        </select>
      </div>
      <div className="filter-item">
        <label>统计月份</label>
        <select className="select-box" value={query.yearMonth} onChange={(event) => setYearMonth(event.target.value)}>
          {monthOptions.map((item) => (
            <option key={item} value={item}>{item}</option>
          ))}
        </select>
      </div>
      <div className="filter-item">
        <label>开始日期</label>
        <input className="input-box" type="date" value={query.dateFrom} onChange={(event) => setDateRange(event.target.value, query.dateTo)} />
      </div>
      <div className="filter-item">
        <label>结束日期</label>
        <input className="input-box" type="date" value={query.dateTo} onChange={(event) => setDateRange(query.dateFrom, event.target.value)} />
      </div>
    </section>
  );
}
