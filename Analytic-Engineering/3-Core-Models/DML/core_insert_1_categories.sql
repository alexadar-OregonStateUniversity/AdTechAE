INSERT INTO c_core.core_categories (
    category_code, 
    category_name, 
    system_modify_date
)
SELECT 
    TRIM(category_code) AS category_code, 
    TRIM(category) AS category_name, 
    CURRENT_TIMESTAMP
FROM b_intermediate.int_brands
WHERE 
    TRIM(category_code) IS NOT NULL
GROUP BY 
    TRIM(category_code),
    TRIM(category)
ORDER BY category_code ASC
