/*
Question: What skills are required for the top-paying 'Data Analyst' jobs?
- Use the top 10 highest-paying Data Analyst Jobs from first query
- Add the specific skills required for these roles
- Why? It provides a detailed look at which high-paying jobs demand certain skills,
helping job seekers understand which skills to develop that align with top salaries.
*/
-- Get top 10 highest-paying remote Data Analyst jobs with salary; include even if company name is missing.

SELECT
    cd.name AS company_name,
    j.job_title,
    j.salary_year_avg,
    COALESCE(STRING_AGG(sd.skills, ', ' ORDER BY sd.skills), 'No skills listed') AS required_skills
FROM job_postings_fact j
LEFT JOIN company_dim cd ON j.company_id = cd.company_id
LEFT JOIN skills_job_dim sjd ON j.job_id = sjd.job_id
LEFT JOIN skills_dim sd ON sjd.skill_id = sd.skill_id
WHERE
    j.job_title_short = 'Data Analyst'
    AND j.job_location = 'Anywhere'
    AND j.salary_year_avg IS NOT NULL
GROUP BY
    j.job_id, cd.name, j.job_title, j.salary_year_avg
ORDER BY
    j.salary_year_avg DESC
LIMIT 10;