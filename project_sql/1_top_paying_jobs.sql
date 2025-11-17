/* 
Question: What are the top-paying jobs?
- Identify the top 10 highest-paying 'Data Analyst' roles that are available remotely.
- Focus on job postings with specified salaries (remove nulls)
- Why? Highlight the top-paying opportunities for Data Analysts, offering insights into
*/

/*
🎯 GOAL:
Find the top 10 highest-paying 'Data Analyst' jobs that:
  - Are labeled as 'Anywhere' (i.e., remote),
  - Have a non-null annual salary,
  - Are included even if the company name is missing.

✅ STRATEGY:
1. First, isolate only the relevant jobs using a CTE (Common Table Expression).
2. Then, enrich those jobs with company names—but do NOT drop jobs if company data is missing.
3. Sort by salary (descending) and limit to top 10.
*/

-- Step 1: Define a CTE to pre-filter only the jobs we care about.
-- This keeps the query clean, readable, and efficient.
WITH top_10_jobs AS (
    SELECT *
    FROM job_postings_fact
    WHERE
        job_title_short = 'Data Analyst'     -- Only Data Analyst roles
        AND job_location = 'Anywhere'        -- Fully remote positions
        AND salary_year_avg IS NOT NULL      -- Must have a known annual salary
        -- ⚠️ Note: We do NOT filter by company here—company info is secondary.
)

-- Step 2: Select from the filtered job list (NOT from company_dim!)
-- Why? Because JOBS are our primary focus—not companies.
SELECT
    cd.name AS company_name,                 -- May be NULL—and that’s OK!
    tj.job_id,
    tj.job_title,
    tj.job_location,
    tj.job_schedule_type,
    tj.salary_year_avg,
    tj.job_posted_date

-- Step 3: Start FROM the job list (top_10_jobs), then LEFT JOIN company data.
-- 🔄 Why LEFT JOIN?
--    → We want to KEEP every job in top_10_jobs, even if there's no matching company.
--    → If we used INNER JOIN, jobs with missing/incomplete company info would vanish.
--    → Since your priority is the JOB (not the company name), LEFT JOIN is essential.
FROM
    top_10_jobs tj
LEFT JOIN company_dim cd
    ON tj.company_id = cd.company_id         -- Link jobs to companies via company_id

-- Step 4: Sort by salary (highest first) to get the top-paying roles.
-- We sort on tj.salary_year_avg (from the CTE) to ensure accuracy.
ORDER BY
    tj.salary_year_avg DESC

-- Step 5: Limit to top 10 results.
-- This applies AFTER sorting, so you truly get the 10 highest-paying matching jobs.
LIMIT 10;