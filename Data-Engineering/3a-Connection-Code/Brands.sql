/*
Contains the largely raw data from the Brands.jsonl file

    Execution:
    psql -U fetchuser -d fetchdb -h 127.0.0.1 < Operation >
    psql -c "DROP TABLE IF EXISTS Brands;"
    psql -f Brands.sql 
    psql -c "SELECT * FROM Brands;"
*/

DROP TABLE IF EXISTS Brands;
CREATE TABLE Brands (
    brand_id TEXT, 
    barcode TEXT, 
    brand_code TEXT, 
    category TEXT, 
    category_code TEXT,
    cpg_code TEXT,
    cpg_name TEXT, 
    top_brand TEXT,
    brand_name TEXT
);