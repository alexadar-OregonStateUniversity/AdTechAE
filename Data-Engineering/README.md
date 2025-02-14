# Data Engineering Pipeline

## Overview
This directory contains the data engineering pipeline for processing and loading structured data into a PostgreSQL database. The pipeline consists of several stages: data collection, data correction, and data connection. Each stage is organized into subdirectories with corresponding scripts.

## Directory Structure
```
Data-Engineering/
├── 1a-Collection-Code/
│   ├── Collect.sh
├── 1b-Collection-Data/
│   ├── brands.json
│   ├── receipts.json
│   ├── users.json
├── 2a-Correction-Code/
│   ├── Correct.sh
│   ├── FormatJ.py
├── 2b-Correction-Data/
│   ├── brands.jsonl
│   ├── receipts.jsonl
│   ├── users.jsonl
│   ├── brands_paths.txt
│   ├── receipts_paths.txt
│   ├── users_paths.txt
├── 3a-Connection-Code/
│   ├── Connect.sh
│   ├── Users_ETL.py
│   ├── Brands_ETL.py
│   ├── Receipts_ETL.py
│   ├── Users.sql
│   ├── Brands.sql
│   ├── Receipt_Order.sql
│   ├── Receipt_Items.sql
│   ├── Setup.sh
├── 3b-Connection-Data/
│   ├── users.csv
│   ├── brands.csv
│   ├── receipt_order.csv
│   ├── receipt_items.csv
├── README.md
```

## Pipeline Stages

### 1. Data Collection (1a-Collection-Code)
- `Collect.sh`: Downloads and Unzips the raw JSON files from the provided urls.

### 2. Data Correction (2a-Correction-Code)
- `Correct.sh`: Converts JSON files to JSONL format for easy line-by-line processing.
- `FormatJ.py`: Cleans JSONL files and outputs validated JSON files.

### 3. Data Connection (3a-Connection-Code)
- `Connect.sh`: Handles database connection setup and execution of SQL scripts.
- `Setup.sh`: Handles setting up the PostgreSQL database for ease and automation.
- `Users_ETL.py`: Processes user data from JSONL and formats it for database insertion.
- `Brands_ETL.py`: Processes brand data from JSONL and formats it for database insertion.
- `Receipts_ETL.py`: Processes receipt data from JSONL, separating receipt-level and item-level data into CSV files (`receipt_order.csv` and `receipt_items.csv`).

### 4. Database Connection and Loading
- SQL schema definitions for PostgreSQL are located in `3a-Connection-Code/*.sql`.
- Data is loaded into tables using PostgreSQL `\COPY` commands.
- Credentials: `PGPASSWORD='fetchpass' psql -U fetchuser -d fetchdb -h 127.0.0.1`
  ```sql
    Username: "fetchuser"
    Password: "fetchpass"
    Host/URL: 127.0.0.1
    Port No.: 5432
    Database: "fetchdb"
  ```

## Data Flow
1. **Collection** → Downloads data and unzips JSON files.
2. **Correction** → Corrects and Converts JSON to JSONL files.
3. **Connection** → Extracts, Transforms, and Loads into PostgreSQL.

## Database Schema
The database consists of the following tables:
- `Users` → Stores user information.
- `Brands` → Stores brand metadata.
- `Receipt_Order` → Stores high-level receipt transaction details.
- `Receipt_Items` → Stores individual items purchased on a receipt.

## Troubleshooting
- Check `python3` installation and that version is compatible
- Check Windows Subsystem For Linux (WSL), Ubuntu, and Linux 
- Check PostgreSQL status and credentials (See: Setup.sh)
- If shell files aren't working try the following:
  ```bash
  # sed -i 's/\r$//' <script>.sh
  sed -i 's/\r$//' Collect.sh
  ```

