201215

### WHERE

>행 제한을 위한 조건식 (참거짓을 판별할 수 있는)
>
>그룹함수 사용 불가

```sql
select *
from emp
where deptno = 20;

--조건식에 꼭 column명만 들어가는 것은 아님
select empno,ename,deptno,30,'A'
from emp
where 1 = 1;


--alias 지정 : "" / 문자 지정 : ''
select empno "NUMBER"
from emp
where ename = 'SCOTT';

select * 
from employees
where first_name = 'Jennifer';


--날짜 형식
--도구 -> 환경설정 -> 데이터베이스 -> NLS 에서 형식 확인
select *
from emp
where hiredate = '1987/04/19';


select *
from emp
where ename < 'SCOTT';


--between A and B
select * 
from emp
where sal between 2000 and 3000;

select *
from emp
where ename between 'A' and 'C';


-- in
select *
from emp
where deptno in (10,20);

select *
from emp
where ENAME in ('SCOTT','ADAMS','FORD');


--like : 패턴 비교
--문자 타입에서만 사용
-- % : 0개 이상의 문자
-- _ : 한 문자
select *
from emp
where ename like '%S';

select *
from emp
where ename like '_D%';


--escape '식별자'
--'식별자'사이의 문자는 와일드카드(x) 일반 문자 취급
select *
from employees
where job_id like '%$_%' escape '$';


--null
--도구 -> 환경설정 -> 고급 에서 null 형태 변경 가능
select *
from emp
where comm is null;


--논리 연산자 and / or / not
select *
from emp
where deptno = 10 or sal < 2000;

select *
from emp
where (sal between 2000 and 3000) 
and deptno = 20; 

select *
from emp
where deptno not in (10,20);

select *
from emp
where ename not like '%S';


--table to excel
--필요한 만큼 drag 후 마우스오른쪽버튼 '익스포트'
```



### ORDER BY

> 정렬

```sql
--default : 오름차순(asc)
select *
from emp
order by deptno;

select *
from emp
order by deptno desc;

select *
from emp
order by deptno desc, sal;


--column명 대신, column 순서 작성 가능
select *
from emp
order by 8 desc;


---column명 대신, alias 작성 가능
select empno,deptno num
from emp
order by num desc;
```



```sql
--치환변수
select *
from emp
where deptno = &ID;

select *
from emp
&condition;

select empno,ename,sal,&col
from emp
order by &col;
```



```sql
--NLS 지정
--날짜형식 지정 시, 연월일뿐만 아니라 시분초까지 기록되어있을 수 있으므로, between을 활용!
SELECT *
FROM EMP 
WHERE HIREDATE BETWEEN '1981/01/01' AND '1982/01/01'; 

SELECT *
FROM EMP 
WHERE HIREDATE BETWEEN '1981/01/01' AND '1981/01/02'; 

--00:00까지 읽혀질 수 있으므로, 마지막 1초 제외
SELECT * 
FROM EMP 
WHERE HIREDATE BETWEEN TO_DATE('19810101','YYYYMMDD') 
AND TO_DATE('19820101','YYYYMMDD')-1/86400 ;
```

