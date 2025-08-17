
-- Dimensions (simplified)
IF OBJECT_ID('dw.dim_product') IS NOT NULL
	DROP TABLE dw.dim_product;

CREATE TABLE dw.dim_product (
  sku           VARCHAR(50) PRIMARY KEY,
  product_name  VARCHAR(200) NULL,
  category      VARCHAR(50)  NULL,
  brand         VARCHAR(50)  NULL,
  uom           VARCHAR(10)  NULL,
  load_ts            DATETIME2(3)   NOT NULL 
        CONSTRAINT DF_dim_product_load_ts DEFAULT (SYSUTCDATETIME())
);

IF OBJECT_ID('dw.dim_customer') IS NOT NULL
	DROP TABLE dw.dim_customer;
CREATE TABLE dw.dim_customer (
  customer_id   VARCHAR(50) PRIMARY KEY,
  customer_name VARCHAR(200) NULL,
  tier          VARCHAR(20)  NULL,
  channel       VARCHAR(50)  NULL,
  load_ts            DATETIME2(3)   NOT NULL 
        CONSTRAINT DF_dim_customer_load_ts DEFAULT (SYSUTCDATETIME())
);

IF OBJECT_ID('dw.dim_location') IS NOT NULL
	DROP TABLE dw.dim_location;
CREATE TABLE dw.dim_location (
  location_id VARCHAR(50) PRIMARY KEY,
  region      VARCHAR(50) NULL,
  load_ts            DATETIME2(3)   NOT NULL 
        CONSTRAINT DF_dim_location_load_ts DEFAULT (SYSUTCDATETIME())
);
IF OBJECT_ID('dw.dim_gl_account') IS NOT NULL
	DROP TABLE dw.dim_gl_account;
IF OBJECT_ID('dw.dim_gl_account') IS NULL
CREATE TABLE dw.dim_gl_account (
  coa_account  VARCHAR(20) PRIMARY KEY,
  description  VARCHAR(100) NULL,
  load_ts            DATETIME2(3)   NOT NULL 
        CONSTRAINT DF_dim_gl_account_ts DEFAULT (SYSUTCDATETIME())
);

-- FX (daily CAD->USD)
IF OBJECT_ID('dw.dim_fx_rates') IS NOT NULL
	DROP TABLE dw.dim_fx_rates;
CREATE TABLE dw.dim_fx_rates (
  [date]        DATE,
  from_currency CHAR(3),
  to_currency   CHAR(3),
  rate          DECIMAL(18,6),
  load_ts            DATETIME2(3)   NOT NULL 
        CONSTRAINT DF_dim_fx_rates_ts DEFAULT (SYSUTCDATETIME()),
  CONSTRAINT PK_dim_fx PRIMARY KEY ([date], from_currency, to_currency)
);

-- Date (subset for demo)
IF OBJECT_ID('dw.dim_date') IS NOT NULL
	DROP TABLE dw.dim_date;
CREATE TABLE dw.dim_date (
  [date]        DATE PRIMARY KEY,
  [year]        INT,
  [month]       INT,
  [day]         INT,
  [month_name]  VARCHAR(20),
  [weekday_name]VARCHAR(20),
  is_month_end  BIT,
  load_ts            DATETIME2(3)   NOT NULL 
        CONSTRAINT DF_dim_date_ts DEFAULT (SYSUTCDATETIME())
);
GO

--select * from dw.dim_customer;
--select * from dw.dim_date;
--select * from dw.dim_fx_rates;
--select * from dw.dim_gl_account;
--select * from dw.dim_location;
--select * from dw.dim_product;




-- Dimensions (simplified)
IF OBJECT_ID('stg.dim_product') IS NOT NULL
	DROP TABLE stg.dim_product;

CREATE TABLE stg.dim_product (
  sku           VARCHAR(50) PRIMARY KEY,
  product_name  VARCHAR(200) NULL,
  category      VARCHAR(50)  NULL,
  brand         VARCHAR(50)  NULL,
  uom           VARCHAR(10)  NULL,
  load_ts            DATETIME2(3)   NOT NULL 
        CONSTRAINT DF_dim_product_load_ts DEFAULT (SYSUTCDATETIME())
);

IF OBJECT_ID('stg.dim_customer') IS NOT NULL
	DROP TABLE stg.dim_customer;
CREATE TABLE stg.dim_customer (
  customer_id   VARCHAR(50) PRIMARY KEY,
  customer_name VARCHAR(200) NULL,
  tier          VARCHAR(20)  NULL,
  channel       VARCHAR(50)  NULL,
  load_ts            DATETIME2(3)   NOT NULL 
        CONSTRAINT DF_dim_customer_load_ts DEFAULT (SYSUTCDATETIME())
);

IF OBJECT_ID('stg.dim_location') IS NOT NULL
	DROP TABLE stg.dim_location;
CREATE TABLE stg.dim_location (
  location_id VARCHAR(50) PRIMARY KEY,
  region      VARCHAR(50) NULL,
  load_ts            DATETIME2(3)   NOT NULL 
        CONSTRAINT DF_dim_location_load_ts DEFAULT (SYSUTCDATETIME())
);
IF OBJECT_ID('stg.dim_gl_account') IS NOT NULL
	DROP TABLE stg.dim_gl_account;
IF OBJECT_ID('stg.dim_gl_account') IS NULL
CREATE TABLE stg.dim_gl_account (
  coa_account  VARCHAR(20) PRIMARY KEY,
  description  VARCHAR(100) NULL,
  load_ts            DATETIME2(3)   NOT NULL 
        CONSTRAINT DF_dim_gl_account_ts DEFAULT (SYSUTCDATETIME())
);

-- FX (daily CAD->USD)
IF OBJECT_ID('stg.dim_fx_rates') IS NOT NULL
	DROP TABLE stg.dim_fx_rates;
CREATE TABLE stg.dim_fx_rates (
  [date]        DATE,
  from_currency CHAR(3),
  to_currency   CHAR(3),
  rate          DECIMAL(18,6),
  load_ts            DATETIME2(3)   NOT NULL 
        CONSTRAINT DF_dim_fx_rates_ts DEFAULT (SYSUTCDATETIME()),
  CONSTRAINT PK_dim_fx PRIMARY KEY ([date], from_currency, to_currency)
);

-- Date (subset for demo)
IF OBJECT_ID('stg.dim_date') IS NOT NULL
	DROP TABLE stg.dim_date;
CREATE TABLE stg.dim_date (
  [date]        DATE PRIMARY KEY,
  [year]        INT,
  [month]       INT,
  [day]         INT,
  [month_name]  VARCHAR(20),
  [weekday_name]VARCHAR(20),
  is_month_end  BIT,
  load_ts            DATETIME2(3)   NOT NULL 
        CONSTRAINT DF_dim_date_ts DEFAULT (SYSUTCDATETIME())
);
GO


--select * from stg.dim_customer;
--select * from stg.dim_date;
--select * from stg.dim_fx_rates;
--select * from stg.dim_gl_account;
--select * from stg.dim_location;
--select * from stg.dim_product;