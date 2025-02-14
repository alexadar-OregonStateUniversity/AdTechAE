DROP TABLE IF EXISTS c_core.core_brands CASCADE;
CREATE TABLE c_core.core_brands (
    brand_id TEXT UNIQUE,
    barcode TEXT,
    brand_code TEXT PRIMARY KEY, 
    brand_name TEXT,
    top_brand BOOLEAN,
    category_code TEXT,
    cpg_code TEXT,
    cpg_name TEXT,
    system_modify_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (category_code) REFERENCES c_core.core_categories(category_code) 
        DEFERRABLE INITIALLY DEFERRED
);

