-- Create schemas (idempotent)
IF NOT EXISTS (SELECT 1 FROM sys.schemas WHERE name = 'stg') EXEC('CREATE SCHEMA stg');
IF NOT EXISTS (SELECT 1 FROM sys.schemas WHERE name = 'xref') EXEC('CREATE SCHEMA xref');
IF NOT EXISTS (SELECT 1 FROM sys.schemas WHERE name = 'dw')  EXEC('CREATE SCHEMA dw');
IF NOT EXISTS (SELECT 1 FROM sys.schemas WHERE name = 'adm') EXEC('CREATE SCHEMA adm');
GO


IF OBJECT_ID('stg.erp1_revenue', 'U') IS NOT NULL
    DROP TABLE stg.erp1_revenue;
GO

CREATE TABLE stg.erp1_revenue
(
    erp_doc_id         VARCHAR(50)    NOT NULL,
    erp_doc_type       VARCHAR(20)    NULL,
    erp_post_date      VARCHAR(20)    NULL,  -- store as text instead of DATE
    erp_sku            VARCHAR(50)    NULL,
    erp_customer_code  VARCHAR(50)    NULL,
    erp_location_code  VARCHAR(50)    NULL,
    qty                DECIMAL(18,4)  NULL,
    unit_price         DECIMAL(18,4)  NULL,
    gross_amount       DECIMAL(18,4)  NULL,
    discount_amount    DECIMAL(18,4)  NULL,
    currency_code      VARCHAR(10)    NULL,
    tax_amount         DECIMAL(18,4)  NULL,
    uom                VARCHAR(10)    NULL,
    load_ts            DATETIME2(3)   NOT NULL 
        CONSTRAINT DF_erp1_revenue_load_ts DEFAULT (SYSUTCDATETIME()),
    
    CONSTRAINT PK_erp1_revenue PRIMARY KEY CLUSTERED (erp_doc_id)
);
GO


IF OBJECT_ID('stg.erp2_revenue', 'U') IS NOT NULL
    DROP TABLE dbo.erp2_revenue;
GO

CREATE TABLE stg.erp2_revenue
(
    erp_doc_id         VARCHAR(50)    NOT NULL,
    erp_doc_type       VARCHAR(20)    NULL,
    erp_post_date      VARCHAR(20)    NULL,  -- store as text instead of DATE
    erp_sku            VARCHAR(50)    NULL,
    erp_customer_code  VARCHAR(50)    NULL,
    erp_location_code  VARCHAR(50)    NULL,
    qty                DECIMAL(18,4)  NULL,
    unit_price         DECIMAL(18,4)  NULL,
    gross_amount       DECIMAL(18,4)  NULL,
    discount_amount    DECIMAL(18,4)  NULL,
    currency_code      VARCHAR(10)    NULL,
    tax_amount         DECIMAL(18,4)  NULL,
    uom                VARCHAR(10)    NULL,
    load_ts            DATETIME2(3)   NOT NULL 
        CONSTRAINT DF_erp2_revenue_load_ts DEFAULT (SYSUTCDATETIME()),
    
    CONSTRAINT PK_erp2_revenue PRIMARY KEY CLUSTERED (erp_doc_id)
);
GO


IF OBJECT_ID('stg.erp3_revenue', 'U') IS NOT NULL
    DROP TABLE stg.erp3_revenue;
GO

CREATE TABLE stg.erp3_revenue
(
    erp_doc_id         VARCHAR(50)    NOT NULL,
    erp_doc_type       VARCHAR(20)    NULL,
    erp_post_date      VARCHAR(20)    NULL,  -- store as text instead of DATE
    erp_sku            VARCHAR(50)    NULL,
    erp_customer_code  VARCHAR(50)    NULL,
    erp_location_code  VARCHAR(50)    NULL,
    qty                DECIMAL(18,4)  NULL,
    unit_price         DECIMAL(18,4)  NULL,
    gross_amount       DECIMAL(18,4)  NULL,
    discount_amount    DECIMAL(18,4)  NULL,
    currency_code      VARCHAR(10)    NULL,
    tax_amount         DECIMAL(18,4)  NULL,
    uom                VARCHAR(10)    NULL,
    load_ts            DATETIME2(3)   NOT NULL 
        CONSTRAINT DF_erp3_revenue_load_ts DEFAULT (SYSUTCDATETIME()),
    
    CONSTRAINT PK_erp3_revenue PRIMARY KEY CLUSTERED (erp_doc_id)
);
GO


-- DBO Tables
IF OBJECT_ID('dbo.erp1_revenue', 'U') IS NOT NULL
    DROP TABLE dbo.erp1_revenue;
GO

CREATE TABLE dbo.erp1_revenue
(
    erp_doc_id         VARCHAR(50)    NOT NULL,
    erp_doc_type       VARCHAR(20)    NULL,
    erp_post_date      VARCHAR(20)    NULL,  -- store as text instead of DATE
    erp_sku            VARCHAR(50)    NULL,
    erp_customer_code  VARCHAR(50)    NULL,
    erp_location_code  VARCHAR(50)    NULL,
    qty                DECIMAL(18,4)  NULL,
    unit_price         DECIMAL(18,4)  NULL,
    gross_amount       DECIMAL(18,4)  NULL,
    discount_amount    DECIMAL(18,4)  NULL,
    currency_code      VARCHAR(10)    NULL,
    tax_amount         DECIMAL(18,4)  NULL,
    uom                VARCHAR(10)    NULL,
    load_ts            DATETIME2(3)   NOT NULL 
        CONSTRAINT DF_erp1_revenue_load_ts DEFAULT (SYSUTCDATETIME()),
    
    CONSTRAINT PK_erp1_revenue PRIMARY KEY CLUSTERED (erp_doc_id)
);
GO


IF OBJECT_ID('dbo.erp2_revenue', 'U') IS NOT NULL
    DROP TABLE dbo.erp2_revenue;
GO

CREATE TABLE dbo.erp2_revenue
(
    erp_doc_id         VARCHAR(50)    NOT NULL,
    erp_doc_type       VARCHAR(20)    NULL,
    erp_post_date      VARCHAR(20)    NULL,  -- store as text instead of DATE
    erp_sku            VARCHAR(50)    NULL,
    erp_customer_code  VARCHAR(50)    NULL,
    erp_location_code  VARCHAR(50)    NULL,
    qty                DECIMAL(18,4)  NULL,
    unit_price         DECIMAL(18,4)  NULL,
    gross_amount       DECIMAL(18,4)  NULL,
    discount_amount    DECIMAL(18,4)  NULL,
    currency_code      VARCHAR(10)    NULL,
    tax_amount         DECIMAL(18,4)  NULL,
    uom                VARCHAR(10)    NULL,
    load_ts            DATETIME2(3)   NOT NULL 
        CONSTRAINT DF_erp2_revenue_load_ts DEFAULT (SYSUTCDATETIME()),
    
    CONSTRAINT PK_erp2_revenue PRIMARY KEY CLUSTERED (erp_doc_id)
);
GO


IF OBJECT_ID('dbo.erp3_revenue', 'U') IS NOT NULL
    DROP TABLE dbo.erp3_revenue;
GO

CREATE TABLE dbo.erp3_revenue
(
    erp_doc_id         VARCHAR(50)    NOT NULL,
    erp_doc_type       VARCHAR(20)    NULL,
    erp_post_date      VARCHAR(20)    NULL,  -- store as text instead of DATE
    erp_sku            VARCHAR(50)    NULL,
    erp_customer_code  VARCHAR(50)    NULL,
    erp_location_code  VARCHAR(50)    NULL,
    qty                DECIMAL(18,4)  NULL,
    unit_price         DECIMAL(18,4)  NULL,
    gross_amount       DECIMAL(18,4)  NULL,
    discount_amount    DECIMAL(18,4)  NULL,
    currency_code      VARCHAR(10)    NULL,
    tax_amount         DECIMAL(18,4)  NULL,
    uom                VARCHAR(10)    NULL,
    load_ts            DATETIME2(3)   NOT NULL 
        CONSTRAINT DF_erp3_revenue_load_ts DEFAULT (SYSUTCDATETIME()),
    
    CONSTRAINT PK_erp3_revenue PRIMARY KEY CLUSTERED (erp_doc_id)
);
GO