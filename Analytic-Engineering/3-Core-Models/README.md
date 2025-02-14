# Core Models

## Overview
The Core Models directory contains the final structured fact and dimension tables, derived from Intermediate Models. These models are fully normalized, optimized for analysis, and serve as the foundation for business intelligence and reporting.

Core models establish:
- **3NF/BCNF normalization** ensuring that all non-key attributes depend only on the primary key.
- **Fact and dimension tables** for analytical reporting.
- **Foreign key relationships** between dimensions and facts.
- **Data integrity, indexing, and optimized storage**.

The Core Models are the primary data source for aggregations and dashboard visualizations.

---

## Directory Structure
```
3-Core-Models/
│-- DDL/                   # Schema Definitions For Tables
│   ├── core_create_1_categories.sql
│   ├── core_create_2_users.sql
│   ├── core_create_3_items.sql
│   ├── core_create_4_brands.sql
│   ├── core_create_5_receipt_order.sql
│   ├── core_create_6_receipt_items.sql
│-- DML/                   # Insert/Update Transformations
│   ├── core_insert_1_categories.sql
│   ├── core_insert_2_users.sql
│   ├── core_insert_3_items.sql
│   ├── core_insert_4_brands.sql
│   ├── core_insert_5_receipt_order.sql
│   ├── core_insert_6_receipt_items.sql
│-- DOC/                   # Data Dictionary Documentation
│   ├── core_data_dictionary_brands.csv
│   ├── core_data_dictionary_categories.csv
│   ├── core_data_dictionary_items.csv
│   ├── core_data_dictionary_receipt_items.csv
│   ├── core_data_dictionary_receipt_order.csv
│   ├── core_data_dictionary_users.csv
│-- ERD/                    # Entity-Relationship Diagrams
│-- ├── FetchER_1.html
│-- ├── FetchER_2.svg
│-- core.sh                # Execution script to run DDL & DML
│-- Explore.sql            # Query exploration file for validation
│-- README.md              # Documentation for this stage

```

---

## Execution Order
To properly create and populate core tables, follow this order:

### 1. **Create Tables (DDL)**
Execute the table creation scripts before inserting data:
```bash
PGPASSWORD='fetchpass' psql -U fetchuser -d fetchdb -h 127.0.0.1 -f DDL/core_create_1_categories.sql
PGPASSWORD='fetchpass' psql -U fetchuser -d fetchdb -h 127.0.0.1 -f DDL/core_create_2_users.sql
```

### 2. **Insert Transformed Data (DML)**
Populate the core tables using insert scripts:
```bash
PGPASSWORD='fetchpass' psql -U fetchuser -d fetchdb -h 127.0.0.1 -f DML/core_insert_1_categories.sql
PGPASSWORD='fetchpass' psql -U fetchuser -d fetchdb -h 127.0.0.1 -f DML/core_insert_5_receipt_order.sql
```

Alternatively, execute all scripts using:
```bash
bash core.sh
```

---

## Schema Design Principles
- **BCNF Structure:** Tables are fully normalized with no transitive dependencies.
- **Fact-Dimension Model:** Establishes clear **dimension** (e.g., users, brands) and **fact** (e.g., transactions, purchases) relationships.
- **Foreign Key Constraints:** Ensure relational integrity.
- **Tracking Modifications:** `system_modify_date` fields log updates.
- **Indexing for Performance:** Optimized for fast queries.

---

## Documentation
Each table’s schema and descriptions are provided in the `DOC/` folder as CSV data dictionaries. 

Example format:
| Column Name   | Data Type    | Description                     | Constraints |
|---------------|--------------|---------------------------------|-------------|
| receipt_id    | TEXT         | Unique identifier for the receipt | PRIMARY KEY |
| total_spent   | NUMERIC(10,2)| Total amount spent on receipt   | None        |


---

## **Entity-Relationship Diagrams**

The `ER-Diagrams/` folder contains:

- `FetchERD_1.html` and `FetchERD_2.svg`: The official ER diagrams representing the database schema, including entity relationships, primary and foreign keys, and structured connections between tables.
- These diagrams visualize the fact and dimension tables, ensuring **clear foreign key relationships and normalization.
- They serve as a structural reference for database integrity, guiding schema design and modifications.
- The `.html` and `.svg` files allow for easy viewing and sharing of the ER diagrams without requiring additional tools.


---
