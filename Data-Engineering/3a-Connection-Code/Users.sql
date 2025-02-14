/*
Contains the largely raw data from the Users.jsonl file

    Execution:
    psql -U fetchuser -d fetchdb -h 127.0.0.1 < Operation >
    psql -c "DROP TABLE IF EXISTS Users;"
    psql -f Users.sql 
    psql -c "SELECT * FROM Users;"
*/

DROP TABLE IF EXISTS Users;
CREATE TABLE Users (
    user_id TEXT,
    active TEXT,
    create_date TEXT,
    last_login TEXT,
    user_role TEXT,
    signup_source TEXT,
    user_state TEXT
);
