# Prototype Page Tree (All 7 Submodules)

## 1) Finance One-Map (template-first)
- Shared GIS Layer (cross-cutting capability, not a standalone page)
  - Region polygon map and click-to-filter
  - Region popup metrics and quick jump
  - Shared context applied to F1-F6
- F1 Overview Dashboard
  - Time and weather widgets
  - Region/time global filter bar
  - KPI cards: county/town/village counts, unclosed last month, account-set-missing
- F2 Income Band Analysis (5w/10w/20w)
  - Above/Below count and ratio
  - Regional distribution chart (under shared GIS context)
  - Monthly trend
- F3 Income Drilldown List
  - Filtered list by region, threshold, month
  - Detail drawer and export
- F4 Financial Indicators
  - Cash, AR, inventory, fixed assets, AP, operating income/expense, mgmt expense
- F5 Balance Sheet Analysis
  - Asset/Liability/Equity line items (begin/end values)
  - Delta comparison and export
- F6 Income and Distribution Analysis
  - Income statement items and distribution items
  - Query and export

## 2) Asset One-Map
- A1 Asset overview by region
- A2 Operating vs non-operating asset charts
- A3 Asset type composition
- A4 Top villages by asset value

## 3) Resource One-Map
- R1 Land usage overview (agri/construction/unused)
- R2 Resource composition and totals
- R3 Region comparison view

## 4) Contract One-Map
- C1 Contract count and amount by type
- C2 Current receivable/payable
- C3 Cumulative receivable/payable

## 5) Member One-Map
- M1 Household and population overview
- M2 Member vs non-member
- M3 Gender ratio and counts

## 6) Equity One-Map
- E1 Total equity value and dividend
- E2 Equity type composition
- E3 Ranking and annual comparison

## 7) Warning Supervision
- W1 Rule management (read-model display + rule config hooks)
- W2 Warning event list and severity distribution
- W3 Event handling status and aging

## Cross-page conventions
- Global filters: region_code, region_level, start_date, end_date
- Shared GIS context applies to all analysis pages.
- All charts support drilldown where source requirements mention details.
- Export entry must exist on list/report pages.
