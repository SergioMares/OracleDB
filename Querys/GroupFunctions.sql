/*
 * Group functions
 * Returns a result from a set of rows avoiding null values
 * The Oracle group functions are:
 * AVG, COUNT, MAX, MIN, STDDEV, SUM, VARIANCE 
 *---------------------------------------------------------------------
 * when using a group function, use it alone or also use 
 * the GROUP BY clause to avoid errors. So, all the rows
 * in the select that aren´t a group funciton, must be in the group by
 */

SELECT AVG(salary), MAX(salary), MIN(salary), SUM(salary)
FROM employees
WHERE job_id LIKE '%REP%';

--MIN & MAX also works with diferentvalue types
SELECT MAX(hire_date), MIN(hire_date)
FROM employees

--COUNT returns the number of rows of a table(query)
SELECT COUNT(*)
FROM employees
WHERE department_id = 50;

SELECT COUNT(commission_pct)
FROM employees
WHERE department_id = 80;

--COUNT suppots DISTINCT
SELECT COUNT(DISTINCT department_id)
FROM employees

--We can use the NLV with group functions to include the null values
SELECT AVG(NVL(commission_pct, 0))
FROM employees

--GROUP BY-- 
--groups the rows of the query in reference of one or multiple rows
SELECT department_id, AVG(salary)
FROM employees
GROUP BY department_id --if we don't use the GROUP BY we'll get an error
ORDER BY department_id

--you can group by multiple rows
SELECT department_id depaid, job_id, SUM(salary)
FROM employees
GROUP BY department_id, job_id
ORDER BY department_id, job_id

-- if we try to use a group function in WHERE it will give us an error because
-- WHERE is just for simple rows. Use instead HAVING for multiple rows
SELECT department_id, MAX(salary)
FROM employees
GROUP BY department_id
HAVING MAX(salary)>10000

SELECT job_id, SUM(salary) payroll
FROM employees
WHERE job_id NOT LIKE '%REP%'
GROUP BY job_id
HAVING SUM(salary)>13000
ORDER BY SUM(salary) 
