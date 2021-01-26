--201214
SELECT * FROM EMPLOYEES;

DESC EMPLOYEES;

SELECT EMPLOYEE_ID,LAST_NAME,HIRE_DATE STARTDATE, JOB_ID
FROM EMPLOYEES;

SELECT EMPLOYEE_ID,JOB_ID,30
FROM EMPLOYEES;

SELECT DISTINCT JOB_ID
FROM EMPLOYEES;

SELECT EMPLOYEE_ID "Emp #",LAST_NAME "Employee",JOB_ID "job",HIRE_DATE "Hire Date"
from employees;

SELECT LAST_NAME||', '||JOB_ID "Employee and Title"
FROM EMPLOYEES;

SELECT employee_id || ',' || first_name || ',' || last_name
 || ',' || email || ',' || phone_number || ','|| job_id
 || ',' || manager_id || ',' || hire_date || ','
 || salary || ',' || commission_pct || ',' ||
department_id
 THE_OUTPUT
FROM employees;