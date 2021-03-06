SELECT * FROM EMPLOYEES;

SELECT MAX(SALARY) "Maximum"
    ,MIN(SALARY) "Minimum"
    ,SUM(SALARY) "Sum"
    ,ROUND(AVG(SALARY),0) "Average"
FROM EMPLOYEES;

SELECT JOB_ID
    ,MAX(SALARY) "Maximum"
    ,MIN(SALARY) "Minimum"
    ,SUM(SALARY) "Sum"
    ,ROUND(AVG(SALARY),0) "Average"
FROM EMPLOYEES
GROUP BY JOB_ID;

SELECT JOB_ID, COUNT(*)
FROM EMPLOYEES
GROUP BY JOB_ID
ORDER BY JOB_ID;

SELECT JOB_ID, COUNT(*)
FROM EMPLOYEES
WHERE JOB_ID = 'IT_PROG'
GROUP BY JOB_ID
ORDER BY JOB_ID;

SELECT COUNT(DISTINCT MANAGER_ID) "Number of Managers"
FROM EMPLOYEES;

SELECT MAX(SALARY)-MIN(SALARY) "Difference"
FROM EMPLOYEES;

SELECT MANAGER_ID,MIN(SALARY)
FROM EMPLOYEES
WHERE MANAGER_ID IS NOT NULL
GROUP BY MANAGER_ID 
HAVING MIN(SALARY) > 6000
ORDER BY MIN(SALARY) DESC;

SELECT COUNT(EMPLOYEE_ID) TOTAL
    ,COUNT(CASE WHEN TO_CHAR(HIRE_DATE,'YYYY')='2005' THEN EMPLOYEE_ID END) "2005"
    ,COUNT(CASE WHEN TO_CHAR(HIRE_DATE,'YYYY')='2006' THEN EMPLOYEE_ID END) "2006"
    ,COUNT(CASE WHEN TO_CHAR(HIRE_DATE,'YYYY')='2007' THEN EMPLOYEE_ID END) "2007"
    ,COUNT(CASE WHEN TO_CHAR(HIRE_DATE,'YYYY')='2008' THEN EMPLOYEE_ID END) "2008"
FROM EMPLOYEES;

SELECT JOB_ID
    ,SUM(CASE DEPARTMENT_ID WHEN 20 THEN SALARY END) "Dept20"
    ,SUM(CASE DEPARTMENT_ID WHEN 50 THEN SALARY END) "Dept50"
    ,SUM(CASE DEPARTMENT_ID WHEN 80 THEN SALARY END) "Dept80"
    ,SUM(CASE DEPARTMENT_ID WHEN 90 THEN SALARY END) "Dept90"
    ,SUM(SALARY) "Total"
FROM EMPLOYEES
GROUP BY JOB_ID;

-------------------------
--부서별 직무별 급여의 합
SELECT DEPTNO
    ,SUM(CASE WHEN job = 'ANALYST' THEN sal END) Analyst
    ,SUM(CASE WHEN job = 'CLERK' THEN sal END) Clerk
    ,SUM(CASE WHEN job = 'MANAGER' THEN sal END) Manager
    ,SUM(CASE WHEN job = 'PRESIDENT' THEN sal END) President
    ,SUM(CASE WHEN job = 'SALESMAN' THEN sal END) Salesman
FROM EMP
GROUP BY DEPTNO
ORDER BY DEPTNO;
