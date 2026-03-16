import type { ApiEndpointDescriptor } from '@/app/types/api';
import type { QueryState } from '@/app/types/query';
import { apiClient } from '@/app/api/apiClient';
import { getMockFinanceData } from './mock/nongjingMock';

export const financeEndpoints: ApiEndpointDescriptor[] = [
  { method: 'GET', path: '/api/nongjing/finance/summary', summary: '财务首页汇总指标', params: ['regionCode', 'yearMonth'] },
  { method: 'GET', path: '/api/nongjing/finance/income-bands', summary: '收入分档统计', params: ['regionCode', 'yearMonth'] },
  { method: 'GET', path: '/api/nongjing/finance/income-detail', summary: '高低阈值明细', params: ['regionCode', 'thresholdType', 'page', 'pageSize'] },
  { method: 'GET', path: '/api/nongjing/finance/balance-analysis', summary: '资产负债分析', params: ['regionCode', 'yearMonth'] },
  { method: 'GET', path: '/api/nongjing/finance/distribution', summary: '收益分配结构', params: ['regionCode', 'yearMonth'] },
];

export const financeService = {
  getPageData: async (query: QueryState) => apiClient.get('/api/nongjing/finance/summary', { regionCode: query.regionCode, yearMonth: query.yearMonth, quarter: query.quarter }, () => getMockFinanceData(query)),
};
