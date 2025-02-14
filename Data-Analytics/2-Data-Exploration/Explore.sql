--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
SELECT barcode, *
FROM a_staging.stg_receipt_items ri
LEFT JOIN a_staging.stg_brands b 
    ON (ri.item_barcode = b.barcode)
WHERE barcode IS NOT NULL

SELECT *
FROM a_staging.stg_receipt_items ri
INNER JOIN a_staging.stg_brands b
    ON (ri.item_barcode = b.barcode)

SELECT item_description_mod, item_number_mod, *
FROM c_core.core_receipt_items ri   
INNER JOIN c_core.core_items i   
    ON (ri.item_hash_id = i.item_hash_id)
INNER JOIN c_core.core_brands b 
    ON (item_number_mod = barcode)

SELECT *
FROM b_intermediate.int_receipt_items ri
INNER JOIN b_intermediate.int_brands b
    ON 
    (ri.brand_code = b.brand_code) 
    OR 
    (ri.item_number_mod = b.barcode)
    -- OR 
    -- ()
    
-- WHERE brand_code IS NOT NULL



WITH items_data AS (
    SELECT item_description_mod, item_number_mod, *
    FROM c_core.core_receipt_items ri   
    INNER JOIN c_core.core_items i   
        ON (ri.item_hash_id = i.item_hash_id)
    INNER JOIN c_core.core_brands b 
        ON (item_number_mod = barcode)
)
SELECT * 
FROM items_data

SELECT brand_code
FROM core_brands
GROUP BY brand_code




-- Latest Date




-- Get the Maximum Date Scanned (Month & Year)
WITH max_date AS (
    SELECT MAX(date_scanned) AS max_date_scanned
    FROM b_intermediate.int_receipt_order
),
max_dates AS (
    SELECT 
        EXTRACT(MONTH FROM max_date_scanned) AS max_month_scanned,
        EXTRACT(YEAR FROM max_date_scanned) AS max_year_scanned
    FROM max_date
)
SELECT b.*, ro.date_scanned, ro.*, ri.*
FROM b_intermediate.int_receipt_order ro
LEFT JOIN b_intermediate.int_receipt_items ri 
    ON ro.receipt_id = ri.receipt_id
LEFT JOIN b_intermediate.int_brands b
    ON b.barcode = ri.item_number_mod
INNER JOIN max_dates 
    ON EXTRACT(MONTH FROM ro.date_scanned) = max_dates.max_month_scanned
    AND EXTRACT(YEAR FROM ro.date_scanned) = max_dates.max_year_scanned
;


WITH max_date AS (
    SELECT MAX(date_scanned) AS max_date_scanned
    FROM b_intermediate.int_receipt_order
)
SELECT 
    EXTRACT(MONTH FROM max_date_scanned) AS max_month_scanned,
    EXTRACT(YEAR FROM max_date_scanned) AS max_year_scanned
FROM max_date;


-- 3 2021
SELECT *
FROM a_staging.stg_receipt_items ri
LEFT JOIN a_staging.stg_receipt_order ro
    ON ri.receipt_id = ro.receipt_id
WHERE    
    EXTRACT(MONTH FROM date_scanned) = 3
    AND
    EXTRACT(YEAR FROM date_scanned) = 2021
    AND
    brand_code IS NOT NULL

SELECT 
-- (SELECT MAX(purchase_date) FROM b_intermediate.int_receipt_order) as Max_Date,
--*
purchase_date
FROM b_intermediate.int_receipt_order
WHERE purchase_date >= DATE_TRUNC('month', (SELECT MAX(purchase_date) FROM b_intermediate.int_receipt_order)) - INTERVAL '6 months'
GROUP BY purchase_date
ORDER BY purchase_date DESC


WITH test_brand AS (
SELECT 
    ri.item_description_mod, 
    ri.item_number_mod,
    ri.brand_code,
    SUM(ro.total_spent) total_spend

FROM b_intermediate.int_receipt_items ri
INNER JOIN b_intermediate.int_receipt_order ro
    ON (ri.receipt_id = ro.receipt_id)
WHERE ri.user_id IN (  SELECT user_id 
                    FROM b_intermediate.int_users
                    WHERE create_date >= DATE_TRUNC('month', (SELECT MAX(create_date) FROM b_intermediate.int_users)) - INTERVAL '6 months'
                    GROUP BY user_id
                    )
    AND 
    (
    ri.item_description_mod IS NOT NULL
    OR
    ri.item_number_mod IS NOT NULL
    OR
    ri.brand_code IS NOT NULL
    )
GROUP BY 
    ri.item_description_mod, 
    ri.item_number_mod,
    ri.brand_code
ORDER BY
    total_spend DESC)
SELECT * 
FROM test_brand
WHERE 
    item_description_mod IN (
        SELECT brand_name
        FROM b_intermediate.int_brands
    )

SELECT *
FROM b_intermediate.int_receipt_items
WHERE item_description_mod IN (SELECT brand_name FROM b_intermediate.int_brands)

SELECT *
FROM a_staging.stg_receipt_items
WHERE brand_code = 'BRAND'