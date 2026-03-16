import type { TableData } from '@/app/types/modules';

export function DataTable({ data }: { data: TableData }) {
  return (
    <div className="table-wrap">
      <table>
        <thead>
          <tr>
            {data.columns.map((column) => <th key={column.key}>{column.label}</th>)}
          </tr>
        </thead>
        <tbody>
          {data.rows.map((row, index) => (
            <tr key={index}>
              {data.columns.map((column) => <td key={column.key}>{String(row[column.key] ?? '')}</td>)}
            </tr>
          ))}
        </tbody>
      </table>
    </div>
  );
}
