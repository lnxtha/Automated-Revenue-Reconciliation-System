# Re-run code after reset to generate the README.md file again

readme_content = """# Automated Revenue Reconciliation System  

This project simulates an **enterprise-level BI solution** for a food & beverage company operating multiple plants. The goal is to build a **faster, automated, and more accurate revenue reconciliation system** between multiple ERP systems and the General Ledger (GL).  

## 🚀 Problem Statement  
Finance teams often spend days reconciling sales and revenue data across multiple ERP systems and the General Ledger. Manual processes lead to **timing differences, credit memo mismatches, and journal entry discrepancies**, delaying the month-end close.  

## ✅ Solution  
This project implements an **end-to-end data pipeline** that:  
- Consolidates revenue data from **3 ERP systems** and the **General Ledger**  
- Applies **crosswalk mappings** (products, customers, locations, GL accounts) for conformance  
- Uses **incremental SQL loads (MERGE with hash checks)** for efficient updates  
- Stores unified data in a **centralized data warehouse**  
- Provides a **Power BI dashboard** with drill-downs by product, location, or GL account  
- Automates detection of **manual journal entries, credit memos, and variances**  

## 🛠️ Tech Stack  
- **SQL Server** – staging, xref, and dimensional models  
- **SSIS / Import Wizard** – initial data ingestion from CSVs  
- **T-SQL Stored Procedures** – incremental loads with audit logging  
- **Power BI** – self-service dashboard for finance  
- **GitHub** – version control and collaboration  

## 📊 Key Features  
- Automated revenue reconciliation across ERP and GL  
- Incremental load design using `MERGE` and `HASHBYTES` for change detection  
- Audit logging with counts of inserts/updates  
- Support for foreign exchange (CAD→USD) and date dimensions  
- Power BI dashboard for real-time insights  

## 📂 Dataset  
Includes synthetic but realistic datasets:  
- `erp1_revenue`, `erp2_revenue`, `erp3_revenue`  
- `gl_revenue` (with MJEs, reclasses, and timing differences)  
- Crosswalks: product, customer, location, GL account  
- Dimensions: product, customer, location, GL account, FX, date  

## 🎯 Outcome  
This system enables finance teams to:  
- **Reduce month-end close from days to hours**  
- **Isolate and trace discrepancies** (manual journals, credits, timing)  
- **Gain confidence in financial reporting** through automated reconciliation  
- **Leverage self-service analytics** via a centralized Power BI dashboard  
"""

# Save to README.md
file_path = "/mnt/data/README.md"
with open(file_path, "w") as f:
    f.write(readme_content)

file_path
