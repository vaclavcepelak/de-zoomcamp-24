-- BigQuery SQL 

-- Create an external table
-- Download data from here and upload them to GCS
CREATE SCHEMA IF NOT EXISTS `test-terraform-412514.homework_03`;

CREATE OR REPLACE EXTERNAL TABLE `test-terraform-412514.homework_03.green_taxi_data_2022_external` 
OPTIONS (
  format = 'PARQUET',
  uris = ['gs://mage-zoomcamp-vaclav-cepelak/homework_03/monthly_data_*.parquet']
)
;

CREATE OR REPLACE TABLE `test-terraform-412514.homework_03.green_taxi_data_2022` AS
SELECT
  *
FROM `test-terraform-412514.homework_03.green_taxi_data_2022_external`
;

-- Question 2: Write a query to count the distinct number of PULocationIDs for the entire dataset on both the tables.
SELECT
  COUNT(DISTINCT PULocationID)
FROM `test-terraform-412514.homework_03.green_taxi_data_2022_external`
;

SELECT
  COUNT(DISTINCT PULocationID)
FROM `test-terraform-412514.homework_03.green_taxi_data_2022`
;

-- Question 3. How many records have a fare_amount of 0?
SELECT
  COUNT(*)
FROM `test-terraform-412514.homework_03.green_taxi_data_2022_external`
WHERE fare_amount = 0
;

-- Question 5:
-- Write a query to retrieve the distinct PULocationID between lpep_pickup_datetime 06/01/2022 and 06/30/2022 (inclusive)
-- Use the materialized table you created earlier in your from clause and note the estimated bytes. Now change the table
-- in the from clause to the partitioned table you created for question 4 and note the estimated bytes processed. What are
-- these values?

CREATE OR REPLACE TABLE `test-terraform-412514.homework_03.green_taxi_data_2022_partitioned`
PARTITION BY DATE(lpep_pickup_datetime) AS
SELECT
  *
FROM `test-terraform-412514.homework_03.green_taxi_data_2022_external`
;

SELECT
  COUNT(DISTINCT PULocationID)
FROM `test-terraform-412514.homework_03.green_taxi_data_2022` 
WHERE DATE(lpep_pickup_datetime) BETWEEN '2022-06-01' AND '2022-06-30'
;

SELECT
  COUNT(DISTINCT PULocationID)
FROM `test-terraform-412514.homework_03.green_taxi_data_2022_partitioned` 
WHERE DATE(lpep_pickup_datetime) BETWEEN '2022-06-01' AND '2022-06-30'
;
