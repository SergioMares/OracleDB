/*
 *the priority when a query is evaluated is the following:
 * 1 -> arithmetic operators  
 * 2 -> concatenation operators 
 * 3 -> comparison conditions 
 * 4 -> IS [NOT] NULL, LIKE [NOT] IN
 * 5 -> [NOT] BETWEEN 
 * 6 -> Condición lógica NOT
 * 7 -> Condición lógica AND 
 * 8 -> Condición lógica OR 
 */


--we only show the rows that meet the condition (WHERE)
SELECT employee_id, last_name, job_id, department_id
FROM employees
WHERE department_id = 90


--strings and dates must have simple quotes. All the values are case sensitive
SELECT employee_id, last_name, job_id, department_id
FROM employees
WHERE last_name = 'Whalen'


--we can also use the comparison conditions (=, >, >=, <, <=, <>)
SELECT last_name, salary
FROM employees
WHERE salary <= 3000


/*more comparison conditions are: 
 *BETWEEN ... AND (between 2 values)
 *IN (set) (matches any of a list of values)
 *LIKE (matches a character pattern)
 *IS NULL (it's a null value)
 */
SELECT last_name, salary
FROM employees
WHERE salary BETWEEN 2500 AND 3500

SELECT employee_id, last_name, salary, manager_id
FROM employees
WHERE manager_id IN (100, 101, 201)

SELECT first_name
FROM employees
WHERE first_name LIKE 's%'

SELECT last_name
FROM employees
WHERE last_name LIKE '_o%'

--using the ESCAPE command we tell the query to look for a text with a '_' and avoid 
--reading it as the normal use of the character '_'
SELECT employee_id, last_name, job_id
FROM employees
WHERE job_id LIKE '%SA\_%' ESCAPE '\'

SELECT last_name, manager_id
FROM employees
WHERE manager_id IS NULL


--we can also use logic conditions (AND, OR, NOT)
SELECT employee_id, last_name, job_id, salary
FROM employees
WHERE salary >= 10000
AND job_id LIKE '%MAN%'

SELECT last_name, job_id
FROM employees
WHERE job_id NOT IN ('IT_PROG', 'ST_CLERK', 'SA_REP');

--Check this query as an example of the priority when a query is evaluated
SELECT last_name, job_id, salary 
FROM employees
WHERE job_id = 'SA_REP' --job_id = 'SA_REP' OR (job_id = 'AD_PRES' AND alary > 15000)
OR job_id = 'AD_PRES'
AND salary > 15000--job_id = 'AD_PRES' AND alary > 15000
 
--the results od the query will be ordered by the hire date
SELECT last_name, job_id, department_id, hire_date
FROM employees
ORDER BY hire_date

--the default is that the results will be displayed in ascending order, but we can use 
--the DESC command to sort them in descending order
SELECT last_name, job_id, department_id, hire_date
FROM employees
ORDER BY hire_date DESC

--we can also sort the results by an alias
SELECT last_name, job_id, salary * 12 salanual
FROM employees
ORDER BY salanual

--furthermore, we can sort by more than one column.
SELECT last_name, department_id, salary
FROM employees
ORDER BY department_id, salary DESC
