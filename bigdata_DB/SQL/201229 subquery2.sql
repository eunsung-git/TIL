--�μ���ȣ �� �޿� ��� Ŀ�̼��� �޴� ����� ��ġ�ϴ� ��� ����
SELECT LAST_NAME,DEPARTMENT_ID,SALARY
FROM EMPLOYEES
WHERE (SALARY,DEPARTMENT_ID) IN (SELECT SALARY,DEPARTMENT_ID
                                 FROM EMPLOYEES
                                 WHERE COMMISSION_PCT IS NOT NULL);

--�޿� �� JOB_ID�� 1700 ��ġ�� ��� ����
WITH ED AS (SELECT *
             FROM EMPLOYEES E JOIN DEPARTMENTS D
             ON E.DEPARTMENT_ID = D.DEPARTMENT_ID)
SELECT ED.LAST_NAME,ED.DEPARTMENT_NAME,ED.SALARY
FROM ED JOIN LOCATIONS L
ON ED.LOCATION_ID = L.LOCATION_ID
AND ED.LOCATION_ID = 1700;

--�޿� �� MANAGER_ID�� Kochhar�� ������ ��� ��� ����
SELECT LAST_NAME,HIRE_DATE,SALARY
FROM EMPLOYEES
WHERE (SALARY,MANAGER_ID) IN (SELECT SALARY,MANAGER_ID
                              FROM EMPLOYEES
                              WHERE LAST_NAME = 'Kochhar')
AND LAST_NAME != 'Kochhar';

--��� ���������ں��� ���� �޿��� �޴� ��� ����
SELECT E.LAST_NAME,E.HIRE_DATE,E.SALARY
FROM EMPLOYEES E JOIN (SELECT *
                       FROM EMPLOYEES
                       WHERE JOB_ID = 'SA_MAN') S
ON E.SALARY > S.SALARY;

SELECT LAST_NAME,HIRE_DATE,SALARY
FROM EMPLOYEES
WHERE SALARY > (SELECT MAX(SALARY)
                FROM EMPLOYEES
                WHERE JOB_ID = 'SA_MAN');

--�̸��� T�� �����ϴ� ���ÿ� �����ϴ� ��� ����
WITH DL AS (SELECT *
            FROM DEPARTMENTS D JOIN LOCATIONS L
            ON D.LOCATION_ID = L.LOCATION_ID)
SELECT E.EMPLOYEE_ID,E.LAST_NAME,E.DEPARTMENT_ID
FROM EMPLOYEES E JOIN DL
ON E.DEPARTMENT_ID = DL.DEPARTMENT_ID
AND DL.CITY LIKE 'T%';

--�ش�μ��� ��� �޿����� ���� �޿��� ��� ����, ��ձ޿� �Ҽ��� 2�ڸ��� �ݿø�
SELECT E.LAST_NAME ENAME,E.SALARY,E.DEPARTMENT_ID DEPTNO,ROUND(S.DEPT_AVG,2) DEPT_AVG
FROM EMPLOYEES E 
JOIN (SELECT DEPARTMENT_ID,AVG(SALARY) DEPT_AVG
      FROM EMPLOYEES
      GROUP BY DEPARTMENT_ID) S
ON E.DEPARTMENT_ID = S.DEPARTMENT_ID
AND E.SALARY > S.DEPT_AVG
ORDER BY DEPT_AVG;

--�����ڰ� ���� ��� ���
SELECT E.LAST_NAME
FROM EMPLOYEES E
WHERE NOT EXISTS (SELECT *
                  FROM EMPLOYEES
                  WHERE MANAGER_ID = E.MANAGER_ID);

--�ش� �μ��� ��� �޿����� ���� �޿��� �޴� ����� ��
SELECT E.LAST_NAME
FROM EMPLOYEES E 
JOIN (SELECT DEPARTMENT_ID,AVG(SALARY) DEPT_AVG
      FROM EMPLOYEES
      GROUP BY DEPARTMENT_ID) S
ON E.DEPARTMENT_ID = S.DEPARTMENT_ID
AND E.SALARY < S.DEPT_AVG;

--�μ����� �ڽź��� ä�볯¥�� ������ �� ���� �޿��� �޴� ���ᰡ �� �� �̻��� ����� ��
SELECT E.LAST_NAME
FROM EMPLOYEES E
WHERE EXISTS (SELECT *
              FROM EMPLOYEES
              WHERE HIRE_DATE < E.HIRE_DATE
              AND SALARY < E.SALARY);

--��� ����� ���ID,�� �� �μ��̸�
SELECT EMPLOYEE_ID,LAST_NAME
      , (SELECT DEPARTMENT_NAME
         FROM DEPARTMENTS D
         WHERE D.DEPARTMENT_ID = E.DEPARTMENT_ID) DEPARTMENT
FROM EMPLOYEES E;

--�� �޿��� ��ü ȸ���� �� �޿��� 1/8�� �ʰ��ϴ� �μ�,�μ��� �� �޿�
WITH DP AS (SELECT DEPARTMENT_ID,SUM(SALARY) DEPT_TOTAL
            FROM EMPLOYEES
            GROUP BY DEPARTMENT_ID)
SELECT D.DEPARTMENT_NAME,DP.DEPT_TOTAL
FROM DEPARTMENTS D JOIN DP
ON D.DEPARTMENT_ID = DP.DEPARTMENT_ID
AND DP.DEPT_TOTAL > (SELECT SUM(SALARY)*0.125
                     FROM EMPLOYEES);

---------------------------------------
SELECT 'CREATE SYNONYM '||TABLE_NAME||' FOR TEST.'||TABLE_NAME||';'
FROM ALL_TABLES 
WHERE OWNER = 'TEST' ; 

CREATE SYNONYM PRODUCTS FOR TEST.PRODUCTS;
CREATE SYNONYM ORDERS FOR TEST.ORDERS;
CREATE SYNONYM ORDER_ITEMS FOR TEST.ORDER_ITEMS;
CREATE SYNONYM ORDER_CANCEL FOR TEST.ORDER_CANCEL;
CREATE SYNONYM WISHLIST FOR TEST.WISHLIST;
CREATE SYNONYM BLACKLIST FOR TEST.BLACKLIST;
CREATE SYNONYM DORMANT_HIST FOR TEST.DORMANT_HIST;
CREATE SYNONYM custs FOR sh.customers;
CREATE SYNONYM prods FOR sh.products;
CREATE SYNONYM sales FOR sh.sales;
CREATE SYNONYM times FOR sh.times;
CREATE SYNONYM channels FOR sh.channels;
CREATE SYNONYM promotions FOR sh.promotions;
CREATE SYNONYM keynote FOR user30.keynote;
CREATE SYNONYM chatting FOR user30.chatting;
CREATE SYNONYM all_chatting FOR user30.all_chatting;
CREATE SYNONYM kospi FOR user30.kospi;

----WISHLIST�� ����� ��ǰ�� �ִ� ���� �ֹ��հ�
SELECT * FROM CUSTOMERS; --CUST_ID
SELECT * FROM ORDERS; --CUST_ID
SELECT * FROM WISHLIST;

--WISHLIST TABLE�� ������� �ʿ����� �����Ƿ�,
--FROM�� �ø��� �ʰ� �������� �ۼ�

--��� 1 EXISTS
SELECT c.cust_id,c.cust_fname,c.cust_lname
      ,SUM(o.order_total) AS order_total
FROM  customers c 
JOIN orders o
ON c.cust_id = o.cust_id
AND EXISTS (SELECT 1
            FROM wishlist 
            WHERE cust_id = c.cust_id
            AND deleted = 'N') 
GROUP BY c.cust_id,c.cust_fname,c.cust_lname 
ORDER BY c.cust_id ;

--��� 2 IN
SELECT c.cust_id, c.cust_fname, c.cust_lname
      ,SUM(o.order_total) AS order_total
FROM  customers c
JOIN orders o
ON c.cust_id   = o.cust_id
AND c.cust_id IN (SELECT cust_id
                  FROM wishlist 
                  WHERE deleted = 'N') 
GROUP BY c.cust_id, c.cust_fname, c.cust_lname 
ORDER BY c.cust_id ;

--��� 3 INLINE VIEW
SELECT a.cust_id, a.cust_fname, a.cust_lname, o.order_total
FROM (SELECT cust_id, cust_fname, cust_lname 
      FROM customers c
      WHERE EXISTS (SELECT 1
                    FROM wishlist 
                    WHERE cust_id = c.cust_id
                    AND deleted = 'N')) a 
JOIN (SELECT cust_id, SUM(order_total) AS order_total
      FROM orders    
      GROUP BY cust_id) o
ON a.cust_id = o.cust_id
ORDER BY a.cust_id ;


----���� �ֹ��ݾ� �հ�(SUM(order_total)), ���ɻ�ǰ ��� �հ�(SUM(unit_price*quantity))
SELECT * FROM CUSTOMERS; --CUST_ID
SELECT * FROM ORDERS; --CUST_ID
SELECT * FROM WISHLIST;

--�ʿ��� ���̺��� FROM�� ���� �ø��� ����, INLINE VIEW �ִ��� Ȱ��
SELECT c.cust_id, c.cust_fname, c.cust_lname, o.ord_tot, w.wish_tot
FROM customers c
JOIN (SELECT cust_id, SUM(order_total) AS ord_tot
      FROM orders 
      GROUP BY cust_id) o
ON c.cust_id = o.cust_id
JOIN (SELECT cust_id, SUM(unit_price * quantity) AS wish_tot
      FROM wishlist
      WHERE deleted = 'N'
      GROUP BY cust_id) w 
ON c.cust_id = w.cust_id
ORDER BY c.cust_id ;


----��ǰ�� �Ǹ� ����(QUANTITY_SOLD)�� �հ�, �Ǹŵ��� ���� ��ǰ�� �����Ѵٸ� �ش� ��ǰ�� �Բ� ǥ��
SELECT * FROM PRODS;  --PROD_ID
SELECT * FROM SALES;

--OUTER JOIN Ȱ��
SELECT P.PROD_ID,P.PROD_NAME, S.SOLD_SUM
FROM PRODS P
LEFT OUTER JOIN (SELECT PROD_ID,SUM(QUANTITY_SOLD) SOLD_SUM
                 FROM SALES
                 GROUP BY PROD_ID) S
ON P.PROD_ID = S.PROD_ID;


----2000���� ���� �޿��� �޴� �������,�μ�����
----��, �ٹ��ϴ� ����� ���� �μ������� �Բ� �˻�
SELECT * FROM EMPLOYEES;
SELECT * FROM DEPARTMENTS;
SELECT * FROM LOCATIONS;

SELECT D.DEPARTMENT_ID DEPTNO
      ,D.DEPARTMENT_NAME DNAME
      ,L.CITY LOC
      ,E.EMPLOYEE_ID EMPNO
      ,E.LAST_NAME ENAME
      ,E.SALARY SAL
FROM EMPLOYEES E 
RIGHT OUTER JOIN (SELECT DEPARTMENT_ID,DEPARTMENT_NAME, LOCATION_ID
                  FROM DEPARTMENTS) D
ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
AND SALARY > 2000
RIGHT OUTER JOIN (SELECT LOCATION_ID,CITY
                  FROM LOCATIONS) L
ON D.LOCATION_ID = L.LOCATION_ID
ORDER BY E.DEPARTMENT_ID;

SELECT D.*, E.EMPNO, E.ENAME, E.SAL 
FROM DEPT D LEFT OUTER JOIN EMP  E 
ON D.DEPTNO = E.DEPTNO
AND E.SAL > 2000 ; 

SELECT D.*, E.EMPNO, E.ENAME, E.SAL 
FROM DEPT D 
LEFT OUTER JOIN (SELECT * FROM  EMP
                 WHERE SAL > 2000)  E 
ON D.DEPTNO = E.DEPTNO  ; 


----'Asten'(CUSTOMERS.CITY)���� WISHLIST�� ����� ��ǰ�� 
----���� �ֹ��� ��ǰ(ORDERS, ORDER_ITEMS)�� ��ǰ�� �ݾ��� ��(SUM(UNIT_PRICE*QUANTITY))
SELECT * FROM CUSTOMERS; --CUST_ID
SELECT * FROM ORDERS; --CUST_ID
SELECT * FROM ORDER_ITEMS; --ORDER_ID
SELECT * FROM WISHLIST; --PRODUCT_ID,UNIT_PRICE,QUANTITY

--��� 1 FULL OUTER JOIN ���
SELECT c.cust_id, c.cust_lname, x.product_id, x.wish_tot, x.order_tot
FROM (SELECT cust_id, cust_lname
      FROM customers  
      WHERE city = 'Asten') c
JOIN (SELECT NVL(w.cust_id, o.cust_id)       AS cust_id
            ,NVL(w.product_id, o.product_id) AS product_id
            ,NVL(w.wish_tot,0)               AS wish_tot
            ,NVL(o.order_tot,0)              AS order_tot
      FROM (SELECT cust_id
                  ,product_id
                  ,SUM(unit_price * quantity) AS wish_tot
            FROM wishlist
            WHERE deleted = 'N'
            GROUP BY cust_id, product_id) w
      FULL OUTER JOIN (SELECT o.cust_id
                             ,i.product_id
                             ,SUM(i.unit_price * i.quantity) AS order_tot
                       FROM orders o JOIN order_items i
                       ON o.order_id = i.order_id 
                       GROUP BY o.cust_id, i.product_id) o
      ON o.cust_id = w.cust_id 
      AND o.product_id = w.product_id) x 
ON c.cust_id = x.cust_id 
ORDER BY c.cust_id, x.product_id ;

--��� 2 UNION ALL ���
SELECT c.cust_id, c.cust_lname, x.product_id, x.wish_tot, x.order_tot
FROM (SELECT cust_id, cust_lname 
      FROM customers 
      WHERE city = 'Asten') c
JOIN (SELECT cust_id
            ,product_id
            ,SUM(wish_tot)  AS wish_tot,
            ,SUM(order_tot) AS order_tot
      FROM (SELECT cust_id
                  ,product_id
                  ,unit_price * quantity AS wish_tot
                  ,0                     AS order_tot
            FROM wishlist
            WHERE deleted = 'N'
            UNION ALL
            SELECT o.cust_id
                  ,i.product_id
                  ,0
                  ,i.unit_price * i.quantity AS order_tot
            FROM orders o JOIN order_items i
            ON o.order_id = i.order_id)
            GROUP BY cust_id, product_id) x
ON c.cust_id = x.cust_id
ORDER BY c.cust_id, x.product_id ;


----CUSTS.COUNTRY_ID�� 52778 �̸鼭 ���� ������ �ϳ��� ���� �� ����
SELECT * FROM SALES;
SELECT * FROM CUSTS;--CUST_ID

--��� 1 LIKE
SELECT CUST_ID, CUST_LAST_NAME, CUST_YEAR_OF_BIRTH, CUST_CITY
FROM CUSTS
WHERE CUSTS.COUNTRY_ID = 52778
AND CUST_ID NOT IN (SELECT NVL(CUST_ID,1)
                    FROM SALES);

--��� 2 EXISTS                 
SELECT cust_id, cust_last_name, cust_year_of_birth, cust_city
FROM custs c
WHERE country_id = 52778
AND NOT EXISTS (SELECT 1
                FROM sales
                WHERE cust_id = c.cust_id ) ; 


----CUSTS.COUNTRY_ID�� 52778 �̰�, 
----1998�� 10���� 10�� �̻��� ���� ������ ���� �� ����       
SELECT * FROM SALES;
SELECT * FROM CUSTS;--CUST_ID

--��� 1 LIKE
SELECT cust_id, cust_last_name, cust_year_of_birth, cust_city
FROM custs c
WHERE country_id = 52778
AND cust_id IN (SELECT cust_id 
                FROM sales
                WHERE time_id BETWEEN TO_DATE('19981001','YYYYMMDD')
                AND TO_DATE('19981101','YYYYMMDD') - 1/86400
                GROUP BY cust_id
                HAVING COUNT(cust_id) >= 10) ;

SELECT cust_id, cust_last_name, cust_year_of_birth, cust_city
FROM custs c
WHERE country_id = 52778
AND cust_id IN (SELECT cust_id 
                FROM sales
                WHERE TO_CHAR(time_id,'YYYYMM') = '199810' 
                GROUP BY cust_id
                HAVING COUNT(cust_id) >= 10) ;

--��� 2 EXISTS
SELECT cust_id, cust_last_name, cust_year_of_birth, cust_city
FROM custs c
WHERE country_id = 52778
AND EXISTS (SELECT *
            FROM sales
            WHERE time_id BETWEEN TO_DATE('19981001','YYYYMMDD')
            AND TO_DATE('19981101','YYYYMMDD') - 1/86400
            AND cust_id = c.cust_id
            GROUP BY cust_id
            HAVING COUNT(cust_id) >= 10) ;


----CUSTS.COUNTRY_ID�� 52778 �̸鼭 ���� ������ �ϳ��� ���ų�, 
----COUNTRY_ID�� 52778 �̸鼭 1998�� 10���� 10�� �̻��� ���� ������ ���� �� ����
----���� ������ �ִ� ���� ���� ������ �Բ� �˻��ϸ�, 
----���� ���� ��������, �� ��ȣ �������� ����
SELECT * FROM SALES;
SELECT * FROM CUSTS;--CUST_ID

--��� 1 UNION ALL Ȱ��
SELECT c.cust_id, c.cust_last_name, c.cust_year_of_birth,
            c.cust_city, COUNT(s.cust_id) CNT
FROM custs c JOIN sales s
ON c.cust_id = s.cust_id
AND c.country_id = 52778
AND s.time_id BETWEEN TO_DATE('19981001','YYYYMMDD')
    AND TO_DATE('19981101','YYYYMMDD') - 1/86400
GROUP BY c.cust_id,c.cust_last_name,c.cust_year_of_birth,c.cust_city
HAVING COUNT(s.cust_id) >= 10
UNION ALL
SELECT cust_id, cust_last_name, cust_year_of_birth, cust_city, 0
FROM custs c
WHERE country_id = 52778
AND NOT EXISTS (SELECT 1 
                FROM sales
                WHERE cust_id = c.cust_id )
ORDER BY cnt DESC, cust_id ;

-- ��� 2 OUTER JOIN Ȱ��
SELECT c.cust_id, c.cust_last_name, c.cust_year_of_birth,
            c.cust_city, COUNT(s.cust_id) AS CNT
FROM sales s LEFT OUTER JOIN custs c 
ON c.cust_id = s.cust_id
AND c.country_id = 52778
AND DECODE(s.cust_id,NULL,'199810',TO_CHAR(time_id,'YYYYMM')) = '199810'
GROUP BY c.cust_id,c.cust_last_name,c.cust_year_of_birth,c.cust_city
HAVING COUNT(s.cust_id) >= 10 OR COUNT(s.cust_id)  = 0
ORDER BY cnt DESC, cust_id ;


----1981�⵵�� �Ի��� ������� �Ի� ������ �ο��� �˻�, ����� ���� ���� �Բ� ���
--��� 1 LEVEL & CONNECT BY Ȱ��
SELECT b.hire, NVL(a.cnt,0) CNT
FROM (SELECT TO_CHAR(hiredate,'YYYY/MM') hire, count(*) cnt
      FROM emp
      WHERE hiredate BETWEEN TO_DATE('1981/01/01','YYYY/MM/DD')
            AND TO_DATE('1982/01/01','YYYY/MM/DD') - 1/86400
      GROUP BY TO_CHAR(hiredate,'YYYY/MM')) a
RIGHT OUTER JOIN (SELECT TO_CHAR(ADD_MONTHS(TO_DATE('19810101','YYYYMMDD'),LEVEL-1),'YYYY/MM') hire
                  FROM dual
                  CONNECT BY LEVEL <= 12) b
ON a.hire = b.hire
ORDER BY 1 ;

--��� 2 ROWNUM���� 12�� ���� ��, OUTER JOIN Ȱ��
SELECT A.HIRE, NVL(B.CNT,0) CNT
FROM (SELECT '1981/'||LPAD(ROWNUM,2,'0') HIRE
      FROM EMP 
      WHERE ROWNUM <= 12) A 
LEFT OUTER JOIN (SELECT TO_CHAR(HIREDATE,'YYYY/MM') HIRE, COUNT(*) CNT
                 FROM EMP
                 WHERE TO_CHAR(HIREDATE,'YYYY') = '1981'
                 GROUP BY TO_CHAR(HIREDATE,'YYYY/MM')) B
ON A.HIRE = B.HIRE 
ORDER BY 1 ;


----1981�⵵�� �Ի��� ������� �μ���ȣ, �Ի� ���� �ο���
----��, �Ի��� ����� ���� ���� �Բ� ���

--��� 1 UNION ALL
SELECT b.DEPTNO, b.hire, NVL(a.cnt,0) CNT
FROM (SELECT DEPTNO, TO_CHAR(hiredate,'YYYY/MM') hire, count(*) cnt
      FROM emp
      WHERE hiredate BETWEEN TO_DATE('1981/01/01','YYYY/MM/DD')
            AND TO_DATE('1982/01/01','YYYY/MM/DD') - 1/86400
      GROUP BY DEPTNO, TO_CHAR(hiredate,'YYYY/MM')) a
RIGHT OUTER JOIN (SELECT 10 DEPTNO 
                        ,TO_CHAR(ADD_MONTHS(TO_DATE('19810101','YYYYMMDD'),LEVEL-1),'YYYY/MM') hire
                  FROM dual
                  CONNECT BY LEVEL <= 12
			      UNION ALL 
			      SELECT 20 DEPTNO
                        ,TO_CHAR(ADD_MONTHS(TO_DATE('19810101','YYYYMMDD'),LEVEL-1),'YYYY/MM') hire
                  FROM dual
                  CONNECT BY LEVEL <= 12
			      UNION ALL 
			      SELECT 30 DEPTNO
                        ,TO_CHAR(ADD_MONTHS(TO_DATE('19810101','YYYYMMDD'),LEVEL-1),'YYYY/MM') hire
                  FROM dual
                  CONNECT BY LEVEL <= 12) b
ON a.deptno = b.deptno 
AND a.hire = b.hire
ORDER BY 1,2 ;

--��� 2 CROSS JOIN
SELECT b.DEPTNO, b.hire, NVL(a.cnt,0) CNT
FROM (SELECT DEPTNO, TO_CHAR(hiredate,'YYYY/MM') hire, count(*) cnt
      FROM emp
      WHERE hiredate BETWEEN TO_DATE('1981/01/01','YYYY/MM/DD')
            AND TO_DATE('1982/01/01','YYYY/MM/DD') - 1/86400
      GROUP BY DEPTNO, TO_CHAR(hiredate,'YYYY/MM')) a
RIGHT OUTER JOIN (SELECT D.DEPTNO, H.HIRE
                  FROM (SELECT DEPTNO 
			            FROM DEPT 
			            WHERE DEPTNO <= 30) D 
                        CROSS JOIN 
                       (SELECT TO_CHAR(ADD_MONTHS(TO_DATE('19810101','YYYYMMDD'),LEVEL-1),'YYYY/MM') hire
                        FROM dual
                        CONNECT BY LEVEL <= 12) H) b
ON a.deptno = b.deptno 
AND a.hire = b.hire
ORDER BY 1,2 ;

--��� 3 PARTITION BY
SELECT a.DEPTNO, b.hire, NVL(a.cnt,0) CNT
FROM (SELECT DEPTNO, TO_CHAR(hiredate,'YYYY/MM') hire, count(*) cnt
      FROM emp
      WHERE hiredate BETWEEN TO_DATE('1981/01/01','YYYY/MM/DD')
            AND TO_DATE('1982/01/01','YYYY/MM/DD') - 1/86400
      GROUP BY DEPTNO, TO_CHAR(hiredate,'YYYY/MM')) a
PARTITION BY (A.DEPTNO)			 
RIGHT OUTER JOIN (SELECT TO_CHAR(ADD_MONTHS(TO_DATE('19810101','YYYYMMDD'),LEVEL-1),'YYYY/MM') hire
                  FROM dual
                  CONNECT BY LEVEL <= 12) b
ON a.hire = b.hire
ORDER BY 1,2 ;
