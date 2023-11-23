/************************
파일명: Or03SelectBasic.sql
처음으로 실행해 보는 질의어 (SQL문 혹은 Query문)
개발자들 상이에서는 '시퀄'이라고 표현하기도 합니다.
설명 : select, where 등 가장 기본적인 DQL문 사용해보기
************/
-- HR계정으로 하기 

/*
SQL Developr 에서 주석 사용하기 
    블럭단위 주석  : 자바와 동일함 
    라인단위 주석 :  -- 실행문장. 하이픈 2개를 연속으로 사용합니다.
*/

--select문 : 테이블에 저장된 레코드를 조회하는 SQL문으로 DQL문에 해당합니다.
--    형식- 
--    select 컬럼1, 컬럼2, ... 혹은 *
--    from 테이블명 
--    where 조건1 and 조건2 or 조건3
--    order by 정렬할 컬럼 asc (오름차순) desc (내림차순);



--사원테이블에 저장된 모든 레코드를 대상으로 모든 컬럼을 조회하기
--(쿼리문은 댓도문자를 구분하지 않는다.)
SELECT * from employees;
SELECT * FROM employees;  --대소문자 구분을 하지 않는다.


--컬럼명을 지정해서 조회하고 싶은 컬럼만 조회하기
--사원번호, 이름, 이메일, 부서번호만 조회하시오.
SELECT employee_id, first_name, last_name, email, department_id
    FROM    employees;      

    
-- 테이블의 구조와 컬럼별 자료형 및 크기를 출력한다.
-- 즉, 테이블의 스키마를 알 수 있다.
desc employees;


-- as 는 생략할 수 있다.   데이터 값의 대소문자는 분류한다.
select employee_id "사원아이디", first_name as "이름", last_name "성"
    from employees where first_name = 'William';

    
--오라클은 기본적으로 모든 영문 대소문자를 구분하지 않는다. 예약어의 경우 대소문자 구분없이 사용할 수 있다.
--하지만 레코드인 경우 대소문자를 구분한다. 따라서 아래 SQL문을 실행하면 아무런 결과도 나오지 않는다.
select employee_id "사원아이디", first_name as "이름", last_name "성"
    from employees where first_name = 'WilliAm';  --  대소문자 구분을 안했기 때문에 결과가 나오지 않는다.
    
    

--where 문을 이용해서 조건에 맞는 레코드 추출하기 
--last_name 이 Smith인 레코드를 추출하시오
select * from employees where last_name = 'Smith';



--where 절에 2개 이상의 조건이 필요할때 and 혹은 or를 사용할 수 있다.
--last_name = Smith 이면서 급여가 8000인 사원을 추출하시오 
--컬럼이 문자형인 경우 싱글쿼테이션으로 감싸주고 숫자인 경우 생략한다.
--컬럼이 문자형인 경우 싱글쿼테이션이 없으면 에러발생 주의 
--컬럼이 숫자형인 경우 싱글 쿼테이션 생략가능(있어도 가능 없어도 가능)
select * from employees where last_name = 'Smith' and salary = 8000;



--비교연산자를 통한 Qurey문 작성
--이상, 이하와 같은 조건에 > <= 와 같은 비교연산자 
--날짜인 경우 이전, 이후 와 같은 조건도 가능하다.
--급여가 5000 미만인 사원의 정보를 추출하시오.
select * from employees where salary < 5000;



--입사일이 04년 01월 01일 이후인 사람을 추출하시오
SELECT * from employees where hire_date >= '04/01/01';



--in 연산자 : or 연산자와 같이 하나의 컴럼에 여러개의 값으로 조건을 걸고 싶을 때 사용
--급여가 4200, 6400, 8000인 사원의 정보를 추출하시오
select * from employees where salary = 4200 or salary = 6400 or salary = 8000;  -- in을 사용하지않고 기본적 or로 사용
select * from employees where salary in (4200, 6400, 8000);  -- or in을 사용



--not 연산자 : 해당 조건이 아닌 레코드를 추출한다.
--부서번호가 50이 아닌 사원정보를 조회하는 SQL문을 작성하시오
select * from employees where department_id <> 50;  -- 50이 아닌~  
select * from employees where not (department_id = 50);



--between and 연산자 : 컬럼의 구간을 정해 검색할때 사용
--급여가 4000~8000 사이의 사원을 인출하시오
select * from employees where salary >=4000 and salary <= 8000;
select * from employees where salary between 4000 and 8000;




--distinct : 컬럼에서 중복되는 레코드를 제거할 때 사용
--특정조건으로 select 했을 때 하나의 컬럼에서 중복되는 값이 있는 경우 중복값을 제거한 후 결과를 출력할 수 있다.
--담당 업무 아이디를 중복을 제거한 후 출력하시오 
--전체 사원에 대한 담당업무명이 인출된다.
select job_id from employees;
select DISTINCT job_id from employees;



--like 연산자 _ % : 특정 키워드를 통한 문자열을 검색할 때 사용한다.
--% 모든 문자 혹은 문자열을 대체한다.  D% Da, Dda, Deawoo  %Z aZ asdZ adZ %c%  adCef 
--_ 문자 하나를 대체한다.  D__ Dad ,Ddd 
--first_name이 D 로 시작하는 직원을 검색하시오
select * from employees where first_name like 'D%';
--first_name이 세번째 문자가 a인 직원을 검색하시오 
select * from employees where first_name like '__a%'; 
--last_name y로 끝나는 직원을 검색하시오
select * from employees where last_name like '%y';
--phone_number 1344가 포함된 직원을 검색하시오 
select * from employees where phone_number like '%1344%';




--order by : 레코드 정렬하기.sorting
-- 오름차순 : order by 칼럼명 asc(default라 생략가능)
-- 내림차순 : order by 칼럼명 desc
--2개이상의 컬럼으로 정렬해야 할 경우 ,로 구분해서 정렬한다. 
--먼저 입력한 컬럼으로 정렬된 상태에서 두번째 컬럼이 정렬됩니다
--사원정보 테이블에서 급여가 낮은 순서에서 높은 순서로 출력되도록 정렬하시오
--frist_name, salary, email, phone_number
select first_name, salary, email, phone_number from employees order by salary;
select first_name, salary, email, phone_number from employees order by salary desc;
--부서번호를 내림차순으로 정렬한 후 해당부서에서 낮은급여 받는 직원이 먼저 출력되도록 출력하시오
select employee_id "사원번호", last_name "이름", first_name "성", department_id "부서번호", salary "급여"from employees
    order by department_id desc,salary;




--is null // is not null : 값이 null 이거나 null이 아닌 레코드 가져오기
--                         컬럼중 null 값을 허용하는 경우 값을 입력하지 않으면 
--                         null값이 되는데 이를 대상으로 select할 때 사용한다.
--보너스율이 없는 사람을 검색하시오
select * from employees where commission_pct is null;
--영업사원이면서 급여가 8000이상인 사원을 조회하시오
select * from employees where salary >= 8000 and commission_pct is not null;

/***********************
연습문제(scott계정에서 진행합니다.)
************************/
/*
1. 덧셈 연산자를 이용하여 모든 사원에 대해서 $300의 급여인상을 계산한후 
이름, 급여, 인상된 급여를 출력하시오.
*/
select * from emp;
select ename"이름", sal"급여",(sal+300)"인상된 급여" from emp;

/*
2. 사원의 이름, 급여, 연봉을 수입이 많은것부터 작은순으로 출력하시오. 
연봉은 월급에 12를 곱한후 $100을 더해서 계산하시오.
*/
select ename, sal,(sal*12+100)"연봉" from emp order by (sal*12+100) desc;




/*
3. 급여가  2000을 넘는 사원의 이름과 급여를 내림차순으로 정렬하여 출력하시오
*/
select ename, sal from emp where sal > 2000 order by sal desc;


/*
4. 사원번호가  7782인 사원의 이름과 부서번호를 출력하시오.
*/
select ename, empno from emp where empno like '%7782%';

/*
5. 급여가 2000에서 3000사이에 포함되지 않는 사원의 이름과 급여를 출력하시오.
*/
select ename, sal from emp where 

/*
6. 입사일이 81년2월20일 부터 81년5월1일 사이인 사원의 이름, 
담당업무, 입사일을 출력하시오.
*/


/*
7. 부서번호가 20 및 30에 속한 사원의 이름과 부서번호를 출력하되 이름을 
기준(내림차순)으로 출력하시오
*/


/*
8. 사원의 급여가 2000에서 3000사이에 포함되고 부서번호가 20 또는 30인 
사원의 이름, 급여와 부서번호를 출력하되 이름순(오름차순)으로 출력하시오
*/

    
/*
9. 1981년도에 입사한 사원의 이름과 입사일을 출력하시오. (like 연산자와 와일드카드 사용)
*/  


/*
10. 관리자가 없는 사원의 이름과 담당업무를 출력하시오. 
*/


/*
11. 커미션을 받을수 있는 자격이 되는 사원의 이름, 급여, 커미션을 
출력하되 급여 및 커미션을 기준으로 내림차순으로 정렬하여 출력하시오.
*/


/*
12. 이름의 세번째 문자가 R인 사원의 이름을 표시하시오.
*/


/*
13. 이름에 A와 E를 모두 포함하고 있는 사원의 이름을 표시하시오.
*/

/*
아래와 같은 경우 A와 E가 포함되긴 하나 순서가 있으므로 E로 시작하고 A가 나오는 
이름은 검색되지 않는다.
*/


/*
14. 담당업무가 사무원(CLERK) 또는 영업사원(SALESMAN)이면서 급여가 
$1600, $950, $1300 이 아닌 사원의 이름, 담당업무, 급여를 출력하시오. 
*/


/*
15. 커미션이 $500 이상인 사원의 이름과 급여 및 커미션을 출력하시오. 
*/


















