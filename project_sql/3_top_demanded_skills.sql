/*
 To identify the top 5 in-demand skills for Data Analysts across all job postings 
 (not just remote), you'll follow a similar structure—but remove the remote filter 
 and keep the focus on
*/

SELECT 
    s.skill_id,
    s.skills AS skill_name,
    COUNT(*) AS job_postings
FROM 
    job_postings_fact j
INNER JOIN 
    skills_job_dim sj ON j.job_id = sj.job_id
INNER JOIN 
    skills_dim s ON sj.skill_id = s.skill_id
WHERE 
    j.job_title_short = 'Data Analyst'
GROUP BY 
    s.skill_id, s.skills
ORDER BY 
    job_postings DESC
LIMIT 5;