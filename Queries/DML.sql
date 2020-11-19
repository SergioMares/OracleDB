--DML stands for data manipulation language. We can insert, update, delete, commit or 
--rollback info in our DB

--with INSERT we can add a new row at a time to our table
INSERT INTO departments(department_id, department_name, manager_id, location_id)
VALUES (700, 'Public Relations', 100, 1700);

/*We can use some special values in the INSERT statement like the 
 *SYSDATE(actual date of the server)
 *or a personalized date
 *if we don't specify the rows we're gonna insert and we're not gonna insert all of them
 *we must use a NULL in the field that we don't want to insert
 */
INSERT INTO employees
VALUES (207, 'Louis','Popp','LPOPP1','515.124.4567',SYSDATE,'AC_ACCOUNT',6900,NULL,205,100)

INSERT INTO employees
VALUES (208, 'Den','Raphealy','DRAPHEALI','515.127.4561',
        TO_DATE('FEB 3, 1999', 'MON DD, YYYY'),'AC_ACCOUNT',11000,NULL,100,30)

--A way to make multiple inserts, it's to use the '&' to create variables
--using the '&' will request to insert manually the data
INSERT INTO departments (department_id, department_name, location_id)
VALUES (&department_id, '&department_name', &location)

--we'll create the next table to explain how to copy data from a table using subqueries
CREATE TABLE sales_reps(
  id NUMBER(6) PRIMARY KEY,
  name VARCHAR2(25),
  salary NUMBER(8,2),
  commission_pct NUMBER(2,2)
)

--when using a subquery and an INSERT, we don't have to use the VALUES statement
INSERT INTO sales_reps(id, name, salary, commission_pct)
            SELECT employee_id, last_name, salary, commission_pct
            FROM employees
            WHERE job_id LIKE '%REP%'


--with UPDATE we can modify existing data 
UPDATE employees
SET department_id=70
WHERE employee_id=113

--if we don't use the UPDATE statement, it will modify all the rowsnb 
UPDATE sales_reps
SET salary = 10000

--we can modify multiple columns in one simple UPDATE and also use subqueries
UPDATE employees
SET job_id = (SELECT job_id
                  FROM employees
                  WHERE employee_id =205),
        salary = (SELECT salary
                  FROM employees
                  WHERE employee_id=205)
WHERE employee_id =114

--with DELETE we can remove data from our DB
DELETE FROM departments
WHERE department_name = 'Contracting'

--same as UPDATE the WHERE statement is optional
DELETE FROM sales_reps

--the following query returns a warning. Tells that we were almost to delete important data
DELETE FROM employees 
WHERE department_id IN (SELECT department_id
                        FROM departments
                        WHERE department_name LIKE '%Public%')

--TRUNCATE deletes everything on a table. It's a DDL command. It means that it's harder
--to revert what we do 
TRUNCATE TABLE sales_reps

--ROLLBACK will undo changes in the data base, like a DELETE
--COMMIT is the opposite of the ROLLBACK. COMMIT saves permanently the changes made.
--the following queries will show the utility of the COMMIT and ROLLBACK
SELECT * FROM sales_reps;

INSERT INTO sales_reps(id, name, salary, commission_pct)
SELECT employee_id, last_name, salary, commission_pct
FROM employees
WHERE job_id LIKE '%REP%';

ROLLBACK;

COMMIT;

DELETE FROM sales_reps;

ROLLBACK;--to undo the delete
