export function StatusBox({ state, message }: { state: 'loading' | 'error' | 'empty'; message: string }) {
  const className = state === 'loading' ? 'loading-box' : state === 'error' ? 'error-box' : 'empty-box';
  return <div className={className}>{message}</div>;
}
