#!/bin/bash

# Installation of PostgreSQL
sudo apt update && sudo apt install -y postgresql postgresql-contrib
sudo update-alternatives --install /usr/bin/psql psql /usr/lib/postgresql/17/bin/psql 1
echo 'export PATH="/usr/lib/postgresql/17/bin:$PATH"' >> ~/.bashrc
source ~/.bashrc

# Start PostgreSQL Server
sudo service postgresql start

# Ensure the PostgreSQL user and database exist
sudo -i -u postgres psql <<EOF
DO \$\$ 
BEGIN
    IF NOT EXISTS (SELECT FROM pg_roles WHERE rolname = 'fetchuser') THEN
        CREATE USER fetchuser;
        ALTER USER fetchuser WITH SUPERUSER;
    END IF;
END \$\$;

DROP DATABASE IF EXISTS fetchdb;
CREATE DATABASE fetchdb;
GRANT ALL PRIVILEGES ON DATABASE fetchdb TO fetchuser;
GRANT ALL ON SCHEMA public TO fetchuser;
EOF

# Set fetchuser as Default for Current Session
export PGUSER=fetchuser
export PGDATABASE=fetchdb
export PGHOST=127.0.0.1

# Connect to PostgreSQL and verify
# psql -c "\l"  # List databases
# psql -c "\q"  # Quit PostgreSQL

# Stop PostgreSQL Server
sudo service postgresql stop
sudo service postgresql status  
