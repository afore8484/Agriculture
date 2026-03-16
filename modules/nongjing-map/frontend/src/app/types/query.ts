export type SortOrder = 'asc' | 'desc';

export interface QueryState {
  regionCode: string;
  regionName: string;
  year: string;
  quarter: string;
  yearMonth: string;
  dateFrom: string;
  dateTo: string;
  page: number;
  pageSize: number;
  sortBy: string;
  sortOrder: SortOrder;
}
