--check catalogs
SHOW CATALOGS;
SHOW SCHEMAS FROM iceberg;
SHOW TABLES IN iceberg.efdna;

--EFDNA schema & Table
CREATE SCHEMA iceberg.efdna;

CREATE TABLE iceberg.efdna.customer (
    customer_id BIGINT,
    customer_name VARCHAR,
    customer_email VARCHAR,
    update_count INTEGER,
    created_ts TIMESTAMP,
    updated_ts TIMESTAMP
);

CREATE TABLE iceberg.efdna.account (
    account_id BIGINT,
    customer_id BIGINT,
    account_type VARCHAR,
    balance DECIMAL(18,2),
    account_status VARCHAR,
    created_ts TIMESTAMP
);

CREATE TABLE iceberg.efdna.transaction (
    transaction_id BIGINT,
    account_id BIGINT,
    transaction_type VARCHAR,
    amount DECIMAL(18,2),
    transaction_ts TIMESTAMP
);