PGPASSWORD='fetchpass' psql -U fetchuser -d fetchdb -h 127.0.0.1 -c "CREATE SCHEMA IF NOT EXISTS a_staging;"
PGPASSWORD='fetchpass' psql -U fetchuser -d fetchdb -h 127.0.0.1 -c "CREATE SCHEMA IF NOT EXISTS b_intermediate;"
PGPASSWORD='fetchpass' psql -U fetchuser -d fetchdb -h 127.0.0.1 -c "CREATE SCHEMA IF NOT EXISTS c_core;"
PGPASSWORD='fetchpass' psql -U fetchuser -d fetchdb -h 127.0.0.1 -c "CREATE SCHEMA IF NOT EXISTS d_mart;"
