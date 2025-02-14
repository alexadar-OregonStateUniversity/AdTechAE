DROP TABLE IF EXISTS b_intermediate.int_users;
CREATE TABLE b_intermediate.int_users(
    user_id VARCHAR(150) NOT NULL,
    active BOOLEAN,
    create_date TIMESTAMP,
    last_login TIMESTAMP,
    user_role VARCHAR(150),
    signup_source VARCHAR(150),
    user_state VARCHAR(2),
    PRIMARY KEY(user_id),
    system_modify_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
