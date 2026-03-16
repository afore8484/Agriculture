import type { ApiResponse } from '@/app/types/api';
import { buildQueryString } from '@/app/utils/format';

interface ClientOptions {
  baseUrl?: string;
  token?: string;
  fetchImpl?: typeof fetch;
}

interface RequestOptions {
  timeoutMs?: number;
  useFallbackOnError?: boolean;
}

const resolveToken = (token?: string) => {
  if (token) return token;
  if (typeof window === 'undefined') return import.meta.env.VITE_AUTH_TOKEN || '';
  return sessionStorage.getItem('nongjing_token') || localStorage.getItem('nongjing_token') || import.meta.env.VITE_AUTH_TOKEN || '';
};

export function buildApiUrl(baseUrl: string, path: string, params?: Record<string, string | number | undefined | null>) {
  return `${baseUrl}${path}${buildQueryString(params || {})}`;
}

export function createApiClient(options: ClientOptions = {}) {
  const fetchImpl = options.fetchImpl ?? fetch;
  const baseUrl = options.baseUrl ?? import.meta.env.VITE_API_BASE_URL ?? '';

  async function get<T>(
    path: string,
    params: Record<string, string | number | undefined | null>,
    fallback: () => Promise<T>,
    requestOptions: RequestOptions = {},
  ): Promise<ApiResponse<T>> {
    const timeoutMs = requestOptions.timeoutMs ?? 3000;

    if (!baseUrl) {
      return { code: 200, message: 'mock', data: await fallback() };
    }

    const controller = new AbortController();
    const timeoutId = window.setTimeout(() => controller.abort(), timeoutMs);

    try {
      const response = await fetchImpl(buildApiUrl(baseUrl, path, params), {
        method: 'GET',
        signal: controller.signal,
        headers: {
          'Content-Type': 'application/json',
          Authorization: resolveToken(options.token) ? `Bearer ${resolveToken(options.token)}` : '',
        },
      });

      if (!response.ok) {
        throw new Error(`HTTP ${response.status}`);
      }

      return (await response.json()) as ApiResponse<T>;
    } catch (error) {
      if (requestOptions.useFallbackOnError) {
        console.warn(`[apiClient] fallback for ${path}:`, error);
        return { code: 200, message: 'mock-fallback', data: await fallback() };
      }
      throw error;
    } finally {
      window.clearTimeout(timeoutId);
    }
  }

  return { get };
}

export const apiClient = createApiClient();
