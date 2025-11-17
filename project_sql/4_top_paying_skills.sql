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

/*

-- JSON

[
  {
    "skill_id": 224,
    "skill_name": "svn",
    "avg_salary": "400000.00",
    "job_postings": "1"
  },
  {
    "skill_id": 38,
    "skill_name": "solidity",
    "avg_salary": "179000.00",
    "job_postings": "1"
  },
  {
    "skill_id": 65,
    "skill_name": "couchbase",
    "avg_salary": "160515.00",
    "job_postings": "1"
  },
  {
    "skill_id": 206,
    "skill_name": "datarobot",
    "avg_salary": "155485.50",
    "job_postings": "1"
  },
  {
    "skill_id": 27,
    "skill_name": "golang",
    "avg_salary": "155000.00",
    "job_postings": "2"
  },
  {
    "skill_id": 109,
    "skill_name": "mxnet",
    "avg_salary": "149000.00",
    "job_postings": "2"
  },
  {
    "skill_id": 119,
    "skill_name": "dplyr",
    "avg_salary": "147633.33",
    "job_postings": "3"
  },
  {
    "skill_id": 73,
    "skill_name": "vmware",
    "avg_salary": "147500.00",
    "job_postings": "1"
  },
  {
    "skill_id": 212,
    "skill_name": "terraform",
    "avg_salary": "146733.83",
    "job_postings": "3"
  },
  {
    "skill_id": 250,
    "skill_name": "twilio",
    "avg_salary": "138500.00",
    "job_postings": "2"
  },
  {
    "skill_id": 220,
    "skill_name": "gitlab",
    "avg_salary": "134126.00",
    "job_postings": "7"
  },
  {
    "skill_id": 98,
    "skill_name": "kafka",
    "avg_salary": "129999.16",
    "job_postings": "40"
  },
  {
    "skill_id": 222,
    "skill_name": "puppet",
    "avg_salary": "129820.00",
    "job_postings": "2"
  },
  {
    "skill_id": 100,
    "skill_name": "keras",
    "avg_salary": "127013.33",
    "job_postings": "3"
  },
  {
    "skill_id": 101,
    "skill_name": "pytorch",
    "avg_salary": "125226.20",
    "job_postings": "20"
  },
  {
    "skill_id": 31,
    "skill_name": "perl",
    "avg_salary": "124685.75",
    "job_postings": "20"
  },
  {
    "skill_id": 223,
    "skill_name": "ansible",
    "avg_salary": "124370.00",
    "job_postings": "2"
  },
  {
    "skill_id": 121,
    "skill_name": "hugging face",
    "avg_salary": "123950.00",
    "job_postings": "2"
  },
  {
    "skill_id": 99,
    "skill_name": "tensorflow",
    "avg_salary": "120646.83",
    "job_postings": "24"
  },
  {
    "skill_id": 63,
    "skill_name": "cassandra",
    "avg_salary": "118406.68",
    "job_postings": "11"
  },
  {
    "skill_id": 238,
    "skill_name": "notion",
    "avg_salary": "118091.67",
    "job_postings": "6"
  },
  {
    "skill_id": 219,
    "skill_name": "atlassian",
    "avg_salary": "117965.60",
    "job_postings": "15"
  },
  {
    "skill_id": 218,
    "skill_name": "bitbucket",
    "avg_salary": "116711.75",
    "job_postings": "6"
  },
  {
    "skill_id": 96,
    "skill_name": "airflow",
    "avg_salary": "116387.26",
    "job_postings": "71"
  },
  {
    "skill_id": 3,
    "skill_name": "scala",
    "avg_salary": "115479.53",
    "job_postings": "59"
  }
]


*/