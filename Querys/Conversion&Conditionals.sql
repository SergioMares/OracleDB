/*there are two types of conversion functions; implicit and explicit functions. We're gonna 
 *deepen into explicit functions.
 * VARCHAR2 or CHAR <-> NUMBER
 * VARCHAR2 or CHAR <-> DATE
 */

--TO_CHAR(date, 'format_model') DATES
/*format model 
 *YYYY  -> Year as numbers
 *YEAR  -> Years as string
 *MM    -> Month as 2 digits
 *MONTH -> Month as string
 *MON   -> Month as 3 chars
 *DY    -> Day as 3 chars
 *DAY   -> Day as a string
 *DD    -> Day of the month 
 *---------------------------------*
 *To express hours as more especific way, we can use the following format
 *HH24:MI:SS AM
 *---------------------------------*
 *We can put strings in the date using "quotes"
 *---------------------------------*
 *use the Ddspth to se numbers as cardinal dates
 *the fm before a date, deletes 0 on left and spaces
 */
 
SELECT employee_id, hire_date, 
       TO_CHAR(hire_date, 'MM/YY') month_date,
       TO_CHAR(hire_date, 'HH24:MI:SS AM fmDD-MM-YYYY'),
       TO_CHAR(hire_date,  '"hired Friday the" Ddspth')
FROM employees
WHERE last_name = 'Higgins'

--TO_CHAR(number, 'format_model') NUMBERS
/*format model
 *9 -> a number
 *0 -> a 0
 *$ -> a float dollar sign
 *L -> a float local badge 
 *. -> prints a decimal comma
 *, -> indicates thousands
 */

SELECT TO_CHAR (salary, '$99,999.00'), salary
FROM employees
WHERE last_name = 'Ernst'

--We can do the reverse process of the previous examples with the TO_NUMBER and TO_DATE 
--command. if the format model is between brackets it means that is an optional to use 
--the format model

SELECT last_name, TO_CHAR(hire_date, 'DD-Mon-YYY')
FROM employees
WHERE hire_date < TO_DATE('01-Ene-09', 'DD-Mon-RR')



/*
 *the NVL funciton allows us to work with the null values. In other words, it transforms 
 *the null value in something else
 * NVL(x,y) if x is null returns y, otherwise returns y
 * x & y have to be the same type of data. if they're different use the TO_XXX funciotns
 */

SELECT last_name, manager_id, NVL(TO_CHAR(manager_id), 'No Manager')
FROM employees
WHERE manager_id IS NULL


--The NVL2 functions is kinda an ternary operator
--NVL2(x,y,z) check x. if null returns y else returns z

SELECT last_name, salary, commission_pct,
NVL2(commission_pct, 'not null', 'is null') income
FROM employees
WHERE department_id IN (50,80);


--the NULLIF(x,y) function returns null if x & y are the same. Otherwise returns the 
--first one that is not null

SELECT first_name, LENGTH(first_name) "x",
last_name, LENGTH(last_name) "y",
NULLIF(LENGTH(first_name), LENGTH(last_name)) result
FROM employees


--COALESCE is like the NVL function but let us choose multiple options
--COALESCE(x,y,z,...,n)returns the first one that is not null

SELECT last_name, commission_pct, salary, 
COALESCE(commission_pct, salary, 10) comm
FROM employees
ORDER BY commission_pct



--Conditionales IF-THEN-ELSE--

--CASE
SELECT last_name, job_id, salary,
       CASE job_id WHEN 'IT_PROG' THEN 1.10 * salary
                   WHEN 'FI_ACCOUNT' THEN 1.15 * salary
                   WHEN 'AD_VP' THEN 1.20 * salary 
                   ELSE salary 
       END "REVISED SALARY"
FROM employees

--DECODE
SELECT last_name, job_id, salary,
       DECODE (job_id, 'IT_PROG', 1.10 * salary,
                       'ST_CLERK', 1.15 * salary,
                       'SA_REP', 1.20 * salary,
              salary) revised_salary
FROM employees


SELECT last_name, salary,
       DECODE (TRUNC(salary/2000,0),
                            0, 0.00,
                            1, 0.09,
                            2, 0.20,
                            3, 0.30,
                            4, 0.40,
                            5, 0.42,
                            6, 0.44,
       0.45) tax_rate
FROM employees
WHERE department_id=80;
