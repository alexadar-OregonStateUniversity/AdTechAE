INSERT INTO a_staging.stg_users (    
    user_id,
    active,
    create_date, 
    last_login,
    user_role,
    signup_source,
    user_state
)
SELECT 
    user_id::VARCHAR(150),
    active::BOOLEAN,
    create_date::TIMESTAMP, 
    last_login::TIMESTAMP,
    user_role::VARCHAR(150),
    signup_source::VARCHAR(150),
    user_state::VARCHAR(2)
FROM public.users
ON CONFLICT (user_id) DO NOTHING;
