/* 
Question: What are the top-paying jobs?
- Identify the top 10 highest-paying 'Data Analyst' roles that are available remotely.
- Focus on job postings with specified salaries (remove nulls)
- Why? Highlight the top-paying opportunities for Data Analysts, offering insights into
*/

-- Get top 10 highest-paying remote Data Analyst jobs with salary; include even if company name is missing.
SELECT
    cd.name AS company_name,
    j.job_title,
    j.salary_year_avg
FROM job_postings_fact j
LEFT JOIN company_dim cd ON j.company_id = cd.company_id
WHERE
    j.job_title_short = 'Data Analyst'
    AND j.job_location = 'Anywhere'
    AND j.salary_year_avg IS NOT NULL
ORDER BY j.salary_year_avg DESC
LIMIT 10;