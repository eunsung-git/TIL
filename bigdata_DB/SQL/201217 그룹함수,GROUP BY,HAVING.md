201217

### 그룹 함수

> | 함수    | 설명                   |
> | ------- | ---------------------- |
> | MIN()   | 최소값                 |
> | MAX()   | 최대값                 |
> | AVG()   | 평균                   |
> | SUM()   | 합계                   |
> | COUNT() | null을  제외한 행 개수 |
> 
>그룹함수 간 중첩은 1번만 가능
>


```SQL
SELECT SUM(SAL), AVG(SAL), MAX(SAL), MIN(SAL), COUNT(SAL)
FROM EMP ;

SELECT COUNT(*), COUNT(ENAME), COUNT(EMPNO), COUNT(HIREDATE)
FROM EMP 
WHERE DEPTNO = 10 ; 

SELECT SUM(COMM)/14, AVG(NVL(COMM,0))
FROM EMP ;

SELECT COUNT(NVL(COMM,0)), COUNT(*)
FROM EMP 
WHERE COMM IS NULL ;

SELECT SUM(ALL DEPTNO), SUM(DISTINCT DEPTNO)
FROM EMP ; 
```





### GROUP BY

> 그룹 생성
>
> 그룹당 하나의 행만 출력
>
> 그룹함수가 적용된 column을 제외하고, SELECT의 모든 column은 GROUP BY 에 있어야 함

```sql
SELECT DEPTNO , SUM(SAL), AVG(SAL),
       MIN(SAL), MAX(SAL), MIN(HIREDATE), COUNT(*)
FROM EMP 
GROUP BY DEPTNO ; 

SELECT SUM(SAL)
FROM EMP 
GROUP BY DEPTNO ; 

SELECT DEPTNO, JOB, SUM(SAL) 
FROM EMP 
GROUP BY DEPTNO, JOB ;

SELECT TO_CHAR(HIREDATE,'YYYY') HIREDATE,SUM(SAL)
FROM EMP
GROUP BY TO_CHAR(HIREDATE,'YYYY')
```





### HAVING

> 그룹 제한을 위한 조건식 

```SQL
SELECT DEPTNO, SUM(SAL), AVG(SAL) 
FROM EMP 
GROUP BY DEPTNO 
HAVING SUM(SAL) > 9000 ; 

SELECT DEPTNO, SUM(SAL)
FROM EMP 
WHERE DEPTNO IN (10,20) 
GROUP BY DEPTNO 
HAVING SUM(SAL) > 10000 ;  

SELECT DEPTNO, SUM(SAL)
FROM EMP 
WHERE JOB IN ('SALESMAN','MANAGER') 
GROUP BY DEPTNO 
HAVING SUM(SAL) > 5000 ; 

```





### JOIN

```sql
SELECT *
FROM EMP, DEPT 
WHERE EMPNO = 7788 
AND EMP.DEPTNO = DEPT.DEPTNO; 

SELECT * 
FROM EMPLOYEES   E 
    ,DEPARTMENTS D 
WHERE E.DEPARTMENT_ID = D.DEPARTMENT_ID  ;
```

