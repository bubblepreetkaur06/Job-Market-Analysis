SELECT 
    jp.job_id,
    cd.name AS company_name,
    jp.job_title,
    jp.job_location,
    jp.job_schedule_type,
    jp.salary_year_avg,
    jp.job_posted_date
FROM
    job_postings_fact jp
LEFT JOIN company_dim cd
ON cd.company_id = jp.company_id
WHERE job_title_short = 'Data Analyst' 
      AND job_location LIKE '%India'
      AND salary_year_avg IS NOT NULL
ORDER BY salary_year_avg DESC
LIMIT 10
