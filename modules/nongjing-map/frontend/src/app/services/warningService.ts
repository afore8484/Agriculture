import type { ApiEndpointDescriptor } from '@/app/types/api';
import type { QueryState } from '@/app/types/query';
import { apiClient } from '@/app/api/apiClient';
import { getMockAlertData } from './mock/nongjingMock';

export const warningEndpoints: ApiEndpointDescriptor[] = [
  { method: 'GET', path: '/api/nongjing/warnings/summary', summary: '预警汇总指标', params: ['regionCode', 'yearMonth'] },
  { method: 'GET', path: '/api/nongjing/warnings/rules', summary: '规则列表', params: ['regionCode'] },
  { method: 'GET', path: '/api/nongjing/warnings/events', summary: '事件列表', params: ['regionCode', 'status'] },
  { method: 'GET', path: '/api/nongjing/warnings/efficiency', summary: '处理效能统计', params: ['regionCode', 'role'] },
];

export const warningService = {
  getPageData: async (query: QueryState) => apiClient.get('/api/nongjing/warnings/summary', { regionCode: query.regionCode, yearMonth: query.yearMonth }, () => getMockAlertData(query)),
};
