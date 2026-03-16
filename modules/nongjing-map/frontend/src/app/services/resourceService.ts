import type { ApiEndpointDescriptor } from '@/app/types/api';
import type { QueryState } from '@/app/types/query';
import { apiClient } from '@/app/api/apiClient';
import { getMockResourceData } from './mock/nongjingMock';

export const resourceEndpoints: ApiEndpointDescriptor[] = [
  { method: 'GET', path: '/api/nongjing/resources/summary', summary: '资源汇总指标', params: ['regionCode', 'yearMonth'] },
  { method: 'GET', path: '/api/nongjing/resources/district-stats', summary: '资源区域统计', params: ['regionCode'] },
  { method: 'GET', path: '/api/nongjing/resources/fetch-jobs', summary: '资源信息调取任务', params: ['regionCode', 'status'] },
];

export const resourceService = {
  getPageData: async (query: QueryState) => apiClient.get('/api/nongjing/resources/summary', { regionCode: query.regionCode, yearMonth: query.yearMonth }, () => getMockResourceData(query)),
};
