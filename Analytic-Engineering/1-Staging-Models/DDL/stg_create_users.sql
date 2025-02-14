DROP TABLE IF EXISTS a_staging.stg_users;
CREATE TABLE a_staging.stg_users (
    user_id VARCHAR(150) PRIMARY KEY NOT NULL,
    active BOOLEAN,
    create_date TIMESTAMP, 
    last_login TIMESTAMP,
    user_role VARCHAR(150),
    signup_source VARCHAR(150),
    user_state VARCHAR(2),

    CONSTRAINT stg_users_unique UNIQUE (user_id, active, create_date, last_login
                                       ,user_role, signup_source, user_state)
);


