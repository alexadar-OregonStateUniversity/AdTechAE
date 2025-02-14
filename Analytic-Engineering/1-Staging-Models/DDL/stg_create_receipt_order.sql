DROP TABLE IF EXISTS a_staging.stg_receipt_order;
CREATE TABLE a_staging.stg_receipt_order (
    receipt_id TEXT PRIMARY KEY,
    user_id TEXT,
    bonus_points_earned NUMERIC(10,2),
    bonus_earned_reason TEXT,
    create_date TIMESTAMP,
    date_scanned TIMESTAMP,
    finish_date TIMESTAMP,
    modify_date TIMESTAMP,
    points_award_date TIMESTAMP,
    points_earned NUMERIC(10,2),
    purchase_date TIMESTAMP,
    purchased_item_count INTEGER,
    rewards_status VARCHAR(150),
    total_spent NUMERIC(10,2)
);
