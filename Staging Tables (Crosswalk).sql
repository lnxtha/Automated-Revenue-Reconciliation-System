-- Crosswalks
IF OBJECT_ID('xref.map_product_xwalk') IS NOT NULL
	DROP TABLE xref.map_product_xwalk;
CREATE TABLE xref.map_product_xwalk (
  erp_system     VARCHAR(10),
  erp_sku        VARCHAR(50),
  conformed_sku  VARCHAR(50),
  start_date     DATE,
  end_date       DATE,
  CONSTRAINT PK_xref_map_product PRIMARY KEY (erp_system, erp_sku, start_date),
    load_ts            DATETIME2(3)   NOT NULL 
        CONSTRAINT DF_map_product_xwalk_load_ts DEFAULT (SYSUTCDATETIME())
);

IF OBJECT_ID('xref.map_customer_xwalk') IS NOT NULL
	DROP TABLE xref.map_customer_xwalk;
CREATE TABLE xref.map_customer_xwalk (
  erp_system          VARCHAR(10),
  erp_customer_code   VARCHAR(50),
  conformed_customer  VARCHAR(50),
  start_date          DATE,
  end_date            DATE,
  CONSTRAINT PK_xref_map_customer PRIMARY KEY (erp_system, erp_customer_code, start_date),
    load_ts            DATETIME2(3)   NOT NULL 
        CONSTRAINT DF_map_customer_xwalk_load_ts DEFAULT (SYSUTCDATETIME())
);

IF OBJECT_ID('xref.map_location_xwalk') IS NOT NULL
	DROP TABLE xref.map_location_xwalk;
CREATE TABLE xref.map_location_xwalk (
  erp_system          VARCHAR(10),
  erp_location_code   VARCHAR(50),
  conformed_location  VARCHAR(50),
  start_date          DATE,
  end_date            DATE,
  CONSTRAINT PK_xref_map_location PRIMARY KEY (erp_system, erp_location_code, start_date),
    load_ts            DATETIME2(3)   NOT NULL 
        CONSTRAINT DF_map_location_xwalk_load_ts DEFAULT (SYSUTCDATETIME())
);

IF OBJECT_ID('xref.map_gl_account_xwalk') IS NOT NULL
	DROP TABLE xref.map_gl_account_xwalk;
CREATE TABLE xref.map_gl_account_xwalk (
  erp_system   VARCHAR(10),
  erp_account  VARCHAR(20),
  coa_account  VARCHAR(20),
  CONSTRAINT PK_xref_map_gl_account PRIMARY KEY (erp_system, erp_account),
    load_ts            DATETIME2(3)   NOT NULL 
        CONSTRAINT DF_map_gl_account_xwalk_load_ts DEFAULT (SYSUTCDATETIME())
);
GO




-- stg
-- Crosswalks
-- Crosswalks
IF OBJECT_ID('stg.map_product_xwalk') IS NOT NULL
	DROP TABLE stg.map_product_xwalk;
CREATE TABLE stg.map_product_xwalk (
  erp_system     VARCHAR(10),
  erp_sku        VARCHAR(50),
  conformed_sku  VARCHAR(50),
  start_date     DATE,
  end_date       DATE,
  CONSTRAINT PK_stg_map_product PRIMARY KEY (erp_system, erp_sku, start_date),
    load_ts            DATETIME2(3)   NOT NULL 
        CONSTRAINT DF_map_product_xwalk_load_ts DEFAULT (SYSUTCDATETIME())
);

IF OBJECT_ID('stg.map_customer_xwalk') IS NOT NULL
	DROP TABLE stg.map_customer_xwalk;
CREATE TABLE stg.map_customer_xwalk (
  erp_system          VARCHAR(10),
  erp_customer_code   VARCHAR(50),
  conformed_customer  VARCHAR(50),
  start_date          DATE,
  end_date            DATE,
  CONSTRAINT PK_stg_map_customer PRIMARY KEY (erp_system, erp_customer_code, start_date),
    load_ts            DATETIME2(3)   NOT NULL 
        CONSTRAINT DF_map_customer_xwalk_load_ts DEFAULT (SYSUTCDATETIME())
);

IF OBJECT_ID('stg.map_location_xwalk') IS NOT NULL
	DROP TABLE stg.map_location_xwalk;
CREATE TABLE stg.map_location_xwalk (
  erp_system          VARCHAR(10),
  erp_location_code   VARCHAR(50),
  conformed_location  VARCHAR(50),
  start_date          DATE,
  end_date            DATE,
  CONSTRAINT PK_stg_map_location PRIMARY KEY (erp_system, erp_location_code, start_date),
    load_ts            DATETIME2(3)   NOT NULL 
        CONSTRAINT DF_map_location_xwalk_load_ts DEFAULT (SYSUTCDATETIME())
);

IF OBJECT_ID('stg.map_gl_account_xwalk') IS NOT NULL
	DROP TABLE stg.map_gl_account_xwalk;
CREATE TABLE stg.map_gl_account_xwalk (
  erp_system   VARCHAR(10),
  erp_account  VARCHAR(20),
  coa_account  VARCHAR(20),
  CONSTRAINT PK_stg_map_gl_account PRIMARY KEY (erp_system, erp_account),
    load_ts            DATETIME2(3)   NOT NULL 
        CONSTRAINT DF_map_gl_account_xwalk_load_ts DEFAULT (SYSUTCDATETIME())
);
GO


