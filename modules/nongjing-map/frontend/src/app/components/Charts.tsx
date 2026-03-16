import { Bar, BarChart, CartesianGrid, Cell, Legend, Line, LineChart, Pie, PieChart, ResponsiveContainer, Tooltip, XAxis, YAxis } from 'recharts';
import type { NamedValue, TrendPoint } from '@/app/types/modules';

const COLORS = ['#53d2ff', '#7ef0c1', '#ffbd59', '#ff7d7d', '#8d9cff'];

export function DonutChart({ data, dataKey = 'value', nameKey = 'name', height = 260 }: { data: NamedValue[]; dataKey?: string; nameKey?: string; height?: number }) {
  return (
    <div style={{ width: '100%', height }}>
      <ResponsiveContainer>
        <PieChart>
          <Pie data={data} dataKey={dataKey} nameKey={nameKey} innerRadius={55} outerRadius={90} paddingAngle={4}>
            {data.map((entry, index) => <Cell key={entry.name} fill={COLORS[index % COLORS.length]} />)}
          </Pie>
          <Tooltip formatter={(value: number) => `${value}`} />
          <Legend />
        </PieChart>
      </ResponsiveContainer>
    </div>
  );
}

export function CompareBarChart({ data, firstLabel = '数值', secondLabel = '对比值', height = 280 }: { data: TrendPoint[]; firstLabel?: string; secondLabel?: string; height?: number }) {
  return (
    <div style={{ width: '100%', height }}>
      <ResponsiveContainer>
        <BarChart data={data}>
          <CartesianGrid stroke="rgba(255,255,255,0.08)" vertical={false} />
          <XAxis dataKey="label" stroke="#8fa8b9" />
          <YAxis stroke="#8fa8b9" />
          <Tooltip />
          <Legend />
          <Bar dataKey="value" fill="#53d2ff" name={firstLabel} radius={[8, 8, 0, 0]} />
          {data.some((item) => typeof item.value2 === 'number') ? <Bar dataKey="value2" fill="#7ef0c1" name={secondLabel} radius={[8, 8, 0, 0]} /> : null}
        </BarChart>
      </ResponsiveContainer>
    </div>
  );
}

export function TrendLineChart({ data, firstLabel = '主值', secondLabel = '对比一', thirdLabel = '对比二', height = 280 }: { data: TrendPoint[]; firstLabel?: string; secondLabel?: string; thirdLabel?: string; height?: number }) {
  return (
    <div style={{ width: '100%', height }}>
      <ResponsiveContainer>
        <LineChart data={data}>
          <CartesianGrid stroke="rgba(255,255,255,0.08)" vertical={false} />
          <XAxis dataKey="label" stroke="#8fa8b9" />
          <YAxis stroke="#8fa8b9" />
          <Tooltip />
          <Legend />
          <Line dataKey="value" name={firstLabel} stroke="#53d2ff" strokeWidth={3} dot={{ r: 3 }} />
          {data.some((item) => typeof item.value2 === 'number') ? <Line dataKey="value2" name={secondLabel} stroke="#7ef0c1" strokeWidth={2} dot={{ r: 2 }} /> : null}
          {data.some((item) => typeof item.value3 === 'number') ? <Line dataKey="value3" name={thirdLabel} stroke="#ffbd59" strokeWidth={2} dot={{ r: 2 }} /> : null}
        </LineChart>
      </ResponsiveContainer>
    </div>
  );
}
