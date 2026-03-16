export interface RegionOption {
  regionCode: string;
  regionName: string;
  level: string;
  longitude: number;
  latitude: number;
}

export interface MetricCard {
  label: string;
  value: string;
  hint?: string;
  status?: 'positive' | 'warning' | 'negative' | 'neutral';
}

export interface NamedValue {
  name: string;
  value: number;
  share?: number;
  note?: string;
}

export interface TrendPoint {
  label: string;
  value: number;
  value2?: number;
  value3?: number;
}

export interface TableColumn {
  key: string;
  label: string;
}

export interface TableData {
  columns: TableColumn[];
  rows: Array<Record<string, string | number>>;
}

export interface ModuleEntry {
  code: string;
  name: string;
  requirementCount: number;
  focus: string;
  path: string;
}

export interface WeatherInfo {
  weatherType: string;
  temperatureRange: string;
  humidity: string;
  windLevel: string;
}

export interface GisRegionMetric {
  regionCode: string;
  regionName: string;
  x: number;
  y: number;
  summary: string;
  highlight: string;
}

export interface OverviewData {
  weather: WeatherInfo;
  cards: MetricCard[];
  mapRegions: GisRegionMetric[];
  moduleEntries: ModuleEntry[];
  trends: TrendPoint[];
  focusList: string[];
}

export interface FinanceData {
  kpis: MetricCard[];
  incomeBands: NamedValue[];
  highThresholdTable: TableData;
  lowThresholdTable: TableData;
  subjectTable: TableData;
  balanceTable: TableData;
  distribution: NamedValue[];
  trend: TrendPoint[];
}

export interface AssetData {
  kpis: MetricCard[];
  categoryStats: NamedValue[];
  regionRanking: TableData;
  ledgerTable: TableData;
  operationStats: NamedValue[];
}

export interface ResourceData {
  kpis: MetricCard[];
  typeStats: NamedValue[];
  districtStats: TableData;
  dispatchTable: TableData;
  layerTips: string[];
}

export interface ContractData {
  kpis: MetricCard[];
  typeStats: NamedValue[];
  currentReceivablePayable: TrendPoint[];
  accumulativeReceivablePayable: TrendPoint[];
  contractTable: TableData;
}

export interface MemberData {
  kpis: MetricCard[];
  structureStats: NamedValue[];
  districtStats: TableData;
  memberTable: TableData;
}

export interface EquityData {
  kpis: MetricCard[];
  equityStructure: NamedValue[];
  dividendTrend: TrendPoint[];
  mappingTable: TableData;
}

export interface AlertData {
  kpis: MetricCard[];
  ruleTable: TableData;
  eventTable: TableData;
  efficiencyTable: TableData;
  categoryStats: NamedValue[];
}
