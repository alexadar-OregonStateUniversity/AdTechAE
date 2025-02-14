WITH 
MART AS (
    SELECT total_spend 
    FROM d_mart.mart_brand_metrics
    WHERE brand_code = 'CRACKER BARREL'
),
CORE AS (
    SELECT SUM(final_price_mod) AS total_spend
    FROM c_core.core_receipt_items
    WHERE brand_code = 'CRACKER BARREL'
)
SELECT 
    MART.total_spend AS Mart, 
    CORE.total_spend AS Core, 
    MART.total_spend = CORE.total_spend AS is_match
FROM MART, CORE;
