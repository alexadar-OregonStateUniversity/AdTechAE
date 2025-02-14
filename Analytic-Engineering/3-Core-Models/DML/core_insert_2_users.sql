INSERT INTO c_core.core_users (
    user_id,
    active,
    create_date,
    last_login,
    user_role,
    signup_source,
    user_state,
    system_modify_date
)
SELECT 
    user_id,
    active,
    create_date,
    last_login,
    user_role,
    signup_source,
    user_state,
    CURRENT_TIMESTAMP 
FROM b_intermediate.int_users
ON CONFLICT (user_id) DO UPDATE 
SET 
    active = EXCLUDED.active,
    create_date = EXCLUDED.create_date,
    last_login = EXCLUDED.last_login,
    user_role = EXCLUDED.user_role,
    signup_source = EXCLUDED.signup_source,
    user_state = EXCLUDED.user_state,
    system_modify_date = CURRENT_TIMESTAMP;
