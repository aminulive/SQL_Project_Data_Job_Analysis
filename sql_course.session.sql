/* To find the top 10 skills with the highest job postings that are 
remote (work from home), you need to join the relevant tables 
and filter for remote jobs.

*/

SELECT 
    s.skill_id,
    s.skills AS skill_name,
    COUNT(*) AS job_postings
FROM 
    job_postings_fact j
LEFT JOIN 
    skills_job_dim sj ON j.job_id = sj.job_id
LEFT JOIN 
    skills_dim s ON sj.skill_id = s.skill_id
WHERE 
    j.job_work_from_home = TRUE
    AND j.job_title_short = 'Data Analyst'
    AND s.skill_id IS NOT NULL
GROUP BY 
    s.skill_id, s.skills
ORDER BY 
    job_postings DESC
LIMIT 10;