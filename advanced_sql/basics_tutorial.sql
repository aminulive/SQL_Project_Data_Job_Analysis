CREATE TABLE job_applied (
    job_id INT,
    application_sent_date DATE,
    custom_resume BOOLEAN,
    resume_file_name VARCHAR(255),
    cover_letter_sent BOOLEAN,
    cover_letter_file_name VARCHAR(255),
    status VARCHAR(50)
);

INSERT INTO job_applied
            (
            job_id,
            application_sent_date,
            custom_resume,
            resume_file_name,
            cover_letter_sent,
            cover_letter_file_name,
            status
            )
VALUES      (
            1,
            '2024-02-01',
            true,
            'resume_01.pdf',
            true,
            'cover_letter_01.pdf',
            'submitted'
            ),
            
            (
            2,
            '2024-02-02',
            false,
            'resume_02.pdf',
            false,
            NULL,
            'interview scheduled'
            ),
            
            (
            3,
            '2024-02-03',
            true,
            'resume_03.pdf',
            true,
            'cover_letter_03.pdf',
            'ghosted'
            ),
            
            (
            4,
            '2024-02-04',
            true,
            'resume_04.pdf',
            false,
            NULL,
            'submitted'
            ),
            
            (
            5,
            '2024-02-05',
            false,
            'resume_05.pdf',
            true,
            'cover_letter_05.pdf',
            'rejected'
            );            

ALTER TABLE job_applied
ADD contact VARCHAR(50);

UPDATE job_applied
SET contact = 'Erlich Bachman'
WHERE job_id = 1;

UPDATE job_applied
SET contact = 'Dinesh Chugtai'
WHERE job_id = 2;

UPDATE job_applied
SET contact = 'Bertram Gilfoyle'
WHERE job_id = 3;

UPDATE job_applied
SET contact = 'Jian Yang'
WHERE job_id = 4;

UPDATE job_applied
SET contact = 'Big Head'
WHERE job_id = 5;

ALTER TABLE job_applied
RENAME COLUMN  contact TO contact_name;

ALTER TABLE job_applied
ALTER COLUMN contact_name TYPE TEXT;

ALTER TABLE job_applied
DROP COLUMN contact_name;

 SELECT * FROM job_applied;

SELECT
    company_id,
    name AS company_name
FROM 
    company_dim
WHERE 
    company_id IN (

SELECT 
    company_id
FROM
    job_postings_fact
WHERE
job_no_degree_mention = true
ORDER BY
    company_id
)

WITH company_job_count AS (
SELECT
    company_id,
    COUNT(*) no_of_jobs
FROM
    job_postings_fact
GROUP BY 
    company_id
)
SELECT 
    company_dim.company_id,
    name AS company_name,
    company_job_count.no_of_jobs
FROM company_dim
LEFT JOIN company_job_count 
ON company_job_count.company_id = company_dim.company_id
ORDER BY no_of_jobs DESC
LIMIT 25;

SELECT *
FROM job_postings_fact
LIMIT 20;


WITH jobs_table AS (
SELECT
    skill_id,
    COUNT(job_id) AS total_jobs
FROM
skills_job_dim
GROUP BY
    skill_id
)
SELECT
    jobs_table.skill_id,
    skills_dim.skills AS skill_name,
    jobs_table.total_jobs
FROM
    skills_dim 
LEFT JOIN jobs_table
ON jobs_table.skill_id = skills_dim.skill_id
ORDER BY jobs_table.total_jobs DESC

LIMIT 20;



SELECT
    job_postings_fact.job_id,
    skill_id
FROM
    skills_job_dim
WHERE
    job_work_from_home = true
LEFT JOIN job_postings_fact
ON job_postings_fact.job_id = skills_dim.skills 
GROUP BY
    job_id

LIMIT 20;

SELECT * FROM job_postings_fact LIMIT 20;

-- No of Jobs that are Remote:

SELECT
    job_id,
    COUNT (job_work_from_home) AS no_of_jobs
FROM
    job_postings_fact
WHERE
    job_work_from_home = true
GROUP BY
    job_id
LIMIT 20;





WITH remote_job_skills AS (
SELECT 
    skill_id,
    COUNT(*) AS skill_count
FROM
    skills_job_dim
INNER JOIN
    job_postings_fact
ON job_postings_fact.job_id = skills_job_dim.job_id
WHERE
    job_postings_fact.job_work_from_home = true
GROUP BY
    skill_id
)

SELECT
    skills_dim.skill_id,
    skills_dim.skills AS skill_name,
    skill_count

FROM 
    remote_job_skills
INNER JOIN skills_dim
ON skills_dim.skill_id = remote_job_skills.skill_id
ORDER BY
    skill_count DESC
LIMIT 20;





-- First Collect skills that are remote:

WITH jobs_table AS (
SELECT
    skills_job_dim.skill_id,
    COUNT(skills_job_dim.job_id) AS total_jobs
FROM
    skills_job_dim
    INNER JOIN job_postings_fact
ON job_postings_fact.job_id = skills_job_dim.job_id
WHERE
    job_postings_fact.job_work_from_home = true

GROUP BY
    skills_job_dim.skill_id
    )

    SELECT
    jobs_table.skill_id,
    skills AS skill_name,
    jobs_table.total_jobs
FROM
    skills_dim
INNER JOIN jobs_table
ON jobs_table.skill_id = skills_dim.skill_id
ORDER BY jobs_table.total_jobs DESC

LIMIT 20;







SELECT 
    job_id,
    job_title_short,
    job_work_from_home,
    salary_year_avg
FROM (
    SELECT * FROM january_jobs
    UNION ALL
    SELECT * FROM february_jobs
    UNION ALL
    SELECT * FROM march_jobs
) AS q1_jobs
WHERE
    job_work_from_home = true AND 
    (salary_year_avg > 70000 AND job_title_short = 'Data Analyst')
ORDER BY
    salary_year_avg DESC

--LIMIT 20;



































