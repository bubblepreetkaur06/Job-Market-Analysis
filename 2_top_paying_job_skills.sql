-- Demonstration of CTE
WITH top_paying_jobs AS (
    SELECT jp.job_id,
        cd.name AS company_name,
        jp.job_title,
        jp.job_location,
        jp.salary_year_avg
    FROM job_postings_fact jp
        LEFT JOIN company_dim cd ON cd.company_id = jp.company_id
    WHERE job_title_short = 'Data Analyst'
        AND job_location LIKE '%India'
        AND salary_year_avg IS NOT NULL
    ORDER BY salary_year_avg DESC
    LIMIT 10
) --Inner join to ensure we only get those jobs, which have skills associated with them
SELECT tpj.*,
    s.skills
FROM top_paying_jobs tpj
    INNER JOIN skills_job_dim sj ON tpj.job_id = sj.job_id
    INNER JOIN skills_dim s ON sj.skill_id = s.skill_id
ORDER BY salary_year_avg DESC
LIMIT 100