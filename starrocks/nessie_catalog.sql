-- Connect to StarRocks using MySQL client:
-- mysql -h 127.0.0.1 -P 9030 -u root
-- Password is blank by default.

DROP CATALOG iceberg_nessie;

-- 1) Create external catalog for Iceberg metadata in Nessie and storage in MinIO
CREATE EXTERNAL CATALOG iceberg_nessie
COMMENT "Iceberg catalog backed by Nessie + MinIO"
PROPERTIES (
  "type" = "iceberg",
  "iceberg.catalog.type" = "rest",
  "iceberg.catalog.uri" = "http://efdna-nessie-catalog:19120/api/v2",
  "iceberg.catalog.warehouse" = "s3://warehouse/",
  "aws.s3.access_key" = "minioadmin",
  "aws.s3.secret_key" = "minioadmin",
  "aws.s3.endpoint" = "http://efdna-minio-storage:9000",
  "aws.s3.enable_path_style_access" = "true",
  "aws.s3.region" = "us-east-1"
);

-- 2) Check catalog creation
SHOW CATALOGS;


-- 3) Use the catalog and inspect databases/schemas
SET CATALOG iceberg_nessie;
SHOW DATABASES;
SHOW TABLES;

-- 4) If the schema is already present in Nessie, query it
USE efdna;
SHOW TABLES;
SELECT * FROM efdna.customer LIMIT 10;
SELECT * FROM efdna.account LIMIT 10;
SELECT * FROM efdna.transaction LIMIT 10;

-- 5) If the schema does not exist yet, create it and table definitions
CREATE DATABASE IF NOT EXISTS efdna;
USE efdna;

CREATE TABLE IF NOT EXISTS customer (
    customer_id BIGINT,
    customer_name VARCHAR(255),
    customer_email VARCHAR(255),
    update_count INT,
    created_ts DATETIME,
    updated_ts DATETIME
) DUPLICATE KEY(customer_id)
DISTRIBUTED BY HASH(customer_id) BUCKETS 10;

CREATE TABLE IF NOT EXISTS account (
    account_id BIGINT,
    customer_id BIGINT,
    account_type VARCHAR(50),
    balance DECIMAL(18,2),
    account_status VARCHAR(50),
    created_ts DATETIME
) DUPLICATE KEY(account_id)
DISTRIBUTED BY HASH(account_id) BUCKETS 10;

CREATE TABLE IF NOT EXISTS transaction (
    transaction_id BIGINT,
    account_id BIGINT,
    transaction_type VARCHAR(50),
    amount DECIMAL(18,2),
    transaction_ts DATETIME
) DUPLICATE KEY(transaction_id)
DISTRIBUTED BY HASH(transaction_id) BUCKETS 10;

SHOW TABLES;
