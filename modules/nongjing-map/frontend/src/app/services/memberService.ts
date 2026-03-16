import type { ApiEndpointDescriptor } from '@/app/types/api';
import type { QueryState } from '@/app/types/query';
import { apiClient } from '@/app/api/apiClient';
import { getMockMemberData } from './mock/nongjingMock';

export const memberEndpoints: ApiEndpointDescriptor[] = [
  { method: 'GET', path: '/api/nongjing/members/summary', summary: '成员汇总指标', params: ['regionCode', 'yearMonth'] },
  { method: 'GET', path: '/api/nongjing/members/structure', summary: '成员结构统计', params: ['regionCode'] },
  { method: 'GET', path: '/api/nongjing/members/district-stats', summary: '成员区域统计', params: ['regionCode'] },
  { method: 'GET', path: '/api/nongjing/members/list', summary: '成员台账查询', params: ['regionCode', 'page', 'pageSize'] },
];

export const memberService = {
  getPageData: async (query: QueryState) => apiClient.get('/api/nongjing/members/summary', { regionCode: query.regionCode, yearMonth: query.yearMonth }, () => getMockMemberData(query)),
};
