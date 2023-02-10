-- The dataset for this exercise has been derived from the `Indeed Data Scientist/Analyst/Engineer` [dataset](https://www.kaggle.com/elroyggj/indeed-dataset-data-scientistanalystengineer) on kaggle.com. 

-- Before beginning to answer questions, take some time to review the data dictionary and familiarize yourself with the data that is contained in each column.

-- #### Provide the SQL queries and answers for the following questions/tasks using the data_analyst_jobs table you have created in PostgreSQL:

-- 1.	How many rows are in the data_analyst_jobs table?
SELECT COUNT(*)
FROM data_analyst_jobs;
-- 1793

-- 2.	Write a query to look at just the first 10 rows. What company is associated with the job posting on the 10th row?
SELECT *
FROM data_analyst_jobs
LIMIT 10;
-- ExxonMobil

-- 3.	How many postings are in Tennessee? How many are there in either Tennessee or Kentucky?
SELECT location, COUNT(location)
FROM data_analyst_jobs 
GROUP BY location;
-- There are 21 postings in TN, 6 postings in KY

-- 4.	How many postings in Tennessee have a star rating above 4?
SELECT COUNT(star_rating)
FROM data_analyst_jobs
WHERE location='TN'
AND star_rating>4;
-- 3

-- 5.	How many postings in the dataset have a review count between 500 and 1000?
SELECT COUNT(review_count)
FROM data_analyst_jobs
WHERE review_count BETWEEN 500 AND 1000;
--151

-- 6.	Show the average star rating for companies in each state. The output should show the state as `state` and the average rating for the state as `avg_rating`. Which state shows the highest average rating?
SELECT location AS "state", AVG(star_rating) AS "avg_rating"
FROM data_analyst_jobs
GROUP BY state;
-- Kansas shows the highest average rating

-- 7.	Select unique job titles from the data_analyst_jobs table. How many are there?
SELECT COUNT(DISTINCT title)
FROM data_analyst_jobs;
-- 881

-- 8.	How many unique job titles are there for California companies?
SELECT COUNT(DISTINCT title)
FROM data_analyst_jobs
WHERE location='CA';
--230

-- 9.	Find the name of each company and its average star rating for all companies that have more than 5000 reviews across all locations. How many companies are there with more that 5000 reviews across all locations?
SELECT company, AVG(star_rating)
FROM data_analyst_jobs
WHERE review_count > 5000
GROUP BY company
ORDER BY company;
-- 41

-- 10.	Add the code to order the query in #9 from highest to lowest average star rating. Which company with more than 5000 reviews across all locations in the dataset has the highest star rating? What is that rating?
SELECT company, AVG(star_rating)
FROM data_analyst_jobs
WHERE review_count > 5000
GROUP BY star_rating, company
ORDER BY star_rating DESC;
-- American Express with a 4.199 rating

-- 11.	Find all the job titles that contain the word ‘Analyst’. How many different job titles are there? 
SELECT COUNT(title)
FROM data_analyst_jobs
WHERE title LIKE '%_nalyst%'
	OR title LIKE '%_NALYST%';
-- 1669

-- 12.	How many different job titles do not contain either the word ‘Analyst’ or the word ‘Analytics’? What word do these positions have in common?
SELECT title
FROM data_analyst_jobs
WHERE title NOT LIKE '%_nalyst%'
	AND title NOT LIKE '%_nalytics%'
	AND title NOT LIKE '%_NALYST%'
	AND title NOT LIKE '%_NALYTICS%';
--4. The non-analytics listings use words like "Data Consultant" or "Data Specialist" or specifically mention Tableau.




-- **BONUS:**

-- You want to understand which jobs requiring SQL are hard to fill. Find the number of jobs by industry (domain) that require SQL and have been posted longer than 3 weeks. 
SELECT domain, COUNT(title) AS jobs_available
FROM data_analyst_jobs
WHERE skill='SQL'
	AND days_since_posting>21
GROUP BY domain;
-- 15 total jobs

--  - Disregard any postings where the domain is NULL. 
SELECT domain, COUNT(title) AS jobs_available
FROM data_analyst_jobs
WHERE skill='SQL'
	AND days_since_posting>21
	AND domain IS NOT NULL
GROUP BY domain; 
-- 11 total jobs

--  - Order your results so that the domain with the greatest number of `hard to fill` jobs is at the top.
SELECT domain, COUNT(title) AS jobs_available
FROM data_analyst_jobs
WHERE skill='SQL'
	AND days_since_posting>21
	AND domain IS NOT NULL
GROUP BY domain
ORDER BY jobs_available DESC;
--got it

--   - Which three industries are in the top 4 on this list? How many jobs have been listed for more than 3 weeks for each of the top 4?
-- Consulting & Business Services - 5 jobs
-- Consumer Goods & Services - 2 jobs
-- Computers & Electronics - 1 jobs
-- Internet & Software - 1 jobs

-- Extra Work
-- 1. For each company, give the company name and the difference between its star rating and the national average star rating.
SELECT AVG(star_rating)
FROM data_analyst_jobs
-- Average Star Rating: 3.7919270704752604
SELECT company, (star_rating -3.7919270704752604) AS star_difference
FROM data_analyst_jobs
WHERE star_rating IS NOT NULL 
GROUP BY company, star_rating
ORDER BY star_difference DESC;

-- 2. Using a correlated subquery: For each company, give the company name, its domain, its star rating, and its domain average star rating
SELECT title, domain, star_rating 
FROM data_analyst_jobs
WHERE

-- 3. Repeat question 2 using a CTE instead of a correlated subquery
