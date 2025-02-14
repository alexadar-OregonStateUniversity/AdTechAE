# A Stakeholder Data Model  


This document provides structured SQL queries designed to answer the predetermined business questions using a data model built in the `Analytic-Engineering/4-Mart-Models/` directory. The data model analyzes brand performance by aggregating transactional data into a structured, easy-to-query format.  

The Mart database acts as a refined data warehouse optimized for analytics. It is built on pre-aggregated metrics, that reduce the need for raw transactional joins, and increase querying speed for reports, dashboards, and other analytics products.  

---

#### Data Model `d_mart.mart_brand_metrics`  
This table aggregates Brand performance metrics by purchase month and year, providing a structured format for business insights.  

##### Schema Overview  

| Column Name              | Data Type            | Description |
|--------------------------|----------------------|-------------|
| `brand_code`             | `TEXT NOT NULL`      | Unique brand identifier |
| `total_spend`            | `NUMERIC(12,2)`      | Total spend across all receipts for the brand in a given month/year |
| `total_items_purchased`  | `INTEGER`            | Total number of items purchased for the brand in the given period |
| `total_receipt_count`    | `INTEGER`            | Count of unique receipts associated with the brand |
| `new_users_spend`        | `NUMERIC(12,2)`      | Total spend from users who joined in the past 6 months |
| `new_user_items_purchased` | `INTEGER`         | Number of items purchased by new users |
| `new_user_receipt_count` | `INTEGER`            | Number of receipts submitted by new users |
| `purchase_year`          | `INTEGER NOT NULL`   | Year of purchase  |
| `purchase_month`         | `INTEGER NOT NULL`   | Month of purchase  |
| `system_modify_date`     | `TIMESTAMP DEFAULT CURRENT_TIMESTAMP` | System timestamp for record modifications |

##### Primary Key

- `(brand_code, purchase_year, purchase_month)` ensures unique brand records for each month-year combination.  

##### Design Considerations  
- Avoids expensive joins on raw transaction data when querying trends.  
- Captures spend and transactions for all time and new users for side-by-side comparison.  
- Partitioning by `year` and `month` for faster retrieval is made possible by this structure.  

---

#### Business Questions  

1. What are the top 5 brands by receipts scanned for most recent month?
   
2. How does the ranking of the top 5 brands by receipts scanned for the recent month compare to the ranking for the previous month?

3. Which brand has the most spend among users who were created within the past 6 months?

4. Which brand has the most transactions among users who were created within the past 6 months?

---

#### Queries & Answers  

`SQL Dialect: PostgreSQL`  

##### 1. What are the top 5 brands by receipts scanned for most recent month?  

```sql
WITH Recent_Month AS (
    SELECT purchase_year, purchase_month
    FROM d_mart.mart_brand_metrics
    ORDER BY 
        purchase_year DESC, 
        purchase_month DESC
    LIMIT 1
)
SELECT mbm.brand_code, mbm.total_receipt_count
FROM d_mart.mart_brand_metrics mbm
JOIN Recent_Month rm 
    ON mbm.purchase_year = rm.purchase_year 
    AND mbm.purchase_month = rm.purchase_month
ORDER BY mbm.total_receipt_count DESC
LIMIT 5;
```

##### Answer  

```
    BRAND       COUNT
    -----------------
    KLEENEX	    17
    PEPSI	    16
    KNORR	    15
    KRAFT	    14
    DORITOS	    12
```
---

##### 2. How does the ranking of the top 5 brands by receipts scanned for the recent month compare to the ranking for the previous month?
 
```sql
WITH Ranked_Brands AS (
    SELECT 
        brand_code, 
        purchase_year, 
        purchase_month,
        total_receipt_count,
        RANK() OVER (PARTITION BY purchase_year, purchase_month 
                    ORDER BY total_receipt_count DESC) AS rank
    FROM d_mart.mart_brand_metrics
)
SELECT brand_code, purchase_year, purchase_month, total_receipt_count, rank
FROM Ranked_Brands
WHERE rank <= 5
ORDER BY purchase_year DESC, purchase_month DESC, rank;
```

##### Answer 
```
    BRAND           YEAR        MONTH   COUNT   RANK
    ------------------------------------------------
    KLEENEX	        2021	    1	    17	    1
    PEPSI	        2021	    1	    16  	2
    KNORR	        2021	    1	    15	    3
    KRAFT	        2021	    1	    14	    4
    RICE-A-RONI	    2021	    1	    12	    5
    DORITOS	        2021	    1	    12	    5
```
    With this dataset there are no previous months with 
    reliable data to compare to.
---

##### 3. Which brand has the most spend among users who were created within the past 6 months?  

```sql
WITH Recent_Month AS (
    SELECT purchase_year, purchase_month
    FROM d_mart.mart_brand_metrics
    ORDER BY 
        purchase_year DESC, 
        purchase_month DESC
    LIMIT 1
)
SELECT mbm.brand_code, mbm.new_users_spend
FROM d_mart.mart_brand_metrics mbm
JOIN Recent_Month rm 
    ON mbm.purchase_year = rm.purchase_year 
    AND mbm.purchase_month = rm.purchase_month
ORDER BY mbm.new_users_spend DESC
LIMIT 1;
```

##### Answer 

``` 
    BRAND               SPEND
    --------------------------
    CRACKER BARREL	    703.50
```
---

##### 4. Which brand has the most transactions among users who were created within the past 6 months? 

  
```sql
WITH Recent_Month AS (
    SELECT purchase_year, purchase_month
    FROM d_mart.mart_brand_metrics
    ORDER BY 
        purchase_year DESC, 
        purchase_month DESC
    LIMIT 1
)
SELECT mbm.brand_code, mbm.new_user_receipt_count
FROM d_mart.mart_brand_metrics mbm
JOIN Recent_Month rm 
    ON mbm.purchase_year = rm.purchase_year 
    AND mbm.purchase_month = rm.purchase_month
ORDER BY mbm.new_user_receipt_count DESC
LIMIT 1;

```

##### Answer 

```
    BRAND       COUNT
    -----------------
    PEPSI	    16
```
---