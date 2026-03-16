import { useEffect, useMemo, useState } from 'react';

interface UsePageDataOptions<T> {
  cacheKey: string;
  loader: () => Promise<{ data: T }>;
  deps: unknown[];
  staleMs?: number;
}

interface CacheEntry<T> {
  data: T;
  timestamp: number;
}

const pageCache = new Map<string, CacheEntry<unknown>>();

export function usePageData<T>({ cacheKey, loader, deps, staleMs = 60_000 }: UsePageDataOptions<T>) {
  const cachedEntry = useMemo(() => pageCache.get(cacheKey) as CacheEntry<T> | undefined, [cacheKey]);
  const [data, setData] = useState<T | null>(cachedEntry?.data ?? null);
  const [loading, setLoading] = useState(!cachedEntry);
  const [refreshing, setRefreshing] = useState(false);
  const [error, setError] = useState<string | null>(null);

  useEffect(() => {
    let cancelled = false;
    const existing = pageCache.get(cacheKey) as CacheEntry<T> | undefined;
    const isFresh = existing ? Date.now() - existing.timestamp < staleMs : false;

    if (existing) {
      setData(existing.data);
      setLoading(false);
      setRefreshing(!isFresh);
    } else {
      setLoading(true);
      setRefreshing(false);
    }

    if (isFresh) {
      return () => {
        cancelled = true;
      };
    }

    setError(null);

    loader()
      .then((response) => {
        if (!cancelled) {
          pageCache.set(cacheKey, { data: response.data, timestamp: Date.now() });
          setData(response.data);
        }
      })
      .catch((err) => {
        if (!cancelled) {
          setError(err instanceof Error ? err.message : '加载失败');
        }
      })
      .finally(() => {
        if (!cancelled) {
          setLoading(false);
          setRefreshing(false);
        }
      });

    return () => {
      cancelled = true;
    };
  }, [cacheKey, staleMs, ...deps]);

  return { data, loading, refreshing, error };
}
