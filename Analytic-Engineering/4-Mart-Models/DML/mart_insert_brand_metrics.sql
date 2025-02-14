INSERT INTO d_mart.mart_brand_metrics (
    brand_code,
    total_spend,
    total_items_purchased,
    total_receipt_count,
    new_users_spend,
    new_user_items_purchased,
    new_user_receipt_count,
    purchase_year,
    purchase_month,
    system_modify_date
)
SELECT 
    ri.brand_code,

    SUM(ri.final_price_mod) AS total_spend, 
    SUM(ri.quantity_purchased_mod) AS total_items_purchased,
    COUNT(DISTINCT ri.receipt_id) AS total_receipt_count,

    SUM(ri.final_price_mod) 
        FILTER (WHERE ut.create_date >= (SELECT MAX(purchase_date) FROM c_core.core_receipt_order) - INTERVAL '6 months') 
        AS new_users_spend,

    SUM(ri.quantity_purchased_mod) 
        FILTER (WHERE ut.create_date >= (SELECT MAX(purchase_date) FROM c_core.core_receipt_order) - INTERVAL '6 months') 
        AS new_user_items_purchased,

    COUNT(DISTINCT ri.receipt_id) 
        FILTER (WHERE ut.create_date >= (SELECT MAX(purchase_date) FROM c_core.core_receipt_order) - INTERVAL '6 months') 
        AS new_user_receipt_count,

    EXTRACT(YEAR FROM ro.purchase_date) AS year,
    EXTRACT(MONTH FROM ro.purchase_date) AS month,

    CURRENT_TIMESTAMP
    
FROM c_core.core_receipt_items ri
LEFT JOIN c_core.core_receipt_order ro
    ON ri.receipt_id = ro.receipt_id
LEFT JOIN c_core.core_users ut
    ON ri.user_id = ut.user_id
WHERE
    ro.date_scanned IS NOT NULL
    AND ri.brand_code IS NOT NULL
GROUP BY 
    ri.brand_code,
    EXTRACT(YEAR FROM ro.purchase_date),
    EXTRACT(MONTH FROM ro.purchase_date)
ON CONFLICT (brand_code, purchase_year, purchase_month) DO NOTHING;