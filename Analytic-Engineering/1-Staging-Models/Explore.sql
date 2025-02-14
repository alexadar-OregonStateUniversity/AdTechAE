SELECT * 
FROM fetchdb.public.users

-- how many User id's in Users? 494 total, 212 ids, 42.91%
SELECT 
    COUNT(*)::NUMERIC AS total_records, 
    COUNT(DISTINCT user_id)::NUMERIC AS unique_user_ids,
    ((COUNT(DISTINCT user_id)::NUMERIC / NULLIF(COUNT(*), 0)) * 100) AS uniqueness_ratio
FROM fetchdb.public.users

-- how many occurrences of id in Users? 20x per id and down
SELECT user_id, COUNT(*) count_per_id
FROM users
GROUP BY user_id
ORDER BY count_per_id DESC 

-- are the records in Users duplicates or unique? duplicates
SELECT COUNT(*) record_count
FROM Users
GROUP BY 
    user_id, 
    active, 
    create_date, 
    last_login,
    user_role,
    signup_source, 
    user_state
ORDER BY 
    record_count DESC

-- longest string in each field?
SELECT 
    MAX(LENGTH(user_id))         user_id_len, 
    MAX(LENGTH(active))          activate_len, 
    MAX(LENGTH(create_date))     create_dt_len, 
    MAX(LENGTH(last_login))      last_login_len,
    MAX(LENGTH(user_role))       user_role_len,
    MAX(LENGTH(signup_source))   signup_src_len, 
    MAX(LENGTH(user_state))      user_state_len
FROM Users

-- count of variation of column?
SELECT 
    COUNT(DISTINCT(user_id))         user_id_cnt,       -- VARCHAR(150)
    COUNT(DISTINCT(active))          activate_cnt,      -- BOOLEAN
    COUNT(DISTINCT(create_date))     create_dt_cnt,     -- DATETIME
    COUNT(DISTINCT(last_login))      last_login_cnt,    -- DATETIME
    COUNT(DISTINCT(user_role))       user_role_cnt,     -- VARCHAR(150)
    COUNT(DISTINCT(signup_source))   signup_src_cnt,    -- VARCHAR(150)
    COUNT(DISTINCT(user_state))      user_state_cnt     -- VARCHAR(2)
FROM Users 

------------------------------------------------------------------------

SELECT 
    COUNT(DISTINCT brand_id) AS distinct_brand_id,
    COUNT(DISTINCT barcode) AS distinct_barcode,
    COUNT(DISTINCT brand_code) AS distinct_brand_code,
    COUNT(DISTINCT category) AS distinct_category,
    COUNT(DISTINCT category_code) AS distinct_category_code,
    COUNT(DISTINCT cpg_code) AS distinct_cpg_code,
    COUNT(DISTINCT cpg_name) AS distinct_cpg_name,
    COUNT(DISTINCT top_brand) AS distinct_top_brand,
    COUNT(DISTINCT brand_name) AS distinct_brand_name
FROM brands;

SELECT 
    MAX(LENGTH(brand_id)) AS max_length_brand_id,
    MAX(LENGTH(barcode)) AS max_length_barcode,
    MAX(LENGTH(brand_code)) AS max_length_brand_code,
    MAX(LENGTH(category)) AS max_length_category,
    MAX(LENGTH(category_code)) AS max_length_category_code,
    MAX(LENGTH(cpg_code)) AS max_length_cpg_code,
    MAX(LENGTH(cpg_name)) AS max_length_cpg_name,
    MAX(LENGTH(top_brand)) AS max_length_top_brand,
    MAX(LENGTH(brand_name)) AS max_length_brand_name
FROM brands;


SELECT 
    COUNT(*) AS duplicate_count
FROM brands
GROUP BY 
    brand_id, 
    barcode, 
    brand_code, 
    category, 
    category_code, 
    cpg_code, 
    cpg_name, 
    top_brand, 
    brand_name
ORDER BY 
    duplicate_count DESC

SELECT brand_id, COUNT(*) per_brand_count
FROM brands
GROUP BY brand_id
ORDER BY per_brand_count

--------------------------------------------------------------------------------

SELECT COUNT(DISTINCT receipt_id)
FROM receipt_order

SELECT 
    receipt_id,  
    COUNT(*) record_count
FROM receipt_order
GROUP BY receipt_id
ORDER BY record_count DESC

--------------------------------------------------------------------------------

SELECT CONCAT(receipt_id, user_id), COUNT(*) occ_count
FROM receipt_items
GROUP BY CONCAT(receipt_id, user_id)
ORDER BY occ_count DESC 

SELECT CONCAT(receipt_id, user_id, brand_code), COUNT(*) occ_count
FROM receipt_items
GROUP BY CONCAT(receipt_id, user_id, brand_code)
ORDER BY occ_count DESC 

SELECT 
    COUNT(*) AS duplicate_count
FROM receipt_items
GROUP BY 
    receipt_id, user_id, item_barcode, brand_code, competitive_product, 
    competitor_rewards_group, deleted, item_description, discounted_item_price, 
    final_price, item_number, item_price, metabrite_campaign_id, needs_fetch_review, 
    needs_fetch_review_reason, original_final_price, original_metabrite_barcode, 
    original_metabrite_description, original_metabrite_item_price, 
    original_metabrite_quantity_purchased, original_receipt_item_text, partner_item_id, 
    points_earned, points_not_awarded_reason, points_payer_id, prevent_target_gap_points, 
    price_after_coupon, quantity_purchased, rewards_group, rewards_product_partner_id, 
    target_price, user_flagged_barcode, user_flagged_description, user_flagged_new_item, 
    user_flagged_price, user_flagged_quantity
ORDER BY 
    duplicate_count DESC

SELECT 
    competitive_product 
FROM receipt_items
GROUP BY competitive_product


SELECT 
    deleted 
FROM receipt_items
GROUP BY deleted

SELECT 
    prevent_target_gap_points 
FROM receipt_items
GROUP BY prevent_target_gap_points

