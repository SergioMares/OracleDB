--We can get info from different tables using the JOIN command

--NATURAL JOIN-- select all the equal rows of two different tables. The rows must have the 
--same name and also the same type of value 

SELECT department_id, department_name
FROM departments
NATURAL JOIN locations

--We can use USING to tables with different value types and specify just some rows and not
--all that have the same name
SELECT e.employee_id, e.last_name, d.department_name
FROM employees e JOIN departments d
USING (department_id)

--the ON command is useful to make conditionals. It's like a WHERE command
SELECT e.employee_id, e.last_name, e.department_id, d.department_id, d.location_id
FROM employees e JOIN departments d
ON (e.department_id = d.department_id)

--we can also make JOIN of the same table with the ON command
SELECT e.employee_id, e.last_name EMP, 
       e.manager_id, m.employee_id, m.last_name MGR
FROM employees e JOIN employees m
ON (e.manager_id = m.employee_id)--show us the employee and his manager

--ON supports the use of the logcal conditionals
SELECT e.employee_id, e.last_name EMP, 
       e.manager_id, m.employee_id, m.last_name MGR
FROM employees e JOIN employees m
ON (e.manager_id = m.employee_id)
AND e.manager_id = 149

--we can use as many JOIN as we want
SELECT e.last_name, e.department_id, d.department_id, 
       d.department_name, d.location_id, l.location_id, l.city
FROM employees e
JOIN departments d
ON e.department_id = d.department_id
JOIN locations l
ON d.location_id = l.location_id

--id we wanna see rows from different tables that don't coincideor doesn't meet the ON,
--we can use the (LEFT/RIGHT/FULL) OUTER JOIN

--We see all employees, even those without department. (all from the LEFT)
SELECT e.last_name, e.department_id, d.department_name
FROM employees e LEFT OUTER JOIN  departments d
ON (e.department_id = d.department_id)

--We see all departments even those that do not have assigned employees (all from the RIGHT)
SELECT e.last_name, e.department_id, d.department_name
FROM employees e RIGHT OUTER JOIN  departments d
ON (e.department_id = d.department_id)

--We see all of both, departments and employees
SELECT e.last_name, e.department_id, d.department_name
FROM employees e FULL OUTER JOIN  departments d
ON (e.department_id = d.department_id)

/* 
 *Some querys will be a cartesian product, this is kinda bad query 'cause, even when it 
 *doesn't have an error and gice us a result, it maybe gve us mucho more info that we need
 *or some wrong data. the query bellow is an example of a cartesian product
 */
SELECT COUNT(*)
FROM employees e, departments d

--i, for some reason, we wanna make a cartesian product, we can use the CROSS JOINT
SELECT COUNT(*)
FROM employees CROSS JOIN departments

--we can make JOIN with WHERE. It´s almost the same, just defferent sintaxis
SELECT e.employee_id, e.last_name,
e.department_id, d.department_id,
d.location_id
FROM employees e, departments d, locations l
WHERE e.department_id = d.department_id
AND d.location_id=l.location_id
AND e.manager_id =100
