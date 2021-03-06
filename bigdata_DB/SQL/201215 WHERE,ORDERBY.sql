SELECT * FROM EMPLOYEES;

SELECT LAST_NAME,SALARY
FROM EMPLOYEES 
WHERE SALARY > 12000;

SELECT LAST_NAME,DEPARTMENT_ID
FROM EMPLOYEES
WHERE EMPLOYEE_ID = 176;

SELECT LAST_NAME,SALARY
FROM EMPLOYEES
WHERE SALARY NOT BETWEEN 5000 AND 12000;

SELECT LAST_NAME,JOB_ID,HIRE_DATE
FROM EMPLOYEES
WHERE LAST_NAME IN ('Matos','Taylor');

SELECT LAST_NAME,DEPARTMENT_ID
FROM EMPLOYEES
WHERE DEPARTMENT_ID IN (20,50)
ORDER BY LAST_NAME;

SELECT LAST_NAME "Employee",SALARY "Monthly Salary"
FROM EMPLOYEES
WHERE (SALARY BETWEEN 5000 AND 12000)
AND DEPARTMENT_ID IN (20,50);

SELECT LAST_NAME,HIRE_DATE
FROM EMPLOYEES
WHERE HIRE_DATE LIKE '2006%';

SELECT LAST_NAME, JOB_ID
FROM EMPLOYEES
WHERE MANAGER_ID IS NULL;

SELECT LAST_NAME,SALARY,COMMISSION_PCT
FROM EMPLOYEES
WHERE COMMISSION_PCT IS NOT NULL
ORDER BY SALARY DESC,COMMISSION_PCT DESC;

SELECT LAST_NAME,SALARY
FROM EMPLOYEES
WHERE SALARY > 12000;

SELECT EMPLOYEE_ID,LAST_NAME,SALARY,DEPARTMENT_ID
FROM EMPLOYEES
WHERE MANAGER_ID = 103
ORDER BY LAST_NAME;

SELECT EMPLOYEE_ID,LAST_NAME,SALARY,DEPARTMENT_ID
FROM EMPLOYEES
WHERE MANAGER_ID = 201
ORDER BY SALARY;

SELECT EMPLOYEE_ID,LAST_NAME,SALARY,DEPARTMENT_ID
FROM EMPLOYEES
WHERE MANAGER_ID = 124
ORDER BY EMPLOYEE_ID;

SELECT LAST_NAME
FROM EMPLOYEES
WHERE LAST_NAME LIKE '__a%';

SELECT LAST_NAME
FROM EMPLOYEES
WHERE LAST_NAME LIKE '%a%e%'
or LAST_NAME LIKE '%e%a%';

SELECT LAST_NAME,JOB_ID,SALARY
FROM EMPLOYEES
WHERE JOB_ID IN ('SA_REP','ST_CLERK')
AND SALARY NOT IN(2500,3500,7000);

SELECT LAST_NAME "Employee",SALARY "Monthly Salary",COMMISSION_PCT
FROM EMPLOYEES
WHERE COMMISSION_PCT = 0.2;
---------------------------
SELECT *
FROM EMP
WHERE SAL < COMM;

SELECT *
FROM EMP
WHERE HIREDATE LIKE '1981%';

SELECT *
FROM EMP
WHERE HIREDATE LIKE '1981%'
AND DEPTNO IN (10,20)
ORDER BY HIREDATE;

SELECT *
FROM EMP
WHERE HIREDATE BETWEEN '1980/12/17' AND '1980/12/18';

SELECT *
FROM EMP
WHERE HIREDATE LIKE '%04%';

SELECT *
FROM EMP
WHERE ENAME LIKE 'S%'
OR ENAME LIKE 'A%';