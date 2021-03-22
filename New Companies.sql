/* PROBLEM */
/* Amber's conglomerate corporation just acquired some new companies. Each of the companies follows this hierarchy: 
Founder > lead Manager > Senior Manager > Manager > Employee

Given the table schemas below, write a query to print the company_code, founder name, total number of lead managers, total number of senior managers, total number of managers, and total number of employees. Order your output by ascending company_code.

Note:

The tables may contain duplicate records.
The company_code is string, so the sorting should not be numeric. For example, if the company_codes are C_1, C_2, and C_10, then the ascending company_codes will be C_1, C_10, and C_2.

Input Format

The following tables contain company data:
Company: The company_code is the code of the company and founder is the founder of the company. 
Lead_Manager: The lead_manager_code is the code of the lead manager, and the company_code is the code of the working company. 
Senior_Manager: The senior_manager_code is the code of the senior manager, the lead_manager_code is the code of its lead manager, and the company_code is the code of the working company. 
Manager: The manager_code is the code of the manager, the senior_manager_code is the code of its senior manager, the lead_manager_code is the code of its lead manager, and the company_code is the code of the working company. 
Employee: The employee_code is the code of the employee, the manager_code is the code of its manager, the senior_manager_code is the code of its senior manager, the lead_manager_code is the code of its lead manager, and the company_code is the code of the working company. 

Sample Input

Company Table:  Lead_Manager Table:  Senior_Manager Table:  Manager Table:  Employee Table: 

Sample Output

C1 Monika 1 2 1 2
C2 Samantha 1 1 2 2
Explanation

In company C1, the only lead manager is LM1. There are two senior managers, SM1 and SM2, under LM1. There is one manager, M1, under senior manager SM1. There are two employees, E1 and E2, under manager M1.
In company C2, the only lead manager is LM2. There is one senior manager, SM3, under LM2. There are two managers, M2 and M3, under senior manager SM3. There is one employee, E3, under manager M2, and another employee, E4, under manager, M3.

/* SOLUTION */

SELECT  co.company_code
       ,co.founder
       ,COUNT(distinct lm.Lead_manager_code) Lead_manager_code
       ,COUNT(distinct sm.senior_manager_code) senior_manager_code
       ,COUNT(distinct m.manager_code) total_managers
       ,COUNT(distinct ep.employee_code) total_employees
FROM 
    company co
LEFT JOIN 
    Lead_manager lm
    ON co.company_code = lm.company_code
LEFT JOIN 
    senior_manager sm
    ON co.company_code = sm.company_code 
    AND lm.Lead_manager_code = sm.Lead_manager_code
LEFT JOIN 
    manager m
    ON co.company_code = m.company_code 
    AND lm.Lead_manager_code = m.Lead_manager_code 
    AND sm.senior_manager_code = m.senior_manager_code
LEFT JOIN 
    employee ep
ON co.company_code = ep.company_code AND lm.Lead_manager_code = ep.Lead_manager_code AND sm.senior_manager_code = e p.senior_manager_code AND m.manager_code = ep.manager_code
GROUP BY  co.company_code 
         ,co.founder
ORDER BY co.company_code asc;