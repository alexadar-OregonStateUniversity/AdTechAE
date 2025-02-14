INSERT INTO a_staging.stg_brands
(
    brand_id,
    barcode,
    brand_code,
    category,
    category_code,
    cpg_code,
    cpg_name,
    top_brand,
    brand_name
)
SELECT 
    brand_id::TEXT,
    barcode::TEXT,
    brand_code::TEXT,
    category::TEXT,
    category_code::TEXT,
    cpg_code::TEXT,
    cpg_name::TEXT,
    top_brand::BOOLEAN,
    brand_name::TEXT
FROM public.brands
ON CONFLICT (brand_id) DO NOTHING;