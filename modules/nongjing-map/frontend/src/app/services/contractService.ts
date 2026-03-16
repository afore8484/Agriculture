import type { ApiEndpointDescriptor } from '@/app/types/api';
import type { QueryState } from '@/app/types/query';
import { apiClient } from '@/app/api/apiClient';
import { getMockContractData } from './mock/nongjingMock';

export const contractEndpoints: ApiEndpointDescriptor[] = [
  { method: 'GET', path: '/api/nongjing/contracts/summary', summary: '合同汇总指标', params: ['regionCode', 'yearMonth'] },
  { method: 'GET', path: '/api/nongjing/contracts/type-stats', summary: '合同类型统计', params: ['regionCode', 'yearMonth'] },
  { method: 'GET', path: '/api/nongjing/contracts/current-collect-pay', summary: '本期应收应付', params: ['regionCode', 'yearMonth'] },
  { method: 'GET', path: '/api/nongjing/contracts/accumulative-collect-pay', summary: '累计应收应付', params: ['regionCode', 'yearMonth'] },
  { method: 'GET', path: '/api/nongjing/contracts/list', summary: '合同明细列表', params: ['regionCode', 'page', 'pageSize'] },
];

export const contractService = {
  getPageData: async (query: QueryState) => apiClient.get('/api/nongjing/contracts/summary', { regionCode: query.regionCode, yearMonth: query.yearMonth }, () => getMockContractData(query)),
};
