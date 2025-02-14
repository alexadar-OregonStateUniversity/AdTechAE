INSERT INTO c_core.core_items (
    item_hash_id,
    item_description_mod,
    item_number_mod,
    system_modify_date
)
SELECT 
    md5(item_description_mod || '|' || COALESCE((item_number_mod), 'MISSING_NUMBER')) AS item_hash_id,
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
    item_hash_id;
