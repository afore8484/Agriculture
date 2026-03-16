import type { ApiEndpointDescriptor } from '@/app/types/api';
import type { QueryState } from '@/app/types/query';
import { apiClient } from '@/app/api/apiClient';
import { getMockAssetData } from './mock/nongjingMock';

export const assetEndpoints: ApiEndpointDescriptor[] = [
  { method: 'GET', path: '/api/nongjing/assets/summary', summary: '资产汇总指标', params: ['regionCode', 'yearMonth'] },
  { method: 'GET', path: '/api/nongjing/assets/district-ranking', summary: '区域资产价值排名', params: ['regionCode', 'sortBy'] },
  { method: 'GET', path: '/api/nongjing/assets/ledger', summary: '资产台账明细', params: ['regionCode', 'assetType', 'page', 'pageSize'] },
];

export const assetService = {
  getPageData: async (query: QueryState) => apiClient.get('/api/nongjing/assets/summary', { regionCode: query.regionCode, yearMonth: query.yearMonth }, () => getMockAssetData(query)),
};
