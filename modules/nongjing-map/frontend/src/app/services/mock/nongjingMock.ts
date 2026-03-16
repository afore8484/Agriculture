import type {
  AlertData,
  AssetData,
  ContractData,
  EquityData,
  FinanceData,
  GisRegionMetric,
  MemberData,
  ModuleEntry,
  OverviewData,
  RegionOption,
  ResourceData,
  TrendPoint,
} from '@/app/types/modules';
import type { QueryState } from '@/app/types/query';

export const REGION_OPTIONS: RegionOption[] = [
  { regionCode: '460000', regionName: '全省', level: '省', longitude: 110.35, latitude: 19.2 },
  { regionCode: '460100', regionName: '海口市', level: '市', longitude: 110.35, latitude: 20.02 },
  { regionCode: '460200', regionName: '三亚市', level: '市', longitude: 109.51, latitude: 18.25 },
  { regionCode: '460400', regionName: '儋州市', level: '市', longitude: 109.58, latitude: 19.52 },
  { regionCode: '469002', regionName: '琼海市', level: '市', longitude: 110.46, latitude: 19.25 },
  { regionCode: '469005', regionName: '文昌市', level: '市', longitude: 110.75, latitude: 19.54 },
  { regionCode: '469006', regionName: '万宁市', level: '市', longitude: 110.4, latitude: 18.8 },
  { regionCode: '469001', regionName: '五指山市', level: '市', longitude: 109.52, latitude: 18.78 },
  { regionCode: '469007', regionName: '东方市', level: '市', longitude: 108.65, latitude: 19.1 },
  { regionCode: '469021', regionName: '定安县', level: '县', longitude: 110.32, latitude: 19.68 },
  { regionCode: '469022', regionName: '屯昌县', level: '县', longitude: 110.1, latitude: 19.35 },
  { regionCode: '469023', regionName: '澄迈县', level: '县', longitude: 110.01, latitude: 19.74 },
  { regionCode: '469024', regionName: '临高县', level: '县', longitude: 109.69, latitude: 19.91 },
  { regionCode: '469025', regionName: '白沙县', level: '县', longitude: 109.45, latitude: 19.22 },
  { regionCode: '469026', regionName: '昌江县', level: '县', longitude: 109.05, latitude: 19.3 },
  { regionCode: '469027', regionName: '乐东县', level: '县', longitude: 109.18, latitude: 18.75 },
  { regionCode: '469028', regionName: '陵水县', level: '县', longitude: 110.04, latitude: 18.51 },
  { regionCode: '469029', regionName: '保亭县', level: '县', longitude: 109.7, latitude: 18.64 },
  { regionCode: '469030', regionName: '琼中县', level: '县', longitude: 109.84, latitude: 19.03 },
];

export const YEAR_OPTIONS = ['2026', '2025', '2024'];
export const QUARTER_OPTIONS = ['全年', 'Q1', 'Q2', 'Q3', 'Q4'];
export const MONTH_OPTIONS = ['2026-01', '2026-02', '2026-03', '2026-04', '2026-05', '2026-06'];

const MODULE_ENTRIES: ModuleEntry[] = [
  { code: 'finance', name: '财务一张图', requirementCount: 156, focus: '收入分档、财务指标、资产负债分析', path: '/finance' },
  { code: 'assets', name: '资产一张图', requirementCount: 7, focus: '区域价值排名、台账和经营状态', path: '/assets' },
  { code: 'resources', name: '资源一张图', requirementCount: 6, focus: '资源调取、分布和GIS图层联动', path: '/resources' },
  { code: 'contracts', name: '合同一张图', requirementCount: 7, focus: '类型金额、本期与累计应收应付', path: '/contracts' },
  { code: 'members', name: '成员一张图', requirementCount: 24, focus: '成员结构、区域统计和台账查询', path: '/members' },
  { code: 'equity', name: '股权一张图', requirementCount: 19, focus: '股权结构、成员映射和分红', path: '/equity' },
  { code: 'alerts', name: '预警监督', requirementCount: 23, focus: '规则、通知、送办、处置闭环', path: '/alerts' },
];

const regionIndex = (regionCode: string) => Math.max(1, REGION_OPTIONS.findIndex((item) => item.regionCode === regionCode) + 1);
const regionScale = (regionCode: string) => (regionCode === '460000' ? 1 : 0.14 + regionIndex(regionCode) * 0.035);
const monthScale = (yearMonth: string) => 1 + (Math.max(1, MONTH_OPTIONS.indexOf(yearMonth) + 1) - 1) * 0.03;
const yearScale = (year: string) => (Number(year) - 2023) * 0.04 + 1;
const pickRegionName = (regionCode: string) => REGION_OPTIONS.find((item) => item.regionCode === regionCode)?.regionName || '全省';
const formatWan = (value: number) => `${value.toFixed(1)}万`;
const formatYi = (value: number) => `${value.toFixed(2)}亿`;

function baseAmount(query: QueryState, seed: number) {
  return seed * regionScale(query.regionCode) * monthScale(query.yearMonth) * yearScale(query.year);
}

function toMapRegions(query: QueryState): GisRegionMetric[] {
  return REGION_OPTIONS.slice(1).map((item, index) => {
    const value = baseAmount({ ...query, regionCode: item.regionCode }, 1200 + index * 150);
    return {
      regionCode: item.regionCode,
      regionName: item.regionName,
      x: 18 + (index % 4) * 22,
      y: 18 + Math.floor(index / 4) * 24,
      summary: `经营收入 ${formatWan(value)}`,
      highlight: `预警 ${8 + index} 件 / 资产 ${formatYi(value / 1800)}`,
    };
  });
}

function buildMonthlyTrend(query: QueryState, seed: number): TrendPoint[] {
  return MONTH_OPTIONS.map((label, index) => ({
    label,
    value: Number((seed * regionScale(query.regionCode) * (0.82 + index * 0.08)).toFixed(2)),
    value2: Number((seed * 0.72 * regionScale(query.regionCode) * (0.86 + index * 0.05)).toFixed(2)),
    value3: Number((seed * 0.38 * regionScale(query.regionCode) * (0.8 + index * 0.04)).toFixed(2)),
  }));
}

export async function getMockOverviewData(query: QueryState): Promise<OverviewData> {
  const scale = regionScale(query.regionCode);
  return {
    weather: {
      weatherType: '多云转阵雨',
      temperatureRange: '24℃ - 31℃',
      humidity: '85%',
      windLevel: '东北风 3级',
    },
    cards: [
      { label: '区县数量', value: '18', hint: '全省行政区划口径', status: 'neutral' },
      { label: '乡镇街道', value: `${Math.round(212 * scale)}`, hint: `当前区划：${pickRegionName(query.regionCode)}`, status: 'positive' },
      { label: '村集体组织', value: `${Math.round(2698 * scale)}`, hint: '统一组织主数据口径', status: 'positive' },
      { label: '未结账数量', value: `${Math.round(182 * scale)}`, hint: '上月未结账组织', status: 'warning' },
      { label: '未建账套数量', value: `${Math.round(96 * scale)}`, hint: '需督办建账套组织', status: 'warning' },
      { label: '预警事件', value: `${Math.round(63 * scale)}`, hint: '待办与处理中合计', status: 'negative' },
      { label: '合同总额', value: formatYi(10.4 * scale), hint: '履约中合同总额', status: 'positive' },
      { label: '经营性资产', value: formatYi(7.9 * scale), hint: '含资源、厂房、设备', status: 'positive' },
    ],
    mapRegions: toMapRegions(query),
    moduleEntries: MODULE_ENTRIES,
    trends: buildMonthlyTrend(query, 4200),
    focusList: [
      '总览页承担统一入口、统一筛选、统一钻取三项职责。',
      'GIS 在本模块中是横切能力，负责区划选择、热点定位和专题联动。',
      '所有专题页都必须保留与总览页一致的区划和时间上下文。',
    ],
  };
}

export async function getMockFinanceData(query: QueryState): Promise<FinanceData> {
  const amount = baseAmount(query, 8800);
  return {
    kpis: [
      { label: '村集体总收入', value: formatWan(amount), hint: '经营收入、补助收入、投资收益、其他收入', status: 'positive' },
      { label: '高于20万元村数', value: `${Math.round(168 * regionScale(query.regionCode))}`, hint: '当月收入阈值分档', status: 'positive' },
      { label: '低于5万元村数', value: `${Math.round(57 * regionScale(query.regionCode))}`, hint: '重点关注薄弱村', status: 'warning' },
      { label: '未建账套数量', value: `${Math.round(96 * regionScale(query.regionCode))}`, hint: '首页与专题页口径一致', status: 'warning' },
      { label: '流动资产合计', value: formatYi(amount / 4200), hint: '货币资金、应收款项、存货等', status: 'positive' },
      { label: '负债合计', value: formatYi(amount / 6100), hint: '流动负债 + 非流动负债', status: 'negative' },
      { label: '本年收益', value: formatWan(amount * 0.18), hint: '财务指标主卡片', status: 'positive' },
      { label: '未分配收益', value: formatWan(amount * 0.11), hint: '与收益分配页面联动', status: 'neutral' },
    ],
    incomeBands: [
      { name: '高于20万元', value: Math.round(168 * regionScale(query.regionCode)), share: 28.4 },
      { name: '10-20万元', value: Math.round(212 * regionScale(query.regionCode)), share: 35.8 },
      { name: '5-10万元', value: Math.round(154 * regionScale(query.regionCode)), share: 24.1 },
      { name: '低于5万元', value: Math.round(57 * regionScale(query.regionCode)), share: 11.7 },
    ],
    highThresholdTable: {
      columns: [
        { key: 'regionName', label: '区划' },
        { key: 'totalIncome', label: '总收入' },
        { key: 'operatingIncome', label: '经营收入' },
        { key: 'subsidyIncome', label: '补助收入' },
        { key: 'investmentIncome', label: '投资收益' },
        { key: 'otherIncome', label: '其他收入' },
      ],
      rows: REGION_OPTIONS.slice(1, 7).map((item, index) => ({
        regionName: item.regionName,
        totalIncome: formatWan(1600 + index * 120),
        operatingIncome: formatWan(930 + index * 80),
        subsidyIncome: formatWan(320 + index * 30),
        investmentIncome: formatWan(210 + index * 18),
        otherIncome: formatWan(90 + index * 12),
      })),
    },
    lowThresholdTable: {
      columns: [
        { key: 'regionName', label: '区划' },
        { key: 'totalIncome', label: '总收入' },
        { key: 'supportDirection', label: '重点帮扶方向' },
        { key: 'status', label: '当前状态' },
      ],
      rows: REGION_OPTIONS.slice(10, 16).map((item, index) => ({
        regionName: item.regionName,
        totalIncome: formatWan(38 + index * 4.6),
        supportDirection: ['合同清收', '经营项目盘活', '资产确权', '补助资金跟进'][index % 4],
        status: ['待督办', '跟踪中', '整改中'][index % 3],
      })),
    },
    subjectTable: {
      columns: [
        { key: 'subject', label: '科目' },
        { key: 'opening', label: '年初数' },
        { key: 'ending', label: '年末数' },
        { key: 'change', label: '变动说明' },
      ],
      rows: [
        { subject: '货币资金', opening: formatWan(amount * 0.12), ending: formatWan(amount * 0.16), change: '经营收入回款增长' },
        { subject: '应收账款', opening: formatWan(amount * 0.05), ending: formatWan(amount * 0.06), change: '合同应收款增加' },
        { subject: '存货', opening: formatWan(amount * 0.03), ending: formatWan(amount * 0.04), change: '季节性物资储备' },
        { subject: '固定资产', opening: formatWan(amount * 0.22), ending: formatWan(amount * 0.24), change: '新增厂房与设备' },
        { subject: '应付账款', opening: formatWan(amount * 0.04), ending: formatWan(amount * 0.05), change: '工程类应付款待清算' },
      ],
    },
    balanceTable: {
      columns: [
        { key: 'item', label: '资产负债项目' },
        { key: 'current', label: '当前数' },
        { key: 'previous', label: '对比数' },
        { key: 'analysis', label: '分析结论' },
      ],
      rows: [
        { item: '流动资产合计', current: formatYi(amount / 4200), previous: formatYi(amount / 4600), analysis: '资金和应收款提升较明显' },
        { item: '非流动资产合计', current: formatYi(amount / 3000), previous: formatYi(amount / 3200), analysis: '固定资产与在建工程增加' },
        { item: '负债合计', current: formatYi(amount / 6100), previous: formatYi(amount / 6800), analysis: '短期借款略有上升' },
        { item: '所有者权益', current: formatYi(amount / 2200), previous: formatYi(amount / 2400), analysis: '收益留存带动权益增长' },
      ],
    },
    distribution: [
      { name: '经营收入', value: 52 },
      { name: '补助收入', value: 21 },
      { name: '投资收益', value: 17 },
      { name: '其他收入', value: 10 },
    ],
    trend: buildMonthlyTrend(query, 1200),
  };
}

export async function getMockAssetData(query: QueryState): Promise<AssetData> {
  const value = baseAmount(query, 6900);
  return {
    kpis: [
      { label: '资产总值', value: formatYi(value / 2100), hint: '经营性 + 非经营性资产', status: 'positive' },
      { label: '经营性资产', value: formatYi(value / 3100), hint: '厂房、设备、物业等', status: 'positive' },
      { label: '闲置资产占比', value: '12.6%', hint: '需与经营状态联动查看', status: 'warning' },
      { label: '确权完成率', value: '91.4%', hint: '用于后续资产盘活', status: 'positive' },
    ],
    categoryStats: [
      { name: '资源性资产', value: 42 },
      { name: '经营性固定资产', value: 28 },
      { name: '公益性资产', value: 18 },
      { name: '在建工程', value: 12 },
    ],
    regionRanking: {
      columns: [
        { key: 'regionName', label: '区划' },
        { key: 'assetValue', label: '资产价值' },
        { key: 'topAsset', label: '主导资产' },
        { key: 'status', label: '经营状态' },
      ],
      rows: REGION_OPTIONS.slice(1, 6).map((item, index) => ({
        regionName: item.regionName,
        assetValue: formatYi(1.4 + index * 0.26),
        topAsset: ['标准厂房', '商铺物业', '农业设施', '林地资源', '渔业码头'][index],
        status: ['经营良好', '盘活中', '经营良好', '出租中', '待整改'][index],
      })),
    },
    ledgerTable: {
      columns: [
        { key: 'assetName', label: '资产名称' },
        { key: 'assetType', label: '资产类型' },
        { key: 'regionName', label: '所属区划' },
        { key: 'bookValue', label: '账面价值' },
        { key: 'operatorState', label: '经营状态' },
      ],
      rows: [
        { assetName: '村集体物业A座', assetType: '经营性固定资产', regionName: pickRegionName(query.regionCode), bookValue: formatWan(860), operatorState: '出租中' },
        { assetName: '冷链仓储中心', assetType: '经营性固定资产', regionName: '海口市', bookValue: formatWan(720), operatorState: '运营中' },
        { assetName: '标准厂房一期', assetType: '在建工程', regionName: '儋州市', bookValue: formatWan(1180), operatorState: '建设中' },
        { assetName: '集体林地资源包', assetType: '资源性资产', regionName: '陵水县', bookValue: formatWan(450), operatorState: '确权完成' },
      ],
    },
    operationStats: [
      { name: '运营中', value: 58 },
      { name: '出租中', value: 23 },
      { name: '盘活中', value: 11 },
      { name: '闲置待处置', value: 8 },
    ],
  };
}

export async function getMockResourceData(query: QueryState): Promise<ResourceData> {
  const value = baseAmount(query, 5400);
  return {
    kpis: [
      { label: '资源总面积', value: `${Math.round(value / 5)}亩`, hint: '含农用地、建设用地、未利用地', status: 'positive' },
      { label: '农用地面积', value: `${Math.round(value / 6.5)}亩`, hint: '耕地、林地、园地', status: 'positive' },
      { label: '建设用地面积', value: `${Math.round(value / 28)}亩`, hint: '厂房、仓储、公共设施', status: 'neutral' },
      { label: '资源调取任务', value: `${Math.round(28 * regionScale(query.regionCode))}`, hint: '资源信息接口调取批次', status: 'warning' },
    ],
    typeStats: [
      { name: '耕地', value: 38 },
      { name: '林地', value: 24 },
      { name: '园地', value: 18 },
      { name: '建设用地', value: 14 },
      { name: '未利用地', value: 6 },
    ],
    districtStats: {
      columns: [
        { key: 'regionName', label: '区划' },
        { key: 'farmland', label: '农用地' },
        { key: 'construction', label: '建设用地' },
        { key: 'unused', label: '未利用地' },
      ],
      rows: REGION_OPTIONS.slice(1, 7).map((item, index) => ({
        regionName: item.regionName,
        farmland: `${3200 + index * 280}亩`,
        construction: `${680 + index * 36}亩`,
        unused: `${190 + index * 12}亩`,
      })),
    },
    dispatchTable: {
      columns: [
        { key: 'taskName', label: '调取任务' },
        { key: 'source', label: '数据源' },
        { key: 'scope', label: '覆盖范围' },
        { key: 'status', label: '状态' },
      ],
      rows: [
        { taskName: '资源底图同步', source: '自然资源共享库', scope: '全省区县', status: '已完成' },
        { taskName: '耕地确权结果调取', source: '资源台账接口', scope: pickRegionName(query.regionCode), status: '执行中' },
        { taskName: '地块编码核验', source: '专题校核接口', scope: '重点区域', status: '待复核' },
      ],
    },
    layerTips: [
      '图层一：区划边界与资源面积热区。',
      '图层二：资源类型分布与地块标签。',
      '图层三：资源调取任务覆盖范围与状态。',
    ],
  };
}

export async function getMockContractData(query: QueryState): Promise<ContractData> {
  const amount = baseAmount(query, 4300);
  return {
    kpis: [
      { label: '合同总数', value: `${Math.round(486 * regionScale(query.regionCode))}`, hint: '含土地承包、租赁、采购等', status: 'positive' },
      { label: '合同总金额', value: formatYi(amount / 980), hint: '合同一张图总额', status: 'positive' },
      { label: '本期应收款', value: formatWan(amount * 0.15), hint: '按期限、来源、对象查看', status: 'warning' },
      { label: '累计应收款', value: formatWan(amount * 0.48), hint: '历史累计口径', status: 'warning' },
      { label: '本期应付款', value: formatWan(amount * 0.1), hint: '按项目、对象查看', status: 'negative' },
      { label: '累计应付款', value: formatWan(amount * 0.35), hint: '历史累计口径', status: 'negative' },
    ],
    typeStats: [
      { name: '土地承包', value: 32 },
      { name: '物业租赁', value: 26 },
      { name: '工程建设', value: 18 },
      { name: '采购服务', value: 14 },
      { name: '其他合同', value: 10 },
    ],
    currentReceivablePayable: buildMonthlyTrend(query, 360).map((item) => ({ ...item, value2: Number((item.value * 0.64).toFixed(2)) })),
    accumulativeReceivablePayable: buildMonthlyTrend(query, 980).map((item) => ({ ...item, value2: Number((item.value * 0.72).toFixed(2)) })),
    contractTable: {
      columns: [
        { key: 'contractName', label: '合同名称' },
        { key: 'contractType', label: '类型' },
        { key: 'counterparty', label: '相对方' },
        { key: 'amount', label: '金额' },
        { key: 'receivable', label: '应收/应付' },
        { key: 'dueDate', label: '到期日' },
      ],
      rows: [
        { contractName: '农贸市场租赁合同', contractType: '物业租赁', counterparty: '海口海链公司', amount: formatWan(320), receivable: '应收', dueDate: '2026-03-28' },
        { contractName: '土地流转承包合同', contractType: '土地承包', counterparty: '儋州金穗合作社', amount: formatWan(470), receivable: '应收', dueDate: '2026-04-12' },
        { contractName: '基础设施改造合同', contractType: '工程建设', counterparty: '琼中建工', amount: formatWan(260), receivable: '应付', dueDate: '2026-03-20' },
        { contractName: '冷链设备采购合同', contractType: '采购服务', counterparty: '海南农服设备厂', amount: formatWan(198), receivable: '应付', dueDate: '2026-03-25' },
      ],
    },
  };
}

export async function getMockMemberData(query: QueryState): Promise<MemberData> {
  const scale = regionScale(query.regionCode);
  return {
    kpis: [
      { label: '成员总人数', value: `${Math.round(426800 * scale)}`, hint: '成员主数据统一口径', status: 'positive' },
      { label: '成员总户数', value: `${Math.round(128600 * scale)}`, hint: '按户籍与组织关系统计', status: 'positive' },
      { label: '成员覆盖率', value: '94.8%', hint: '与股权对象保持一致', status: 'positive' },
      { label: '待核验成员', value: `${Math.round(1360 * scale)}`, hint: '需与股权、合同主体核验', status: 'warning' },
    ],
    structureStats: [
      { name: '男性', value: 51 },
      { name: '女性', value: 49 },
      { name: '60岁以上', value: 18 },
      { name: '青年劳动力', value: 24 },
      { name: '非成员常住人口', value: 8 },
    ],
    districtStats: {
      columns: [
        { key: 'regionName', label: '区划' },
        { key: 'households', label: '户数' },
        { key: 'population', label: '人数' },
        { key: 'coverage', label: '成员覆盖率' },
      ],
      rows: REGION_OPTIONS.slice(1, 7).map((item, index) => ({
        regionName: item.regionName,
        households: `${8200 + index * 560}`,
        population: `${28600 + index * 1620}`,
        coverage: `${(92.1 + index * 0.4).toFixed(1)}%`,
      })),
    },
    memberTable: {
      columns: [
        { key: 'memberName', label: '成员姓名' },
        { key: 'regionName', label: '所属区划' },
        { key: 'category', label: '成员类别' },
        { key: 'gender', label: '性别' },
        { key: 'age', label: '年龄' },
        { key: 'equityStatus', label: '股权关联' },
      ],
      rows: [
        { memberName: '王海林', regionName: pickRegionName(query.regionCode), category: '集体成员', gender: '男', age: 46, equityStatus: '已关联' },
        { memberName: '陈秀兰', regionName: '三亚市', category: '集体成员', gender: '女', age: 39, equityStatus: '已关联' },
        { memberName: '符天佑', regionName: '儋州市', category: '非成员常住', gender: '男', age: 54, equityStatus: '待核验' },
        { memberName: '黎小芳', regionName: '陵水县', category: '集体成员', gender: '女', age: 28, equityStatus: '已关联' },
      ],
    },
  };
}

export async function getMockEquityData(query: QueryState): Promise<EquityData> {
  const amount = baseAmount(query, 2800);
  return {
    kpis: [
      { label: '股权总值', value: formatYi(amount / 620), hint: '统一股权台账口径', status: 'positive' },
      { label: '持股成员数', value: `${Math.round(36200 * regionScale(query.regionCode))}`, hint: '与成员主数据映射', status: 'positive' },
      { label: '年度分红', value: formatWan(amount * 0.19), hint: '按成员、按区划钻取', status: 'positive' },
      { label: '待处理变更', value: `${Math.round(132 * regionScale(query.regionCode))}`, hint: '含继承、转让、纠错', status: 'warning' },
    ],
    equityStructure: [
      { name: '人口股', value: 48 },
      { name: '劳龄股', value: 21 },
      { name: '土地股', value: 19 },
      { name: '其他股', value: 12 },
    ],
    dividendTrend: buildMonthlyTrend(query, 260),
    mappingTable: {
      columns: [
        { key: 'memberName', label: '成员' },
        { key: 'equityType', label: '股权类型' },
        { key: 'equityAmount', label: '持股值' },
        { key: 'dividend', label: '年度分红' },
        { key: 'status', label: '变更状态' },
      ],
      rows: [
        { memberName: '王海林', equityType: '人口股', equityAmount: '2,400', dividend: formatWan(1.8), status: '正常' },
        { memberName: '陈秀兰', equityType: '土地股', equityAmount: '1,860', dividend: formatWan(1.1), status: '正常' },
        { memberName: '符天佑', equityType: '劳龄股', equityAmount: '1,260', dividend: formatWan(0.8), status: '待核验' },
        { memberName: '黎小芳', equityType: '人口股', equityAmount: '2,180', dividend: formatWan(1.5), status: '变更处理中' },
      ],
    },
  };
}

export async function getMockAlertData(query: QueryState): Promise<AlertData> {
  const scale = regionScale(query.regionCode);
  return {
    kpis: [
      { label: '预警总数', value: `${Math.round(286 * scale)}`, hint: '规则触发总量', status: 'warning' },
      { label: '处理中', value: `${Math.round(96 * scale)}`, hint: '待送办、待受理、处理中', status: 'warning' },
      { label: '已办结', value: `${Math.round(165 * scale)}`, hint: '闭环事件', status: 'positive' },
      { label: '超期事件', value: `${Math.round(25 * scale)}`, hint: '需重点督办', status: 'negative' },
    ],
    ruleTable: {
      columns: [
        { key: 'ruleName', label: '规则名称' },
        { key: 'triggerType', label: '触发条件' },
        { key: 'notifyMode', label: '通知方式' },
        { key: 'level', label: '等级' },
        { key: 'status', label: '状态' },
      ],
      rows: [
        { ruleName: '未结账超期预警', triggerType: '月结超过5日未完成', notifyMode: '弹窗 + 短信', level: '高', status: '启用' },
        { ruleName: '合同应收超期预警', triggerType: '应收款逾期超过15日', notifyMode: '短信 + 待办', level: '中', status: '启用' },
        { ruleName: '资产闲置预警', triggerType: '闲置超过90日', notifyMode: '弹窗', level: '中', status: '启用' },
      ],
    },
    eventTable: {
      columns: [
        { key: 'eventName', label: '事件' },
        { key: 'regionName', label: '区划' },
        { key: 'status', label: '状态' },
        { key: 'handler', label: '受理人' },
        { key: 'deadline', label: '时限' },
      ],
      rows: [
        { eventName: '乐东县 3 月未结账', regionName: '乐东县', status: '送办中', handler: '县级审核员', deadline: '2026-03-18' },
        { eventName: '儋州市 合同应收超期', regionName: '儋州市', status: '处理中', handler: '合同管理员', deadline: '2026-03-20' },
        { eventName: '琼海市 闲置资产超期', regionName: '琼海市', status: '待受理', handler: '资产专员', deadline: '2026-03-16' },
        { eventName: '陵水县 股权变更异常', regionName: '陵水县', status: '已办结', handler: '股权管理员', deadline: '2026-03-12' },
      ],
    },
    efficiencyTable: {
      columns: [
        { key: 'roleName', label: '角色' },
        { key: 'assigned', label: '指派数' },
        { key: 'done', label: '办结数' },
        { key: 'doneRate', label: '办结率' },
        { key: 'avgHours', label: '平均时长' },
      ],
      rows: [
        { roleName: '受理员', assigned: 126, done: 98, doneRate: '77.8%', avgHours: '18h' },
        { roleName: '村会计', assigned: 84, done: 70, doneRate: '83.3%', avgHours: '12h' },
        { roleName: '合同管理员', assigned: 53, done: 42, doneRate: '79.2%', avgHours: '20h' },
      ],
    },
    categoryStats: [
      { name: '未结账', value: 31 },
      { name: '合同应收', value: 25 },
      { name: '资产闲置', value: 22 },
      { name: '股权变更', value: 12 },
      { name: '其他', value: 10 },
    ],
  };
}
