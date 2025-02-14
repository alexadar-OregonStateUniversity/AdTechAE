SELECT *
FROM b_intermediate.int_users

SELECT COUNT(DISTINCT brand_id)
FROM b_intermediate.int_brands

SELECT *
FROM b_intermediate.int_receipt_order

SELECT *
FROM b_intermediate.int_receipt_items



SELECT 
    category_code, 
    category as category_name
FROM b_intermediate.int_brands
WHERE 
    category_code IS NOT NULL
    AND
    category IS NOT NULL
GROUP BY 
    category_code,
    category

SELECT 
    cpg_code, COUNT(DISTINCT cpg_name)
FROM b_intermediate.int_brands
WHERE 
    cpg_code IS NOT NULL
    AND
    cpg_name IS NOT NULL
GROUP BY 
    cpg_code


SELECT 
    brand_id,
    barcode,
    brand_code, 
    brand_name,
    top_brand, 
    category_code,
    cpg_code,
    cpg_name
FROM b_intermediate.int_brands
GROUP BY 
    brand_id,
    barcode,
    brand_code, 
    brand_name,
    top_brand, 
    category_code,
    cpg_code,
    cpg_name


WITH bartest AS (SELECT barcode, COUNT(*) c
FROM b_intermediate.int_brands
GROUP BY barcode
HAVING COUNT(*) > 1
ORDER BY c DESC)
SELECT *
FROM bartest bt
LEFT JOIN b_intermediate.int_brands bb
    ON bt.barcode = bb.barcode
ORDER BY bt.barcode 

WITH item_list AS (
SELECT 
    item_description_mod, 
    item_number_mod
FROM b_intermediate.int_receipt_items
WHERE 
    item_description_mod IS NOT NULL 
    OR 
    item_number_mod IS NOT NULL
GROUP BY
    item_description_mod, 
    item_number_mod
)
SELECT item_description_mod, COUNT(DISTINCT item_number_mod) cc
FROM item_list
GROUP BY item_description_mod
ORDER BY cc DESC


WITH item_list AS (
SELECT 
    item_description_mod, 
    item_number_mod
FROM b_intermediate.int_receipt_items
WHERE 
    item_description_mod IS NOT NULL 
    OR 
    item_number_mod IS NOT NULL
GROUP BY
    item_description_mod, 
    item_number_mod
)
SELECT item_description_mod, COUNT(DISTINCT item_number_mod) cc
FROM item_list
WHERE 
    item_description_mod NOT LIKE 'ITEM NOT FOUND'
    AND 
    item_description_mod IS NOT NULL

GROUP BY item_description_mod
HAVING COUNT(DISTINCT item_number_mod) > 1
ORDER BY cc DESC

WITH item_list AS (
SELECT 
    item_description_mod, 
    item_number_mod
FROM b_intermediate.int_receipt_items
WHERE 
    item_description_mod IS NOT NULL 
    OR 
    item_number_mod IS NOT NULL
GROUP BY
    item_description_mod, 
    item_number_mod
)
SELECT item_description_mod,  item_number_mod
FROM item_list
WHERE 
    item_description_mod LIKE 'CREAM CHEESE'
    OR 
    item_description_mod LIKE 'Hidden Valley Original Ranch Dressing%'
GROUP BY 
    item_description_mod,
    item_number_mod

SELECT *
FROM int_receipt_items
WHERE 
    item_description_mod LIKE 'CREAM CHEESE'
    -- OR 
    -- item_description_mod LIKE 'Hidden Valley Original Ranch Dressing%'
ORDER BY item_number_mod DESC


WITH item_list AS (
SELECT 
    item_description_mod, 
    item_number_mod
FROM b_intermediate.int_receipt_items
WHERE 
    item_description_mod IS NOT NULL 
    OR
    item_number_mod IS NOT NULL
GROUP BY
    item_description_mod, 
    item_number_mod
)
SELECT item_description_mod, item_number_mod
FROM item_list
WHERE 
    item_description_mod NOT LIKE 'ITEM NOT FOUND'
    AND 
    item_description_mod IS NOT NULL

GROUP BY 
    item_description_mod,
    item_number_mod

SELECT *
FROM int_receipt_items 
WHERE 
    item_description_mod NOT LIKE 'ITEM NOT FOUND'
    AND 
    item_description_mod NOT LIKE 'DELETED ITEM'
    AND 
    item_description_mod IS NOT NULL
    AND
    item_number_mod IS NOT NULL
    AND 
    item_price_mod IS NOT NULL

SELECT 
    item_description_mod, 
    item_number_mod
FROM b_intermediate.int_receipt_items 
WHERE 
    item_description_mod NOT LIKE 'ITEM NOT FOUND'
    AND 
    item_description_mod NOT LIKE 'DELETED ITEM'
    AND 
    (
    item_description_mod IS NOT NULL
    OR
    item_number_mod IS NOT NULL
    )
    AND 
    item_price_mod IS NOT NULL
     
WITH test_data AS (
SELECT 
    md5(LOWER(TRIM(item_description_mod)) || '|' || COALESCE(LOWER(TRIM(item_number_mod)), 'MISSING_NUMBER')) AS item_hash_id,
    item_description_mod,
    COALESCE(item_number_mod, 'MISSING_NUMBER') AS item_number_mod,
    CURRENT_TIMESTAMP
FROM b_intermediate.int_receipt_items
WHERE 
    item_description_mod NOT LIKE 'ITEM NOT FOUND'
    AND item_description_mod NOT LIKE 'DELETED ITEM'
    AND (
        item_description_mod IS NOT NULL
        OR item_number_mod IS NOT NULL
    )
    AND item_price_mod IS NOT NULL
GROUP BY 
    item_description_mod, 
    item_number_mod,
    item_hash_id
)
SELECT item_hash_id, COUNT(*) cc
FROM test_data
GROUP BY item_hash_id
ORDER BY cc DESC


--- VALIDATION

WITH validation_data AS (
WITH int_data AS (
    SELECT 
        receipt_id,
        user_id,
        partner_item_id,
        md5(item_description_mod || '|' || COALESCE(item_number_mod, 'MISSING_NUMBER')) AS expected_item_hash_id, 
        item_description_mod,
        item_number_mod
    FROM b_intermediate.int_receipt_items
    WHERE 
        item_description_mod NOT LIKE 'ITEM NOT FOUND'
        AND item_description_mod NOT LIKE 'DELETED ITEM'
        AND (
            item_description_mod IS NOT NULL
            OR item_number_mod IS NOT NULL
        )
        AND item_price_mod IS NOT NULL
),
core_data AS (
    SELECT 
        cri.receipt_id,
        cri.user_id,
        cri.partner_item_id,
        cri.item_hash_id,  
        ci.item_description_mod AS stored_item_description,
        ci.item_number_mod AS stored_item_number
    FROM c_core.core_receipt_items cri
    JOIN c_core.core_items ci 
        ON cri.item_hash_id = ci.item_hash_id
)
SELECT 
    int_data.receipt_id,
    int_data.user_id,
    int_data.partner_item_id,
    int_data.expected_item_hash_id AS expected_hash,
    core_data.item_hash_id AS stored_hash,
    int_data.item_description_mod AS expected_item_description,
    core_data.stored_item_description AS stored_item_description,
    int_data.item_number_mod AS expected_item_number,
    core_data.stored_item_number AS stored_item_number,
    -- Check mismatches
    CASE WHEN int_data.expected_item_hash_id != core_data.item_hash_id THEN 'HASH MISMATCH' ELSE 'MATCH' END AS hash_validation,
    CASE WHEN int_data.item_description_mod != core_data.stored_item_description THEN 'DESCRIPTION MISMATCH' ELSE 'MATCH' END AS description_validation,
    CASE WHEN int_data.item_number_mod != core_data.stored_item_number THEN 'NUMBER MISMATCH' ELSE 'MATCH' END AS number_validation
FROM int_data
LEFT JOIN core_data 
    ON int_data.receipt_id = core_data.receipt_id 
    AND int_data.user_id = core_data.user_id 
    AND int_data.partner_item_id = core_data.partner_item_id
)
SELECT *
FROM validation_data
-- WHERE 
--     hash_validation NOT LIKE 'MATCH'
--     OR
--     description_validation NOT LIKE 'MATCH'
--     OR
--     number_validation NOT LIKE 'MATCH'



SELECT *
FROM core_brands
WHERE 
    brand_code LIKE 'HUGGIES'
    OR 
    brand_code LIKE 'GOODNITES'


SELECT * FROM b_intermediate.int_receipt_items WHERE brand_code LIKE '%BLUE DIAMOND%';

SELECT * FROM a_staging.stg_receipt_items WHERE brand_code LIKE '%BLUE DIAMOND%';

SELECT * FROM a_staging.stg_brands WHERE brand_code LIKE '%BLUE%DIAMOND%';

SELECT * FROM c_core.core_receipt_items WHERE brand_code LIKE '%BLUE DIAMOND%';

SELECT * FROM b_intermediate.int_receipt_items WHERE receipt_id = '600affe60a7214ada2000009' ORDER BY brand_code ASC

SELECT * FROM c_core.core_items WHERE item_description_mod = 'BLDM NUT THINS'

SELECT * FROM b_intermediate.int_receipt_items WHERE brand_code = 'BRAND'

