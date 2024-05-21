select * from CoronaVirius.dbo.[Corona Virus Dataset];
--Q1 . Write a code to check NULL values

SELECT * from CoronaVirius.dbo.[Corona Virus Dataset]
WHERE Province IS NULL; 
SELECT * from CoronaVirius.dbo.[Corona Virus Dataset]
WHERE "Country Region" IS NULL; 
SELECT * from CoronaVirius.dbo.[Corona Virus Dataset]
WHERE Latitude IS NULL; 
SELECT * from CoronaVirius.dbo.[Corona Virus Dataset]
WHERE Longitude IS NULL; 
SELECT * from CoronaVirius.dbo.[Corona Virus Dataset]
WHERE Date IS NULL; 
SELECT * from CoronaVirius.dbo.[Corona Virus Dataset]
WHERE Confirmed IS NULL; 
SELECT * from CoronaVirius.dbo.[Corona Virus Dataset]
WHERE Deaths IS NULL; 
SELECT * from CoronaVirius.dbo.[Corona Virus Dataset]
WHERE Recovered IS NULL;

-- Q2. If NULL values are present, update them with zeros for all columns.
UPDATE CoronaVirius.dbo.[Corona Virus Dataset]
SET 
    Province = COALESCE(Province, ''),
    "Country Region" = COALESCE("Country Region", ''),
    Latitude = TRY_CONVERT(DECIMAL(9, 6), Latitude),
    Longitude = TRY_CONVERT(DECIMAL(9, 6), Longitude),
    Date = COALESCE(Date, ''),
    Confirmed = TRY_CONVERT(INT, Confirmed),
    Deaths = TRY_CONVERT(INT, Deaths),
    Recovered = TRY_CONVERT(INT, Recovered)
WHERE
    Latitude IS NOT NULL 
    AND Longitude IS NOT NULL 
    AND Confirmed IS NOT NULL 
    AND Deaths IS NOT NULL 
    AND Recovered IS NOT NULL;

-- Q3. Check total number of rows
SELECT 
    COUNT(*) AS total_rows
FROM 
    CoronaVirius.dbo.[Corona Virus Dataset]

-- Q4. Check what is start_date and end_date
SELECT 
    MIN(Date) AS start_date,
    MAX(Date) AS end_date
FROM 
    CoronaVirius.dbo.[Corona Virus Dataset];

-- Q5. Number of month present in dataset
SELECT COUNT(DISTINCT LEFT(Date, 7)) AS number_of_months
FROM CoronaVirius.dbo.[Corona Virus Dataset];

-- Q6. Find monthly average for confirmed, deaths, recovered
SELECT 
    LEFT(Date, 7) AS month,
    AVG(CAST(Confirmed AS INT)) AS avg_confirmed,
    AVG(CAST(Deaths AS INT)) AS avg_deaths,
    AVG(CAST(Recovered AS INT)) AS avg_recovered
FROM 
    CoronaVirius.dbo.[Corona Virus Dataset]
GROUP BY 
    LEFT(Date, 7);

-- Q7. Find most frequent value for confirmed, deaths, recovered each month
SELECT 
    LEFT(Date, 7) AS month,
    MAX(Confirmed) AS most_frequent_confirmed,
    MAX(Deaths) AS most_frequent_deaths,
    MAX(Recovered) AS most_frequent_recovered
FROM 
    CoronaVirius.dbo.[Corona Virus Dataset]
GROUP BY 
    LEFT(Date, 7);

-- Q8. Find minimum values for confirmed, deaths, recovered per year
SELECT 
    YEAR(TRY_CONVERT(DATE, Date)) AS year,
    MIN(Confirmed) AS min_confirmed,
    MIN(Deaths) AS min_deaths,
    MIN(Recovered) AS min_recovered
FROM 
    CoronaVirius.dbo.[Corona Virus Dataset]
GROUP BY 
    YEAR(TRY_CONVERT(DATE, Date));

-- Q9. Find maximum values of confirmed, deaths, recovered per year
SELECT 
    YEAR(TRY_CONVERT(DATE, Date)) AS year,
    MAX(Confirmed) AS max_confirmed,
    MAX(Deaths) AS max_deaths,
    MAX(Recovered) AS max_recovered
FROM 
    CoronaVirius.dbo.[Corona Virus Dataset]
GROUP BY 
    YEAR(TRY_CONVERT(DATE, Date));

-- Q10. The total number of cases of confirmed, deaths, recovered each month
SELECT 
    FORMAT(TRY_CONVERT(DATE, Date), 'yyyy-MM') AS month,
    SUM(CONVERT(INT, Confirmed)) AS total_confirmed,
    SUM(CONVERT(INT, Deaths)) AS total_deaths,
    SUM(CONVERT(INT, Recovered)) AS total_recovered
FROM 
    CoronaVirius.dbo.[Corona Virus Dataset]
GROUP BY 
    FORMAT(TRY_CONVERT(DATE, Date), 'yyyy-MM');

-- Q11. Check how corona virus spread out with respect to confirmed case
SELECT 
    SUM(CONVERT(INT, Confirmed)) AS total_confirmed_cases,
    AVG(CONVERT(INT, Confirmed)) AS average_confirmed_cases,
    VAR(CONVERT(INT, Confirmed)) AS variance_confirmed_cases,
    STDEV(CONVERT(INT, Confirmed)) AS stdev_confirmed_cases
FROM 
    CoronaVirius.dbo.[Corona Virus Dataset];

-- Q12. Check how corona virus spread out with respect to death case per month
SELECT 
    FORMAT(TRY_CONVERT(DATE, Date), 'yyyy-MM') AS month,
    SUM(CONVERT(INT, Deaths)) AS total_deaths,
    AVG(CONVERT(INT, Deaths)) AS average_deaths,
    VAR(CONVERT(INT, Deaths)) AS variance_deaths,
    STDEV(CONVERT(INT, Deaths)) AS stdev_deaths
FROM 
    CoronaVirius.dbo.[Corona Virus Dataset]
GROUP BY 
    FORMAT(TRY_CONVERT(DATE, Date), 'yyyy-MM');

-- Q13. Check how corona virus spread out with respect to recovered case
SELECT 
    SUM(CONVERT(INT, Recovered)) AS total_recovered_cases,
    AVG(CONVERT(INT, Recovered)) AS average_recovered_cases,
    VAR(CONVERT(INT, Recovered)) AS variance_recovered_cases,
    STDEV(CONVERT(INT, Recovered)) AS stdev_recovered_cases
FROM 
    CoronaVirius.dbo.[Corona Virus Dataset];

-- Q14. Find Country having the highest number of confirmed cases
SELECT TOP 1
    "Country Region",
    MAX(Confirmed) AS highest_confirmed_cases
FROM 
    CoronaVirius.dbo.[Corona Virus Dataset]
GROUP BY 
    "Country Region"
ORDER BY 
    highest_confirmed_cases DESC;

-- Q15. Find Country having the lowest number of death cases
SELECT 
    "Country Region",
    MIN(Deaths) AS lowest_death_cases
FROM 
    CoronaVirius.dbo.[Corona Virus Dataset]
GROUP BY 
    "Country Region"
ORDER BY 
    lowest_death_cases ASC


-- Q16. Find top 5 countries having the highest recovered cases
SELECT 
    "Country Region",
    SUM(CONVERT(INT, Recovered)) AS total_recovered
FROM 
    CoronaVirius.dbo.[Corona Virus Dataset]
GROUP BY 
    "Country Region"
ORDER BY 
    total_recovered DESC;
