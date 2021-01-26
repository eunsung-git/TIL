----20번 부서의 사원들을 입사 일자 기준으로 정렬
----START_DATE : 입사 일자가 포함된 한 주의 시작일 (일요일)
----END_DATE   : 입사 일자가 포함된 한 주의 종료일 (토요일)
SELECT empno, ename, hiredate
      ,TO_CHAR(hiredate, 'DY') DAY 
      ,TRUNC(hiredate, 'DAY') START_DATE 
      ,TRUNC(hiredate, 'DAY') + 6 END_DATE
FROM emp
WHERE deptno = 20 
ORDER BY hiredate ; 


----TIME_ID값이 '1998/05/01' 일을 포함한 한 주(일요일-토요일)판매 내역의 요일별 금액(AMOUNT_SOLD) 합계 
----단, 검색 결과는 일요일부터 토요일까지 정렬
SELECT TO_CHAR(time_id, 'Day') day, SUM(amount_sold) 
FROM sales 
WHERE time_id BETWEEN TRUNC(TO_DATE('1998/05/01','YYYY/MM/DD'),'DY') 
AND TRUNC(TO_DATE('1998/05/01','YYYY/MM/DD'),'D') + 7 - 1/86400 
GROUP BY time_id 
ORDER BY time_id ;


----부서별 최대 급여를 받는 사원 정보
--방법 1 JOIN & subquery
SELECT E.LAST_NAME,E.SALARY,E.JOB_ID,E.DEPARTMENT_ID
FROM EMPLOYEES E 
JOIN (SELECT DEPARTMENT_ID,MAX(SALARY) SALARY_MAX
      FROM EMPLOYEES
      GROUP BY DEPARTMENT_ID) S
ON E.DEPARTMENT_ID = S.DEPARTMENT_ID
AND E.SALARY = S.SALARY_MAX;

--방법 2 일반 subquery
SELECT e.last_name, e.salary, e.job_id, e.department_id
FROM employees e
WHERE e.salary = (SELECT MAX(salary) 
                  FROM employees s
                  WHERE s.department_id = e.department_id ) ;

--방법 3 PARTITION BY
SELECT last_name, salary, job_id, department_id
FROM (SELECT last_name, salary, job_id, department_id
             ,MAX(salary) OVER(PARTITION BY department_id) max
      FROM employees e) 
WHERE salary = max ;


----급여를 가장 많이 받는 2명
----단, 동일한 급여를 받는 사원이 둘 이상 있다면 함께 검색
--방법 1 TOPN 
SELECT empno, ename, sal, deptno
FROM emp
WHERE sal IN (SELECT sal
              FROM (SELECT DISTINCT sal
                    FROM emp
                    ORDER BY sal DESC)
              WHERE rownum <= 2)
ORDER BY sal DESC ;

--방법 2 RANK
SELECT empno, ename, sal, deptno 
FROM (SELECT empno, ename, sal, deptno
            ,RANK() OVER (ORDER BY sal DESC) rank 
      FROM emp)  
WHERE rank <= 2 ;

--방법 3 FETCH
SELECT empno, ename, sal
FROM emp 
ORDER BY sal DESC 
FETCH FIRST 2 ROWS WITH TIES ; 


----부서별 가장 많은 급여를 받는 사원을 한 명씩 검색
----동일한 급여를 받는 사원이 여러 명일 경우에도 한 명만 검색
--ROW_NUMBER
SELECT empno, ename, sal, deptno
FROM (SELECT empno, ename, sal, deptno
            ,ROW_NUMBER() OVER(PARTITION BY deptno ORDER BY sal DESC) rank 
      FROM emp ) 
WHERE rank = 1 ; 


----학생별 채팅 횟수를 가장 많은 횟수 순으로 검색
SELECT SUBSTR(TEXT,14,3) NAME, COUNT(*) CNT
FROM CHATTING
GROUP BY SUBSTR(TEXT,14,3)
ORDER BY 2 DESC;


----날짜별 학생별 채팅 횟수, 날짜와 채팅 횟수를 기준으로 정렬
--정규식 이용
SELECT yymmdd, name, count(*) 
FROM (SELECT SUBSTR(text,1,8) YYMMDD
            ,REGEXP_SUBSTR(text,'(발신자 )(.+)( 수신자 모두)',1,1,'i',2) NAME      
            ,REGEXP_SUBSTR(text,'(수신자 모두 : )(.+)',1,1,'i',2) TEXT
      FROM all_chatting)
GROUP BY yymmdd, name 
ORDER BY 1, 3 DESC ;


----단어별 사용된 횟수, 횟수를 기준으로 내림차순 정렬
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


----종목별 종가에 대한 5일 이동평균
SELECT * FROM KOSPI;

SELECT stid, stdate, close,
       ROUND(AVG(close) 
             OVER(PARTITION BY stid ORDER BY stdate ROWS BETWEEN 4 PRECEDING AND CURRENT ROW),2) MAVG
FROM kospi ; 


----종목별 거래 마지막일의 5일 이동평균 값
SELECT * FROM KOSPI;

SELECT stid, MAX(mavg) KEEP(DENSE_RANK FIRST ORDER BY stdate DESC) MA
FROM (SELECT stid, stdate, close,
             ROUND(AVG(close) 
                OVER(PARTITION BY stid ORDER BY stdate ROWS BETWEEN 4 PRECEDING AND CURRENT ROW),2) MAVG
      FROM kospi)
GROUP BY stid; 
