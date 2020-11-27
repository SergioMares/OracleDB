--Some DB nomenclature--
/*
 *names of rows must:
 *start with a letter
 *has from 1 to 30 characters
 *have only A-Z. a-z. 0-9,$ & #
 *not be a Oracle's reserved word
 */
 
 --Create a table 
--the DEFAULT option, will add automacally data if we don't put a thing when making an insert 
CREATE TABLE dept
 (deptno NUMBER(2),
 dname VARCHAR2(14),
 lloc VARCHAR(13),
 create_date DATE DEFAULT SYSDATE);
 
 --types of data--
 /*
  *VARCHAR2(size) -> lenth variable string
  *CHAR(size) -> established length string
  *NUMBER(p,s) -> lenth variable number (p is the quantity of digits and s how much of them
                  are decimals) pe 99,999.99 -> NUMBER(7,2)
  *DATE -> dates values
  *LONG -> up to 2 GB string
  *CLOB -> up to 4 GB string
  *RAW & LONH RAW -> raw binary data
  *BLOB -> up to 4GB binary data
  *BFILE -> binary data stored in an external file; up to 4 GB
  */
  
--restrictions--
/*
 *NOT NULL
 *UNIQUE
 *PRIMARY KEY
 *FOREIGN KEY
 *CHECK --it's like an if statement
 */
 
 --Restriction at a row level
CREATE TABLE employees (
 employees_id NUMBER(6) CONSTRAINT emp_emp_id_pk PRIMARY_KEY,
 first_name VARCHAR(2),
 ...);

--Restriction at a table level
CREATE TABLE employees (
 employees_id NUMBER(6),
 first_name VARCHAR(2),
 ...
 job_id VARCHAR2(10) NOT NULL,
 CONSTRAINT emp_emp_id_pk
  PRIMARY KEY (EMPLOYEE_ID));

--defining a foreign key
CONSTRAINT emp_dept_fk FOREIGN KEY (departmente_id)
  REFERENCES departments(department_id)

--foreign key has two more commands: on delete cascade & on delete set null
--cascade: when delete a PK deletes all their dependencies
--set null: when delete a PL sets null all their dependencies

--using a check 
... salary NUMBER(8,2) CONSTRAINT emp_salary_min CHECK(salary>0),...

--how the employees table was created--
CREATE TABLE employees (
  employee_id NUMBER (6)
    CONSTRAINT emp_employe_id PRIMARY KEY,
  first_name VARCHAR2(20),
  last_name VARCHAR2(25)
    CONSTRAINT emp_last_name_nn NOT NULL,
  email VARCHAR2(25)
    CONSTRAINT emp_email_nn NOT NULL
    CONSTRAINT emp_email_uk UNIQUE,
  phone_number VARCHAR2(20),
  hire_date DATE
   CONSTRAINT emp_hire_date_nn NOT NULL,
  job_id VARCHAR2(10)
    CONSTRAINT emp_job_nn NOT NULL,
  salary NUMBER(8,2)
    CONSTRAINT emp_salary_ck CHECK (salary >0),
  commission_pct NUMBER(2,2),
  manager_id NUMBER(6),
  department_id NUMBER(4)
    CONSTRAINT emp_dept_fk REFERENCES
  departments (department_id));

--create a table by a subquery
CREATE TABLE dept80
AS  SELECT employee_id, last_name,
    salary*12 ANNSAL,
    hire_date
    FROM employees
    WHERE department_id = 80;

--modifying a table with ALTER TABLE--
--add a column 
ALTER TABLE dept80
ADD ( job_id VARCHAR2(9) );

--modify a column
ALTER TABLE dept80
MODIFY ( last_name VARCHAR2(30) )

--delete a column
ALTER TABLE dept80
DROP COLUMN job_id;

--delete a table
DROP TABLE dept80;

--when making a DDL command, it automatically makes a commit
/*
 *CREATE TABLE
 *ALTER TABLE
 *DROP TABLE
 *RENAME
 *TRUNCATE
 */

--recover a table with FLASHBACK command
FLASHBACK TABLE dept80 TO BEFORE DROP;

--rename an object
RENAME dept80 TO detail_dept;

--truncate a table
TRUNCATE TABLE detail_dept;
