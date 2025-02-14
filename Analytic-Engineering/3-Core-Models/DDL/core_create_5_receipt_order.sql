DROP TABLE IF EXISTS c_core.core_receipt_order CASCADE;
CREATE TABLE c_core.core_receipt_order (
    receipt_id TEXT PRIMARY KEY,
    -- Financial Data
    total_spent NUMERIC(10,2),
    purchased_item_count INTEGER,
    -- Date Tracking
    purchase_date DATE,
    date_scanned DATE,
    finish_date DATE,
    create_date DATE,
    modify_date DATE,
    -- Rewards Information
    rewards_status VARCHAR(150),
    points_earned NUMERIC(10,2),
    bonus_points_earned NUMERIC(10,2),
    bonus_earned_reason TEXT,
    points_award_date DATE,
    -- User Association
    user_id TEXT,
    -- System Tracking
    system_modify_date DATE DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (user_id) REFERENCES c_core.core_users(user_id) 
        DEFERRABLE INITIALLY DEFERRED
    
);
