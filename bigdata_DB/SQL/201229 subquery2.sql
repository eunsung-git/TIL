--부서번호 및 급여 모두 커미션을 받는 사원과 일치하는 사원 정보
SELECT LAST_NAME,DEPARTMENT_ID,SALARY
FROM EMPLOYEES
WHERE (SALARY,DEPARTMENT_ID) IN (SELECT SALARY,DEPARTMENT_ID
                                 FROM EMPLOYEES
                                 WHERE COMMISSION_PCT IS NOT NULL);

--급여 및 JOB_ID가 1700 위치인 사원 정보
WITH ED AS (SELECT *
             FROM EMPLOYEES E JOIN DEPARTMENTS D
             ON E.DEPARTMENT_ID = D.DEPARTMENT_ID)
SELECT ED.LAST_NAME,ED.DEPARTMENT_NAME,ED.SALARY
FROM ED JOIN LOCATIONS L
ON ED.LOCATION_ID = L.LOCATION_ID
AND ED.LOCATION_ID = 1700;

--급여 및 MANAGER_ID가 Kochhar와 동일한 모든 사원 정보
SELECT LAST_NAME,HIRE_DATE,SALARY
FROM EMPLOYEES
WHERE (SALARY,MANAGER_ID) IN (SELECT SALARY,MANAGER_ID
                              FROM EMPLOYEES
                              WHERE LAST_NAME = 'Kochhar')
AND LAST_NAME != 'Kochhar';

--모든 영업관리자보다 많은 급여를 받는 사원 정보
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

--이름이 T로 시작하는 도시에 거주하는 사원 정보
WITH DL AS (SELECT *
            FROM DEPARTMENTS D JOIN LOCATIONS L
            ON D.LOCATION_ID = L.LOCATION_ID)
SELECT E.EMPLOYEE_ID,E.LAST_NAME,E.DEPARTMENT_ID
FROM EMPLOYEES E JOIN DL
ON E.DEPARTMENT_ID = DL.DEPARTMENT_ID
AND DL.CITY LIKE 'T%';

--해당부서의 평균 급여보다 높은 급여의 사원 정보, 평균급여 소수점 2자리수 반올림
SELECT E.LAST_NAME ENAME,E.SALARY,E.DEPARTMENT_ID DEPTNO,ROUND(S.DEPT_AVG,2) DEPT_AVG
FROM EMPLOYEES E 
JOIN (SELECT DEPARTMENT_ID,AVG(SALARY) DEPT_AVG
      FROM EMPLOYEES
      GROUP BY DEPARTMENT_ID) S
ON E.DEPARTMENT_ID = S.DEPARTMENT_ID
AND E.SALARY > S.DEPT_AVG
ORDER BY DEPT_AVG;

--관리자가 없는 모든 사원
SELECT E.LAST_NAME
FROM EMPLOYEES E
WHERE NOT EXISTS (SELECT *
                  FROM EMPLOYEES
                  WHERE MANAGER_ID = E.MANAGER_ID);

--해당 부서의 평균 급여보다 낮은 급여를 받는 사원의 성
SELECT E.LAST_NAME
FROM EMPLOYEES E 
JOIN (SELECT DEPARTMENT_ID,AVG(SALARY) DEPT_AVG
      FROM EMPLOYEES
      GROUP BY DEPARTMENT_ID) S
ON E.DEPARTMENT_ID = S.DEPARTMENT_ID
AND E.SALARY < S.DEPT_AVG;

--부서에서 자신보다 채용날짜가 늦지만 더 많은 급여를 받는 동료가 한 명 이상인 사원의 성
SELECT E.LAST_NAME
FROM EMPLOYEES E
WHERE EXISTS (SELECT *
              FROM EMPLOYEES
              WHERE HIRE_DATE < E.HIRE_DATE
              AND SALARY < E.SALARY);

--모든 사원의 사원ID,성 및 부서이름
SELECT EMPLOYEE_ID,LAST_NAME
      , (SELECT DEPARTMENT_NAME
         FROM DEPARTMENTS D
         WHERE D.DEPARTMENT_ID = E.DEPARTMENT_ID) DEPARTMENT
FROM EMPLOYEES E;

--총 급여가 전체 회사의 총 급여의 1/8을 초과하는 부서,부서의 총 급여
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

----WISHLIST에 저장된 상품이 있는 고객의 주문합계
SELECT * FROM CUSTOMERS; --CUST_ID
SELECT * FROM ORDERS; --CUST_ID
SELECT * FROM WISHLIST;

--WISHLIST TABLE은 결과물에 필요하지 않으므로,
--FROM에 올리지 않고 조건으로 작성

--방법 1 EXISTS
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

--방법 2 IN
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

--방법 3 INLINE VIEW
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


----고객별 주문금액 합계(SUM(order_total)), 관심상품 목록 합계(SUM(unit_price*quantity))
SELECT * FROM CUSTOMERS; --CUST_ID
SELECT * FROM ORDERS; --CUST_ID
SELECT * FROM WISHLIST;

--필요한 테이블을 FROM에 많이 올리지 말고, INLINE VIEW 최대한 활용
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


----제품별 판매 수량(QUANTITY_SOLD)의 합계, 판매되지 않은 제품이 존재한다면 해당 제품도 함께 표시
SELECT * FROM PRODS;  --PROD_ID
SELECT * FROM SALES;

--OUTER JOIN 활용
SELECT P.PROD_ID,P.PROD_NAME, S.SOLD_SUM
FROM PRODS P
LEFT OUTER JOIN (SELECT PROD_ID,SUM(QUANTITY_SOLD) SOLD_SUM
                 FROM SALES
                 GROUP BY PROD_ID) S
ON P.PROD_ID = S.PROD_ID;


----2000보다 많은 급여를 받는 사원정보,부서정보
----단, 근무하는 사원이 없는 부서정보도 함께 검색
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


----'Asten'(CUSTOMERS.CITY)고객이 WISHLIST에 등록한 상품과 
----실제 주문한 상품(ORDERS, ORDER_ITEMS)의 제품별 금액의 합(SUM(UNIT_PRICE*QUANTITY))
SELECT * FROM CUSTOMERS; --CUST_ID
SELECT * FROM ORDERS; --CUST_ID
SELECT * FROM ORDER_ITEMS; --ORDER_ID
SELECT * FROM WISHLIST; --PRODUCT_ID,UNIT_PRICE,QUANTITY

--방법 1 FULL OUTER JOIN 사용
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

--방법 2 UNION ALL 사용
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


----CUSTS.COUNTRY_ID가 52778 이면서 구매 내역이 하나도 없는 고객 정보
SELECT * FROM SALES;
SELECT * FROM CUSTS;--CUST_ID

--방법 1 LIKE
SELECT CUST_ID, CUST_LAST_NAME, CUST_YEAR_OF_BIRTH, CUST_CITY
FROM CUSTS
WHERE CUSTS.COUNTRY_ID = 52778
AND CUST_ID NOT IN (SELECT NVL(CUST_ID,1)
                    FROM SALES);

--방법 2 EXISTS                 
SELECT cust_id, cust_last_name, cust_year_of_birth, cust_city
FROM custs c
WHERE country_id = 52778
AND NOT EXISTS (SELECT 1
                FROM sales
                WHERE cust_id = c.cust_id ) ; 


----CUSTS.COUNTRY_ID가 52778 이고, 
----1998년 10월에 10건 이상의 구매 내역을 갖는 고객 정보       
SELECT * FROM SALES;
SELECT * FROM CUSTS;--CUST_ID

--방법 1 LIKE
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

--방법 2 EXISTS
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


----CUSTS.COUNTRY_ID가 52778 이면서 구매 내역이 하나도 없거나, 
----COUNTRY_ID가 52778 이면서 1998년 10월에 10건 이상의 구매 내역을 갖는 고객 정보
----구매 내역이 있는 고객은 구매 수량을 함께 검색하며, 
----구매 수량 내림차순, 고객 번호 오름차순 정렬
SELECT * FROM SALES;
SELECT * FROM CUSTS;--CUST_ID

--방법 1 UNION ALL 활용
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

-- 방법 2 OUTER JOIN 활용
SELECT c.cust_id, c.cust_last_name, c.cust_year_of_birth,
            c.cust_city, COUNT(s.cust_id) AS CNT
FROM sales s LEFT OUTER JOIN custs c 
ON c.cust_id = s.cust_id
AND c.country_id = 52778
AND DECODE(s.cust_id,NULL,'199810',TO_CHAR(time_id,'YYYYMM')) = '199810'
GROUP BY c.cust_id,c.cust_last_name,c.cust_year_of_birth,c.cust_city
HAVING COUNT(s.cust_id) >= 10 OR COUNT(s.cust_id)  = 0
ORDER BY cnt DESC, cust_id ;


----1981년도에 입사한 사원들을 입사 월별로 인원수 검색, 사원이 없는 월도 함께 출력
--방법 1 LEVEL & CONNECT BY 활용
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

--방법 2 ROWNUM으로 12달 만든 후, OUTER JOIN 활용
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


----1981년도에 입사한 사원들의 부서번호, 입사 월별 인원수
----단, 입사한 사원이 없는 월도 함께 출력

--방법 1 UNION ALL
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

--방법 2 CROSS JOIN
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

--방법 3 PARTITION BY
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
