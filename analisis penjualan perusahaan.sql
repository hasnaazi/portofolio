SELECT ORDERNUMBER, QUANTITYORDERED,
  rank() OVER (ORDER BY QUANTITYORDERED DESC) AS rank,
  dense_rank() OVER (ORDER BY QUANTITYORDERED DESC) AS dense_rank,
  row_number() OVER (ORDER BY QUANTITYORDERED DESC) AS row_number
  
  from raw_data ORDER BY QUANTITYORDERED DESC
partition digunakan untuk mengelompokkan data berdasarkan jenisny
over pertanda bahwa dia windows function

SELECT ORDERNUMBER, QUANTITYORDERED, SALES, ORDERDATE, PRODUCTLINE,
  MAX(SALES) OVER (PARTITION BY PRODUCTLINE ) AS max_sales,
  MIN(SALES ) OVER (PARTITION BY PRODUCTLINE) AS min_sales,
  SUM(SALES) OVER (PARTITION BY PRODUCTLINE) AS sum_sales,
  AVG(SALES) OVER (PARTITION BY PRODUCTLINE) AS avg_sales
  FROM `my-project-1-data-analyst.satu.sale`

SELECT 
MONTH_V2,
sum_quantityordered,
LAG(sum_quantityordered) OVER (ORDER BY MONTH) AS prev_month_sum_quantityordered
FROM
(
SELECT  
  DATE_TRUNC(ORDERDATE, MONTH) as MONTH,
  FORMAT_TIMESTAMP("%B", timestamp(ORDERDATE)) AS MONTH_V2,
  
  SUM(QUANTITYORDERED) AS sum_quantityordered
  
  FROM `my-project-1-data-analyst.satu.sale`
  group by 
  MONTH,
  MONTH_V2
  ORDER BY MONTH_V2
 )

-- Penggunaa LAG
SELECT 
    MONTH,
    MONTH_V2,
    TOTAL_SALES,
    LAG(TOTAL_SALES) OVER (ORDER BY MONTH ) AS PREV_MONTH

FROM 
(
SELECT 
    DATE_TRUNC(ORDERDATE, MONTH) AS MONTH,
    FORMAT_TIMESTAMP("%B", timestamp (ORDERDATE)) AS MONTH_V2,
    SUM(SALES) AS TOTAL_SALES
FROM 
    `my-project-1-data-analyst.satu.sale`
GROUP BY MONTH, MONTH_V2
)
ORDER BY MONTH ASC

AGGREGATION FUNCTION 
SELECT 
    COUNTRY,
    COUNT(DISTINCT CITY) AS TOTAL_CITY,
    STRING_AGG (DISTINCT CITY, "-") AS LIST_CITY

FROM 
`my-project-1-data-analyst.satu.sale`
GROUP BY COUNTRY
ORDER BY TOTAL_CITY DESC

-- Date Function

SELECT 
DISTINCT COUNTRY,
CITY,
STATUS,
EXTRACT(DAY FROM ORDERDATE) AS DAY,
EXTRACT(WEEK FROM ORDERDATE) AS WEEK,
EXTRACT(MONTH FROM ORDERDATE) AS MONTH,
EXTRACT(QUARTER FROM ORDERDATE) AS QUARTER,
EXTRACT(YEAR FROM ORDERDATE) AS YEAR,
FORMAT_DATE("%A", ORDERDATE) AS DAY_FULLNAME,
FORMAT_DATE("%a", ORDERDATE) AS DAY_SHORTNAME,
FORMAT_DATE("%B", ORDERDATE) AS MONTH_FULLNAME,
FORMAT_DATE("%b", ORDERDATE) AS MONTH_SHORTNAME,
DATE_TRUNC(ORDERDATE, MONTH) AS START_OF_MONTH,
EXTRACT (DAYOFWEEK FROM ORDERDATE) AS DAY_OF_WEEK,
CAST(FORMAT_DATE("%j", ORDERDATE)AS INT64 ) AS DAY_OF_YEAR
FROM 
`my-project-1-data-analyst.satu.sale`