/************************HR계정
파일명: Or06TypeConvert
형변환 함수 /  기타함수
설명 : 데이터 타입을 다른타입으로 변환해야 할 때 사용하는 함수와 기타 함수 
************************/

--sysdate : 현재 날짜와 시간을 초단위로 반환해준다. 
--주로 게시판이나 회원가입에서 새로운 게시물이 있을 때 입력한 날짜를 표현하기위해 사용됩니다.

select sysdate from dual;

-- 날짜 포멧 : 오라클은 대소문자를 구분하지않으므로 서식문자 역시 구분하지않는다. 



-- 따라서 mm과 MM은 동일한 결과를 출력한다.
-- 서식문자를 감싸는게 아님에 주의 해야합니다.
-- 하이픈 슬러쉬 외의 문자는 인식하지 못하므로 서식문자를 제외한 나머지 문자열을 더.쿼로 묶어줘야한다.
--현재 날짜를 '오늘은 0000년 00월 00월 입니다.' 와 같은 형태로 출력하시오 
select to_char(sysdate   , 'yy-mm-dd') from dual;
select to_char(sysdate, '"오늘은" yyyy"년" mm"월" dd"일 입니다."') from dual;   --@@@@
select to_char(sysdate, 'yyyy/mm/dd') from dual;

--요일이나 년도를 표현하는 서식문자들 
select to_char(sysdate,'day')"day",  -- just day 사용이 오늘 날짜 
 to_char(sysdate,'dy')"dy",  
 to_char(sysdate,'mon')"mon",  
 to_char(sysdate,'mm')"mm",   
 to_char(sysdate,'month')"month", 
 to_char(sysdate,'yy')"yy",    
 to_char(sysdate,'dd')"dd" ,
 to_char(sysdate,'ddd')"dd" from dual;

--사원테이블에서 사원의 입사일을 다음과 같이 출력할 수 있도록 서식을지정하여 쿼리문을 작성하시오 

--0000년 00월 00일 0요일

select first_name, last_name, hire_date,salary,
to_char(hire_date, 'yyyy"년" mm"월" dd"일" dy"요일"')입사일 from employees order by hire_date;

--시간 포멧 : 현재시간을 00:00:00 형태로 표시하기
--  또는 날짜와 시간을 동시에 표현할 수도 있다.

select
to_char(sysdate, 'HH:MI:SS')A, 
to_char(sysdate, 'hh24:mi:ss')B ,
to_char(sysdate, 'hh:mi:ss')C ,
to_char(sysdate, 'YYYY--MM--DD hh24:mi:ss')D ,
to_char(sysdate, 'hh24:mi:ss')E ,
to_char(sysdate, 'hh24:mi:ss')F
from dual;

-- 숫자 포멧 
--   0 :  숫자의 자리수를 나타내며 자리수가 맞지 않는 경우 0으로 자리를 채운다.
--   9 : 0과 동일하지만 자리수가 맞지않는 경우 공백으로 채운다.

select 
    to_char(123,'0000'),
    to_char(123,'9999'),  -- 9를 서석으로 사용하면 공백이 생기므로 trim으로 제거할수있다.
    trim(to_char(123,'9999'))  --쓸데없지만 가능하다
    from dual;


-- 숫자의 3자리 마다 , 표시하기 
--  자리수가 확실히 보장된다면 0을 사용하고, 자리수가 다른 부분에서는 9를 사용하여 서식을 지정한다. 
-- 대신 공백은 trim 으로 제거하면된다. 

select 12345,
    to_char(12345, '000,000'), to_char(12345, '999,999'),
    ltrim(to_char(12345, '999,999')),    ltrim(to_char(12345, '990,000'))
    from dual;

-- 통화표시 L  ==> 각 나라에 맞는 통화 표시가 된다 원으로 표시 
select to_char(1000000,'L9,999,000') 
from dual;


-- 숫자 변환 함수 
-- to_number() : 문자형 데이터를 숫자형으로 변환한다.
-- 두개의 문자가 숫자로 변환되어 덧셈에 결과를 출력한다.
select to_number('123')+to_number('456') from dual;  -- 숫자로 바꿨기 때문에 가능

select to_number('123a')+to_number('456') from dual;  -- 숫자가 아닌 문자가 섞여있어 에러발생

--날짜 변환 함수
-- to_date() : 문자형 데이터를 날짜형식으로 변환해서 출력한다.
-- 기본서식은 년월일 순으로 지정된다.

select
    to_date('2023-06-16')날짜기본형식1, 
    to_date('20230616')날짜기본형식2,
    to_date('2023/06/16')날짜기본형식3 
from dual;

-- 날짜 포멧이 년월일 순이 아닌 경우에는 오라클이 날짜로 인식하지 못하여 에러가 발생한다.
-- 이 때는 날짜서식을 이용해 오라클이 인식할 수 있도록 처리해야 합니다.

select 
    to_date('16-06-2023') from dual;-- 오라클에 지정된 날짜 서식이 아니기 때문에 에러발생 
   
--@@ 2023-11-23 17:49:30 와 같은 형태의 문자열을 날짜로 인식할 수 있도록 query문을 작성하시오 

select 
    to_date('2023-11-23 17:49:30') from dual; --에러 
    
--@@ 문자열을 잘라서 사용한다.
select to_date('2023-11-23') from dual; -- 인식가능
-- substr 함수로 문자열을 날짜부분만 잘라서 to_date의 인자로 사용한다.
select 
    substr('2023-11-23 17:49:30',1,10)문자열자르기,     -- 1덱스부터 10까지 출력
    to_date( substr('2023-11-17:49:30',1,10))
    from dual;
-- 날짜와 시간의 서식을 활용한다. 
select 
    to_date('2023-11-23  17:49:30','yyyy-mm-dd hh24:mi:ss')
from dual;

-- 2022/12/25 는 어떤 요일인지 변환함수를 통해 출력하기
-- 단, 문자열은 임의로 변경할 수 없다.

select 
    to_date('2022/12/25')날짜서식확인,
    to_char(sysdate, 'day')요일서식확인,
    to_char(to_date('2022/12/25'),'day')조합
from dual;

--@@ 문자열 2024년 01월 01년 은 어떤 요일이지 
select
    to_date('2024년 01월 01일','yyyy"년" mm"월" dd"일"'),
    to_char(to_date('2024년 01월 01일','yyyy"년" mm"월" dd"일"'),'day') 
    from dual;


--nvl() : null값을 다른 데이터로 변경하는 함수    (컬럼명, 대체할 값)
-- 이와 같이 덧셈을 하면 영업사원이 아닌 경우 급여가 null이 출력된다ㄷ.
-- 따라서 값이 null컴럼은 별도의 처리가 필요하다.
select salary+commission_pct from employees;
-- null 값을 0으로 변경한 후 연산을 진행하므로 정상적인 결과가 출력됩니다.
select first_name, commission_pct, salary*nvl(commission_pct,0)
from employees;
--수고스럽게 이러는 이유는 1+null = null  null과의 연산값은 
--오직 null이기때문에 null과 연산이 필요한 상황이라면 0으로 변경후 진행


--decode java의 switch 문과 비슷한 역할을 하는 함수로 비슷하게 특정값에 해당하는 출력문이 있는 경우 사용합니다.
-- dedcode(컬럼명, 값1, 결과1, 값2, 결과2, 기본값)
-- 내부적인 코드값을 문자열로 변환하여 출력할때 많이 사용됩니다. 

select 
    first_name, last_name, department_id,
    decode( department_id,
    10, 'Adminstraction',
    20, 'Marketing', --  
    30, 'Purchasing', --  
    40, 'Human Resource',
    50, 'Shipping',
    60, 'IT',
    70, 'Public Realation',
    80, 'Sales',
    90, 'Excutive',
    100, 'Finance',
    110, 'Accountind','부서명 확인안됨')DP_ID
    from employees;


-- case Java의  if-esle문과 같은 역할을 하는 함수 
-- case when 조건1 then값1   else 기본값
--사원테이블에서 각 부서번호에 해당하는 부서명을 출력하는 query문을 case문을 통해 
--쉼표 ㄴㄴ  when else end

select 
    first_name, last_name, department_id,
    case 
    when department_id=10 then 'Adminstraction'
    when department_id=20 then 'Marketing'
    when department_id=30 then 'Purchasing'
    when department_id=40 then 'Human Resource'
    when department_id=50 then 'Shipping'
    when department_id=60 then 'IT'
    when department_id=70 then 'PublicRealation'
    when department_id=80 then 'Sales'
    when department_id=90 then 'Excutive'
    when department_id=100 then 'Finance'
    when department_id=110 then 'Accounting'
    else '부서명 없음'
    end team_nameDP_ID  --  case 얼리어스 내용
    from employees
    order by department_id;



/*************************
연습문제
*************************/
--scott계정에서 진행합니다.

/*
1. substr() 함수를 사용하여 사원들의 입사한 년도와 입사한 달만 출력하시오.
*/
select substr(hiredate,1,2) 입사년도,substr(hiredate,4,2) 입사달 from emp order by 입사년도, 입사달; 

/*
2. substr()함수를 사용하여 4월에 입사한 사원을 출력하시오. 
즉, 연도에 상관없이 4월에 입사한 모든사원이 출력되면 된다.
*/
select ename, hiredate from emp where substr(hiredate,5,1) = 4;

/*
3. mod() 함수를 사용하여 사원번호가 짝수인 사람만 출력하시오.
*/
select empno, ename from emp where mod(empno,2)=0;

/*
4. 입사일을 연도는 2자리(YY), 월은 숫자(MON)로 표시하고 요일은 
약어(DY)로 지정하여 출력하시오.
*/


/*
5. 올해 며칠이 지났는지 출력하시오. 현재 날짜에서 올해 1월1일을 뺀 결과를 
출력하고 TO_DATE()함수를 사용하여 데이터 형을 일치 시키시오. 
단, 날짜의 형태는 ‘01-01-2020’ 포맷으로 사용한다. 
즉 sysdate - ‘01-01-2020’ 이와같은 연산이 가능해야한다. 
*/


 
  



/*
6. 사원들의 메니져 사번을 출력하되 상관이 없는 사원에 대해서는 
NULL값 대신 0으로 출력하시오.
*/


/*
7. decode 함수로 직급에 따라 급여를 인상하여 출력하시오. 
'CLERK'는 200, 'SALESMAN'은 180, 'MANAGER'은 150, 'PRESIDENT'는 100을
인상하여 출력하시오.

*/











