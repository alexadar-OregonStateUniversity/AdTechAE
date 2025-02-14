#!/bin/bash

# PostgreSQL Credentials
export PGPASSWORD='fetchpass'
DB_USER='fetchuser'
DB_NAME='fetchdb'
DB_HOST='127.0.0.1'

# Execute all DDL scripts
echo "Executing DDL scripts..."
for sql_file in DDL/*.sql; do
    [ -f "$sql_file" ] && psql -U "$DB_USER" -d "$DB_NAME" -h "$DB_HOST" -f "$sql_file"
done

# Execute all DML scripts
echo "Executing DML scripts..."
for sql_file in DML/*.sql; do
    [ -f "$sql_file" ] && psql -U "$DB_USER" -d "$DB_NAME" -h "$DB_HOST" -f "$sql_file"
done

echo "Intermediate Models Done."
