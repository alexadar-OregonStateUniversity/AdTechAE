DROP TABLE IF EXISTS b_intermediate.int_brands;
CREATE TABLE b_intermediate.int_brands(
    brand_id TEXT PRIMARY KEY,
    barcode TEXT,
    brand_code TEXT,
    brand_name TEXT,
    top_brand BOOLEAN,
    category TEXT,
    category_code TEXT,
    cpg_code TEXT,
    cpg_name TEXT,
    system_add_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);