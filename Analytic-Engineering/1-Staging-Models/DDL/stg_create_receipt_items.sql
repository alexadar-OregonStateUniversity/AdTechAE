DROP TABLE IF EXISTS a_staging.stg_receipt_items;
CREATE TABLE a_staging.stg_receipt_items (
    receipt_id TEXT,
    user_id TEXT,
    item_barcode TEXT,
    brand_code TEXT,
    competitive_product TEXT,
    competitor_rewards_group TEXT,
    deleted BOOLEAN,
    item_description TEXT,
    discounted_item_price NUMERIC(10,2),
    final_price NUMERIC(10,2),
    item_number TEXT,
    item_price NUMERIC(10,2),
    metabrite_campaign_id TEXT,
    needs_fetch_review BOOLEAN,
    needs_fetch_review_reason TEXT,
    original_final_price NUMERIC(10,2),
    original_metabrite_barcode TEXT,
    original_metabrite_description TEXT,
    original_metabrite_item_price NUMERIC(10,2),
    original_metabrite_quantity_purchased INTEGER,
    original_receipt_item_text TEXT,
    partner_item_id TEXT,
    points_earned NUMERIC(10,2),
    points_not_awarded_reason TEXT,
    points_payer_id TEXT,
    prevent_target_gap_points BOOLEAN,
    price_after_coupon NUMERIC(10,2),
    quantity_purchased INTEGER,
    rewards_group TEXT,
    rewards_product_partner_id TEXT,
    target_price NUMERIC(10,2),
    user_flagged_barcode TEXT,
    user_flagged_description TEXT,
    user_flagged_new_item BOOLEAN,
    user_flagged_price NUMERIC(10,2),
    user_flagged_quantity INTEGER,
    
    unique_hash TEXT GENERATED ALWAYS AS (
        md5(
            coalesce(receipt_id, '') || coalesce(user_id, '') || coalesce(item_barcode, '') || 
            coalesce(brand_code, '') || coalesce(competitive_product, '') || coalesce(competitor_rewards_group, '') ||
            coalesce(deleted::TEXT, '') || coalesce(item_description, '') || coalesce(discounted_item_price::TEXT, '') ||
            coalesce(final_price::TEXT, '') || coalesce(item_number, '') || coalesce(item_price::TEXT, '') || 
            coalesce(metabrite_campaign_id, '') || coalesce(needs_fetch_review::TEXT, '') || coalesce(needs_fetch_review_reason, '') ||
            coalesce(original_final_price::TEXT, '') || coalesce(original_metabrite_barcode, '') || 
            coalesce(original_metabrite_description, '') || coalesce(original_metabrite_item_price::TEXT, '') || 
            coalesce(original_metabrite_quantity_purchased::TEXT, '') || coalesce(original_receipt_item_text, '') || 
            coalesce(partner_item_id, '') || coalesce(points_earned::TEXT, '') || coalesce(points_not_awarded_reason, '') || 
            coalesce(points_payer_id, '') || coalesce(prevent_target_gap_points::TEXT, '') || 
            coalesce(price_after_coupon::TEXT, '') || coalesce(quantity_purchased::TEXT, '') || 
            coalesce(rewards_group, '') || coalesce(rewards_product_partner_id, '') || 
            coalesce(target_price::TEXT, '') || coalesce(user_flagged_barcode, '') || coalesce(user_flagged_description, '') || 
            coalesce(user_flagged_new_item::TEXT, '') || coalesce(user_flagged_price::TEXT, '') || coalesce(user_flagged_quantity::TEXT, '')
        )
    ) STORED,
    
    CONSTRAINT unique_receipt_item UNIQUE (unique_hash)
);
