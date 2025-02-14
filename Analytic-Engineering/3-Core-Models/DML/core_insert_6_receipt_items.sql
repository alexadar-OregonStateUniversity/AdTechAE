INSERT INTO c_core.core_receipt_items (
    receipt_id,
    user_id,
    partner_item_id,
    item_hash_id,
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
SELECT 
    ri.receipt_id,
    ri.user_id,
    ri.partner_item_id,
    ci.item_hash_id,
    ri.item_price_mod,
    ri.brand_code,
    ri.discounted_item_price,
    ri.price_after_coupon,
    ri.target_price,
    ri.final_price_mod,
    ri.quantity_purchased_mod,
    ri.rewards_group_mod,
    ri.rewards_product_partner_id,
    ri.points_earned,
    ri.points_not_awarded_reason,
    ri.points_payer_id,
    ri.prevent_target_gap_points,
    ri.deleted,
    ri.metabrite_campaign_id,
    ri.needs_fetch_review,
    ri.needs_fetch_review_reason,
    ri.user_flagged_new_item,
    ri.competitive_product,
    CURRENT_TIMESTAMP
FROM (
    -- Hash Calculation 
    SELECT 
        receipt_id,
        user_id,
        partner_item_id,
        md5(item_description_mod || '|' || COALESCE(item_number_mod, 'MISSING_NUMBER')) AS item_hash_id,
        item_price_mod,
        TRIM(brand_code) AS brand_code,
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
        competitive_product
    FROM b_intermediate.int_receipt_items
    WHERE 
        item_description_mod NOT IN ('ITEM NOT FOUND', 'DELETED ITEM')
        AND (item_description_mod IS NOT NULL OR item_number_mod IS NOT NULL)
        AND item_price_mod IS NOT NULL
        AND brand_code IN (SELECT brand_code FROM c_core.core_brands)
) ri
INNER JOIN c_core.core_receipt_order ro 
    ON ri.receipt_id = ro.receipt_id
LEFT JOIN c_core.core_items ci
    ON ci.item_hash_id = ri.item_hash_id
ON CONFLICT (receipt_id, user_id, partner_item_id) DO NOTHING;
