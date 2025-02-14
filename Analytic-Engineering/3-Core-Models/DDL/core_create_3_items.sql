DROP TABLE IF EXISTS c_core.core_items CASCADE;
CREATE TABLE c_core.core_items (
    Item_Hash_ID TEXT PRIMARY KEY,
    Item_Description_MOD TEXT NOT NULL,
    Item_Number_Mod TEXT NOT NULL,
    system_modify_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
