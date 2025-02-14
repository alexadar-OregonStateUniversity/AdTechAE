# Review Entire Database
PGPASSWORD='fetchpass' psql -U fetchuser -d fetchdb -h 127.0.0.1 -c "SELECT tablename FROM pg_tables WHERE schemaname = 'public';"
PGPASSWORD='fetchpass' psql -U fetchuser -d fetchdb -h 127.0.0.1 -c "SELECT tablename FROM pg_tables WHERE schemaname = 'a_staging';"





