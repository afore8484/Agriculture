import { createHashRouter } from 'react-router';
import { AppLayout } from './components/AppLayout';

const loadOverviewPage = () => import('./pages/OverviewPage');
const loadFinancePage = () => import('./pages/FinancePage');
const loadAssetPage = () => import('./pages/AssetPage');
const loadResourcePage = () => import('./pages/ResourcePage');
const loadContractPage = () => import('./pages/ContractPage');
const loadMemberPage = () => import('./pages/MemberPage');
const loadEquityPage = () => import('./pages/EquityPage');
const loadAlertPage = () => import('./pages/AlertPage');

export const routePrefetchMap: Record<string, () => Promise<unknown>> = {
  '/': loadOverviewPage,
  '/finance': loadFinancePage,
  '/assets': loadAssetPage,
  '/resources': loadResourcePage,
  '/contracts': loadContractPage,
  '/members': loadMemberPage,
  '/equity': loadEquityPage,
  '/alerts': loadAlertPage,
};

export const router = createHashRouter([
  {
    path: '/',
    Component: AppLayout,
    children: [
      {
        index: true,
        lazy: async () => ({ Component: (await loadOverviewPage()).OverviewPage }),
      },
      {
        path: 'finance',
        lazy: async () => ({ Component: (await loadFinancePage()).FinancePage }),
      },
      {
        path: 'assets',
        lazy: async () => ({ Component: (await loadAssetPage()).AssetPage }),
      },
      {
        path: 'resources',
        lazy: async () => ({ Component: (await loadResourcePage()).ResourcePage }),
      },
      {
        path: 'contracts',
        lazy: async () => ({ Component: (await loadContractPage()).ContractPage }),
      },
      {
        path: 'members',
        lazy: async () => ({ Component: (await loadMemberPage()).MemberPage }),
      },
      {
        path: 'equity',
        lazy: async () => ({ Component: (await loadEquityPage()).EquityPage }),
      },
      {
        path: 'alerts',
        lazy: async () => ({ Component: (await loadAlertPage()).AlertPage }),
      },
    ],
  },
]);
