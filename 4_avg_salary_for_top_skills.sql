--average salary associated with each skill, sorted
SELECT skills,
    ROUND(AVG(salary_year_avg), 0) AS Average_Salary
FROM job_postings_fact jp
    INNER JOIN skills_job_dim sj ON jp.job_id = sj.job_id
    INNER JOIN skills_dim s ON sj.skill_id = s.skill_id
WHERE job_title_short = 'Data Analyst'
    AND salary_year_avg IS NOT NULL
GROUP BY skills
ORDER BY Average_Salary DESC
LIMIT 10