# Intermediate Models

## Overview
The **Intermediate Models** directory contains SQL scripts that transform cleaned staging data into structured, normalized tables. This stage applies business logic, standardization, and relational integrity to prepare data for analytical modeling.

Intermediate models refine staging data by:
- **Ensuring 2NF normalization** (each non-key attribute fully depends on the primary key).
- **Applying business transformations** (e.g., calculated fields, data standardization).
- **Structuring relational data** (e.g., linking tables via foreign keys, resolving composite dependencies).
- **Filtering and deduplicating data**.

These models serve as the foundation for the Core Models, which define analytical fact and dimension tables.

---
## Directory Structure
```
2-Intermediate-Models/
│-- DDL/                   # Schema definitions for intermediate tables
│   ├── int_create_brands.sql
│   ├── int_create_receipt_items.sql
│   ├── int_create_receipt_order.sql
│   ├── int_create_users.sql
│-- DML/                   # Insert/update transformations
│   ├── int_insert_brands.sql
│   ├── int_insert_receipt_items.sql
│   ├── int_insert_receipt_order.sql
│   ├── int_insert_users.sql
│-- DOC/                   # Data dictionary and documentation
│   ├── int_data_dictionary_brands.csv
│   ├── int_data_dictionary_receipt_items.csv
│   ├── int_data_dictionary_receipt_order.csv
│   ├── int_data_dictionary_users.csv
│-- Explore.sql            # Query exploration file for validation
│-- Intermediate.sh        # Execution script to run DDL & DML
```

---
## Execution Order
Intermediate transformations should follow this execution order:

1. **Create Tables (DDL)**  
   Execute the table creation scripts from `DDL/` to define schemas before inserting data.
   ```bash
   PGPASSWORD='fetchpass' psql -U fetchuser -d fetchdb -h 127.0.0.1 -f DDL/int_create_users.sql
   PGPASSWORD='fetchpass' psql -U fetchuser -d fetchdb -h 127.0.0.1 -f DDL/int_create_brands.sql
   ```

2. **Insert Transformed Data (DML)**  
   Populate intermediate tables using insert scripts from `DML/`.
   ```bash
   PGPASSWORD='fetchpass' psql -U fetchuser -d fetchdb -h 127.0.0.1 -f DML/int_insert_users.sql
   PGPASSWORD='fetchpass' psql -U fetchuser -d fetchdb -h 127.0.0.1 -f DML/int_insert_receipt_order.sql
   ```

Alternatively, run the entire process via:
```bash
bash Intermediate.sh
```

---
## Schema Design Principles
- **Ensuring 2NF Structure:** Every non-key attribute must fully depend on the primary key.
- **Referential Integrity:** Establish foreign key relationships between tables.
- **Tracking Modifications:** `system_modify_date` columns capture data update timestamps.
- **Deduplication Handling:** ON CONFLICT rules ensure primary keys enforce uniqueness.

---
## Documentation
Each table is documented in the `DOC/` folder with data dictionaries in CSV format.
- **Columns & Data Types**
- **Business Definitions**
- **Constraints & Indexes**
- **Source mappings from staging tables**

Example CSV format:
```csv
"Column Name","Data Type","Description","Constraints"
"user_id","TEXT","Unique identifier for the user","PRIMARY KEY"
"create_date","TIMESTAMP","Date the user was created","None"
```

---
