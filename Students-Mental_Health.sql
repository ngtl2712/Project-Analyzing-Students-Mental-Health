-- Overview of the Dataset
select top 5 * from Students

-- Explore and understand the data
--- Count the number of records in the dataset as total
select count(*) as total
from Students

--- Count the number of records for each student type as count_dom_inter
select inter_dom as student_type,
        count(*) as count_dom_inter
from Students
GROUP BY inter_dom

--> There are 201 International students, 67 Domestic students and 18 students unspecified 

-- Explore the data for each student type in inter_dom
---International Students
select *
from Students
where inter_dom = 'Inter'

---Domestic Students
select *
from Students
where inter_dom = 'Dom'

---Unspecified Students
select *
from Students
where inter_dom IS NULL

--> The data in these rows are all null, which don't help our determination of whether International sutdents have higher risk of mental health than the general population. Thus, this will need to be removed from the dataset when analyzing data.

DELETE 
from Students
where inter_dom IS NULL

-- Query the summary statistics of the diagnostics scores for all students
select
	MIN(todep) AS min_phq,
	MAX(todep) AS max_phq,
	ROUND(AVG(todep),2) AS avg_phq,
	MIN(tosc) AS min_scs,
	MAX(tosc) AS max_scs,
	ROUND(AVG(toas),2) AS avg_scs,
	MIN(toas) AS min_asiss,
	MAX(toas) AS max_asiss,
	ROUND(AVG(toas),2) AS avg_asiss
from Students

-- Summarize the data for international students, local students and compare
SELECT
	inter_dom,
	MIN(todep) AS min_phq,
	MAX(todep) AS max_phq,
	ROUND(AVG(todep),2) AS avg_phq,
	MIN(tosc) AS min_scs,
	MAX(tosc) AS max_scs,
	ROUND(AVG(tosc),2) AS avg_scs,
	MIN(toas) AS min_asiss,
	MAX(toas) AS max_asiss,
	ROUND(AVG(toas),2) AS avg_asiss
FROM Students
GROUP BY inter_dom;

-- See the impact of length of stay
SELECT stay, 
	ROUND(AVG(todep),2) AS avg_phq,
	ROUND(AVG(tosc),2) AS avg_scs,
	ROUND(AVG(toas),2) AS avg_as
FROM Students
WHERE inter_dom = 'Inter'
GROUP BY stay
ORDER BY stay DESC;

-- Analyze the correlation between length of stay and diagnostic scores

WITH length_impact AS (  
    SELECT   
        stay,  
        ROUND(AVG(todep), 2) AS avg_phq,  
        ROUND(AVG(tosc), 2) AS avg_scs,  
        ROUND(AVG(toas), 2) AS avg_as  
    FROM Students  
    WHERE inter_dom = 'Inter'  
    GROUP BY stay  
)  

SELECT   
    (COUNT(*) * SUM(stay * avg_phq) - SUM(stay) * SUM(avg_phq)) /   
    SQRT((COUNT(*) * SUM(stay * stay) - SUM(stay) * SUM(stay)) *   
          (COUNT(*) * SUM(avg_phq * avg_phq) - SUM(avg_phq) * SUM(avg_phq))) AS corr_stay_phq, 
    (COUNT(*) * SUM(stay * avg_scs) - SUM(stay) * SUM(avg_scs)) /   
    SQRT((COUNT(*) * SUM(stay * stay) - SUM(stay) * SUM(stay)) *   
          (COUNT(*) * SUM(avg_scs * avg_scs) - SUM(avg_scs) * SUM(avg_scs))) AS corr_stay_scs,
     (COUNT(*) * SUM(stay * avg_as) - SUM(stay) * SUM(avg_as)) /   
    SQRT((COUNT(*) * SUM(stay * stay) - SUM(stay) * SUM(stay)) *   
          (COUNT(*) * SUM(avg_as * avg_as) - SUM(avg_as) * SUM(avg_as))) AS corr_stay_as                 
FROM length_impact

--- The correlation coefficients between "stay" and "avg_phq" (depression) and "avg_scs" (social connectedness) are 0.27 and 0.14, respectively
--- These values indicate weak correlations, suggesting that the length of stay does not strongly influence feelings of belonging to the native social group or levels of depression.
--- The correlation coefficient between "stay" and "avg_as" (acculturative stress) is -0.64, reflecting a strong negative relationship. international students generally experience less stress related to cultural adjustment as they become more acclimated to their new environment over time.    