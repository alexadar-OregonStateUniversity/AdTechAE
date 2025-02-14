#!/bin/bash

# Setup PostgreSQL Server
source Setup.sh

# Start PostgreSQL Server
sudo service postgresql start

# Users Table ETL ---------------------------------------------------------------
PGPASSWORD='fetchpass' psql -U fetchuser -d fetchdb -h 127.0.0.1 -f Users.sql
touch "../3b-Connection-Data/users.csv"                      
python3 Users_ETL.py ../2b-Correction-Data/users.jsonl ../3b-Connection-Data/users.csv
PGPASSWORD='fetchpass' psql -U fetchuser -d fetchdb -h 127.0.0.1 -c "\COPY 
        Users(user_id, active, create_date, last_login, user_role, signup_source, user_state) 
        FROM '../3b-Connection-Data/users.csv' 
        WITH (FORMAT csv, DELIMITER ';', HEADER FALSE, NULL '');"
# PGPASSWORD='fetchpass' psql -U fetchuser -d fetchdb -h 127.0.0.1 -c "SELECT * FROM Users LIMIT 5;"
# ------------------------------------------------------------------------------

# Brands Table ETL --------------------------------------------------9-----------
PGPASSWORD='fetchpass' psql -U fetchuser -d fetchdb -h 127.0.0.1 -f Brands.sql
touch "../3b-Connection-Data/brands.csv"                      
python3 Brands_ETL.py ../2b-Correction-Data/brands.jsonl ../3b-Connection-Data/brands.csv
PGPASSWORD='fetchpass' psql -U fetchuser -d fetchdb -h 127.0.0.1 -c "\COPY 
        Brands(brand_id, barcode, brand_code, category, category_code, cpg_code, cpg_name, top_brand, brand_name) 
        FROM '../3b-Connection-Data/brands.csv' 
        WITH (FORMAT csv, DELIMITER ';', HEADER FALSE, NULL '');"
# PGPASSWORD='fetchpass' psql -U fetchuser -d fetchdb -h 127.0.0.1 -c "SELECT * FROM Brands LIMIT 5;"
# ------------------------------------------------------------------------------

# Receipts Table ETL -----------------------------------------------------------
PGPASSWORD='fetchpass' psql -U fetchuser -d fetchdb -h 127.0.0.1 -f Receipt_Order.sql
PGPASSWORD='fetchpass' psql -U fetchuser -d fetchdb -h 127.0.0.1 -f Receipt_Items.sql
touch "../3b-Connection-Data/receipt_order.csv"           
touch "../3b-Connection-Data/receipt_items.csv"                      
python3 Receipts_ETL.py ../2b-Correction-Data/receipts.jsonl ../3b-Connection-Data/receipt_order.csv ../3b-Connection-Data/receipt_items.csv

PGPASSWORD='fetchpass' psql -U fetchuser -d fetchdb -h 127.0.0.1 -c "\COPY 
        Receipt_Order(receipt_id, user_id, bonus_points_earned, bonus_earned_reason, create_date, date_scanned, 
                      finish_date, modify_date, points_award_date, points_earned, purchase_date, purchased_item_count, 
                      rewards_status, total_spent) 
        FROM '../3b-Connection-Data/receipt_order.csv' 
        WITH (FORMAT csv, DELIMITER ';', HEADER FALSE, NULL '');"

PGPASSWORD='fetchpass' psql -U fetchuser -d fetchdb -h 127.0.0.1 -c "\COPY 
        Receipt_Items(receipt_id, user_id, item_barcode, brand_code, competitive_product, competitor_rewards_group,
                      deleted, item_description, discounted_item_price, final_price, item_number, item_price, 
                      metabrite_campaign_id, needs_fetch_review, needs_fetch_review_reason, 
                      original_final_price, original_metabrite_barcode, original_metabrite_description, 
                      original_metabrite_item_price, original_metabrite_quantity_purchased, original_receipt_item_text, 
                      partner_item_id, points_earned, points_not_awarded_reason, points_payer_id, 
                      prevent_target_gap_points, price_after_coupon, quantity_purchased, 
                      rewards_group, rewards_product_partner_id, target_price, 
                      user_flagged_barcode, user_flagged_description, user_flagged_new_item, 
                      user_flagged_price, user_flagged_quantity) 
        FROM '../3b-Connection-Data/receipt_items.csv' 
        WITH (FORMAT csv, DELIMITER ';', HEADER FALSE, NULL '');"

# PGPASSWORD='fetchpass' psql -U fetchuser -d fetchdb -h 127.0.0.1 -c "SELECT * FROM Receipt_Order LIMIT 5;"
# PGPASSWORD='fetchpass' psql -U fetchuser -d fetchdb -h 127.0.0.1 -c "SELECT * FROM Receipt_Items LIMIT 5;"
# ------------------------------------------------------------------------------

# Stop PostgreSQL Server
sudo service postgresql stop
sudo service postgresql status 

echo "Connect Stage Complete"