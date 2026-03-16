import { createContext, useContext, useMemo, useState, type PropsWithChildren } from 'react';
import { MONTH_OPTIONS, QUARTER_OPTIONS, REGION_OPTIONS, YEAR_OPTIONS } from '@/app/services/mock/nongjingMock';
import type { QueryState, SortOrder } from '@/app/types/query';

interface QueryContextValue {
  query: QueryState;
  regionOptions: typeof REGION_OPTIONS;
  yearOptions: typeof YEAR_OPTIONS;
  quarterOptions: typeof QUARTER_OPTIONS;
  monthOptions: typeof MONTH_OPTIONS;
  setRegion: (regionCode: string) => void;
  setYear: (year: string) => void;
  setQuarter: (quarter: string) => void;
  setYearMonth: (yearMonth: string) => void;
  setDateRange: (dateFrom: string, dateTo: string) => void;
  setPaging: (page: number, pageSize: number) => void;
  setSort: (sortBy: string, sortOrder: SortOrder) => void;
}

const QueryContext = createContext<QueryContextValue | null>(null);

const defaultRegion = REGION_OPTIONS[0];

export function QueryProvider({ children }: PropsWithChildren) {
  const [query, setQuery] = useState<QueryState>({
    regionCode: defaultRegion.regionCode,
    regionName: defaultRegion.regionName,
    year: YEAR_OPTIONS[0],
    quarter: QUARTER_OPTIONS[0],
    yearMonth: MONTH_OPTIONS[2],
    dateFrom: '2026-03-01',
    dateTo: '2026-03-31',
    page: 1,
    pageSize: 20,
    sortBy: 'regionName',
    sortOrder: 'desc',
  });

  const value = useMemo<QueryContextValue>(() => ({
    query,
    regionOptions: REGION_OPTIONS,
    yearOptions: YEAR_OPTIONS,
    quarterOptions: QUARTER_OPTIONS,
    monthOptions: MONTH_OPTIONS,
    setRegion: (regionCode) => {
      const target = REGION_OPTIONS.find((item) => item.regionCode === regionCode) || defaultRegion;
      setQuery((prev) => ({ ...prev, regionCode: target.regionCode, regionName: target.regionName, page: 1 }));
    },
    setYear: (year) => setQuery((prev) => ({ ...prev, year })),
    setQuarter: (quarter) => setQuery((prev) => ({ ...prev, quarter })),
    setYearMonth: (yearMonth) => setQuery((prev) => ({ ...prev, yearMonth })),
    setDateRange: (dateFrom, dateTo) => setQuery((prev) => ({ ...prev, dateFrom, dateTo })),
    setPaging: (page, pageSize) => setQuery((prev) => ({ ...prev, page, pageSize })),
    setSort: (sortBy, sortOrder) => setQuery((prev) => ({ ...prev, sortBy, sortOrder })),
  }), [query]);

  return <QueryContext.Provider value={value}>{children}</QueryContext.Provider>;
}

export function useQueryContext() {
  const context = useContext(QueryContext);
  if (!context) {
    throw new Error('useQueryContext must be used inside QueryProvider');
  }
  return context;
}
