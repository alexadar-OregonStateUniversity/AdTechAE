INSERT INTO a_staging.stg_receipt_order
(
    receipt_id,
    user_id,
    bonus_points_earned,
    bonus_earned_reason,
    create_date,
    date_scanned,
    finish_date,
    modify_date,
    points_award_date,
    points_earned,
    purchase_date,
    purchased_item_count,
    rewards_status,
    total_spent
)
SELECT 
    receipt_id::TEXT,
    user_id::TEXT,
    NULLIF(bonus_points_earned, '')::NUMERIC(10,2),
    bonus_earned_reason::TEXT,
    NULLIF(create_date, '')::TIMESTAMP,
    NULLIF(date_scanned, '')::TIMESTAMP,
    NULLIF(finish_date, '')::TIMESTAMP,
    NULLIF(modify_date, '')::TIMESTAMP,
    NULLIF(points_award_date, '')::TIMESTAMP,
    NULLIF(points_earned, '')::NUMERIC(10,2),
    NULLIF(purchase_date, '')::TIMESTAMP,
    NULLIF(purchased_item_count, '')::INTEGER,
    rewards_status::VARCHAR(150),
    NULLIF(total_spent, '')::NUMERIC(10,2)
FROM public.receipt_order
ON CONFLICT (receipt_id) DO NOTHING;
