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

/*

# 📊 Skill Insights from Top 10 Highest-Paying Data Analyst Roles

Based on your CSV data, here are the key insights:

## 🔑 Top Skills in High-Paying Data Analyst Roles

1. **SQL** — Appears in **8 out of 8** skill-listed roles (100%!)
2. **Python** — Featured in **7 roles** (87.5%)
3. **Tableau** — Used in **6 roles** (75%)
4. **R** — Present in **4 roles** (50%)
5. **Pandas & Excel** — Each in **3 roles**
6. **Snowflake** — Emerging as a key cloud data platform (3 roles)

## 📌 Notable Observations

- **SQL + Python + Tableau** form the **core "holy trinity"** — appearing together in most top-paying jobs.
- **Cloud platforms** like **AWS, Azure, Snowflake, and Databricks** are increasingly important at senior levels (e.g., Associate Director roles).
- **2 out of the top 2 highest-paying roles** (Mantys at $650k, Meta at $336k) **listed no skills** — possibly indicating:
  - Highly specialized/internal roles,
  - Incomplete job postings,
  - Or executive roles where technical skills are assumed/less emphasized.

## 💡 Strategic Takeaway

If you're aiming for **top-tier Data Analyst roles**, prioritize mastering:
> ✅ **SQL** (non-negotiable)  
> ✅ **Python** (especially `pandas`)  
> ✅ **Tableau** (or **Power BI** — listed in 2 roles)  
> ✅ **Cloud data tools** (Snowflake, AWS, Azure) for senior positions



- JSON

[
  {
    "company_name": "Mantys",
    "job_title": "Data Analyst",
    "salary_year_avg": "650000.0",
    "required_skills": "No skills listed"
  },
  {
    "company_name": "Meta",
    "job_title": "Director of Analytics",
    "salary_year_avg": "336500.0",
    "required_skills": "No skills listed"
  },
  {
    "company_name": "AT&T",
    "job_title": "Associate Director- Data Insights",
    "salary_year_avg": "255829.5",
    "required_skills": "aws, azure, databricks, excel, jupyter, pandas, power bi, powerpoint, pyspark, python, r, sql, tableau"
  },
  {
    "company_name": "Pinterest Job Advertisements",
    "job_title": "Data Analyst, Marketing",
    "salary_year_avg": "232423.0",
    "required_skills": "hadoop, python, r, sql, tableau"
  },
  {
    "company_name": "Uclahealthcareers",
    "job_title": "Data Analyst (Hybrid/Remote)",
    "salary_year_avg": "217000.0",
    "required_skills": "crystal, flow, oracle, sql, tableau"
  },
  {
    "company_name": "SmartAsset",
    "job_title": "Principal Data Analyst (Remote)",
    "salary_year_avg": "205000.0",
    "required_skills": "excel, gitlab, go, numpy, pandas, python, snowflake, sql, tableau"
  },
  {
    "company_name": "Inclusively",
    "job_title": "Director, Data Analyst - HYBRID",
    "salary_year_avg": "189309.0",
    "required_skills": "atlassian, aws, azure, bitbucket, confluence, jenkins, jira, oracle, power bi, python, sap, snowflake, sql, tableau"
  },
  {
    "company_name": "Motional",
    "job_title": "Principal Data Analyst, AV Performance Analysis",
    "salary_year_avg": "189000.0",
    "required_skills": "atlassian, bitbucket, confluence, git, jira, python, r, sql"
  },
  {
    "company_name": "SmartAsset",
    "job_title": "Principal Data Analyst",
    "salary_year_avg": "186000.0",
    "required_skills": "excel, gitlab, go, numpy, pandas, python, snowflake, sql, tableau"
  },
  {
    "company_name": "Get It Recruit - Information Technology",
    "job_title": "ERM Data Analyst",
    "salary_year_avg": "184000.0",
    "required_skills": "python, r, sql"
  }
]

*/