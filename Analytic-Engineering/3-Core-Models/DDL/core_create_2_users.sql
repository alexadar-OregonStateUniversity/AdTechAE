DROP TABLE IF EXISTS c_core.core_users CASCADE;
CREATE TABLE c_core.core_users(
    user_id VARCHAR(150) NOT NULL,
    active BOOLEAN,
    create_date DATE,
    last_login DATE,
    user_role VARCHAR(150),
    signup_source VARCHAR(150),
    user_state VARCHAR(2),
    PRIMARY KEY(user_id),
    system_modify_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
