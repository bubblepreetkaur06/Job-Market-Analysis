WITH skills_demand AS (
    SELECT 
        s.skills,
        sj.skill_id,
        COUNT(sj.job_id) AS Demand_count
    FROM 
        job_postings_fact jp
        INNER JOIN skills_job_dim sj ON jp.job_id = sj.job_id
        INNER JOIN skills_dim s ON sj.skill_id = s.skill_id
    WHERE 
        job_title_short = 'Data Analyst'
        AND salary_year_avg IS NOT NULL
    GROUP BY 
        s.skills, sj.skill_id
), average_salary AS (
    SELECT 
        sj.skill_id, 
        ROUND(AVG(salary_year_avg), 0) AS Average_Salary
    FROM 
        job_postings_fact jp
        INNER JOIN skills_job_dim sj ON jp.job_id = sj.job_id
        INNER JOIN skills_dim s ON sj.skill_id = s.skill_id
    WHERE 
        job_title_short = 'Data Analyst'
        AND salary_year_avg IS NOT NULL
    GROUP BY 
        sj.skill_id
)

SELECT  
    sd.skill_id,
    sd.skills,
    sd.Demand_count,
    avg_s.Average_Salary
FROM 
    skills_demand sd
INNER JOIN average_salary avg_s ON sd.skill_id = avg_s.skill_id
WHERE sd.demand_count > 10
ORDER BY 
    avg_s.Average_Salary DESC,
    sd.Demand_count DESC;
