export interface ApiResponse<T> {
  code: number;
  message: string;
  data: T;
  total?: number;
}

export interface ApiEndpointDescriptor {
  method: 'GET' | 'POST' | 'PUT' | 'DELETE';
  path: string;
  summary: string;
  params: string[];
}
