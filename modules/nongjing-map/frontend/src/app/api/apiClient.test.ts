import { describe, expect, it, vi } from 'vitest';
import { buildApiUrl, createApiClient } from './apiClient';

describe('apiClient', () => {
  it('buildApiUrl should append query string', () => {
    expect(buildApiUrl('https://example.com', '/api/nongjing/overview/cards', { regionCode: '460000', yearMonth: '2026-03' }))
      .toBe('https://example.com/api/nongjing/overview/cards?regionCode=460000&yearMonth=2026-03');
  });

  it('should use fallback when request fails', async () => {
    const fetchImpl = vi.fn().mockRejectedValue(new Error('network'));
    const client = createApiClient({ baseUrl: 'https://example.com', fetchImpl });
    const response = await client.get(
      '/api/nongjing/overview/cards',
      { regionCode: '460000' },
      async () => ({ ok: true }),
      { useFallbackOnError: true },
    );
    expect(response.message).toBe('mock-fallback');
    expect(response.data).toEqual({ ok: true });
  });
});
