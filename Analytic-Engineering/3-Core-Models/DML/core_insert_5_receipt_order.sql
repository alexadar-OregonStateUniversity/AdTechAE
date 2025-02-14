INSERT INTO c_core.core_receipt_order (
    receipt_id,
    total_spent,
    purchased_item_count,
    purchase_date,
    date_scanned,
    finish_date,
    create_date,
    modify_date,
    rewards_status,
    points_earned,
    bonus_points_earned,
    bonus_earned_reason,
    points_award_date,
    user_id,
    system_modify_date
)
SELECT 
    receipt_id,
    total_spent,
    purchased_item_count,
    purchase_date,
    date_scanned,
    finish_date,
    create_date,
    modify_date,
    rewards_status,
    points_earned,
    bonus_points_earned,
    bonus_earned_reason,
    points_award_date,
    user_id,
    CURRENT_TIMESTAMP
FROM b_intermediate.int_receipt_order
WHERE user_id IN (SELECT user_id FROM c_core.core_users) 
ON CONFLICT (receipt_id) DO UPDATE 
SET 
    total_spent = EXCLUDED.total_spent,
    purchased_item_count = EXCLUDED.purchased_item_count,
    purchase_date = EXCLUDED.purchase_date,
    date_scanned = EXCLUDED.date_scanned,
    finish_date = EXCLUDED.finish_date,
    create_date = EXCLUDED.create_date,
    modify_date = EXCLUDED.modify_date,
    rewards_status = EXCLUDED.rewards_status,
    points_earned = EXCLUDED.points_earned,
    bonus_points_earned = EXCLUDED.bonus_points_earned,
    bonus_earned_reason = EXCLUDED.bonus_earned_reason,
    points_award_date = EXCLUDED.points_award_date,
    user_id = EXCLUDED.user_id,
    system_modify_date = CURRENT_TIMESTAMP;
