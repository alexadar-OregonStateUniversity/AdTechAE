/*
This table stores item-level data from receipts, representing individual 
products purchased within a transaction. Each row corresponds to a single 
item listed on a receipt.

Unlike the `Orders` table, which stores high-level transaction information, 
this table contains granular details about purchased products. Multiple 
entries in `Receipt_Items` may be linked to a single record in `Orders`, 
as a receipt can include multiple items.

    Execution:
    psql -U fetchuser -d fetchdb -h 127.0.0.1 < Operation >
    psql -c "DROP TABLE IF EXISTS Receipt_Items;"
    psql -f Receipt_Items.sql 
    psql -c "SELECT * FROM Receipt_Items;"
*/

DROP TABLE IF EXISTS Receipt_Items;
CREATE TABLE Receipt_Items (
    receipt_id TEXT,
    user_id TEXT,
    item_barcode TEXT,
    brand_code TEXT,
    competitive_product TEXT,
    competitor_rewards_group TEXT,
    deleted TEXT,
    item_description TEXT,
    discounted_item_price TEXT,
    final_price TEXT,
    item_number TEXT,
    item_price TEXT,
    metabrite_campaign_id TEXT,
    needs_fetch_review TEXT,
    needs_fetch_review_reason TEXT,
    original_final_price TEXT,
    original_metabrite_barcode TEXT,
    original_metabrite_description TEXT,
    original_metabrite_item_price TEXT,
    original_metabrite_quantity_purchased TEXT,
    original_receipt_item_text TEXT,
    partner_item_id TEXT,
    points_earned TEXT,
    points_not_awarded_reason TEXT,
    points_payer_id TEXT,
    prevent_target_gap_points TEXT,
    price_after_coupon TEXT,
    quantity_purchased TEXT,
    rewards_group TEXT,
    rewards_product_partner_id TEXT,
    target_price TEXT,
    user_flagged_barcode TEXT,
    user_flagged_description TEXT,
    user_flagged_new_item TEXT,
    user_flagged_price TEXT,
    user_flagged_quantity TEXT
);
