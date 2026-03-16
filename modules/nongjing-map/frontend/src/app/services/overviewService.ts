import type { ApiEndpointDescriptor } from '@/app/types/api';
import type { QueryState } from '@/app/types/query';
import { apiClient } from '@/app/api/apiClient';
import { getMockOverviewData, REGION_OPTIONS } from './mock/nongjingMock';

export const overviewEndpoints: ApiEndpointDescriptor[] = [
  { method: 'GET', path: '/api/nongjing/common/regions', summary: '获取行政区划树', params: ['parentCode', 'level'] },
  { method: 'GET', path: '/api/nongjing/overview/weather', summary: '获取首页天气', params: ['regionCode', 'date'] },
  { method: 'GET', path: '/api/nongjing/overview/cards', summary: '获取首页总览卡片', params: ['regionCode', 'yearMonth'] },
  { method: 'GET', path: '/api/nongjing/overview/map-stats', summary: '获取首页地图统计', params: ['regionCode', 'yearMonth'] },
];

export const overviewService = {
  getRegionOptions: async () => apiClient.get('/api/nongjing/common/regions', {}, async () => REGION_OPTIONS),
  getPageData: async (query: QueryState) => apiClient.get('/api/nongjing/overview/cards', { regionCode: query.regionCode, yearMonth: query.yearMonth }, () => getMockOverviewData(query)),
};
