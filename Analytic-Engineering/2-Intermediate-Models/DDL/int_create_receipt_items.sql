DROP TABLE IF EXISTS b_intermediate.int_receipt_items;
CREATE TABLE b_intermediate.int_receipt_items (
    -- Primary Key
    receipt_id TEXT,                         
    user_id TEXT,                             
    partner_item_id TEXT,                     
    -- Identity Fields
    item_description_mod TEXT,                -- Best available description
    item_number_mod TEXT,                     -- Best available item number
    item_price_mod NUMERIC(10,2),             -- Best available item price
    brand_code TEXT,
    -- Pricing Information
    discounted_item_price NUMERIC(10,2),      
    price_after_coupon NUMERIC(10,2),         
    target_price NUMERIC(10,2),               
    final_price_mod NUMERIC(10,2),            -- Best available final price
    -- Quantity Information
    quantity_purchased_mod INTEGER,           -- Best available quantity purchased
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

    PRIMARY KEY (receipt_id, user_id, partner_item_id)
);
