DROP TABLE IF EXISTS c_core.core_receipt_items CASCADE;
CREATE TABLE c_core.core_receipt_items (
    -- Primary Key
    receipt_id TEXT,                         
    user_id TEXT,                             
    partner_item_id TEXT,                     
    item_hash_id TEXT,                         -- Hash-based item identifier
    -- Pricing Information
    item_price_mod NUMERIC(10,2), 
    brand_code TEXT,            
    discounted_item_price NUMERIC(10,2),      
    price_after_coupon NUMERIC(10,2),         
    target_price NUMERIC(10,2),               
    final_price_mod NUMERIC(10,2),            
    -- Quantity Information
    quantity_purchased_mod INTEGER,           
    -- Rewards Information
    rewards_group_mod TEXT,                   
    rewards_product_partner_id TEXT,          
    points_earned NUMERIC(10,2),              
    points_not_awarded_reason TEXT,           
    points_payer_id TEXT,                     
    prevent_target_gap_points BOOLEAN,        
    -- Metadata & Flags
    deleted BOOLEAN,                          
    metabrite_campaign_id TEXT,               
    needs_fetch_review BOOLEAN,               
    needs_fetch_review_reason TEXT,           
    user_flagged_new_item BOOLEAN,            
    competitive_product TEXT,                 
    -- Modify Timestamp
    system_modify_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP, 

    PRIMARY KEY (receipt_id, user_id, partner_item_id),

    FOREIGN KEY (brand_code) REFERENCES c_core.core_brands(brand_code),

    FOREIGN KEY (user_id) REFERENCES c_core.core_users(user_id),

    FOREIGN KEY (receipt_id) REFERENCES c_core.core_receipt_order(receipt_id),

    FOREIGN KEY (item_hash_id) REFERENCES c_core.core_items(item_hash_id)

);
