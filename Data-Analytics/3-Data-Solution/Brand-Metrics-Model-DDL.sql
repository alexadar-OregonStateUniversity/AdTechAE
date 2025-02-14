DROP TABLE IF EXISTS d_mart.mart_brand_metrics CASCADE;
CREATE TABLE d_mart.mart_brand_metrics (
    brand_code TEXT PRIMARY KEY,            -- Unique brand identifier
    purchase_year INTEGER NOT NULL,         -- Purchase Date Year
    purchase_month INTEGER NOT NULL,        -- Purhcase Date Month

    total_spend NUMERIC(12,2),              -- Total Amount Spent (e.g. per Brand)
    total_items_purchased INTEGER,          -- Total Number of Items Purchased Amount 
    total_receipt_count INTEGER,            -- Total Number of Unique Receipts (IDs)

    new_users_spend NUMERIC(12,2),          -- Total Spend from "New Users" (Last 6 Months)
    new_user_items_purchased INTEGER,       -- Total Number of Items Purchased by New Users
    new_user_receipt_count INTEGER,         -- Total Number of Unique Receipts from New Users

    system_modify_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP, 

    PRIMARY KEY (brand_code, year, month)   -- Only One Brand Per Month & Year Allowed

);
