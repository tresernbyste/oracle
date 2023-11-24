/************************   HR계정
파일명: Or08GroupBy
그룹함수 :  전체 레코드(row)에서 통계적인 결과를 구하기위해
            하나이상의 레코드를 그룹으로 묶어서 
            연산후 결과를 반환하는 함수 혹은 쿼리문
여기서 배우는 함수들은 그룹 안에서 사용가능 하다 라고 생각하며 좋음
having count OO  where count XX
************************/
--사원테이블에서 담당업무 인출 : 총107개 
select job_id from employees;


--distinct : 동일한 값이 있는 경우 중복된 레코드를 제거한 후 하나의 레코드만 가져와서 보여준다. 통계값 도출 X
select distinct job_id from employees;

--group by : 동일한 값이 있는 레코드를 하나의 그룹으로 묶어서 가져온다. 
--           보여지는 것은 레코드지만 다수의 레코드가 하나의 그룹으로 묶어진 결과이므로 
--           통계적인 결과를 도출할 수 있다. Ex 합계 최대 최소 평균 등의 연산이 가능 그룹별

--담당업무별 직원수가 몇명인지 count 해봅니다.

select job_id, count(*) from employees group by job_id;

--검증을 위해 해당업무를 통해 select 해서 인출되는 행의 개수와 비교해본다.
select first_name, job_id from employees where job_id = 'FI_ACCOUNT'; 
select first_name, job_id from employees where job_id = 'ST_CLERK';

-- group절이 포함된 select문
-- select 컬럼1, 컬럼2, *
--    from 테이블명
--      where 조건 N
--         groupby 데이터그룹화를 위한 컬럼명
--             having 그룹에서 찾을 조건
--               orderby 데이터정렬

--sum() : 합계를 구할때 사용하는 함수 number타입의 컬럼에서만 사용할 수 있다. 
--select sum(값 혹은 컬럼) from 테이블명;
-- 전체 직원의 급여의 합계를 출력하시오 

select 
    sum(salary)tosal,
    to_char(sum(salary),'990,000')tosal2,
    ltrim(to_char(sum(salary),'$990,000'))tosal3,
    ltrim(to_char(sum(salary),'L990,000'))tosal4
from employees;

--10번 부서에 근무하는 사원들의 급여의 합계는 얼마인지 출력하시오
--select 
--    sum(salary)급여합계, 
--    to_char(sum(salary),'990,000')합계표시
--    from employees
--    where department_id = 80
--    group by DE

--count() : 그룹화된 레코드의 개수를 카운트할때 사용하는 함수
select count(*) from employees;
select count(employee_id) from employees;

--count() 를 사용할때는 위 두가지 방법 모두 가능하지만 * 를 사용할것을 권장합니다. 
--  컬럼의 특성 혹은 데이터의 따른 방해를 받지 않으므로 실행속도가 빠르다  
--  ?  특정항목을 정하게되면 찾아가는과정발생 변수가 발생할수 있으므로 이럴때는 아스타를 사용하는게 더 빠를수 있음
--   count( all 컬럼명) : 사용법으로 컬럼 전체의 레코드를 기준으로 카운트합니다.
--   count( distinct 컬럼명) :  중복을 제거한 한상태에서 카운트합니다.

select 
    count(job_id)"담당업무 전체 갯수1",
    count(all job_id)"담당업무 전체 갯수2",
    count(distinct job_id)"담당업무 갯수3"
from employees;

--avg() : 평균값을 구할 때 사용하는 함수
--전체 사원의 평균 급여는 얼마인지 query문을 작성하시오

select 
    count(*)"전체직원수",
    sum(salary)"전체급여",
    sum(salary)/ count(*)"평균급여",
    avg(salary),
    trim(to_char(avg(salary),'$999,999'))"서식공백제거"
from employees;

--영업팀 SALES 의 평균급여를 구하시오.
-- 정보검색시 대소문자 혹은 공백이 포함된 경우 모든 레코드에 대해 문자열을 확인하는 것은 불가능합니다.
-- 일괄적인 규칙에 적용을 위해 lower,upper() 와 같은 변환 함수는 사용하여 검색하는 것이 좋다. 
select * from departments where lower(department_name) = lower('sales');
--부서번호가 80인 것을 확인한후 다음 query문을 작성한다.
select 
    ltrim(to_char(avg(salary),'$999,000.00'))
    from employees where department_id = 80;
    
-- max() min() 최대값 최소값을 찾을때 사용하는 함수
--   전체 사원중 가장 낮은 급여는 얼마인가요

select 
    min(salary),
    max(salary)
    from employees;
--전체 사원중 급여가 가장 낮은 직원은 누구인가요?
select first_name, last_name, salary from employees where salary = min(salary);
-- 에러가 발생한다. 그룹함수는 일반컬럼에 사용할 수 없습니다. min(salary)


-- 사원테이블에서 가장 낮은 급여인 2100을 받는사원을 인출한다.
select 
    first_name, last_name, salary
    from employees
    where salary = 2100;
--사원중 가장 낮은 급여는 min() 구할수 있으나 가장 낮은 급여를 받는 사람은 아래와 같이 서브쿼리를 통해 구할수 있습니다.
-- 따라서 문제에 따라 서브 쿼리를 사용할지 여부를 결정해야합니다. 
select 
    first_name, salary from employees 
    where salary = (select min(salary) from employees);  -- 서브쿼리 사용방법
    
--group by : 여러개의 레코드를 하나의 그룹으로 그룹화하여 묶여진 결과를 반환하는 query문
--    distinct는 단순히 중복값을 제거하는것이기 때문에 혼동주의 

-- 사원테이블에서 각 부서별 급여의 합계는 얼마인가요?

-- 각각 구한 부서별 급여 
select to_char(sum(salary), '999,000') from employees where department_id = 60;
select sum(salary) from employees where department_id = 100;

--그룹화를 이용한 각 부서별 급여 
-- 부서가 많은 경우 일일이 부서별로 확인할 수 없으므로 부서를 그룹화 합니다. 
-- 중복이 제거된 결과로 보이지만 동일한 레코드 하나의 그룹으로 합쳐진 결과가 인출됩니다.
-- 각 부서별로 급여의 합계를 구할 수 있다. 4자리가 넘어가는 경우 가독성이 떨어지므로 서식을 이용해서 세자리마다 ,를 표시합니다.
select department_id from employees group by department_id;  -- 일단 그룹화

select department_id , trim(to_char(sum(salary),'999,000'))"tosal" 
    from employees 
    group by department_id
    order by sum(salary) desc; 
    
-- 사원테이블에서 각 부서별 사원수와 평균 급여는 얼마인지 구하시오 
-- 출력결과 : 부서번호,  급여총합, 사원총합, 평균급여
-- 출력시 부서기준 오름차순

select
    department_id 부서번호,
    rtrim(to_char(sum(salary),'999,000'))급여총합,
    count(*)사원수 , 
    rtrim(to_char(avg(salary),'999,000'))평균급여 
    from employees 
    group by department_id
    order by department_id asc ;


-- groupby 에서 사용한 컬럼은 select절에서 사용할수 있으나, 그외의 단일컬럼은 select 절에서 사용할수없습니다.
--그룹화된 상태에서 특정 레코드 하나만 선택하는 것은 애매하기 때문이다  
select department_id, sum(salary), count(*), avg(salary), first_name  --  단일컬럼first_name 그룹화 department_id
    from employees 
    group by department_id
    order by department_id asc ;


--부서아이디가 50인 사원들의 직원총합, 평균급여, 급여총합을 구하시오
select '50번 부서', count(*), round(avg(salary)), sum(salary)
    from employees
    where department_id = 50 
    group by department_id;
    
    
--group by having 절 : 물리적으로 존재하는 컬럼이 아닌 그룹함수를 통해 논리적으로 생성된 컬럼의 조건을 추가할때 사용합니다.
-- 해당조건을 where절에 추가하면 에러가 발생합니다.

--@@ 사원테이블에서 각 부서별로 근무하고 있는 직원의 담당업무별 
--   사원수와 평균급여가 얼마인지 구하시오
-- 단, 사원수가 10을 초과하는 레코드만 인출하시오.

--같은 부서에 근무하더라도 담당업무는 다를수 있으므로 이문제에서는 group by 절에 2개의 컬럼을 명시해야한다. 
-- 즉 부서로 그룹화 한 후 다시 담당업무별로 그룹화 한다.

select department_id ,job_id, count(*), avg(salary)
    from employees
    where count(*) >= 2 -- 에러발생!  담당업무별 사원수는 물리적으로 존재하는 컬럼이 아니므로 where 절에 사용하면 에러발생 
    group by department_id, job_id;
    
--  Ex 급여가 3000인 사원 -->  물리적으로 존재하는 salary테이블안 컬럼이므로 where절에 사용
--      평균 급여가 3000인 사원 ---> 연산 논리적으로 존재하므로  having 절에 사용
--                                                        즉, 그룹함수를 통해 구할수 있는 데이터임. 
    
    
    
select department_id ,job_id, count(*), avg(salary)
    from employees
    group by department_id, job_id;
    having count(*);  --그룹의 조건은 having절에 기술
    
-- 담당업무를 사원의 초저급여를 출력하시오 
-- 단, 관리자가 없는 사원과 최저급여가 3000미만인 그룹은 제외시키고 ,결과를 급여의 내림차순으로 출력하시오 

select 
    job_id, min(salary)
    from employees
    where manager_id is not null
    group by job_id
    having not min(salary) < 3000
    order by min(salary) desc;
    
--select 
--    job_id, min(salary), salary --  이렇게 되도 salary는 단일컬럼이므로 그룹바이 불가능 
--    from employees
--    where manager_id is not null
--    group by job_id
--    having not min(salary) < 3000
--    order by salary desc;  -- 여기서 에러!
--    
/*******************************************
연습문제
*******************************************/

--#해당 문제는 hr계정의 employees 테이블을 사용합니다.

/*
1. 전체 사원의 급여최고액, 최저액, 평균급여를 출력하시오. 컬럼의 별칭은 
아래와 같이 하고, 평균에 대해서는 정수형태로 반올림 하시오.
별칭) 급여최고액 -> MaxPay
급여최저액 -> MinPay
급여평균 -> AvgPay
*/
--round(), to_char() : 반올림 처리 되어 출력됨
--trunc() : 소수 이하를 잘라서 출력됨. 반올림되지 않음.


/*
2. 각 담당업무 유형별로 급여최고액, 최저액, 총액 및 평균액을 출력하시오. 
컬럼의 별칭은 아래와 같이하고 모든 숫자는 to_char를 이용하여 세자리마다 
컴마를 찍고 정수형태로 출력하시오.
별칭) 급여최고액 -> MaxPay
급여최저액 -> MinPay
급여평균 -> AvgPay
급여총액 -> SumPay
참고) employees 테이블의 job_id컬럼을 기준으로 한다.
*/
    


/*
3. count() 함수를 이용하여 담당업무가 동일한 사원수를 출력하시오.
참고) employees 테이블의 job_id컬럼을 기준으로 한다.
*/
--물리적으로 존재하는 컬럼이 아니라면 함수 혹은 수식을 그대로 order by절에
--기술하면된다.
--수식이 너무 길다면 별칭을 기술해도 된다. 


/*
4. 급여가 10000달러 이상인 직원들의 담당업무별 합계인원수를 출력하시오.

/*
5. 급여최고액과 최저액의 차액을 출력하시오. 
*/


/*
6. 각 부서에 대해 부서번호, 사원수, 부서 내의 모든 사원의 평균급여를 
출력하시오. 평균급여는 소수점 둘째자리로 반올림하시오.
*/



    






