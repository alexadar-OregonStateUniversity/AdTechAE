INSERT INTO b_intermediate.int_brands(
    brand_id ,
    barcode ,
    brand_code ,
    category ,
    category_code ,
    cpg_code ,
    cpg_name ,
    top_brand ,
    brand_name ,
    system_add_date
)
SELECT 
    brand_id ,
    barcode ,
    brand_code ,
    category ,
    category_code ,
    cpg_code ,
    cpg_name ,
    top_brand BOOLEAN,
    brand_name ,
    CURRENT_TIMESTAMP
FROM a_staging.stg_brands