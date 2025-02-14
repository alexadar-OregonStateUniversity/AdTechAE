DROP TABLE IF EXISTS a_staging.stg_brands;
CREATE TABLE a_staging.stg_brands (
    brand_id TEXT PRIMARY KEY,
    barcode TEXT,
    brand_code TEXT,
    category TEXT,
    category_code TEXT,
    cpg_code TEXT,
    cpg_name TEXT,
    top_brand BOOLEAN,
    brand_name TEXT
);
