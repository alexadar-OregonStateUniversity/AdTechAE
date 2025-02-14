# Analytic Engineering

## Overview
The Analytic Engineering directory contains structured SQL models that transform raw data into optimized analytical tables. This pipeline follows a layered approach using dbt-like modeling, ensuring modular, scalable, and reliable data transformations.

The analytic engineering workflow consists of four stages:
1. **Staging Models (stg_*)**: Extract, clean, and standardize raw data.
2. **Intermediate Models (int_*)**: Apply business logic and normalize data.
3. **Core Models (core_*)**: Structure fact and dimension tables for analysis.
4. **Mart Models (mart_*)**: Aggregate data for reporting and business intelligence.

This directory serves as the foundation for advanced analytics, reporting, and data-driven decision-making.

---

## Directory Structure
```
Analytic-Engineering/
│-- 1-Staging-Models/         # Raw data cleanup and preparation
│-- 2-Intermediate-Models/    # Business transformations and normalization
│-- 3-Core-Models/            # Fact and dimension modeling
│-- 4-Mart-Models/            # Aggregated reporting and KPIs
│-- execution.sh              # Runs all model transformations
│-- validation_queries.sql    # Queries to validate transformations
│-- README.md                 # Documentation for this process
```

---

## Staging Models
The Staging Layer prepares raw data for transformation:
- Renames columns and ensures consistent data types.
- Filters out duplicates and incorrect records.
- Preserves source data integrity while making it queryable.

Execution:
```bash
bash staging.sh
```

---

## Intermediate Models
The Intermediate Layer structures data by:
- Removing partial dependencies (2NF compliance).
- Standardizing values and normalizing data relationships.
- Ensuring referential integrity between staging tables.

Execution:
```bash
bash intermediate.sh
```

---

## Core Models
The Core Layer creates analytical fact and dimension tables by:
- Applying 3NF/BCNF normalization.
- Defining primary keys and relationships.
- Storing business-critical metrics.

Execution:
```bash
bash core.sh
```

---

## Mart Models  
The Mart Layer aggregates and computes KPIs for business intelligence:  
- Precomputes key business metrics.  
- Optimizes data for reporting and visualization.  
- Provides analysts with ready-to-use datasets.  

Execution:  
```bash
bash mart.sh
```
---

## Execution Process
To run all transformations in order:

```bash
bash staging.sh
bash intermediate.sh
bash core.sh
bash mart.sh
```

