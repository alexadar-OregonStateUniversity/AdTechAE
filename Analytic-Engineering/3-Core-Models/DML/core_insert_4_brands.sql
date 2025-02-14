WITH RankedBrands AS (
    SELECT 
        brand_code,
        brand_id,
        barcode,
        brand_name,
        top_brand,
        TRIM(category_code) AS category_code,
        cpg_code,
        cpg_name,
        CURRENT_TIMESTAMP AS system_modify_date,
        -- Count non-null fields for ranking completeness
        (CASE WHEN barcode IS NOT NULL THEN 1 ELSE 0 END +
         CASE WHEN brand_name IS NOT NULL THEN 1 ELSE 0 END +
         CASE WHEN top_brand IS NOT NULL THEN 1 ELSE 0 END +
         CASE WHEN category_code IS NOT NULL THEN 1 ELSE 0 END +
         CASE WHEN cpg_code IS NOT NULL THEN 1 ELSE 0 END +
         CASE WHEN cpg_name IS NOT NULL THEN 1 ELSE 0 END) AS non_null_count,
        -- Use ROW_NUMBER to select the most complete record per brand_code
        ROW_NUMBER() OVER (
            PARTITION BY brand_code 
            ORDER BY 
                (CASE WHEN barcode IS NOT NULL THEN 1 ELSE 0 END +
                 CASE WHEN brand_name IS NOT NULL THEN 1 ELSE 0 END +
                 CASE WHEN top_brand IS NOT NULL THEN 1 ELSE 0 END +
                 CASE WHEN category_code IS NOT NULL THEN 1 ELSE 0 END +
                 CASE WHEN cpg_code IS NOT NULL THEN 1 ELSE 0 END +
                 CASE WHEN cpg_name IS NOT NULL THEN 1 ELSE 0 END) DESC
        ) AS row_rank
    FROM b_intermediate.int_brands
    WHERE 
        brand_code NOT LIKE 'TEST%BRANDCODE%'
)
INSERT INTO c_core.core_brands (
    brand_code,
    brand_id,
    barcode,
    brand_name,
    top_brand,
    category_code,
    cpg_code,
    cpg_name,
    system_modify_date
)
SELECT 
    brand_code,
    brand_id,
    barcode,
    brand_name,
    top_brand,
    category_code,
    cpg_code,
    cpg_name,
    system_modify_date
FROM RankedBrands
WHERE row_rank = 1 -- Keep the record with the most non-null fields
ON CONFLICT (brand_code) DO UPDATE 
SET 
    brand_id = EXCLUDED.brand_id,
    barcode = EXCLUDED.barcode,
    brand_name = EXCLUDED.brand_name,
    top_brand = EXCLUDED.top_brand,
    category_code = EXCLUDED.category_code,
    cpg_code = EXCLUDED.cpg_code,
    cpg_name = EXCLUDED.cpg_name,
    system_modify_date = CURRENT_TIMESTAMP;
