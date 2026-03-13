# Figma Frame Spec - Finance One-Map (Mid-fidelity)

## Frame list
1. `F1_Overview`
2. `F2_IncomeBand`
3. `F3_IncomeDrilldown`
4. `F4_FinancialIndicators`
5. `F5_BalanceSheet`
6. `F6_IncomeDistribution`

## Shared GIS layer (cross-cutting)
- `GIS_Overlay` component is reused on F1-F6.
- Map click updates global `region_code` and refreshes page metrics.
- Popup shows key metrics and provides jump actions.

## Shared layout
- Header: title + update timestamp
- Filter bar: region selector, date range, granularity
- GIS overlay trigger: open/close map drawer
- Body: cards/charts/tables
- Right drawer: drilldown detail

## Component rules
- Each KPI card must include `metric_code` annotation.
- Each chart must include: x-axis dimension, y metric, supported filters.
- Each table must include export button and pagination placeholder.
- Drilldown routes:
  - F2 -> F3 (threshold and region carried)
  - F5 -> detail drawer (line item carried)
  - GIS overlay click -> all pages filtered by selected region

## Required prototype interactions
- Region change updates all KPI cards and charts.
- Threshold click (5w/10w/20w) switches list context.
- Month switch re-renders trend and details.
- Export button opens a modal with current filter snapshot.
- GIS overlay can be opened from any frame and keeps filter context.

## Naming standard
- Frame: `Finance/<PageCode>_<Name>`
- Shared map: `Finance/GIS_Overlay`
- Component: `cmp_<type>_<semantic>`
- Metric badge text: `metric_code=<code>`

## Delivery for Day 1
- Complete frame wire layout for F1-F6.
- Add shared `GIS_Overlay` and link it to all pages.
- Annotate every major component with metric_code.
- Add interaction links for filter, drilldown, and export.
