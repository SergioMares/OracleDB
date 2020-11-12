--Allow us to make a query inside in another query--
--The first query to execute is the subquery (inner query)
--Sub queries must be in parentheses and at the right of the conditional

--Returns employees that has a greater salary than Abel
SELECT last_name, salary
FROM employees
WHERE salary > (SELECT salary 
                FROM employees 
                WHERE last_name = 'Abel');

--We can make multiple subqueries
SELECT last_name, salary, salary
FROM employees
WHERE job_id = (SELECT job_id 
                FROM employees 
                WHERE employee_id = 141)
AND salary > (SElECT salary
              FROM employees
              WHERE employee_id =143);                

--we can use group functions inside subqueries
SELECT last_name, salary, salary
FROM employees
WHERE salary = (SELECT MIN(salary) 
                FROM employees)

--we can also use the HAVING command
SELECT department_id, MIN(salary)
FROM employees
GROUP BY department_id
HAVING MIN(salary) > (SELECT MIN(salary) 
                      FROM employees
                      WHERE department_id =50)
                      
--we can not request a subquery that has more than one row
SELECT employee_id, last_name
FROM employees
WHERE salary = (SELECT MIN(salary) 
                FROM employees
                GROUP BY department_id);
                
/*To make a subquery with multiple rows work, we can use the operators:
 *IN->  Same as any element of thes list
 *ANY-> Compare every value of the subquery one by one (must have another single row operator)
 *(kinda OR)
 *ALL-> Compare all the values of the subquery at the same time (must have another single row operator)
 *(kinda AND)
 */
--returns all the employees that earns less than a programmer 
SELECT employee_id, last_name, job_id, salary
FROM employees
WHERE salary < ANY (SELECT salary
                    FROM employees
                    WHERE job_id ='IT_PROG')
AND job_id <> 'IT_PROG';

--Ifc we have a NULL value in a subquery, the query will not return any thing
SELECT last_name
FROM employees
WHERE employee_id NOT IN (SELECT manager_id --we can use an NVL to avoid this
                          FROM employees);
