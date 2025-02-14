
# Staging Models

## Overview
This folder contains staging models. The staging layer is responsible for:
- Extracting and standardizing raw data from source tables.
- Applying minimal transformations such as type conversions and deduplication.
- Preparing structured data for further processing in the intermediate layer.

## Folder Structure
```
1-Staging-Models/
│── DDL/                        # Table definitions for staging
│   ├── stg_create_brands.sql
│   ├── stg_create_receipt_items.sql
│   ├── stg_create_receipt_order.sql
│   ├── stg_create_users.sql
│── DML/                        # Insert statements for staging
│   ├── stg_insert_brands.sql
│   ├── stg_insert_receipt_items.sql
│   ├── stg_insert_receipt_order.sql
│   ├── stg_insert_users.sql
│── run_staging_queries.sh      # Shell script to execute all SQL scripts
│── Explore.sh                  # Shell script for data exploration
│── Explore.sql                 # SQL queries for data validation
```

## Staging Process

### Create Tables (DDL)
- These DDL scripts define the staging tables.
- These tables hold raw but lightly structured data.
- Scripts use `ON CONFLICT DO NOTHING` to prevent duplicate inserts.

### Insert Data (DML)
- These DML scripts populate the staging tables from the source data.
- These scripts conduct light cleaning in the form of type casting.
- These scripts must be executed before data insertion.

### Execute Queries
- Runs all DDL scripts first to create tables.
- Runs all DML scripts after to insert data.
- Execute with:
  ```sh
  bash Staging.sh
  ```
