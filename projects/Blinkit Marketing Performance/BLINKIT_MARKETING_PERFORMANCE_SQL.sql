SELECT count(*) FROM marketing_performance;

-- CHECKING THE DATA TYPE OF THE DATE COLUMN

DESCRIBE marketing_performance;

-- CONVERTING THE DATA TYPE OF DATE COLUMN FROM TEXT TO DATE

ALTER TABLE marketing_performance
 MODIFY COLUMN date DATE;


SELECT column_name, data_type
FROM information_schema.columns
WHERE table_name = 'marketing_performance';

-- CALULATING ROAS (RETURNS ON ADS SPEND)  FOR EACH COLUMN (REVENUE_GENERATED/SPEND)

SELECT *, ROUND((revenue_generated / spend), 2) AS ROAS
FROM marketing_performance
ORDER BY DATE;

-- BASIC ANALYSIS OF ROAS FOR UNDERSTANDING 

WITH CTE AS (SELECT *, ROUND((revenue_generated / spend), 2) AS ROAS
FROM marketing_performance
ORDER BY DATE)

SELECT DISTINCT channel,
    target_audience,
    MAX(ROAS) AS MAX_ROAS,
    MIN(ROAS) AS MIN_ROAS,
    ROUND(AVG(ROAS), 2) AS AVG_ROAS
FROM CTE
GROUP BY channel , target_audience
ORDER BY MAX_ROAS DESC;

-- EXPORTING THE TABLE WITH ROAS VALUES AS A CSV FILE FOR FURTHER ANALYSIS IN POWER BI 
-- (USED THE BELOW QUERY WITH A PYTHON CODE TO EXPORT TO CSV )

SELECT *, 
ROUND((revenue_generated / spend), 2) AS ROAS
FROM marketing_performance ORDER BY date;
