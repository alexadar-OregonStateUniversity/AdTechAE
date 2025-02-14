DROP TABLE IF EXISTS b_intermediate.int_receipt_order;
CREATE TABLE b_intermediate.int_receipt_order(

    receipt_id              TEXT PRIMARY KEY,   -- uuid for this receipt

    purchase_date           TIMESTAMP,          -- the date of the purchase
    total_spent             NUMERIC(10,2),      -- The total amount on the receipt
    purchased_item_count    INTEGER,            -- Count of number of items on the receipt

    date_scanned            TIMESTAMP,          -- Date that the user scanned their receipt
    finish_date             TIMESTAMP,          -- Date that the receipt finished processing
    rewards_status          VARCHAR(150),       -- status of the receipt through receipt validation and processing

    points_earned           NUMERIC(10,2),      -- The number of points earned for the receipt
    bonus_points_earned     NUMERIC(10,2),      -- Number of bonus points that were awarded upon receipt completion
    bonus_earned_reason     TEXT,               -- event that triggered bonus points
    points_award_date       TIMESTAMP,          -- The date we awarded points for the transaction

    create_date             TIMESTAMP,          -- The date that the event was created
    modify_date             TIMESTAMP,          -- The date the event was modified

    user_id                 TEXT,                -- user id foreign key

    system_modify_date      TIMESTAMP           DEFAULT CURRENT_TIMESTAMP
);
