# Mart Models

## Overview
The Mart Models directory contains final analytical tables optimized for reporting, business intelligence, and visualization. These models aggregate core data into structured, performant datasets designed for direct consumption.

Mart models are structured to:
- **Summarize key business metrics** such as spend, quantity purchased, and user behavior.
- **Optimize for performance** by reducing joins and applying pre-aggregations.
- **Support direct querying** for dashboards and business reports.

---

## Directory Structure
```
4-Mart-Models/
│-- DDL/                   # Schema definitions for mart tables
│   ├── mart_create_brand_metrics.sql
│-- DML/                   # Insert/update transformations
│   ├── mart_insert_brand_metrics.sql
│-- DOC/                   # Data dictionary and documentation
│   ├── mart_data_dictionary_brand_metrics.csv
│-- ERD/                   # Entity relationship diagrams
│   ├── Mart_ERD.html
│   ├── Mart_ERD.svg
│-- mart.sh                # Execution script to run DDL & DML
│-- README.md              # Documentation for the mart layer
```

---

## Execution Order
Mart transformations should follow this execution order:

1. **Create Tables (DDL)**  
   Execute the table creation scripts from `DDL/` to define schemas before inserting data.
   ```bash
   PGPASSWORD='fetchpass' psql -U fetchuser -d fetchdb -h 127.0.0.1 -f DDL/mart_create_brand_metrics.sql
   ```

2. **Insert Transformed Data (DML)**  
   Populate mart tables using insert scripts from `DML/`.
   ```bash
   PGPASSWORD='fetchpass' psql -U fetchuser -d fetchdb -h 127.0.0.1 -f DML/mart_insert_brand_metrics.sql
   ```

Alternatively, run the entire process via:
```bash
bash mart.sh
```

---

## Schema Design Principles
- **Pre-aggregated Metrics:** Mart tables store rolled-up data at a useful level of granularity.
- **Performance Optimization:** Tables are designed for fast analytical queries.
- **Consistent Reporting:** Data structures ensure consistency across business reporting.
- **Time-based Tracking:** Key metrics are organized by time dimensions such as month and year.

---

## Documentation
Each table is documented in the `DOC/` folder with data dictionaries in CSV format.
- **Columns & Data Types**
- **Business Definitions**
- **Constraints & Indexes**

Example CSV format:
```csv
"Column Name","Data Type","Description","Constraints"
"brand_code","TEXT","Unique brand identifier","PRIMARY KEY"
"year","INTEGER","Purchase year","Not Null"
"month","INTEGER","Purchase month","Not Null"
"total_spend","NUMERIC(12,2)","Total amount spent","None"
```

---
