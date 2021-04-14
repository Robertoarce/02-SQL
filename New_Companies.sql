/* PROBLEM */
/*Amber's conglomerate corporation just acquired some new companies. 
Each of the companies follows this hierarchy: 

Write a query to print the company_code, 
founder name,
 total number of lead managers,
 total number of senior managers,
 total number of managers, and total number of employees.
  Order your output by ascending company_code.

Note:

The tables may contain duplicate records.
The company_code is string, so the sorting should not be numeric. 
For example, if the company_codes are C_1, C_2, and C_10, then the ascending company_codes will be C_1, C_10, and C_2.


The following tables contain company data:

Company: The company_code is the code of the company and founder is the founder of the company. 

Lead_Manager: The lead_manager_code is the code of the lead manager, and the company_code is the code of the working company. 

Senior_Manager: The senior_manager_code is the code of the senior manager, the lead_manager_code is the code of its lead manager,
 and the company_code is the code of the working company. 

Manager: The manager_code is the code of the manager, the senior_manager_code is the code of its senior manager, 
the lead_manager_code is the code of its lead manager, and the company_code is the code of the working company. 

Employee: The employee_code is the code of the employee, the manager_code is the code of its manager, 
the senior_manager_code is the code of its senior manager, the lead_manager_code is the code of its lead manager, 
and the company_code is the code of the working company. 


Sample Output

C1 Monika 1 2 1 2
C2 Samantha 1 1 2 2
Explanation

In company C1, the only lead manager is LM1.
 There are two senior managers, SM1 and SM2, under LM1. 
 There is one manager, M1, under senior manager SM1. 
 There are two employees, E1 and E2, under manager M1.

In company C2, the only lead manager is LM2. 
There is one senior manager, SM3, under LM2. 
There are two managers, M2 and M3, under senior manager SM3. 
There is one employee, E3, under manager M2, and another employee, E4, under manager, M3.
*/

/* SOLUTION */

with 


leada as
(
    select company_code, sum(count_lead) as lead    
from  ( select 
        distinct company_code, 
        count(distinct lead_manager_code) as count_lead
        from Lead_Manager

        group by 
            company_code, 
            lead_manager_code ) as a 
    group by 
    company_code
),
  sena as
 
 (select company_code, sum(count_sen) as sen    
from   
    (select distinct company_code, lead_manager_code,
        count(distinct senior_manager_code) as count_sen
        from senior_manager
        group by 
            company_code, lead_manager_code 
     )  as a 
   group by 
            company_code

 ),
 mana as (

 select company_code, sum(count_man) as man    
from   
    (select distinct company_code, lead_manager_code,senior_manager_code,
        count(distinct manager_code) as count_man
        from Manager
        group by 
            company_code, lead_manager_code,senior_manager_code
     )  as a 
   group by 
            company_code
 ) ,
empa as 
 (
select company_code, sum(count_emp) as emp
 from 
(select
        distinct company_code, lead_manager_code,senior_manager_code,manager_code,
        count(distinct employee_code) as count_emp
        from Employee
        
        
        group by 
            company_code, lead_manager_code,senior_manager_code,manager_code
 ) as a
 group by company_code
)

select  a.company_code, founder, leado,sen,man,emp 

from leado as a 

left join sena as b
    on a.company_code = b.company_code
left join mana as c
    on a.company_code = c.company_code
left join empa as d
    on a.company_code = d.company_code 
LEFT JOIN
    Company as e
    on a.company_code = e.company_code
order by a.company_code asc

-------------------------------------
-------------------------------------
-------------------------------------
-------------------------------------
SELECT  a.company_code
       ,founder
       ,lead
       ,sen
       ,man
       ,emp
FROM 
(
	SELECT  company_code
	       ,SUM(count_lead) AS lead
	FROM 
	(
		SELECT  distinct company_code
		       ,COUNT(distinct lead_manager_code) AS count_lead
		FROM Lead_Manager
		GROUP BY  company_code
		         ,lead_manager_code 
	) AS a
	GROUP BY  company_code 
) AS a
LEFT JOIN 
(
	SELECT  company_code
	       ,SUM(count_sen) AS sen
	FROM 
	(
		SELECT  distinct company_code
		       ,lead_manager_code
		       ,COUNT(distinct senior_manager_code) AS count_sen
		FROM senior_manager
		GROUP BY  company_code
		         ,lead_manager_code 
	) AS a
	GROUP BY  company_code 
) AS b
ON a.company_code = b.company_code
LEFT JOIN 
    (
        SELECT  company_code
            ,SUM(count_man) AS man
        FROM 
        (
            SELECT  distinct company_code
                ,lead_manager_code
                ,senior_manager_code
                ,COUNT(distinct manager_code) AS count_man
            FROM Manager
            GROUP BY  company_code
                    ,lead_manager_code
                    ,senior_manager_code 
        ) AS a
        GROUP BY  company_code 
    ) AS c
ON a.company_code = c.company_code
LEFT JOIN 
    (
        SELECT  company_code
            ,SUM(count_emp) AS emp
        FROM 
        (
            SELECT  distinct company_code
                ,lead_manager_code
                ,senior_manager_code
                ,manager_code
                ,COUNT(distinct employee_code) AS count_emp
            FROM Employee
            GROUP BY  company_code
                    ,lead_manager_code
                    ,senior_manager_code
                    ,manager_code 
        ) AS a
        GROUP BY  company_code 
    ) AS d
ON a.company_code = d.company_code 

LEFT JOIN
    Company as e
    on a.company_code = e.company_code

order by a.company_code asc