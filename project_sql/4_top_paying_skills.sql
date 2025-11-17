/*

To identify the top-paying skills for Data Analysts, we’ll calculate 
the average annual salary for each skill based on job postings where that 
skill appears—then rank skills by that average.

Since a single job can list multiple skills, each skill in that job “inherits” 
the job’s salary_year_avg. This gives a fair estimate of how much jobs 
requiring that skill tend to pay.

*/


SELECT 
    s.skill_id,
    s.skills AS skill_name,
    ROUND(AVG(j.salary_year_avg), 2) AS avg_salary,
    COUNT(*) AS job_postings
FROM 
    job_postings_fact j
INNER JOIN 
    skills_job_dim sj ON j.job_id = sj.job_id
INNER JOIN 
    skills_dim s ON sj.skill_id = s.skill_id
WHERE 
    j.job_title_short = 'Data Analyst'
    AND j.salary_year_avg IS NOT NULL
GROUP BY 
    s.skill_id, s.skills

ORDER BY 
    avg_salary DESC
LIMIT 25;