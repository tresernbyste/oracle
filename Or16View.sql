/************************   hr 계정
파일명: Or16 View 
View 뷰
설명 : 뷰는 테이블로부터 생성된 가상의 테이블로 물리적으로 존재하지않고 논리적으로 존재하는 테이블이다. 
************************/

/*
뷰의 생성 
형식 :
    create [or replace] view 뷰이름 [(컬럼1,컬럼2,..N)]
    as
    select * from 테이블명 where 조건 
        혹은 join문도 가능함 
*/

--@@@@
-- hr 계정에 사원테이블에서 담당업무가 ST_CLERK인 사원정보를 조회할 수 있는 view를 생성하시오
-- 출력항목 : 사원아이디, 이름, 직무아이디, 입사일, 부서아이디

--1.조건대로 select 하기
select employee_id, first_name, job_id, hire_date, department_id
    from employees
        where job_id = 'ST_CLERK';
        
--2.위의 조건으로 view생성하기
create view view_employees 
    as 
    select employee_id, first_name, job_id, hire_date, department_id
    from employees
        where job_id = 'ST_CLERK';
--3.생성된 view 실행하기 : select 문을 실행하는 것과 동일한 결과가 인출됩니다.
select * from view_employees;

--4. 데이터 사전에서 뷰 확인하기 
-- 생성시 사용한 쿼리문이 그대로 저장되는것을 알수 있다.

select * from user_views;

------뷰 생성-------------------------------------------------------------
------뷰 수정-------------------------------------------------------------


/*
뷰 수정하기 
    : 뷰 생성 문장에 or replace 만 추가하면 됩니다.
      해당 뷰가 존재하면 수정이 되고 
      해당 뷰가 존재하지않는다면 새로 생성됩니다.
      따라서 처음 뷰를 생성할 때부터 or replace를 사용해도 무방.(근데 굳이)
*/

--@@@@
--앞에서 생성한 뷰를 다음과 같이 수정하시오 
--기존 컬럼인 employee_id,first_name,job_id, hire_date, department_id 를
-- id,fname, job_id, hdate, deptid로 수정하여 뷰를 생성하시오 

create or replace view view_employees 
    (id,fname, jobid, hdate, deptid)
    as 
    select employee_id, first_name, job_id, hire_date, department_id
    from employees
        where job_id = 'ST_CLERK';

select * from view_employees;

/*
퀴즈] 위에서 생성한 view_employees 뷰를 아래 조건에 맞게 수정하시오 
    직무아이디 ST_MAN 인 사원의 사원번호, 이름, 이메일, 매니저아이디 를 조회할수 있도록 수정하시오
    뷰의 컬럼명은 e_id, name, email, m_id로 지정한다. 
    단, 이름은 first_name 과 last_name 이 연결된 형태로 출력하시오
*/

--문제의 조건대로 select문작성 

select employee_id, first_name || ' ' || last_name, email, manager_id 
    from employees
        where job_id ='ST_MAN';

create or replace view view_employeess 
    (e_id, name, email, m_id)
    as 
    select employee_id, first_name || ' ' || last_name, email, manager_id 
    from employees
        where job_id ='ST_MAN';

/*
퀴즈]  사원번호, 이름, 연봉을 계산하여 출력하는 뷰를 생성하시오  
    컬럼의 이름은 emp_id, l_name, annul_sal로 지정하시오 
    뷰이름은 v_emp_salary
    단, 연봉은 3자리마다 컴마 ㄱ
*/

create or replace view  v_emp_salary (emp_id, l_name, annul_sal)
    as
    select employee_id, first_name || ' ' || last_name, to_char(salary*12 , '999,000')
    from employees;





/*
--조인을 통한 view 생성
사원테이블과 부서테이블, 지역테이블을 조인하여 다음 조건에 맞는 뷰를 생성하시오 
    출력항목 : 사원번호, 전체이름, 부서번호, 부서명, 입사일자, 지역명
    뷰의 명칭 : v_emp_join
    뷰의 컬럼 : empid, fullname, deptid, deptname, hdate, locname
    컬럼의 출력형태 : 
        fullnam == first_name + last_name
        hdate == 0000년 00월 00일
        locname == xxx주의 yyy ( 텍사스 주의 사우스레이크)
*/
 select employee_id,  first_name || ' ' || last_name, department_id,department_name,to_char(hire_date, 'yyyy"년" mm"월" dd"일"'), state_province || '주의' || city
        from employees E
            inner join departments using(department_id)
            inner join locations using(location_id);




create or replace view v_emp_join 
    (  empid, fullname, deptid, deptname, hdate, locname )
    as
    select employee_id,  first_name || ' ' || last_name, department_id,department_name,to_char(hire_date, 'yyyy"년" mm"월" dd"일"'), state_province || '주의' || city
        from employees E
            inner join departments using(department_id)
            inner join locations using(location_id);

            
            




