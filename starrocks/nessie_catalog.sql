SET CATALOG default_catalog;
DROP CATALOG iceberg_nessie;


SHOW CATALOGS;



CREATE EXTERNAL CATALOG iceberg_nessie
PROPERTIES (
  "type" = "iceberg",
  "iceberg.catalog.type" = "rest",
  "iceberg.catalog.uri" = "http://efdna-nessie-catalog:19120/iceberg/",
  "iceberg.catalog.warehouse" = "warehouse",
  "iceberg.catalog.vended-credentials-enabled" = "false",
  "aws.s3.endpoint" = "http://efdna-minio-storage:9000",
  "aws.s3.access_key" = "minioadmin",
  "aws.s3.secret_key" = "minioadmin",
  "aws.s3.region" = "us-east-1",
  "aws.s3.enable_path_style_access" = "true",
  "aws.s3.use_instance_profile" = "false",
  "aws.s3.use_aws_sdk_default_behavior" = "false"
);


SET CATALOG iceberg_nessie;
SHOW DATABASES;
SHOW TABLES FROM iceberg_nessie.efdna;


SELECT * FROM iceberg_nessie.efdna.customer;
SELECT * FROM iceberg_nessie.efdna.account;
SELECT * FROM iceberg_nessie.efdna.`transaction`;

SELECT c.customer_name, a.account_type, a.balance
FROM iceberg_nessie.efdna.customer c
JOIN iceberg_nessie.efdna.account a ON a.customer_id = c.customer_id;




SHOW CREATE CATALOG iceberg_nessie;


SELECT * FROM iceberg_nessie.efdna.customer LIMIT 10;
