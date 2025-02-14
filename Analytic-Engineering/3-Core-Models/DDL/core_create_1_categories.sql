DROP TABLE IF EXISTS c_core.core_categories CASCADE;
CREATE TABLE c_core.core_categories (
    category_code TEXT PRIMARY KEY,       -- Unique identifier for the category
    category_name TEXT,                   -- Name of the category
    system_modify_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP 
);