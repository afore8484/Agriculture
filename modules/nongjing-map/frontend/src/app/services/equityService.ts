import type { ApiEndpointDescriptor } from '@/app/types/api';
import type { QueryState } from '@/app/types/query';
import { apiClient } from '@/app/api/apiClient';
import { getMockEquityData } from './mock/nongjingMock';

export const equityEndpoints: ApiEndpointDescriptor[] = [
  { method: 'GET', path: '/api/nongjing/equity/summary', summary: '股权汇总指标', params: ['regionCode', 'yearMonth'] },
  { method: 'GET', path: '/api/nongjing/equity/structure', summary: '股权结构统计', params: ['regionCode'] },
  { method: 'GET', path: '/api/nongjing/equity/dividend-trend', summary: '分红趋势', params: ['regionCode', 'year'] },
  { method: 'GET', path: '/api/nongjing/equity/mapping-list', summary: '成员股权映射台账', params: ['regionCode', 'page', 'pageSize'] },
];

export const equityService = {
  getPageData: async (query: QueryState) => apiClient.get('/api/nongjing/equity/summary', { regionCode: query.regionCode, yearMonth: query.yearMonth }, () => getMockEquityData(query)),
};
