# Overview  

This repository demonstrates the process of transforming raw unstructured JSON data into a structured, queryable relational model. The project addresses key business needs:  

- Designing a structured relational data model  
- Writing SQL queries to answer business questions  
- Identifying and resolving data quality issues  
- Communicating findings and next steps to stakeholders  

For business stakeholders, the following documentation provides the relevant insights:  

- Entity Relationship Diagram (ERD) – `Entity Relationship Diagram.md`  
- SQL queries and results – `Questions & Answers.md`  
- Data quality analysis and fixes – `Data Quality Issues.md`  
- Stakeholder communication – `Message To Manager.md`  

---

1. Project Structure  
2. Data Lifecycle  
3. Setup Instructions  
4. Execution Process  
5. Entity Relationship Diagram  
6. Questions & Answers 
7. Data Quality Assessment  
8. Business Communication  

---

## Project Structure  

```
/
│── Analytic-Engineering/        # Analytic Engineering Framework/Workflows
│   ├── 1-Staging-Models/        # Raw Data Cleanup & Preparation
│   ├── 2-Intermediate-Models/   # Light Normalization & Transformations
│   ├── 3-Core-Models/           # Fact & Dimension Data Modeling
│   ├── 4-Mart-Models/           # Aggregated Reporting Data Models
│   ├── README.md                # Documentation for 'Staging'
│   ├── Setup.sh                 # Script to initialize the analytics pipeline
│── Data-Analytics/              # Business Questions & Data Validation
│   ├── 1-Business-Requirements/ # Understanding business needs
│   ├── 2-Data-Exploration/      # Exploration and Experimentation 
│   ├── 3-Data-Solution/         # Structured Data Model Development
│   ├── 4-Data-Validation/       # Reviewing Reliability of Data Solution(s)
│   ├── 5-Data-Visualization/    # Reports, Dashboards, and Applications
│   ├── README.md
│── Data-Engineering/            # Data Extraction, Transformation, and Loading
│   ├── 1a-Collection-Code/      # Scripts for Data Collection from JSON Sources
│   ├── 1b-Collection-Data/      # Data Outputted From Collection Stage
│   ├── 2a-Correction-Code/      # Scripts for Data Cleaning & Structuring
│   ├── 2b-Correction-Data/      # Data Outputted From Correction Stage
│   ├── 3a-Connection-Code/      # Scripts for Data Insertion into PSQL Database
│   ├── 3b-Connection-Data/      # Data Outputted During the Connection Stage
│   ├── README.md
│── Core_ERD.svg                 # Entity Relationship Diagram (Core_*)
│── Entity Relationship Diagram.md
│── Questions & Answers.md       # Queries that Answer Predetermined Questions
│── Data Quality Issues.md       # Data Quality Issues Identified During Cleaning
│── Message To Manager.md        # Email To Stakeholders About Data Challenges
│── .gitignore                   
│── README.md                    
```

---

## Data Lifecycle 

This project follows a DE → AE → DA pipeline to systematically process data from ingestion to analytics.  

##### Data Engineering (DE)  
- Ingests raw JSON data, cleanses inconsistencies, and loads structured tables into PostgreSQL  
- Uses Python for ingestion, PostgreSQL for storage, and Bash for automation  
- Outputs cleaned, structured relational tables  

##### Analytics Engineering (AE)  
- Creates a structured, normalized data model  
- Uses staging → intermediate → core → mart layers to transform and optimize data  
- Ensures performance-optimized SQL tables for efficient querying  

##### Data Analytics (DA)  
- Uses structured data to answer business questions and validate insights  
- Involves SQL queries, data validation, and visualization tools  
- Outputs business insights and actionable reporting  

This approach ensures data remains accurate, scalable, and performant while keeping concerns separated by function.  

---

## Setup Instructions  

##### Install Linux (WSL)  
```powershell
wsl --install  
wsl  
sudo apt update && sudo apt upgrade -y  
wsl --status  
wsl --set-default-version 2  
```

##### Clone the Repository  
```bash
git clone https://github.com/alexadar-OregonStateUniversity/AdTechAE.git
```

##### Install Python 3.x  
```bash
sudo apt update && sudo apt install -y
sudo apt install python3-pip
```

##### Install PostgreSQL
```bash
# Update package lists
sudo apt update  
# Install PostgreSQL
sudo apt install postgresql postgresql-contrib -y  
# Start PostgreSQL service
sudo service postgresql start  
# Enable PostgreSQL to start on boot
sudo systemctl enable postgresql  
# Switch to PostgreSQL user 
sudo -i -u postgres  
psql  
# Create a new database user
CREATE USER fetchuser WITH ENCRYPTED PASSWORD 'fetchpass';  
# Create a new database
CREATE DATABASE fetchdb OWNER fetchuser;  
# Grant privileges to the user
GRANT ALL PRIVILEGES ON DATABASE fetchdb TO fetchuser;  
\q  
exit  
PGPASSWORD='fetchpass' psql -U fetchuser -d fetchdb -h 127.0.0.1 -c "\dt;"

```

---

## Execution Process  

##### Data Engineering  
```bash
source Data-Engineering/1a-Collection-Code/Collect.sh
source Data-Engineering/2a-Correction-Code/Correct.sh
source Data-Engineering/3a-Connection-Code/Connect.sh
```

##### PostgreSQL Queries  
```bash
sudo service postgresql start
PGPASSWORD='fetchpass' psql -U fetchuser -d fetchdb -h 127.0.0.1 -c "SELECT * FROM Users LIMIT 5;"
PGPASSWORD='fetchpass' psql -U fetchuser -d fetchdb -h 127.0.0.1 -c "SELECT * FROM Brands LIMIT 5;"
PGPASSWORD='fetchpass' psql -U fetchuser -d fetchdb -h 127.0.0.1 -c "SELECT * FROM Receipt_Order LIMIT 5;"
PGPASSWORD='fetchpass' psql -U fetchuser -d fetchdb -h 127.0.0.1 -c "SELECT * FROM Receipt_Items LIMIT 5;"
sudo service postgresql stop
```

---

## Entity Relationship Diagram  

- File: `Entity Relationship Diagram.md`  
- ERD Image: `Core_ERD.svg`  
- Provides a structured relational model with fact and dimension tables, primary keys, and foreign keys  

---

## Questions & Answers   

- File: `Questions & Answers.md`  
- Contains SQL queries answering business questions:  

1. What are the top 5 brands by receipts scanned for most recent month?
2. How does the ranking of the top 5 brands by receipts scanned for the recent month compare to the ranking for the previous month?
3. Which brand has the most spend among users who were created within the past 6 months?
4. Which brand has the most transactions among users who were created within the past 6 months? 

---

## Data Quality Assessment  

- File: `Data Quality Issues.md`  
- Evaluates:  
  - Missing values  
  - Foreign key violations  
  - Duplicate records  
  - Incorrect categorizations  
- Provides resolutions to improve data integrity  

---

## Business Communication  

- File: `Message To Manager.md`  
- Summarizes key data findings, business impact, and next steps  
- Highlights concerns about data quality and model scalability  

---
