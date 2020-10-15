/*Oracle supports the use of functions, they are called single and multiple row functions. 
 *in this sql file i am going to test single row functions, which means that the function
 *only receives one parameter.
 *We have many types of simple sow fucntions: characters, number, date, convertion and general
 *the dual table is used for testing/debug
 */

--Character type--
--We can change if a string is upper or lower case
SELECT LOWER('some TEXT'), UPPER('SOME text'), INITCAP('some text')
FROM dual

--the functions also can be used in the WHERE section
SELECT employee_id, last_name, department_id
FROM employees
WHERE LOWER(last_name) = 'higgins'

--some functions that manipulate strings are: CONCAT, SUBSTR, LENGTH, INSTR, LPAD, RPED & TRIM
SELECT CONCAT ('Hello','World'),--Concatenate strings
       SUBSTR('HelloWorld',1,5),--substring of a string. Strats from 1 to 5
       SUBSTR('HelloWorld',6),--from the character 6 and further
       LENGTH('HelloWorld'),--size of the string
       INSTR('HelloWorld', 'l'),--Search the first position in the string of 'l'
       LPAD('HelloWorld',15,'*'),--pads the left-side of a string with a specific set of characters
       RPAD('HelloWorld',15,'*'),--same as above but from the right
       TRIM('x' FROM 'xxHelloWorldxx')--trim all the 'x' at the beginning and the end
FROM dual

--Number type--
--the three number functions are ROUND, TRUNC, MOD

--if the second parameter is a negative number then we round from the point to the left
SELECT ROUND(45.925, 2), ROUND(45.923, 0), ROUND(45.923, -1)
FROM dual

--Same as above
SELECT TRUNC(45.925, 2), TRUNC(45.923, 0), TRUNC(45.923, -1)
FROM dual

-pretty easy
SELECT last_name, salary, MOD(salary, 5000)
FROM employees
WHERE job_id='SA_REP'

--date type--
--sysdate is useful to check the system's date config
SELECT sysdate FROM dual

--we can make some arithmetic operations with dates
--we add one day to the date 
SELECT sysdate + 1 FROM dual

--check how many weeks a employee has been working 
SELECT last_name, TRUNC((SYSDATE-hire_date)/7,1) AS weeks
FROM employees
WHERE department_id = 90

--Some single functions with dates are MONTHS_BETWEEN, ADD_MONTS, NEXT_DAY, LAST_DAY,
--ROUND, TRUNC
SELECT TRUNC(MONTHS_BETWEEN('01/09/95','11/01/94'))m_b,--returns the months between two dates
       ADD_MONTHS('11/01/94',6)a_m,--add months to a date
       NEXT_DAY('01/09/95','JUEBEBES')n_d,--Returns when is the next day of thw week
       LAST_DAY('01/02/95')l_d--returns when is the last day of a month
FROM dual

SELECT employee_id, hire_date, TRUNC(MONTHS_BETWEEN(SYSDATE, hire_date)) tenure,
       ADD_MONTHS(hire_date, 6) review, NEXT_DAY(hire_date, 'LUNES'), LAST_DAY(hire_date)
FROM employees
WHERE MONTHS_BETWEEN(SYSDATE, hire_date) < 150;

SELECT ROUND(SYSDATE, 'MONTH'),
       ROUND(SYSDATE, 'YEAR'),
       TRUNC(SYSDATE, 'MONTH'),
       TRUNC(SYSDATE, 'YEAR')
FROM dual

SELECT employee_id, hire_date, ROUND(hire_date, 'MONTH'), TRUNC(hire_date, 'MONTH')
FROM employees
WHERE hire_date LIKE '%07'
