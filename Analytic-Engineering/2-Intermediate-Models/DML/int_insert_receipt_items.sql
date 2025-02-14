INSERT INTO b_intermediate.int_receipt_items (
    receipt_id,
    user_id,
    partner_item_id,
    item_description_mod,
    item_number_mod,
    item_price_mod,
    brand_code,
    discounted_item_price,
    price_after_coupon,
    target_price,
    final_price_mod,
    quantity_purchased_mod,
    rewards_group_mod,
    rewards_product_partner_id,
    points_earned,
    points_not_awarded_reason,
    points_payer_id,
    prevent_target_gap_points,
    deleted,
    metabrite_campaign_id,
    needs_fetch_review,
    needs_fetch_review_reason,
    user_flagged_new_item,
    competitive_product,
    system_modify_date
)
WITH Item_Details AS ( 
    SELECT 
        receipt_id,
        user_id,
        partner_item_id,
        COALESCE(
            ANY_VALUE(item_description),
            ANY_VALUE(original_receipt_item_text), 
            ANY_VALUE(user_flagged_description), 
            ANY_VALUE(original_metabrite_description)
        ) AS item_description_mod,
        COALESCE(
            ANY_VALUE(item_barcode),
            ANY_VALUE(user_flagged_barcode), 
            ANY_VALUE(original_metabrite_barcode),
            ANY_VALUE(item_number)
        ) AS item_number_mod,
        COALESCE(
            ANY_VALUE(item_price),
            ANY_VALUE(user_flagged_price),
            ANY_VALUE(original_metabrite_item_price)
        ) AS item_price_mod,

        TRIM(brand_code) as brand_code,
        discounted_item_price, 
        price_after_coupon,
        target_price,

        COALESCE(
            ANY_VALUE(final_price),
            ANY_VALUE(original_final_price)
        ) AS final_price_mod,

        COALESCE(
            ANY_VALUE(quantity_purchased),
            ANY_VALUE(user_flagged_quantity),
            ANY_VALUE(original_metabrite_quantity_purchased)
        ) AS quantity_purchased_mod,

        COALESCE(
            ANY_VALUE(rewards_group),   
            ANY_VALUE(competitor_rewards_group)
        ) AS rewards_group_mod,

        rewards_product_partner_id,
        points_earned,
        points_not_awarded_reason,
        points_payer_id,
        prevent_target_gap_points,
        deleted,
        metabrite_campaign_id,
        needs_fetch_review,
        needs_fetch_review_reason,
        user_flagged_new_item,
        competitive_product,
        CURRENT_TIMESTAMP AS system_modify_date

    FROM a_staging.stg_receipt_items
    GROUP BY
        receipt_id,
        user_id,
        partner_item_id,
        TRIM(brand_code),
        discounted_item_price,
        price_after_coupon,
        target_price,
        rewards_product_partner_id,
        points_earned,
        points_not_awarded_reason,
        points_payer_id,
        prevent_target_gap_points,
        deleted,
        metabrite_campaign_id,
        needs_fetch_review,
        needs_fetch_review_reason,
        user_flagged_new_item,
        competitive_product
)    
SELECT * FROM Item_Details
ON CONFLICT (receipt_id, user_id, partner_item_id) DO UPDATE 
SET 
    item_description_mod = EXCLUDED.item_description_mod,
    item_number_mod = EXCLUDED.item_number_mod,
    item_price_mod = EXCLUDED.item_price_mod,
    brand_code = TRIM(EXCLUDED.brand_code),
    discounted_item_price = EXCLUDED.discounted_item_price,
    price_after_coupon = EXCLUDED.price_after_coupon,
    target_price = EXCLUDED.target_price,
    final_price_mod = EXCLUDED.final_price_mod,
    quantity_purchased_mod = EXCLUDED.quantity_purchased_mod,
    rewards_group_mod = EXCLUDED.rewards_group_mod,
    rewards_product_partner_id = EXCLUDED.rewards_product_partner_id,
    points_earned = EXCLUDED.points_earned,
    points_not_awarded_reason = EXCLUDED.points_not_awarded_reason,
    points_payer_id = EXCLUDED.points_payer_id,
    prevent_target_gap_points = EXCLUDED.prevent_target_gap_points,
    deleted = EXCLUDED.deleted,
    metabrite_campaign_id = EXCLUDED.metabrite_campaign_id,
    needs_fetch_review = EXCLUDED.needs_fetch_review,
    needs_fetch_review_reason = EXCLUDED.needs_fetch_review_reason,
    user_flagged_new_item = EXCLUDED.user_flagged_new_item,
    competitive_product = EXCLUDED.competitive_product,
    system_modify_date = CURRENT_TIMESTAMP;
