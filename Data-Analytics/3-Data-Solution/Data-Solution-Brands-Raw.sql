SELECT 
    ri.brand_code AS brand,

    SUM(final_price_mod) AS total_spend, 
    SUM(quantity_purchased_mod) AS total_items_purchased,
    COUNT(DISTINCT ri.receipt_id) AS total_receipt_count,

    SUM(final_price_mod) 
        FILTER (WHERE ut.create_date >= (SELECT MAX(purchase_date) FROM c_core.core_receipt_order) - INTERVAL '6 months') 
        AS new_users_spend,

    SUM(quantity_purchased_mod) 
        FILTER (WHERE ut.create_date >= (SELECT MAX(purchase_date) FROM c_core.core_receipt_order) - INTERVAL '6 months') 
        AS new_user_items_purchased,

    COUNT(DISTINCT ri.receipt_id) 
        FILTER (WHERE ut.create_date >= (SELECT MAX(purchase_date) FROM c_core.core_receipt_order) - INTERVAL '6 months') 
        AS new_user_receipt_count,

    EXTRACT(YEAR FROM ro.purchase_date) AS year, -- scanned
    EXTRACT(MONTH FROM ro.purchase_date) AS month -- scanned
    
FROM c_core.core_receipt_items ri
LEFT JOIN c_core.core_receipt_order ro
    ON (ri.receipt_id = ro.receipt_id)
LEFT JOIN c_core.core_users ut
    ON (ri.user_id = ut.user_id)
WHERE
    ro.date_scanned IS NOT NULL
    AND
    brand_code IS NOT NULL
GROUP BY 
    ri.brand_code,
    EXTRACT(YEAR FROM ro.purchase_date),
    EXTRACT(MONTH FROM ro.purchase_date)
ORDER BY
    total_receipt_count DESC
