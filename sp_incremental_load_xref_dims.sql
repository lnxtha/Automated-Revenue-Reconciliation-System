USE [database_name]
GO
/****** Object:  StoredProcedure [adm].[sp_incremental_load_xref_dims]    Script Date: 8/17/2025 3:58:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER   PROCEDURE [adm].[sp_incremental_load_xref_dims]
AS
BEGIN
    SET NOCOUNT ON;

	IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[audit_log]') AND type in (N'U'))
	CREATE TABLE [dbo].[audit_log](
	[Id] INT IDENTITY(1,1) PRIMARY KEY,
	[Process] VARCHAR(100) NULL,
	[Table] VARCHAR(100) NULL,
	[Records_inserted] INT NULL,
	[Records_updated] INT NULL,
	[Status] VARCHAR(100),
	[Dated] DATETIME NULL
	);

    DECLARE @SummaryOfChanges TABLE(TableName VARCHAR(50), Change VARCHAR(20));

    ---------------------------------------------------------
    -- Product Crosswalk
    ---------------------------------------------------------
    MERGE xref.map_product_xwalk AS TARGET
    USING (SELECT * FROM stg.map_product_xwalk) AS SOURCE
    ON (TARGET.erp_system = SOURCE.erp_system AND TARGET.erp_sku = SOURCE.erp_sku AND TARGET.start_date = SOURCE.start_date)
    WHEN MATCHED AND HASHBYTES('SHA1',
        UPPER(CONCAT_WS('|', TARGET.erp_system, TARGET.erp_sku, TARGET.conformed_sku, TARGET.start_date, TARGET.end_date)))
        <> HASHBYTES('SHA1',
        UPPER(CONCAT_WS('|', SOURCE.erp_system, SOURCE.erp_sku, SOURCE.conformed_sku, SOURCE.start_date, SOURCE.end_date)))
    THEN UPDATE SET
        TARGET.conformed_sku = SOURCE.conformed_sku,
        TARGET.end_date      = SOURCE.end_date
    WHEN NOT MATCHED BY TARGET
    THEN INSERT (erp_system, erp_sku, conformed_sku, start_date, end_date)
         VALUES (SOURCE.erp_system, SOURCE.erp_sku, SOURCE.conformed_sku, SOURCE.start_date, SOURCE.end_date)
    OUTPUT 'map_product_xwalk', $action INTO @SummaryOfChanges;

    ---------------------------------------------------------
    -- Customer Crosswalk
    ---------------------------------------------------------
    MERGE xref.map_customer_xwalk AS TARGET
    USING (SELECT * FROM stg.map_customer_xwalk) AS SOURCE
    ON (TARGET.erp_system = SOURCE.erp_system AND TARGET.erp_customer_code = SOURCE.erp_customer_code AND TARGET.start_date = SOURCE.start_date)
    WHEN MATCHED AND HASHBYTES('SHA1',
        UPPER(CONCAT_WS('|', TARGET.erp_system, TARGET.erp_customer_code, TARGET.conformed_customer, TARGET.start_date, TARGET.end_date)))
        <> HASHBYTES('SHA1',
        UPPER(CONCAT_WS('|', SOURCE.erp_system, SOURCE.erp_customer_code, SOURCE.conformed_customer, SOURCE.start_date, SOURCE.end_date)))
    THEN UPDATE SET
        TARGET.conformed_customer = SOURCE.conformed_customer,
        TARGET.end_date           = SOURCE.end_date
    WHEN NOT MATCHED BY TARGET
    THEN INSERT (erp_system, erp_customer_code, conformed_customer, start_date, end_date)
         VALUES (SOURCE.erp_system, SOURCE.erp_customer_code, SOURCE.conformed_customer, SOURCE.start_date, SOURCE.end_date)
    OUTPUT 'map_customer_xwalk', $action INTO @SummaryOfChanges;

    ---------------------------------------------------------
    -- Location Crosswalk
    ---------------------------------------------------------
    MERGE xref.map_location_xwalk AS TARGET
    USING (SELECT * FROM stg.map_location_xwalk) AS SOURCE
    ON (TARGET.erp_system = SOURCE.erp_system AND TARGET.erp_location_code = SOURCE.erp_location_code AND TARGET.start_date = SOURCE.start_date)
    WHEN MATCHED AND HASHBYTES('SHA1',
        UPPER(CONCAT_WS('|', TARGET.erp_system, TARGET.erp_location_code, TARGET.conformed_location, TARGET.start_date, TARGET.end_date)))
        <> HASHBYTES('SHA1',
        UPPER(CONCAT_WS('|', SOURCE.erp_system, SOURCE.erp_location_code, SOURCE.conformed_location, SOURCE.start_date, SOURCE.end_date)))
    THEN UPDATE SET
        TARGET.conformed_location = SOURCE.conformed_location,
        TARGET.end_date           = SOURCE.end_date
    WHEN NOT MATCHED BY TARGET
    THEN INSERT (erp_system, erp_location_code, conformed_location, start_date, end_date)
         VALUES (SOURCE.erp_system, SOURCE.erp_location_code, SOURCE.conformed_location, SOURCE.start_date, SOURCE.end_date)
    OUTPUT 'map_location_xwalk', $action INTO @SummaryOfChanges;

    ---------------------------------------------------------
    -- GL Account Crosswalk
    ---------------------------------------------------------
    MERGE xref.map_gl_account_xwalk AS TARGET
    USING (SELECT * FROM stg.map_gl_account_xwalk) AS SOURCE
    ON (TARGET.erp_system = SOURCE.erp_system AND TARGET.erp_account = SOURCE.erp_account)
    WHEN MATCHED AND HASHBYTES('SHA1',
        UPPER(CONCAT_WS('|', TARGET.erp_system, TARGET.erp_account, TARGET.coa_account)))
        <> HASHBYTES('SHA1',
        UPPER(CONCAT_WS('|', SOURCE.erp_system, SOURCE.erp_account, SOURCE.coa_account)))
    THEN UPDATE SET
        TARGET.coa_account = SOURCE.coa_account
    WHEN NOT MATCHED BY TARGET
    THEN INSERT (erp_system, erp_account, coa_account)
         VALUES (SOURCE.erp_system, SOURCE.erp_account, SOURCE.coa_account)
    OUTPUT 'map_gl_account_xwalk', $action INTO @SummaryOfChanges;

    ---------------------------------------------------------
    -- dim_product
    ---------------------------------------------------------
    MERGE dw.dim_product AS TARGET
    USING (SELECT * FROM stg.dim_product) AS SOURCE
    ON (TARGET.sku = SOURCE.sku)
    WHEN MATCHED AND HASHBYTES('SHA1',
        UPPER(CONCAT_WS('|', TARGET.sku, TARGET.product_name, TARGET.category, TARGET.brand, TARGET.uom)))
        <> HASHBYTES('SHA1',
        UPPER(CONCAT_WS('|', SOURCE.sku, SOURCE.product_name, SOURCE.category, SOURCE.brand, SOURCE.uom)))
    THEN UPDATE SET
        TARGET.product_name = SOURCE.product_name,
        TARGET.category     = SOURCE.category,
        TARGET.brand        = SOURCE.brand,
        TARGET.uom          = SOURCE.uom
    WHEN NOT MATCHED BY TARGET
    THEN INSERT (sku, product_name, category, brand, uom)
         VALUES (SOURCE.sku, SOURCE.product_name, SOURCE.category, SOURCE.brand, SOURCE.uom)
    OUTPUT 'dim_product', $action INTO @SummaryOfChanges;

    ---------------------------------------------------------
    -- dim_customer
    ---------------------------------------------------------
    MERGE dw.dim_customer AS TARGET
    USING (SELECT * FROM stg.dim_customer) AS SOURCE
    ON (TARGET.customer_id = SOURCE.customer_id)
    WHEN MATCHED AND HASHBYTES('SHA1',
        UPPER(CONCAT_WS('|', TARGET.customer_id, TARGET.customer_name, TARGET.tier, TARGET.channel)))
        <> HASHBYTES('SHA1',
        UPPER(CONCAT_WS('|', SOURCE.customer_id, SOURCE.customer_name, SOURCE.tier, SOURCE.channel)))
    THEN UPDATE SET
        TARGET.customer_name = SOURCE.customer_name,
        TARGET.tier          = SOURCE.tier,
        TARGET.channel       = SOURCE.channel
    WHEN NOT MATCHED BY TARGET
    THEN INSERT (customer_id, customer_name, tier, channel)
         VALUES (SOURCE.customer_id, SOURCE.customer_name, SOURCE.tier, SOURCE.channel)
    OUTPUT 'dim_customer', $action INTO @SummaryOfChanges;

    ---------------------------------------------------------
    -- dim_location
    ---------------------------------------------------------
    MERGE dw.dim_location AS TARGET
    USING (SELECT * FROM stg.dim_location) AS SOURCE
    ON (TARGET.location_id = SOURCE.location_id)
    WHEN MATCHED AND HASHBYTES('SHA1',
        UPPER(CONCAT_WS('|', TARGET.location_id, TARGET.region)))
        <> HASHBYTES('SHA1',
        UPPER(CONCAT_WS('|', SOURCE.location_id, SOURCE.region)))
    THEN UPDATE SET
        TARGET.region = SOURCE.region
    WHEN NOT MATCHED BY TARGET
    THEN INSERT (location_id, region)
         VALUES (SOURCE.location_id, SOURCE.region)
    OUTPUT 'dim_location', $action INTO @SummaryOfChanges;

    ---------------------------------------------------------
    -- dim_gl_account
    ---------------------------------------------------------
    MERGE dw.dim_gl_account AS TARGET
    USING (SELECT * FROM stg.dim_gl_account) AS SOURCE
    ON (TARGET.coa_account = SOURCE.coa_account)
    WHEN MATCHED AND HASHBYTES('SHA1',
        UPPER(CONCAT_WS('|', TARGET.coa_account, TARGET.description)))
        <> HASHBYTES('SHA1',
        UPPER(CONCAT_WS('|', SOURCE.coa_account, SOURCE.description)))
    THEN UPDATE SET
        TARGET.description = SOURCE.description
    WHEN NOT MATCHED BY TARGET
    THEN INSERT (coa_account, description)
         VALUES (SOURCE.coa_account, SOURCE.description)
    OUTPUT 'dim_gl_account', $action INTO @SummaryOfChanges;

    ---------------------------------------------------------
    -- dim_fx_rates
    ---------------------------------------------------------
    MERGE dw.dim_fx_rates AS TARGET
    USING (SELECT * FROM stg.dim_fx_rates) AS SOURCE
    ON (TARGET.[date] = SOURCE.[date] AND TARGET.from_currency = SOURCE.from_currency AND TARGET.to_currency = SOURCE.to_currency)
    WHEN MATCHED AND TARGET.rate <> SOURCE.rate
    THEN UPDATE SET TARGET.rate = SOURCE.rate
    WHEN NOT MATCHED BY TARGET
    THEN INSERT ([date], from_currency, to_currency, rate)
         VALUES (SOURCE.[date], SOURCE.from_currency, SOURCE.to_currency, SOURCE.rate)
    OUTPUT 'dim_fx_rates', $action INTO @SummaryOfChanges;

    ---------------------------------------------------------
    -- dim_date
    ---------------------------------------------------------
    MERGE dw.dim_date AS TARGET
    USING (SELECT * FROM stg.dim_date) AS SOURCE
    ON (TARGET.[date] = SOURCE.[date])
    WHEN MATCHED AND HASHBYTES('SHA1',
        UPPER(CONCAT_WS('|', TARGET.[date], TARGET.[year], TARGET.[month], TARGET.[day],
                               TARGET.[month_name], TARGET.[weekday_name], TARGET.is_month_end)))
        <> HASHBYTES('SHA1',
        UPPER(CONCAT_WS('|', SOURCE.[date], SOURCE.[year], SOURCE.[month], SOURCE.[day],
                               SOURCE.[month_name], SOURCE.[weekday_name], SOURCE.is_month_end)))
    THEN UPDATE SET
        TARGET.[year]         = SOURCE.[year],
        TARGET.[month]        = SOURCE.[month],
        TARGET.[day]          = SOURCE.[day],
        TARGET.[month_name]   = SOURCE.[month_name],
        TARGET.[weekday_name] = SOURCE.[weekday_name],
        TARGET.is_month_end   = SOURCE.is_month_end
    WHEN NOT MATCHED BY TARGET
    THEN INSERT ([date], [year], [month], [day], [month_name], [weekday_name], is_month_end)
         VALUES (SOURCE.[date], SOURCE.[year], SOURCE.[month], SOURCE.[day], SOURCE.[month_name], SOURCE.[weekday_name], SOURCE.is_month_end)
    OUTPUT 'dim_date', $action INTO @SummaryOfChanges;

    ---------------------------------------------------------
    -- Final Change Summary
    ---------------------------------------------------------
    SELECT TableName, Change, COUNT(*) AS CountPerChange
    FROM @SummaryOfChanges
    GROUP BY TableName, Change;

	INSERT INTO dbo.audit_log (Process, [Table], Records_inserted, Records_updated, Status, Dated)
    SELECT 
        'Incremental data load - xref/dim',
        TableName,
        SUM(CASE WHEN Change = 'INSERT' THEN 1 ELSE 0 END) AS Records_inserted,
        SUM(CASE WHEN Change = 'UPDATE' THEN 1 ELSE 0 END) AS Records_updated,
        'SP Completed',
        GETDATE()
    FROM @SummaryOfChanges
    GROUP BY TableName;
END
