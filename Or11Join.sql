/************************   HR 계정으로 하기
파일명: Or11Join
TABLE JOIN 
설명 : 2개 이상의 테이블을 동시에 참조하는 데이터를 가져와야 할 때 사용하는 SQL문
************************/

/*
inner join
    가장 많이 사용되는 조인문으로 테이블간에 연결조건을 모두 만족하는 레코드를 검색할 때 사용된다.
    일반적으로 기본키(primary key)와 외래키 (foriegn)를 사용하여 join하는 경우가 대부분이다.
    두개의 테이블에 동일한 이름의 컬럼이 존재하면 "테이블명.컬럼명" 형태로 기술합니다.
    테이블의 별칭을 사용하면 "별칭.컬럼명"의 형태도 사용가능하다.
   
    형식(표준방식)
    select 컬럼1,컬럼2....
      from 테이블1 inner join 테이블2
        on 테이블1.기본컬럼 = 테이블2.외래키컬럼
          where  조건1 and 조건2
    
*/


-- 사원테이블과 부서테이블을 조인하여 각 직원이 어떤 부서에서 근무하는지 출력하시오. 단, 표준방식으로 작성하시오..
-- 출력결과는 사원아이디, 이름1, 이름2, 이메일, 부서번호, 부서명

desc employees;
desc departments;

/*
ORA-00918: 열의 정의가 애매합니다
department_id는 조인한 양쪽 테이블의 존재하는 컬럼이므로 어떤 테이블에서 가져와 출력할지 결정해야합니다. 
열의정의가 애매한 경우 컬럼앞에 테이블명을 추가한다.(두개중에 하나의 테이블에서 가져와쓸것인지 명확하게 표시해준다.
AS(얼리어스)를 통해 테이블에 별칭을 부여하여 query문을 사용할수 있다.
*/

select 
    employee_id, first_name, last_name, email, Emp.department_id, department_name
    from employees Emp inner join departments Dep
     on Emp.department_id = Dep.department_id;
        
/* @@@
실행결과에서는 소속된 부서가 없는 1명을 제외한 나머지 106명의 레코드가 인출된다.
즉, inner join 한 테이블에서 양쪽 모두 만족되는 레코드만 가져오게 됩니다.
*/
      
-- 3개이상 테이블 조인하기 
--seattle(시애들)에 위치한 부서에서 근무하는 직원의 정보를 출력하는 query문을 작성하시오 단, 표준방식을 이용해서 작성하시오.
--출력결과는 사원이름, 이메일, 부서아이디, 부서명, 담당업무아이디, 담당업무명, 근무지역
--출력결과는 다음테이블에 존재합니다.
-- 사원테이블 : 사원이름, 이메일, 부서아이디, 담당업무 아이디
-- 부서테이블 : 부서아이디(참조), 부서명, 지역일련번호(참조)
-- 담당업무테이블 : 담당업무명, 담당업무아이디(참조)
-- 지역테이블 : 근무부서, 지역일련번호(참조)


--1. 지역테이블을 통해 레코드확인하기. 지역일련번호 1700 확인했습니다.
select * from locations where lower(city) = 'seattle';

--2.확인한 지역일련번호를 통해 부서테이블의 레코드 확인하기    21개의 부서를 확인했습니다.
select * from departments where location_id = 1700;

--3.부서일련번호를 통해 사원테이블의 레코드를 확인합니다. --6명 확인
select * from employees where department_id = 30;
--4.담당업무명 확인하기 
select * from jobs where job_id ='PU_MAN';
select * from jobs where job_id ='PU_CLERK';
--5.join query문을 작성


select  
    first_name, email, D.department_id, department_name, E.job_id, job_title, city, state_province
    from locations L 
    inner join departments D on L.location_id = D.location_id
    inner join employees E on D.department_id = E.department_id
    inner join jobs J on E.job_id = J.job_id
    where lower(city) = 'seattle';
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
-- //////////////////////////////////////////////////////////////////////////////////////////////////////



    
--@@@@@ 형식2 : 오라클 방식
-- select 컬럼1,컬럼2 
-- from 테이블1,테이블2
-- where 테이블1.기본키컬럼 = 테이블2.외래키컬럼
--  and 조건 1, and 조건2

--사원테이블과 부서테이블을 조인하여 각 직원이 어떤 부서에서 근무하는지 출력하시오 
-- 단, 오라클방식으로 출력하시오 
-- 출력결과 : 사원아이디, 이름1, 이름2, 이메일, 부서번호, 부서명



select 
    employee_id, first_name, last_name, email, department_id, department_name
    from departments D, employees E
    where
     D.department_id = E.department_id;
--ORA-00918: 열의 정의가 애매합니다
    
select 
    employee_id, first_name, last_name, email, D.department_id, department_name   -- 기본키를 기준으로 결과값을 지정해준다.
    from departments D, employees E
    where
     D.department_id = E.department_id;


--seattle에 위치한 부서에서 근무하는 직원의 정보를 출력하는 query문을 작성하시오.
-- 단 , 오라클 방식으로 작성하시오 
-- 출력결과 : 사원이름, 이메일, 부서아이디, 부서명, 담당업무아이디, 담당업무명, 근무지역
-- 위 출력 결과는 다음 테이블에 존재합니다.
-- 사원테이블 : 사원이름, 이메일, 부서아이디, 담당업무아이디
-- 부서테이블 : 부서아이디(참조), 부서명, 지역일련번호(참조)
-- 담당업무테이블 : 담당업무아이디(참조), 담당업무명
-- 지역테이블 : 근무부서, 지역일련번호(참조)

select 
    first_name, last_name, email, D.department_id, department_name,J.job_id, job_title, city, state_province
    from employees E,departments D, jobs J, locations L
    where 
    D.department_id = E.department_id and
    D.location_id = L.location_id and
    J.job_id = E.job_id and lower(city) = 'seattle'; 
    
    
    
    
    
    
    
    
    
    
    
    
    
-- //////////////////////////////////////////////////////////////////////////////////////////////////////

    
--@@@@@@@@@  outer join @@@@@@@@@@@@@@@@@


-- outer join (외부 조인)

/*
 outer join 은 inner join 과는 달리 그 테이블의 조인 조건이 정확히 일치하지않아도 기준이되는 테이블에서 
 레코드를 인출하는 join 방식입니다.
 
 outer join 을 사용할 때에는 반드시 outer전에 기준이 되는 테이블을 결정하고 query문을 작성해야합니다.

--> left right full 왼쪽, 오른쪽, 양쪽 테이블기준이 있다.

    (표준형식) 형식1.
    select 컬럼1, 컬럼2...
    from 테이블1
        left[right,full] outer join 테이블2 
            on 테이블1.기본키 = 테이블2.참조키(외래키)
        where 조건1 and 조건2 or 조건 3
*/

--@@@@ 
--전체직원의 사원번호, 이름, 부서아이디, 부서명, 지역을 
--외부조인을 통해 출력하시오

select employee_id, first_name, last_name, E.department_id, department_name, city
    from  employees E  -- 얘가 기준이 되기때문에 
     left outer join departments D 
        on E.department_id = D.department_id
     left outer join locations L on D.location_id = L.location_id;
--실행결과를 보면 내부조인과는 다르게 106명이 아닌 107명이 인출된다.
--부서가 지정되지않은 사원까지 인출되기 때문이다.
--이 경우 부서쪽에 레코드가 없으므로 null로 출력된다.


select employee_id, first_name, last_name, E.department_id, department_name, city
    from  employees E
     left outer join departments D on E.department_id = D.department_id
     left outer join locations L on D.location_id = L.location_id;
    
--outer join oracle--
/*
    형식2(오라클방식)
    select 칼럼1, 칼럼2....
    from 테이블1,테이블2
    where
        테이블1.기본키 = 테이블2.참조키(+)
        and 조건1 or 조건2;
*/
--## 테이블1.기본키 (+)  = 테이블2.참조키  -- 테이블을 바꾸지않고 right outer join 이다! 
-- 오라클 방식으로 변경시에는 outer join 연산자인 (+)를 붙혀준다.
-- 위의 경우 왼쪽 테이블이 기준이된다.  기준이 되는 테이블을 변경할 때는 테이블의 위치를 옮겨준다.(+)를 옮기지않는다.  left outer join 이라면 테이블위치를 바꾸라는것

--@@@@ 
-- 전체직원의 사원번호, 이름 , 부서아이디, 부서명, 지역을 outer join left로 출력하시오 단, 오라클방식으로 작성하시오

select 
    employee_id, first_name, D.department_id, department_name, city  -- 왼쪽을 기준으로 나오기때문에 107명 인출 참조키에서 불러온값을 없을경우 null값으로 대체 
    from employees E, departments D, locations L
    where E.department_id = D.department_id (+) and
    D.location_id = L.location_id (+);
    
    
    
    
    
    
    
    
    
-- 2007년에 입사한 사원을 조회하시오 
--단, 부서에 배치되지않은 직원의 경우 <부서없음>으로 출력하시오. 표준방식적용
-- 출력항목 : 사번, 이름, 부서명

--저장된 레코드 확인
select first_name, hire_date, to_char(hire_date, 'yyyy') from employees;

--2007년에 입사한 사원을 인출하시오
-- 방법 1 like를 이용하여 07로 시작하는 레코드를 인출한다.
select first_name, hire_date from employees where hire_date like '07%';
--방법 2 to_char()를 통해 날짜서식을 만든 후 레코드를 출력한다.
select first_name, hire_date from employees where to_char(hire_date,'yyyy') = '2007';

-- 외부조인(표준방식) 으로 결과를 확인
-- nvl(컬럼명, '변경할값') : null 값에 데이터를 특정한 값으로 변경해줍니다.

select employee_id, first_name, last_name, nvl(department_name, '<부서없음>')
    from employees E
     left outer join departments D on 
     E.department_id =D.department_id
     where to_char(hire_date, 'yyyy') = '2007';



--@@@@ 
--2007년에 입사한 사원을 조회하시오 단, 부서에 배치되지않은 직원의 경우 <부서없음> 으로 출력하시도  오라클방식 사용
-- 출력항목 : 사번, 이름, 부서명


select employee_id, first_name, last_name, nvl(department_name, '<부서없음>')  -- employees 가 기준이기때문에 null값을 포함한 값이 나오게 된다.

    from employees E, departments D 
    where E.department_id =D.department_id (+) and
     to_char(hire_date, 'yyyy') = '2007';

select employee_id, first_name, last_name, nvl(department_name, '<부서없음>')  -- right join oracle을 사용함. department 가 기준이기때문에 부서가없는 레코드 열을 생성되지않음
    from employees E, departments D 
    where E.department_id (+) =D.department_id and
     to_char(hire_date, 'yyyy') = '2007';   
      
      
      
      
      
--/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////



--self join (셀프조인) : 셀프조인은 하나의 테이블의 있는 컬럼끼리 연결해야 하는 경우 사용한다. 
--즉, 자기 자신이 테이블과 조인을 맺는 것이다. self join에서는 별칭이 테이블을 구분하는 구분자의 역할을 하므로 굉장히 중요하다.

/*
형식
    select 
        별칭1.컬럼, 별칭2.컬럼 ...
        from 테이블별칭1, 테이블별칭2
        where 별칭1.컬럼 = 별칭2.컬럼
*/

--@@@@ 
--사원테이블에서 각 사원의 매니저아이디와 매니저 이름을 출력하시오 단 이름은 first_name 가 last_name 을 하나로 연결해서 출력하시오

--여기서는 사원입장의 테이블 empClerk과 매니저입장의 테이블 empManager를 별칭으로 생성한후 where절에 self join조건을 기술한다. 


--select (first_name || last_name), manager_id, employees
      

select empClerk.employee_id 사원번호, empClerk.first_name || ' ' || empClerk.last_name 사원이름, empManager.employee_id 매니저사원번호,
    concat(empManager.first_name ||' ',empManager.last_name) 매니저이름
 from employees empClerk, employees empManager
    where empClerk.manager_id = empManager.employee_id;


--@@@@2
-- self join 을 사용하여 "kimberely / Grant " 사원보다 입사일이 낮은 사원의 이름과 입사일을 출력하시오
-- 출력항목 : 이름 입사일 



--select * from employees where lower(first_name) = 'kimberely';    -- 입사일 07-05-24 확인

select * from employees where hire_date >'07/05/24';

select notKim.first_name, notKim.last_name, notKim.hire_date
from employees Kim, employees notKim
    where Kim.hire_date < notKim.hire_date
    and Kim.first_name = 'Kimberely' and Kim.last_name = 'Grant'
    order by hire_date;
      
      
      
      


--/////////////////////////////////////////////////////////////////////////////////////////////////

--using : join 문에서 주로 사용하는 on절을 대체할 수 있는 문장
-- 형식 : on 테이블1.컬럼 = 테이블2.컬럼
--          using(컬럼)


--@@@@  seattle 에 위치한 부서에서 근무하는 직원의 정보를 출력하는 query문을 작성하시오
-- 단, using 을 사용해서 작성하시오
-- 출력항목 : 사원이름 , 이메일, 부서아이디, 부서명, 담당업무아이디, 담당업무명, 근무지역



--select 
--first_name, last_name, email, E.department_id, department_name, job_id, job_title, city
--    from locations
--    inner join departments 
--     where E.department_id = D.department_id and 
--        D.location_id = L.location_id and 

      
      
      
 select  
    first_name, email, department_id, department_name, job_id, job_title, city, state_province 
    from locations L 
   inner join departments using(location_id)
   inner join employees using(department_id)
   inner join jobs using(job_id)
    where lower(city) = 'seattle';     

--using 절에 사용된 참조컬럼의 경우 select절에서 테이블의 별칭을 붙이면 오히려 오류가 발생한다.
--using 절에 사용된 컬럼은 양쪽의 테이블에 동시에 존재하는 컬럼이라는 것을 전제로 작성되기 때문에 이 별칭을 사용할 이유가 없기 때문이다.
--


-- 위에 using 절을 사용한 것과 동일한 결과  ## using 을 사용해서 join구문을 좀더 간단하게 표현할 수 있다.
select  
    first_name, email, D.department_id, department_name, E.job_id, job_title, city, state_province 
    from locations L 
    inner join departments D on L.location_id = D.location_id
    inner join employees E on D.department_id = E.department_id
    inner join jobs J on E.job_id = J.job_id
    where lower(city) = 'seattle';   
      
      
--@@@@ 
-- 2005년에 입사한 사원들 중 California(stste_provinve) / South San Francisco(City) 에서 근무하는 사원들의 정보를 출력하시오.
-- 단, 표준방식과 using을 사용해서 작성하시오
-- 출력결과 : 사원번호, 이름, 성, 급여, 부서명, 국가코드, 국가명(Contry_name), 급여(세자리마다 , 표현) 
-- 참고 : 국가명은 contries 테이블에 입력되어있다.



select * from employees where hire_date like '05%';
select * from locations where state_province = 'California' and lower(city) = 'south san francisco'; -- 1500 location_id == 1500
select * from departments where location_id = 1500;

select * from employees 
    where department_id = 50 and substr(hire_date,1,2)='05';

--혼자 실습 
select employee_id, first_name || last_name 이름, salary, department_name, country_id, country_name, city
    from locations L   --기준이 되는 값을 확실히 설정해야한다.  크게 상관은 없다.
    inner join departments using(location_id)
    inner join employees using(department_id)
    inner join countries using(country_id)
     where department_id = 50 and hire_date like '05%' ;
 
 
--선생님작성     
select employee_id, first_name || last_name, trim(to_char(salary,'$990,000')), department_name, country_id, country_name, city
    from employees 
    inner join departments using(department_id)
    inner join locations using(location_id)
    inner join countries using(country_id)
     where department_id = 50 and hire_date like '05%' ;

      
--11_조인

------------------------------------------------------------연습문제





/*
1. inner join 방식중 오라클방식을 사용하여 first_name 이 Janette 인 
사원의 부서ID와 부서명을 출력하시오.
출력목록] 부서ID, 부서명
*/

select department_id D, department_name 
    from employees 
        inner join departments on employees.department_id = D.department_id
    where employees.first_name = Janette;




/* 오라클 방식은 표준방식에서의 inner join대신 콤마를 이용해서 테이블을 
조인하고 on절 대신 where절에 조인될 컬럼을 명시한다. */    

/*
2. inner join 방식중 SQL표준 방식을 사용하여 사원이름과 함께 그 사원이 
소속된 부서명과 도시명을 출력하시오
출력목록] 사원이름, 부서명, 도시명
*/


/*
3. 사원의 이름(FIRST_NAME)에 'A'가 포함된 모든사원의 이름과 부서명을 
출력하시오.
출력목록] 사원이름, 부서명
*/    


/*
4. “city : Toronto / state_province : Ontario” 에서 근무하는 모든 
사원의 이름, 업무명, 부서번호 및 부서명을 출력하시오.
출력목록] 이름, 업무명, 부서ID, 부서명
*/


/*
5. Equi Join을 사용하여 커미션(COMMISSION_PCT)을 받는 모든 
사원의 이름, 부서명, 도시명을 출력하시오. 
출력목록] 사원이름, 부서ID, 부서명, 도시명
*/



/*
6. inner join과 using 연산자를 사용하여 50번 부서(DEPARTMENT_ID)에 
속하는 모든 담당업무(JOB_ID)의 고유목록(distinct)을 부서의 도시명(CITY)을 
포함하여 출력하시오.
출력목록] 담당업무ID, 부서ID, 부서명, 도시명
*/



/*
7. 담당업무ID가 FI_ACCOUNT인 사원들의 메니져는 누구인지 출력하시오. 
단, 레코드가 중복된다면 중복을 제거하시오. 
출력목록] 이름, 성, 담당업무ID, 급여
*/

select * from employees;


select EA.first_name, EA.last_name, EA.department_id, EA.salary
    from employees E , employees EA
        where E.department_id = EA.manager_id
        and E.department_id = 108;
        
    


/*
8. 각 부서의 메니져가 누구인지 출력하시오. 출력결과는 부서번호를 
오름차순 정렬하시오.
출력목록] 부서번호, 부서명, 이름, 성, 급여, 담당업무ID
※ departments 테이블에 각 부서의 메니져가 있습니다.
*/

select department_id from employees; 

select D.department_id , D.department_name, E.first_name, last_name, salary, job_id ,D.manager_id
    from departments D, employees E
        where D.manager_id = E.employee_id;
       
        
       


/*
9. 담당업무명이 Sales Manager인 사원들의 입사년도와 
입사년도(hire_date)별 평균 급여를 출력하시오. 출력시 년도를 기준으로 
오름차순 정렬하시오. 
출력항목 : 입사년도, 평균급여
*/

        


      
      
      
      
      
      
      
      
      
      