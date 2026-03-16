import type { ApiEndpointDescriptor } from '@/app/types/api';
import type { QueryState } from '@/app/types/query';
import { apiClient } from '@/app/api/apiClient';
import { REGION_OPTIONS, getMockOverviewData } from './mock/nongjingMock';

export const gisEndpoints: ApiEndpointDescriptor[] = [
  { method: 'GET', path: '/api/nongjing/common/region-detail', summary: '区划详情与边界', params: ['regionCode'] },
  { method: 'GET', path: '/api/nongjing/overview/map-stats', summary: '地图统计', params: ['regionCode', 'yearMonth'] },
  { method: 'GET', path: '/api/nongjing/resources/layer-stats', summary: '资源专题图层', params: ['regionCode', 'yearMonth'] },
];

export const gisService = {
  getRegionOptions: async () => apiClient.get('/api/nongjing/common/regions', {}, async () => REGION_OPTIONS),
  getMapData: async (query: QueryState) => apiClient.get('/api/nongjing/overview/map-stats', { regionCode: query.regionCode, yearMonth: query.yearMonth }, async () => (await getMockOverviewData(query)).mapRegions),
};
