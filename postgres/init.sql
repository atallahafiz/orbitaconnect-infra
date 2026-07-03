-- Aktifkan extension untuk monitoring query berat (Simulasi Cloud SQL Insights)
CREATE EXTENSION IF NOT EXISTS pg_stat_statements;

-- Grant least-privilege access (Prinsip Zero Trust)
GRANT ALL PRIVILEGES ON DATABASE orbitaconnect TO bagisto_user;
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT ALL ON TABLES TO bagisto_user;
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT ALL ON SEQUENCES TO bagisto_user;