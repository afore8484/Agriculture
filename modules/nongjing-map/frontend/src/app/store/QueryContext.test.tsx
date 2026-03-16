import { fireEvent, render, screen } from '@testing-library/react';
import { describe, expect, it } from 'vitest';
import { QueryProvider, useQueryContext } from './QueryContext';

function Probe() {
  const { query, setRegion } = useQueryContext();
  return (
    <div>
      <span>{query.regionName}</span>
      <button type="button" onClick={() => setRegion('460200')}>切换区划</button>
    </div>
  );
}

describe('QueryContext', () => {
  it('updates region name when region code changes', () => {
    render(
      <QueryProvider>
        <Probe />
      </QueryProvider>,
    );

    expect(screen.getByText('全省')).toBeInTheDocument();
    fireEvent.click(screen.getByText('切换区划'));
    expect(screen.getByText('三亚市')).toBeInTheDocument();
  });
});
