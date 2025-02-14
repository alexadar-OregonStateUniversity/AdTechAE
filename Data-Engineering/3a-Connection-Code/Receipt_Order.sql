/*
This table stores receipt-level data, representing a single purchase event. 
Each row corresponds to a unique receipt scanned by a user, capturing 
high-level details about the transaction such as total amount spent, 
purchase date, and any associated reward points.

This table does not store individual items from the receipt. Instead, 
each receipt may have multiple corresponding entries in the `Receipt_Items` 
table, which stores details about specific products purchased.


    Execution:
    psql -U fetchuser -d fetchdb -h 127.0.0.1 < Operation >
    psql -c "DROP TABLE IF EXISTS Receipt_Order;"
    psql -f Receipt_Order.sql 
    psql -c "SELECT * FROM Receipt_Order;"
*/

DROP TABLE IF EXISTS Receipt_Order;
CREATE TABLE Receipt_Order (
    receipt_id TEXT,
    user_id TEXT,
    bonus_points_earned TEXT,
    bonus_earned_reason TEXT,
    create_date TEXT,
    date_scanned TEXT, 
    finish_date TEXT,
    modify_date TEXT,
    points_award_date TEXT,
    points_earned TEXT,
    purchase_date TEXT,  
    purchased_item_count TEXT,
    rewards_status TEXT,
    total_spent TEXT

);