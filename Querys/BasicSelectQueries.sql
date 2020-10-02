/*
* all the examples bellow were tested with the hr oracle's database 
*/

/*
*Remember that SQL is not case sensitive, but it's nice to have some code convention
*
*/

-- will display every column from the departments table
SELECT * 
FROM departments;

--will display just the dpartment_id & the location_id columns
SELECT department_id, location_id
FROM departments; 

--we can do some arithmetic operations with the queries
SELECT last_name, salary, salary + 300
FROM employees;

--SQL uses the hierarchy of operations 
SELECT last_name, salary, 12*salary+100, 12 * (salary +100)
FROM employees;

--some queries will return a null value, which could be a value that is not available, 
--unassigned, or applicable. A null value is always different from a zero (0)
SELECT last_name, job_id, salary, commission_pct
FROM employees;

SELECT last_name, salary, commission_pct, 12*salary*commission_pct
FROM employees;

--we can change the name of a header with an alias
--'AS' is optional to name an alias 
--we use double quotes when we use special characters in the alias or when we want to 
--display something literally
SELECT last_name AS name, commission_pct "comÑ"
FROM employees;

--to concatenate, we use the pipe ||
SELECT last_name || ' is a ' || job_id AS "Employees"
FROM employees;

-- With the 'DISTINCT' command, we only show all the elements of the column except the 
--repeated ones
SELECT DISTINCT department_id
FROM employees;

--the 'DESC' command describe to us a table
DESC employees
