--평균 급여 이상을 받는 모든 사원의 사원번호, 성 및 급여
SELECT EMPLOYEE_ID, LAST_NAME, SALARY
FROM EMPLOYEES
WHERE SALARY > (SELECT AVG(SALARY)
                FROM EMPLOYEES)
ORDER BY SALARY;

--성에 'u'가 포함된 사원과 같은 부서에 근무하는 사원의 사원번호와 성
SELECT EMPLOYEE_ID, LAST_NAME
FROM EMPLOYEES
WHERE DEPARTMENT_ID IN (SELECT DEPARTMENT_ID
                        FROM EMPLOYEES
                        WHERE LAST_NAME LIKE '%u%');

-- 부서 위치 id가 1700인 사원의 성, 부서id 및 직무id
SELECT E.LAST_NAME, D.DEPARTMENT_ID, E.JOB_ID
FROM EMPLOYEES E JOIN DEPARTMENTS D
ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
JOIN LOCATIONS L
ON D.LOCATION_ID = L.LOCATION_ID
AND L.LOCATION_ID = 1700
ORDER BY D.DEPARTMENT_ID;

-- king에게 보고하는 모든 사원의 성과 급여
SELECT LAST_NAME,SALARY
FROM EMPLOYEES
WHERE MANAGER_ID = (SELECT EMPLOYEE_ID
                    FROM EMPLOYEES
                    WHERE LAST_NAME = 'King');
                    
-- executive 부서의 모든 사원의 부서id, 성 및 직무 id
SELECT DEPARTMENT_ID, LAST_NAME, JOB_ID
FROM EMPLOYEES
WHERE DEPARTMENT_ID = (SELECT DEPARTMENT_ID
                       FROM DEPARTMENTS
                       WHERE DEPARTMENT_NAME = 'Executive');

-- 부서 60의 사원보다 급여가 많은 모든 사원
SELECT LAST_NAME
FROM EMPLOYEES
WHERE SALARY > ANY (SELECT SALARY
                    FROM EMPLOYEES
                    WHERE DEPARTMENT_ID = 60);
                    
-- 평균보다 많은 급여를 받고 성에 'u'가 포함된 사원이 속한 부서의 사원 정보
SELECT EMPLOYEE_ID, LAST_NAME, SALARY
FROM EMPLOYEES
WHERE DEPARTMENT_ID IN (SELECT DEPARTMENT_ID
                        FROM EMPLOYEES
                        WHERE LAST_NAME LIKE '%u%')
AND SALARY > (SELECT AVG(SALARY)
              FROM EMPLOYEES);
