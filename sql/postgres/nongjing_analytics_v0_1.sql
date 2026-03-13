-- PostgreSQL 16 + PostGIS
-- Nongjing One-Map analytics read model (v0.1)

CREATE EXTENSION IF NOT EXISTS postgis;
CREATE SCHEMA IF NOT EXISTS nongjing_analytics;
SET search_path TO nongjing_analytics, public;

-- =========================
-- Dimensions
-- =========================

CREATE TABLE IF NOT EXISTS dim_time (
    time_key            INTEGER PRIMARY KEY,      -- YYYYMMDD
    calendar_date       DATE NOT NULL UNIQUE,
    year_no             INTEGER NOT NULL,
    quarter_no          INTEGER NOT NULL,
    month_no            INTEGER NOT NULL,
    week_no             INTEGER NOT NULL,
    day_no              INTEGER NOT NULL,
    month_start_date    DATE NOT NULL,
    month_end_date      DATE NOT NULL
);

CREATE TABLE IF NOT EXISTS dim_region (
    region_id           BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    region_code         VARCHAR(32) NOT NULL UNIQUE,
    region_name         TEXT NOT NULL,
    region_level        SMALLINT NOT NULL,        -- 2 county, 3 town, 4 village
    parent_region_code  VARCHAR(32),
    geom                geometry(MultiPolygon, 4326),
    centroid            geometry(Point, 4326),
    is_active           BOOLEAN NOT NULL DEFAULT TRUE,
    created_at          TIMESTAMPTZ NOT NULL DEFAULT now(),
    updated_at          TIMESTAMPTZ NOT NULL DEFAULT now()
);

CREATE INDEX IF NOT EXISTS idx_dim_region_level ON dim_region(region_level);
CREATE INDEX IF NOT EXISTS idx_dim_region_parent ON dim_region(parent_region_code);
CREATE INDEX IF NOT EXISTS idx_dim_region_geom ON dim_region USING GIST(geom);

CREATE TABLE IF NOT EXISTS dim_org (
    org_id                  BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    org_code                VARCHAR(64) NOT NULL UNIQUE,
    org_name                TEXT NOT NULL,
    region_code             VARCHAR(32) NOT NULL,
    org_type                VARCHAR(32) NOT NULL DEFAULT 'village_collective',
    is_account_set_created  BOOLEAN NOT NULL DEFAULT FALSE,
    status                  VARCHAR(16) NOT NULL DEFAULT 'active',
    created_at              TIMESTAMPTZ NOT NULL DEFAULT now(),
    updated_at              TIMESTAMPTZ NOT NULL DEFAULT now(),
    CONSTRAINT fk_dim_org_region FOREIGN KEY (region_code) REFERENCES dim_region(region_code)
);

CREATE INDEX IF NOT EXISTS idx_dim_org_region ON dim_org(region_code);

CREATE TABLE IF NOT EXISTS dim_metric (
    metric_code         VARCHAR(64) PRIMARY KEY,
    metric_name         TEXT NOT NULL,
    module_code         VARCHAR(32) NOT NULL,
    page_code           VARCHAR(32) NOT NULL,
    data_type           VARCHAR(16) NOT NULL,
    description         TEXT
);

CREATE TABLE IF NOT EXISTS dim_income_band (
    band_code           VARCHAR(16) PRIMARY KEY,
    threshold_min       NUMERIC(18,2),
    threshold_max       NUMERIC(18,2),
    comparator          VARCHAR(8) NOT NULL
);

CREATE TABLE IF NOT EXISTS fact_weather_daily (
    weather_id          BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    region_code         VARCHAR(32) NOT NULL,
    weather_date        DATE NOT NULL,
    weather_type        VARCHAR(32),
    temp_min            NUMERIC(5,2),
    temp_max            NUMERIC(5,2),
    source_system       VARCHAR(32),
    created_at          TIMESTAMPTZ NOT NULL DEFAULT now(),
    CONSTRAINT uq_weather_region_date UNIQUE (region_code, weather_date),
    CONSTRAINT fk_weather_region FOREIGN KEY (region_code) REFERENCES dim_region(region_code)
);

-- =========================
-- Finance facts
-- =========================

CREATE TABLE IF NOT EXISTS fact_village_finance_monthly (
    fact_id                  BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    period_month             DATE NOT NULL,
    time_key                 INTEGER NOT NULL,
    region_code              VARCHAR(32) NOT NULL,
    org_code                 VARCHAR(64) NOT NULL,
    total_income             NUMERIC(20,2) NOT NULL DEFAULT 0,
    operating_income         NUMERIC(20,2) NOT NULL DEFAULT 0,
    subsidy_income           NUMERIC(20,2) NOT NULL DEFAULT 0,
    investment_income        NUMERIC(20,2) NOT NULL DEFAULT 0,
    other_income             NUMERIC(20,2) NOT NULL DEFAULT 0,
    operating_expense        NUMERIC(20,2) NOT NULL DEFAULT 0,
    management_expense       NUMERIC(20,2) NOT NULL DEFAULT 0,
    year_profit              NUMERIC(20,2) NOT NULL DEFAULT 0,
    undistributed_profit     NUMERIC(20,2) NOT NULL DEFAULT 0,
    currency_funds           NUMERIC(20,2) NOT NULL DEFAULT 0,
    accounts_receivable      NUMERIC(20,2) NOT NULL DEFAULT 0,
    inventory                NUMERIC(20,2) NOT NULL DEFAULT 0,
    fixed_assets_original    NUMERIC(20,2) NOT NULL DEFAULT 0,
    fixed_assets_net         NUMERIC(20,2) NOT NULL DEFAULT 0,
    accounts_payable         NUMERIC(20,2) NOT NULL DEFAULT 0,
    is_closed                BOOLEAN NOT NULL DEFAULT FALSE,
    is_account_set_created   BOOLEAN NOT NULL DEFAULT FALSE,
    source_updated_at        TIMESTAMPTZ,
    load_batch_id            VARCHAR(64),
    created_at               TIMESTAMPTZ NOT NULL DEFAULT now(),
    CONSTRAINT uq_finance_month_org UNIQUE (period_month, org_code),
    CONSTRAINT fk_finance_time FOREIGN KEY (time_key) REFERENCES dim_time(time_key),
    CONSTRAINT fk_finance_region FOREIGN KEY (region_code) REFERENCES dim_region(region_code),
    CONSTRAINT fk_finance_org FOREIGN KEY (org_code) REFERENCES dim_org(org_code)
);

CREATE INDEX IF NOT EXISTS idx_finance_region_month ON fact_village_finance_monthly(region_code, period_month);
CREATE INDEX IF NOT EXISTS idx_finance_org_month ON fact_village_finance_monthly(org_code, period_month);

CREATE TABLE IF NOT EXISTS fact_balance_sheet_snapshot (
    snapshot_id              BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    snapshot_date            DATE NOT NULL,
    time_key                 INTEGER NOT NULL,
    region_code              VARCHAR(32) NOT NULL,
    org_code                 VARCHAR(64) NOT NULL,
    account_code             VARCHAR(32) NOT NULL,
    account_name             TEXT NOT NULL,
    line_no                  INTEGER,
    value_begin_year         NUMERIC(20,2) NOT NULL DEFAULT 0,
    value_end_period         NUMERIC(20,2) NOT NULL DEFAULT 0,
    value_delta              NUMERIC(20,2) NOT NULL DEFAULT 0,
    account_category         VARCHAR(24) NOT NULL, -- asset/liability/equity
    account_subcategory      VARCHAR(32),
    created_at               TIMESTAMPTZ NOT NULL DEFAULT now(),
    CONSTRAINT uq_bs_snapshot UNIQUE (snapshot_date, org_code, account_code),
    CONSTRAINT fk_bs_time FOREIGN KEY (time_key) REFERENCES dim_time(time_key),
    CONSTRAINT fk_bs_region FOREIGN KEY (region_code) REFERENCES dim_region(region_code),
    CONSTRAINT fk_bs_org FOREIGN KEY (org_code) REFERENCES dim_org(org_code)
);

CREATE INDEX IF NOT EXISTS idx_bs_region_date ON fact_balance_sheet_snapshot(region_code, snapshot_date);
CREATE INDEX IF NOT EXISTS idx_bs_category ON fact_balance_sheet_snapshot(account_category, account_subcategory);

CREATE TABLE IF NOT EXISTS fact_income_distribution_snapshot (
    income_dist_id           BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    snapshot_date            DATE NOT NULL,
    time_key                 INTEGER NOT NULL,
    region_code              VARCHAR(32) NOT NULL,
    org_code                 VARCHAR(64) NOT NULL,
    item_code                VARCHAR(32) NOT NULL,
    item_name                TEXT NOT NULL,
    line_no                  INTEGER,
    amount                   NUMERIC(20,2) NOT NULL DEFAULT 0,
    created_at               TIMESTAMPTZ NOT NULL DEFAULT now(),
    CONSTRAINT uq_income_dist UNIQUE (snapshot_date, org_code, item_code),
    CONSTRAINT fk_income_dist_time FOREIGN KEY (time_key) REFERENCES dim_time(time_key),
    CONSTRAINT fk_income_dist_region FOREIGN KEY (region_code) REFERENCES dim_region(region_code),
    CONSTRAINT fk_income_dist_org FOREIGN KEY (org_code) REFERENCES dim_org(org_code)
);

CREATE INDEX IF NOT EXISTS idx_income_dist_region_date ON fact_income_distribution_snapshot(region_code, snapshot_date);

-- =========================
-- Other submodule facts
-- =========================

CREATE TABLE IF NOT EXISTS fact_asset_summary_monthly (
    asset_fact_id            BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    period_month             DATE NOT NULL,
    region_code              VARCHAR(32) NOT NULL,
    org_code                 VARCHAR(64) NOT NULL,
    asset_total_value        NUMERIC(20,2) NOT NULL DEFAULT 0,
    operating_asset_value    NUMERIC(20,2) NOT NULL DEFAULT 0,
    non_operating_value      NUMERIC(20,2) NOT NULL DEFAULT 0,
    created_at               TIMESTAMPTZ NOT NULL DEFAULT now(),
    CONSTRAINT uq_asset_month_org UNIQUE (period_month, org_code)
);

CREATE TABLE IF NOT EXISTS fact_resource_summary_monthly (
    resource_fact_id         BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    period_month             DATE NOT NULL,
    region_code              VARCHAR(32) NOT NULL,
    org_code                 VARCHAR(64) NOT NULL,
    agri_land_area           NUMERIC(20,4) NOT NULL DEFAULT 0,
    construction_land_area   NUMERIC(20,4) NOT NULL DEFAULT 0,
    unused_land_area         NUMERIC(20,4) NOT NULL DEFAULT 0,
    created_at               TIMESTAMPTZ NOT NULL DEFAULT now(),
    CONSTRAINT uq_resource_month_org UNIQUE (period_month, org_code)
);

CREATE TABLE IF NOT EXISTS fact_contract_summary_monthly (
    contract_fact_id         BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    period_month             DATE NOT NULL,
    region_code              VARCHAR(32) NOT NULL,
    org_code                 VARCHAR(64) NOT NULL,
    contract_type            VARCHAR(32) NOT NULL,
    contract_count           INTEGER NOT NULL DEFAULT 0,
    contract_amount          NUMERIC(20,2) NOT NULL DEFAULT 0,
    receivable_current       NUMERIC(20,2) NOT NULL DEFAULT 0,
    payable_current          NUMERIC(20,2) NOT NULL DEFAULT 0,
    receivable_cumulative    NUMERIC(20,2) NOT NULL DEFAULT 0,
    payable_cumulative       NUMERIC(20,2) NOT NULL DEFAULT 0,
    created_at               TIMESTAMPTZ NOT NULL DEFAULT now(),
    CONSTRAINT uq_contract_month_org_type UNIQUE (period_month, org_code, contract_type)
);

CREATE TABLE IF NOT EXISTS fact_member_summary_monthly (
    member_fact_id           BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    period_month             DATE NOT NULL,
    region_code              VARCHAR(32) NOT NULL,
    org_code                 VARCHAR(64) NOT NULL,
    household_count          INTEGER NOT NULL DEFAULT 0,
    population_count         INTEGER NOT NULL DEFAULT 0,
    member_count             INTEGER NOT NULL DEFAULT 0,
    non_member_count         INTEGER NOT NULL DEFAULT 0,
    female_member_count      INTEGER NOT NULL DEFAULT 0,
    male_member_count        INTEGER NOT NULL DEFAULT 0,
    created_at               TIMESTAMPTZ NOT NULL DEFAULT now(),
    CONSTRAINT uq_member_month_org UNIQUE (period_month, org_code)
);

CREATE TABLE IF NOT EXISTS fact_equity_summary_monthly (
    equity_fact_id           BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    period_month             DATE NOT NULL,
    region_code              VARCHAR(32) NOT NULL,
    org_code                 VARCHAR(64) NOT NULL,
    equity_total_value       NUMERIC(20,2) NOT NULL DEFAULT 0,
    dividend_total_value     NUMERIC(20,2) NOT NULL DEFAULT 0,
    equity_type              VARCHAR(32),
    created_at               TIMESTAMPTZ NOT NULL DEFAULT now(),
    CONSTRAINT uq_equity_month_org_type UNIQUE (period_month, org_code, equity_type)
);

-- =========================
-- Warning supervision
-- =========================

CREATE TABLE IF NOT EXISTS warning_rule (
    rule_code                VARCHAR(32) PRIMARY KEY,
    rule_name                TEXT NOT NULL,
    metric_code              VARCHAR(64) NOT NULL,
    operator                 VARCHAR(8) NOT NULL,
    threshold_value          NUMERIC(20,4) NOT NULL,
    severity                 VARCHAR(16) NOT NULL,
    enabled                  BOOLEAN NOT NULL DEFAULT TRUE,
    created_at               TIMESTAMPTZ NOT NULL DEFAULT now(),
    updated_at               TIMESTAMPTZ NOT NULL DEFAULT now()
);

CREATE TABLE IF NOT EXISTS fact_warning_event (
    warning_event_id         BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    event_time               TIMESTAMPTZ NOT NULL,
    period_month             DATE,
    region_code              VARCHAR(32) NOT NULL,
    org_code                 VARCHAR(64),
    rule_code                VARCHAR(32) NOT NULL,
    metric_code              VARCHAR(64) NOT NULL,
    actual_value             NUMERIC(20,4),
    threshold_value          NUMERIC(20,4),
    severity                 VARCHAR(16) NOT NULL,
    status                   VARCHAR(16) NOT NULL DEFAULT 'open',
    handler                  VARCHAR(64),
    handled_at               TIMESTAMPTZ,
    note                     TEXT,
    created_at               TIMESTAMPTZ NOT NULL DEFAULT now(),
    CONSTRAINT fk_warning_region FOREIGN KEY (region_code) REFERENCES dim_region(region_code),
    CONSTRAINT fk_warning_org FOREIGN KEY (org_code) REFERENCES dim_org(org_code),
    CONSTRAINT fk_warning_rule FOREIGN KEY (rule_code) REFERENCES warning_rule(rule_code)
);

CREATE INDEX IF NOT EXISTS idx_warning_event_region_time ON fact_warning_event(region_code, event_time);
CREATE INDEX IF NOT EXISTS idx_warning_event_status ON fact_warning_event(status);

-- =========================
-- Materialized views for finance one-map
-- =========================

CREATE MATERIALIZED VIEW IF NOT EXISTS mv_finance_overview_monthly AS
SELECT
    f.period_month,
    f.region_code,
    COUNT(DISTINCT CASE WHEN r.region_level = 2 THEN r.region_code END) AS county_cnt,
    COUNT(DISTINCT CASE WHEN r.region_level = 3 THEN r.region_code END) AS town_cnt,
    COUNT(DISTINCT f.org_code) AS village_org_cnt,
    COUNT(DISTINCT CASE WHEN f.is_closed = FALSE THEN f.org_code END) AS unclosed_org_cnt,
    COUNT(DISTINCT CASE WHEN f.is_account_set_created = FALSE THEN f.org_code END) AS account_set_missing_cnt
FROM fact_village_finance_monthly f
LEFT JOIN dim_region r ON r.region_code = f.region_code
GROUP BY f.period_month, f.region_code;

CREATE INDEX IF NOT EXISTS idx_mv_finance_overview_month_region
    ON mv_finance_overview_monthly(period_month, region_code);

CREATE MATERIALIZED VIEW IF NOT EXISTS mv_finance_income_band_summary AS
SELECT
    period_month,
    region_code,
    COUNT(*) AS org_total,
    COUNT(*) FILTER (WHERE total_income >= 50000)  AS above_50k_cnt,
    COUNT(*) FILTER (WHERE total_income >= 100000) AS above_100k_cnt,
    COUNT(*) FILTER (WHERE total_income >= 200000) AS above_200k_cnt,
    COUNT(*) FILTER (WHERE total_income < 50000)   AS below_50k_cnt,
    COUNT(*) FILTER (WHERE total_income < 100000)  AS below_100k_cnt,
    COUNT(*) FILTER (WHERE total_income < 200000)  AS below_200k_cnt,
    ROUND(COUNT(*) FILTER (WHERE total_income >= 50000)::NUMERIC / NULLIF(COUNT(*),0), 4)  AS above_50k_ratio,
    ROUND(COUNT(*) FILTER (WHERE total_income >= 100000)::NUMERIC / NULLIF(COUNT(*),0), 4) AS above_100k_ratio,
    ROUND(COUNT(*) FILTER (WHERE total_income >= 200000)::NUMERIC / NULLIF(COUNT(*),0), 4) AS above_200k_ratio
FROM fact_village_finance_monthly
GROUP BY period_month, region_code;

CREATE INDEX IF NOT EXISTS idx_mv_income_band_month_region
    ON mv_finance_income_band_summary(period_month, region_code);

-- Refresh helpers
CREATE OR REPLACE FUNCTION fn_refresh_finance_views() RETURNS VOID AS $$
BEGIN
    REFRESH MATERIALIZED VIEW mv_finance_overview_monthly;
    REFRESH MATERIALIZED VIEW mv_finance_income_band_summary;
END;
$$ LANGUAGE plpgsql;
