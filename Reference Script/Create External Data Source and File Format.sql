CREATE DATABASE SCOPED CREDENTIAL cred_arijit
WITH
    IDENTITY = 'Managed Identity'

CREATE EXTERNAL DATA SOURCE source_silver
WITH
(
    LOCATION = 'https://awprojectdatalakestorage.blob.core.windows.net/silver', 
    CREDENTIAL = cred_arijit
)

CREATE EXTERNAL DATA SOURCE source_gold
WITH
(
    LOCATION = 'https://awprojectdatalakestorage.blob.core.windows.net/gold', 
    CREDENTIAL = cred_arijit
)

CREATE EXTERNAL FILE FORMAT format_parquet
WITH
(
    FORMAT_TYPE = PARQUET,
    DATA_COMPRESSION = 'org.apache.hadoop.io.compress.SnappyCodec'
)
--------------------------------
--MOVE DATA TO GOLD LAYER
--------------------------------

CREATE EXTERNAL TABLE gold.extsales
WITH
(
    LOCATION = 'extsales',
    DATA_SOURCE = source_gold,
    FILE_FORMAT = format_parquet
)AS 
SELECT * FROM gold.sales

SELECT * FROM gold.extsales


