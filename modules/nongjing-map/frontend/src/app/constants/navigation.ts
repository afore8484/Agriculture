import type { ModuleEntry } from '@/app/types/modules';

export const MODULE_NAV: ModuleEntry[] = [
  { code: 'overview', name: '总览页', requirementCount: 242, focus: '总览入口与GIS联动', path: '/' },
  { code: 'finance', name: '财务一张图', requirementCount: 156, focus: '收入分档与资产负债分析', path: '/finance' },
  { code: 'assets', name: '资产一张图', requirementCount: 7, focus: '区域价值排名与台账', path: '/assets' },
  { code: 'resources', name: '资源一张图', requirementCount: 6, focus: '资源调取与图层联动', path: '/resources' },
  { code: 'contracts', name: '合同一张图', requirementCount: 7, focus: '累计应收应付与明细', path: '/contracts' },
  { code: 'members', name: '成员一张图', requirementCount: 24, focus: '成员结构与区域统计', path: '/members' },
  { code: 'equity', name: '股权一张图', requirementCount: 19, focus: '股权映射与分红结构', path: '/equity' },
  { code: 'alerts', name: '预警监督', requirementCount: 23, focus: '规则通知与处置闭环', path: '/alerts' },
];
