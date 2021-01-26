----20�� �μ��� ������� �Ի� ���� �������� ����
----START_DATE : �Ի� ���ڰ� ���Ե� �� ���� ������ (�Ͽ���)
----END_DATE   : �Ի� ���ڰ� ���Ե� �� ���� ������ (�����)
SELECT empno, ename, hiredate
      ,TO_CHAR(hiredate, 'DY') DAY 
      ,TRUNC(hiredate, 'DAY') START_DATE 
      ,TRUNC(hiredate, 'DAY') + 6 END_DATE
FROM emp
WHERE deptno = 20 
ORDER BY hiredate ; 


----TIME_ID���� '1998/05/01' ���� ������ �� ��(�Ͽ���-�����)�Ǹ� ������ ���Ϻ� �ݾ�(AMOUNT_SOLD) �հ� 
----��, �˻� ����� �Ͽ��Ϻ��� ����ϱ��� ����
SELECT TO_CHAR(time_id, 'Day') day, SUM(amount_sold) 
FROM sales 
WHERE time_id BETWEEN TRUNC(TO_DATE('1998/05/01','YYYY/MM/DD'),'DY') 
AND TRUNC(TO_DATE('1998/05/01','YYYY/MM/DD'),'D') + 7 - 1/86400 
GROUP BY time_id 
ORDER BY time_id ;


----�μ��� �ִ� �޿��� �޴� ��� ����
--��� 1 JOIN & subquery
SELECT E.LAST_NAME,E.SALARY,E.JOB_ID,E.DEPARTMENT_ID
FROM EMPLOYEES E 
JOIN (SELECT DEPARTMENT_ID,MAX(SALARY) SALARY_MAX
      FROM EMPLOYEES
      GROUP BY DEPARTMENT_ID) S
ON E.DEPARTMENT_ID = S.DEPARTMENT_ID
AND E.SALARY = S.SALARY_MAX;

--��� 2 �Ϲ� subquery
SELECT e.last_name, e.salary, e.job_id, e.department_id
FROM employees e
WHERE e.salary = (SELECT MAX(salary) 
                  FROM employees s
                  WHERE s.department_id = e.department_id ) ;

--��� 3 PARTITION BY
SELECT last_name, salary, job_id, department_id
FROM (SELECT last_name, salary, job_id, department_id
             ,MAX(salary) OVER(PARTITION BY department_id) max
      FROM employees e) 
WHERE salary = max ;


----�޿��� ���� ���� �޴� 2��
----��, ������ �޿��� �޴� ����� �� �̻� �ִٸ� �Բ� �˻�
--��� 1 TOPN 
SELECT empno, ename, sal, deptno
FROM emp
WHERE sal IN (SELECT sal
              FROM (SELECT DISTINCT sal
                    FROM emp
                    ORDER BY sal DESC)
              WHERE rownum <= 2)
ORDER BY sal DESC ;

--��� 2 RANK
SELECT empno, ename, sal, deptno 
FROM (SELECT empno, ename, sal, deptno
            ,RANK() OVER (ORDER BY sal DESC) rank 
      FROM emp)  
WHERE rank <= 2 ;

--��� 3 FETCH
SELECT empno, ename, sal
FROM emp 
ORDER BY sal DESC 
FETCH FIRST 2 ROWS WITH TIES ; 


----�μ��� ���� ���� �޿��� �޴� ����� �� �� �˻�
----������ �޿��� �޴� ����� ���� ���� ��쿡�� �� �� �˻�
--ROW_NUMBER
SELECT empno, ename, sal, deptno
FROM (SELECT empno, ename, sal, deptno
            ,ROW_NUMBER() OVER(PARTITION BY deptno ORDER BY sal DESC) rank 
      FROM emp ) 
WHERE rank = 1 ; 


----�л��� ä�� Ƚ���� ���� ���� Ƚ�� ������ �˻�
SELECT SUBSTR(TEXT,14,3) NAME, COUNT(*) CNT
FROM CHATTING
GROUP BY SUBSTR(TEXT,14,3)
ORDER BY 2 DESC;


----��¥�� �л��� ä�� Ƚ��, ��¥�� ä�� Ƚ���� �������� ����
--���Խ� �̿�
SELECT yymmdd, name, count(*) 
FROM (SELECT SUBSTR(text,1,8) YYMMDD
            ,REGEXP_SUBSTR(text,'(�߽��� )(.+)( ������ ���)',1,1,'i',2) NAME      
            ,REGEXP_SUBSTR(text,'(������ ��� : )(.+)',1,1,'i',2) TEXT
      FROM all_chatting)
GROUP BY yymmdd, name 
ORDER BY 1, 3 DESC ;


----�ܾ ���� Ƚ��, Ƚ���� �������� �������� ����
SELECT * FROM KEYNOTE;

SELECT WORD, COUNT(*) AS CNT 
FROM (SELECT DECODE(B.NO,1,REGEXP_SUBSTR(TEXT,'([[:alpha:]]+)( )',1,1,'i',1)
                    ,REGEXP_SUBSTR(TEXT,'( )([[:alpha:]]+)',1,B.NO-1,'i',2)) WORD
      FROM KEYNOTE A 
      CROSS JOIN (SELECT LEVEL NO 
                  FROM DUAL
                  CONNECT BY LEVEL <= 242) B )
WHERE WORD IS NOT NULL  
GROUP BY WORD  
ORDER BY CNT DESC ;


----���� ������ ���� 5�� �̵����
SELECT * FROM KOSPI;

SELECT stid, stdate, close,
       ROUND(AVG(close) 
             OVER(PARTITION BY stid ORDER BY stdate ROWS BETWEEN 4 PRECEDING AND CURRENT ROW),2) MAVG
FROM kospi ; 


----���� �ŷ� ���������� 5�� �̵���� ��
SELECT * FROM KOSPI;

SELECT stid, MAX(mavg) KEEP(DENSE_RANK FIRST ORDER BY stdate DESC) MA
FROM (SELECT stid, stdate, close,
             ROUND(AVG(close) 
                OVER(PARTITION BY stid ORDER BY stdate ROWS BETWEEN 4 PRECEDING AND CURRENT ROW),2) MAVG
      FROM kospi)
GROUP BY stid; 
