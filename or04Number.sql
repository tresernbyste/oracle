/************************
파일명: Or04Number.sql
숫자(수학) 관련 함수
숫자데이터를 처리하기 위한 숫자관련 함수를 알아보자
검색,추출한 값을 수적으로 보다 정확하게 정의하기 위함으로 많이 이용됨.
테이블 생성시 number 타입으로 선언된 컬럼에 저장된 데이터를 대상으로 한다.
************/
-- HR계정으로 하기 
--현재 접속한 계정에 생성된 테이블, 뷰를 보여준다.
select * from tab;
select * from seoulit; -- 없으면 테이블 또는 뷰가 존재하지 않습니다. 라고 나와야함

select * from dual; --dummy data 가 나오게 됨 
-- 하나의 행으로 결과를 출력하기 위해 제공되는 테이블로 오라클에서 자동으로 생성되는 논리적 테이블 dual
-- VARCHAR1로 정의된 dummy data 라는 단 하나의 컬럼으로 구성되어 있습니다.

select 1+2 from dual;  -- 이런식으로 사용

--abs() 절대값구하기 
select abs(12000) from dual;
select abs(-9000) from dual;  -- 절대값이기 때문에 자동변환 
select abs(salary)"급여의 절대값" from employees order by salary desc;

--trunc(a,b) 소수점을 특정자리수에서 잘라내기
select trunc(3.145912345,2) from dual; -- 3.14
select trunc(3.14591234) from dual; --- 3
select trunc(1233.142515,-2) from dual; --1200  금액이라면 100단위이하 절삭과 같은 형태로 활용할 수 있다.

--!!사원테이블에서 영업사원이 1000불에 대한 커미션을 계산하여 급여에 합한 결과를 출력하는 query문을 작성하시오
-- 급여 1000, 보너스율0.1 계산하는법 
--영업사원을 먼저 찾아서 검색하시오
select * from employees where job_id like 'SA_%';
--영업사원은 커미션을 받기 때문에 값이 저장되어 있습니다. 이렇게도 영업사원을 추출가능
select * from employees where commission_pct is not null; 
--커미션을 계산하여 이름과 함께 출력한다.
select first_name, salary,trunc(commission_pct,2)"comm", (salary*(1+trunc(commission_pct,2)))"totalsal" from employees where commission_pct is not null ;
--커미션을 소수점 1자리까지 금액 계산하기


--소수점 관련함수 ceil() : 소수점 이하를 무조건 올림처리
--                floor() : 소수점 이하를 무조건 버림처리
--                round() : 소주점 이하를 무조건 반올림처리
--                       있을때 : 숫자만큼 소수점이 표현되므로 그 다음수가 5이상이면 올림, 5미만이면 버림.
--                       없을때 : 소수점 첫번째자리가 5이상이면 올림, 5미만이면 버림

select ceil(32.8) from dual;
select ceil(32.2) from dual;

select floor(32.8) from dual;
select floor(32.2) from dual;

select round(32.8), round(0.533) from dual; -- 두번째 인수가 없을경우 소수점 첫째자리에서 올림 반올림
--첫번째 항목: 소수이하 6자리까지 표현
select round(0.1234567, 6) , round(2.345612,4) from dual;


--mod()    나머지 구하는 함수
select mod(99,4) from dual;
--power()  거듭 제곱 구하는 함수
select power(2,10) from dual;
--sqrt()   제곱근을 구하는 함수
select sqrt(49) from dual; 


--4_숫자관련함수
--HR 계정이용
/*
연습문제] 사원테이블에서 보너스율이 있는 사원만 인출한 후 보너스율을 
    소수점 1자리로 표현하시오. 
    출력내용 : 이름, 급여, 보너스율
*/
-- 1.커미션이 있는 사원만 인출

-- 2.소수점 처리하기




