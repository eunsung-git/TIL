--��� �޿� �̻��� �޴� ��� ����� �����ȣ, �� �� �޿�
SELECT EMPLOYEE_ID, LAST_NAME, SALARY
FROM EMPLOYEES
WHERE SALARY > (SELECT AVG(SALARY)
                FROM EMPLOYEES)
ORDER BY SALARY;

--���� 'u'�� ���Ե� ����� ���� �μ��� �ٹ��ϴ� ����� �����ȣ�� ��
SELECT EMPLOYEE_ID, LAST_NAME
FROM EMPLOYEES
WHERE DEPARTMENT_ID IN (SELECT DEPARTMENT_ID
                        FROM EMPLOYEES
                        WHERE LAST_NAME LIKE '%u%');

-- �μ� ��ġ id�� 1700�� ����� ��, �μ�id �� ����id
SELECT E.LAST_NAME, D.DEPARTMENT_ID, E.JOB_ID
FROM EMPLOYEES E JOIN DEPARTMENTS D
ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
JOIN LOCATIONS L
ON D.LOCATION_ID = L.LOCATION_ID
AND L.LOCATION_ID = 1700
ORDER BY D.DEPARTMENT_ID;

-- king���� �����ϴ� ��� ����� ���� �޿�
SELECT LAST_NAME,SALARY
FROM EMPLOYEES
WHERE MANAGER_ID = (SELECT EMPLOYEE_ID
                    FROM EMPLOYEES
                    WHERE LAST_NAME = 'King');
                    
-- executive �μ��� ��� ����� �μ�id, �� �� ���� id
SELECT DEPARTMENT_ID, LAST_NAME, JOB_ID
FROM EMPLOYEES
WHERE DEPARTMENT_ID = (SELECT DEPARTMENT_ID
                       FROM DEPARTMENTS
                       WHERE DEPARTMENT_NAME = 'Executive');

-- �μ� 60�� ������� �޿��� ���� ��� ���
SELECT LAST_NAME
FROM EMPLOYEES
WHERE SALARY > ANY (SELECT SALARY
                    FROM EMPLOYEES
                    WHERE DEPARTMENT_ID = 60);
                    
-- ��պ��� ���� �޿��� �ް� ���� 'u'�� ���Ե� ����� ���� �μ��� ��� ����
SELECT EMPLOYEE_ID, LAST_NAME, SALARY
FROM EMPLOYEES
WHERE DEPARTMENT_ID IN (SELECT DEPARTMENT_ID
                        FROM EMPLOYEES
                        WHERE LAST_NAME LIKE '%u%')
AND SALARY > (SELECT AVG(SALARY)
              FROM EMPLOYEES);
