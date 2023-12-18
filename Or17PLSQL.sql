/************************   hr 계정
파일명: Or17 PLSQL
설명 : 오라클에서 제공하는 프로그래밍언어
************************/

--PLSQL :  Procedural Language
--일반 프로그래밍 언어에서 가지고 있는 요소를 모두 가지고 있으며 DB업무를 처리하기 위해 최적화된 언어이다.

/* 
- 예제1. PL/SQL 맛보기
- 화면상에 내용을 출력하고 싶을때 on으로 설정한다.
- off 일때는 출력되지않는다.
*/

set serveroutput on; 

declare                             --선언부 주로 변수를 선언 
    cnt number;                     -- 숫자타입의 변수를 선언 
begin                               --실행부 begin ~ end 절에 실행을 위한 로직을 기술한다.
    cnt := 10;                      --변수에 10을 대입한다 (자바의 초기화) 대입연산자  := 를 사용 
    cnt := cnt + 1;                 --복합대입연산자 같이 사용 
    dbms_output.put_line(cnt);      -- java의 println()과 동일한 구문
end;
/

/*
PL/SQL 문장의 끝에는 /를 붙여야하는데 
       만약 없으면 호스트환경으로 빠져나오지 못한다. 
       즉, PL/SQL 문장을 위해 필요합니다.
       호스트환경이란, query문을 입력하기위한 SQL>  상태를 말합니다.
*/
/*
예제 2 일반변수 및 into
*/
--사원테이블에서 사원번호가 120인 사원의 이름과 연락처를 출력하는 PL/SQL문을 작성하시오 

select * from employees where employee_id=120;

select concat(first_name||' ', last_name), phone_number
from employees where employee_id=120;

declare --선언부
    empName varchar2(50);       --선언부에서 변수를 선언할대는 테이블생성시와 동일하게 선언한다.
    empPhone varchar2(30);      --변수명 자료형(크기) 단, 기존에 생성된 컬럼의 타입과 크기를 참조하여 선언해주는 것이 좋다.
begin  --실행부 : select절에서 가져온 결과를 선언부에서 선언한 변수에 1:1로 대입하여 값을 저장한다. 이때 into를 사용한다.
    select 
        concat(concat(first_name,' '),last_name),phone_number
    into
        empName, empPhone
    from employees
    where employee_id=120;
    
    dbms_output.put_line(empName || ' '|| empPhone);
end;
/











--예제3. 참조변수 (하나의 컬럼참조)
--참조변수 : 특정테이블의 컬럼을 참조하는 변수로서 동일한 자료형과 크기로 선언하고 싶을때 사용한다.
-- 형식 : 테이블명.컬럼명 %tpye
--        테이블의  '하나'의 컬럼만 참조합니다.
/*
부서번호 10인 사원의 사원번호,급여, 부서번호를 가져와서 아래 변수에 대입후 화면상에 출력하는 PL/SQL문을 작성하시오.
단, 변수는 기존테이블의 자료형을 참조하는 '참조변수'로 선언하시오

시나리오의 조건에 맞는 select문을 작성한 후에 시작한다.
*/
select employee_id, salary, department_id from employees     --사원번호, 급여, 부서번호를 사원테이블로부터 불러오는데
    where department_id =10;                                 --부서번호가 10인 사람의 정보를 
    
declare                                             --선언부 
    empNo employees.employee_id%type;               --사원테이블의 사원번호를 참조해오겠다  number(6,0)
    empSal employees.salary%type;                   --사원테이블의 급여를 동일한 자료형과 크기로 참조해오겠다.number(8,2)
    deptId employees.department_id%type;            --사원테이블의 부서번호를 자료형과 크기로 참조해오겠다. number(4,0)
begin  --select의 결과는 into를 통해 선언한 변수에 할당한다.
    select employee_id, salary, department_id
        into empNo, empSal,deptId
    from employees
    where department_id = 10;
    
    dbms_output.put_line(empNo || ' ' || empSal || ' '|| deptId);
end;
/

--예제4 참조변수2 
--  전체컬럼을 참조하는 방법
--사원번호가 100인 사원의 레코드를 가져와서 emp_row변수에 전체컬럼을 저장한 후 화면에 다음 정보를 출력하시오.
--단, emp_row는 사원테이블이 전체컬럼을 저장할 수 있는 참조변수로 선언해야한다. 
--출력정보 : 사원번호, 이름, 이메일, 급여

select * from employees where employee_id = 100;

declare   --사원테이블 전체 컬럼을 참조하는 참조변수를 선언한다. 이 때 테이블명 뒤에 %rowtype을 붙혀 선언한다.
    
    emp_row employees%rowtype;
begin 
    select * into emp_row
    from employees where employee_id =100;
    
    dbms_output.put_line(emp_row.employee_id || ' '|| emp_row.first_name||' '||emp_row.last_name|| emp_row.email||' '|| emp_row.salary);
end;
/

--예제5 복합변수 
-- : class를 정의하듯 필요한 자료형을 묶어 하나의 자료형을 만든 후 생성하는 변수를 말한다. 
-- 형식 : tpye 복합자료형 is recode ( 컬럼1 자료형 (크기), 컬럼2 테이블명.컬럼명%type );
-- 앞에서 선언한 자료형을 기반으로 변수를 생성한다. 
-- 복합변수 자료형을 만들때는 일반변수와 참조변수 2가지를 복합해서 사용할 수 있다.

--@@@@
--사원번호, 이름(first_name+last_name), 담당업무명을 저장할 수 있는 복합변수를 선언한 후, 100번 사원의 정보를 출력하는 PL/SQL을 작성하시오.

select employee_id, first_name||' '||last_name, job_id
from employees where employee_id=100;

declare
    type emp_3type is record(
        emp_id employees.employee_id%type,
        emp_name varchar2(60),
        emp_job employees.job_id%type
        );
        record3 emp_3type;
--        앞에서 선언한 복합변수 자료형을 통해 선언한 복합변수로 3개의 값을 저장할 수 있다.
begin           -- select절에서 가져온 3개의 값을 복합변수에 저장한다.
    select employee_id, first_name||' '||last_name, job_id
        into record3
    from employees where employee_id=100;
    -- 출력시 복합변수 자료형의 컬럼을 명시합니다. record3.emp~
    dbms_output.put_line(record3.emp_id||' '||
                        record3.emp_name||' '||
                        record3.emp_job);
end;
/


/*
아래 절차에 따라 PL/SQL문을 작성하시오.
1.복합변수생성
- 참조테이블 : employees
- 복합변수자료형의 이름 : empTypes
        멤버1 : emp_id -> 사원번호
        멤버2 : emp_name -> 사원의전체이름(이름+성)
        멤버3 : emp_salary -> 급여
        멤버4 : emp_percent -> 보너스율
위에서 생성한 자료형을 이용하여 복합변수 rec2를 생성후 사원번호 100번의 정보를 할당한다.
2.1의 내용을 출력한다.

3.위 내용을 완료한후 치환연산자를 사용하여 사원번호를 사용자로부터 입력받은 후 해당 사원의 정보를 출력할수있도록 수정하시오
*/

--1.
 select employee_id, first_name||' '||last_name, salary, commission_pct
    from employees where employee_id = 100;

--2.
declare
    type emp_Types is record(
        emp_id employees.employee_id%type,
        emp_name varchar2(60),
        emp_salary employees.salary%type,
        emp_percent employees.commission_pct%type
        );
        rec2 emp_Types;
begin 
    select employee_id, first_name||' '||last_name, salary, nvl(commission_pct,0)
        into rec2
    from employees where employee_id = 100;
    
    dbms_output.put_line('사원번호 / 사원명 / 급여 / 보너스율 ');
    dbms_output.put_line(rec2.emp_id || ' '|| rec2.emp_name||' '|| rec2.emp_salary|| rec2.emp_percent);
end;
/


/* @@@@@@@@@@@@@@@@@@@@@@@@@
치환연산자 : PL/SQL 에서 사용자로부터 데이터를 입력받을 때 사용하는 연산자로 
             변수앞에 &(and)를 붙여주면 된다. 실행시 입력창이 뜬다. (Scanner, system in 과 같은 입력형태의 실행문이 됨) 
*/
--3. 앞에서 작성한 PL/SQL문을 
--   치환연산자를 사용하여 사원번호를 사용자로부터 입력받은후 해당 사원의 정보를 출력할 수 있도록 수정하시오.


declare
    type emp_Types is record(
        emp_id employees.employee_id%type,
        emp_name varchar2(60),
        emp_salary employees.salary%type,
        emp_percent employees.commission_pct%type
        );
        rec2 emp_Types;
        -- 치환연산자를 통해 입력받은 값을 할당하여 변수를 선언한다.
        inputNum number(3);
        
begin 
    -- 입력받은 사원번호를 쿼리에 적용한다.
    select employee_id, first_name||' '||last_name, salary, nvl(commission_pct,0)
        into rec2
    from employees where employee_id =  &inputNum;
    
    dbms_output.put_line('사원번호 / 사원명 / 급여 / 보너스율 ');
    dbms_output.put_line(rec2.emp_id || ' '|| rec2.emp_name||' '|| rec2.emp_salary|| rec2.emp_percent);
end;
/

----------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------

/*
바인드변수 
    : 호스트환경에서 선언된 변수로써 비 PL/SQL 변수이다. 
      호스트환경이란 PL/SQL의 블럭을 제외한 나머지 부분을 말한다.
      콘솔(CMD)에서는 SQL> 명령프롬프트가 있는 상태를 말합니다.  ## declare를 벗어난 환경 = 호스트환경

형식 : 
        var 변수명 자료형;
        혹은 
        variable 변수명 자료형;
*/

set serveroutput on;

var return_var number; -- 바인드변수 declare밖

declare                --  PL/SQL 문 시작  선언부에 아무내용이 없을 수도 있음 
begin 
                       -- 바인드 변수는 일반변수와의 차이가??
    :return_var := 999;
    dbms_output.put_line(:return_var);
end;
/

print return_var;

----------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------


--예제7 제어문 (조건문 : if)
-- 변수에 저장된 숫자가 홀수 or 짝수인지 판단하는 PL/SQL을 작성하시오 
-- if then if elsif then
declare                                         --선언부에서 숫자타입의 변수를 선언
    num number;                                 
begin
    num := 10;
    
    if mod(num,2) = 0 then
        dbms_output.put_line(num || '은 짝수');
    else
        dbms_output.put_line(num || '은 홀수');
    end if;
end;
/
-- 위 예제를 치환연산자를 통해 숫자를 입력받을 수 있도록 수정하시오 

declare                                         
    num number;             -- num 변수 선언
    inputNum number;        -- 치환연산에 사용될 변수도 선언 
   
begin
    num := &inputNum;           -- num 변수에 치환연산에 사용될 변수를 대입
     
    if mod(num,2) = 0 then
        dbms_output.put_line(num || '은 짝수');
    else
        dbms_output.put_line(num || '은 홀수');
    end if;
end;
/

--사원번호를 사용자로부터 입력받은 후 해당 사원이 어떤부서에서
--근무하는지를 출력하는 PL/SQL문을 작성하시오. 단, if~elsif문을 사용하여 구현하시오.


declare
    emp_id employees.employee_id%type := &emp_id;
    emp_name varchar2(50);
    emp_dept employees.department_id%type;
    dept_name varchar2(30) := '부서정보없음';    -- 부서명의 초기화 값을 설정
begin
    select employee_id, last_name, department_id
        into emp_id, emp_name, emp_dept
    from employees
    where employee_id = emp_id;
    
    
    -- 여러개의 조건을 사용할 경우 자바와 같이 else if 를 사용하지않고  elsif 로 기술해야합니다. 
    -- 중괄호 대신 then과 end if가 사용됩니다. 
    if emp_dept = 50 then
        dept_name := 'Shipping';
    elsif emp_dept = 60 then
        dept_name := 'IT';
    elsif emp_dept = 70 then
        dept_name := 'Public Relations';
    elsif emp_dept = 80 then
        dept_name := 'Sales';    
    elsif emp_dept = 90 then
        dept_name := 'Executive';
    elsif emp_dept = 100 then
        dept_name := 'Finance';
    end if;
    
    dbms_output.put_line('사원번호'|| emp_id || '의 정보');
    dbms_output.put_line('이름:' || emp_name || ', 부서번호: ' || emp_dept || ' , 부서명:'|| dept_name);
end;
/
    
----------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------

--예제9 제어문 ( 조건문 : case~when ) 
-- 앞에서 if~elsif로 작성한 PL/SQL문을 case~when문으로 변경하시오 

declare
    emp_id employees.employee_id%type := &emp_id;
    emp_name varchar2(50);
    emp_dept employees.department_id%type;
    dept_name varchar2(30) := '부서정보없음';    -- 부서명의 초기화 값을 설정
begin
    select employee_id, last_name, department_id
        into emp_id, emp_name, emp_dept
    from employees
    where employee_id = emp_id;
    
    -- case~when 문이 if문과 다른점은 할당할 변수를 먼저 선언한 후 문장내에서 조건을 판단하여
    --    if문에 쓰이는 것처럼 매번 판단하지 않아도 된다. 
    
    dept_name :=
        case emp_dept
            when 50 then 'Shipping'
            when 60 then 'IT'
            when 70 then 'Public Relations'
            when 80 then 'Sales'
            when 90 then 'Excutive'
            when 100 then 'Finance'
        end;    
    dbms_output.put_line('사원번호'|| emp_id || '의 정보');
    dbms_output.put_line('이름:' || emp_name || ', 부서번호: ' || emp_dept || ' , 부서명:'|| dept_name);
end;
/

----------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------

--제어문 (  반목문 : loop  )

--1. basic loop  : 자바의 do while 문과 같이 조건 확인 없이 loop진입한 후 탈출조건이 될때 까지 반복합니다.
--                  탈출시에는 exit를 사용합니다.


-- 조건확인없이  루프로 진입한다.
-- 0~10까지 출력한다. 증가연산자, 복합대입연산자가 없으므로 일반적인 방식으로 변수를 증가시켜야한다. 
-- num이 10을 초과하면 loop문을 탈출합니다.  탈출조건 exit when ( java break;) 와 동일한 역할
declare 
    num number := 0;
begin 
    loop
        dbms_output.put_line(num);
        num := num + 1;
        exit when ( num > 10);
    end loop;
end;
/

--1-1. basic loop 
-- basic loop 문으로 1부터 10까지의 정수의 합을 구하는 프로그램을 작성하시오 

declare 
    i number := 1;
    sunNum number := 0;
begin 
    loop
        sunNum := sunNum + i;
        i := i + 1;
        exit when ( i > 10);
    end loop;
    dbms_output.put_line('1~10까지의 합은 : '|| sunNum);
end;
/

---------------------------------------------------------------------------------

--2. while loop 
--    : 조건은 먼저 확인한 후 실행한다.
--    즉, 조건에 맞지 않는다면 단한번도 실행되지 않을 수 있다.
--    반복의 조건이 있으므로 특별한 경우가 아니라면 exit를 사용하지 않아도 됩니다.

-- 제어문 ( 반복문 : while )

declare
    num1 number := 0;
begin
    while num1<11 loop
        dbms_output.put_line( '이번숫자는:' || num1);
        num1 := num1 + 1;
    end loop;
end;
/

-- 예제 제어문 ( 반복문 : while loop 별찍기 )
declare
    starStr varchar2(100);
    i number := 1;
    j number := 1;

begin       -- 행, 열 개념이 없기때문에 i 조건일때 별을 찍어서 행이 넘어갈수 있게 만들어야한다 
            -- 자바 와는 다르기 때문에 행열개념이 없어 이런식으로 표현해줘야한다. 
            
    while i<=5 loop
      starStr :=  starStr||'*';
        while j<=5 loop
            j := j + 1;
        end loop;
        dbms_output.put_line(starStr);
        i := i + 1;
        j := 1;
    end loop;
end;
/

--제어문 ( 반복문 : while loop )
-- while loop문으로 1부터 10까지의 정수의 합을 구하는 프로그램을 작성하시오. 

declare
    i number := 1;
    sunNum number := 0;
begin 
    while i<= 10 loop           -- i가 10 이하일때만 누적해서 더해준다..
        sunNum := sunNum + i;
        i := i + 1;
    end loop;
    dbms_output.put_line('1~10까지의 합은:'||sunNum);
end;
/

-- 제어문 ( 반복문 : for문 )
--    : 반복의 횟수를 지정하여 사용할 수 있는 반복문으로 반복을 위한 변수를 별도로 선언하지 않아도 된다. 
--      그러므로 특별한 이유가 없으면 선언부( declare ) 를 기술하지 않아도 된다. 

declare  -- 선언된 변수 없음 
begin
    for num2 in 0 .. 10 loop
        dbms_output.put_line( 'for 문 짱인듯: ' || num2);
    end loop
end;
/

-- 특별하게 선언부가 필요하지않기때문에 선언부 ( declare ) 를 사용하지 않음.
begin 
    for num3 in reverse 0 .. 10 loop
        dbms_output.put_line( '거꾸로 for문짱인듯:' || num3);
    end loop;
end;
/


-- 제어문 ( 반복문 : for 구구단 )
-- for loop 문으로 구구단을 출력하는 프로그램을 작성하시오 

begin                                                               -- 2~9단 까지 반복
    for dan in 2..9 loop                                        
        dbms_output.put_line(dan||'단');                            -- 라벨출력
        for su in 1..9 loop                                         -- 1~9까지 반복
            dbms_output.put_line(dan||'*'||su||'='||(dan*su));      -- 구구단은 즉시 출력 후 줄바꿈 처리 
        end loop;
    end loop;
end;
/

declare
    guguStr varchar2(1000);  -- 배열처럼 하나의 단을 저장하기 위한 변수 
begin
     for dan in 2..9 loop
       
        for su in 1..9 loop
           guguStr := guguStr || dan||'*'||su||'='||(dan*su) || ' ';   -- 문자열의 증가연산자 느낌으로 배열과 같이 단에 수를 줄바꿈없이 누적연결시킴
        end loop;
        dbms_output.put_line(guguStr);
        guguStr := '';     -- 하나의 단의 누적이 끝나게 되면 다음 단으로 넘어가는 for문이 들어가기전에 공백을 초기화시켜준다
    end loop;
end;
/
-- 단과 수를 바꿔서 행열을 전환시킴
declare
    guguStr varchar2(1000);  -- 배열처럼 하나의 단을 저장하기 위한 변수 
begin
     for su in 2..9 loop
       
        for dan in 1..9 loop
           guguStr := guguStr || dan||'*'||su||'='||(dan*su) || ' ';   -- 문자열의 증가연산자 느낌으로 배열과 같이 단에 수를 줄바꿈없이 누적연결시킴
        end loop;
        dbms_output.put_line(guguStr);
        guguStr := '';     -- 하나의 단의 누적이 끝나게 되면 다음 단으로 넘어가는 for문이 들어가기전에 공백을 초기화시켜준다
    end loop;
end;
/


---------------------------------------------------------------------------------
---------------------------------------------------------------------------------
----Cursor ----------------------------------------------------------------------

/*
Cursor 커서 
 : select 문장에 의해 여러행이 반환되는 경우 각 행에 접근하기 위한 일종의 반복개체
 
선언형식 
    :  Cursor 커서명 is    
            select 쿼리문 단, into 절이 없는 형태로 기술합니다.
    
    Open Cursor 
        : 쿼리를 수행하라는 의미, 즉, Open할때 Cursor선언시 select문장이 실행되어 결과셋을 얻게 됩니다.
          Cursor는 그 결과셋의 첫번째 행에 위치하게 됩니다. 
    
    Fetch ~ into ~ 
        : 결과셋에 하나의 행을 읽어드리는 작업으로 결과셋의 인출(Fetch)한 후에 Cursor는 다음 행으로 이동한다.
        
    Close Cursor
        : 커서 닫기로 결과셋의 자원을 반납한다.select문장이 모두 처리된 후 Cursor를 닫아준다.

    Cursor의 속성 
        &Found : 가장 최근에 인출(Fetch) 행을 Return하면 True,
                    아니면 False를 반환합니다.
                    
        &NotFound : &Found 반대의 값을 반환한다.
        &RowCount : 지금까지 Return 된 행의 갯수를 반환합니다.       
*/

-- Cursor 
-- 부서테이블의 레코드를 Cursor를 통해 출력하는 PL/SQL문을 작성하시오 

declare
    v_dept departments%rowtype;
    cursor cur1 is 
        select
            department_id, department_name, location_id
        from departments;
begin
    /*
    해당 쿼리문을 수행해서 결과셋을 가져온다. 결과셋이란 쿼리문을 실행하고 돌아오는 결과값.
    */
    open cur1;
    -- basic 루프문으로 얻어온 결과셋의 갯수만큼 반복하여 인출한다.
    loop
        fetch cur1 into
            v_dept.department_id,
            v_dept.department_name,
            v_dept.location_id;
            
        exit when cur1%notfound;
        
        dbms_output.put_line(v_dept.department_id||' '||
                             v_dept.department_name|| ' '||
                             v_dept.location_id);
    end loop;
    
    close cur1;
end;
/
            
-- Cursor 
-- Cursor를 사용하여 사원테이블에서 커미션이 null이 아닌 사원의 사원번호, 이름, 급여를 출력하시오.
-- 출력시에는 이름의 오름차순으로 정렬하시오.

--문제의 조건에 맞는 쿼리문작성
select employee_id, last_name, salary from employees where commission_pct is not null order by last_name;


declare 
    -- 작성한 쿼리를 통해 커서를 생성합니다.
    cursor curEmp is
        select employee_id, last_name, salary
        from employees
        where commission_pct is not null
        order by last_name asc;
        -- 사원테이블의 전체컬럼을 참조하는 참조변수 선언
    varEmp employees%rowType;    -- rowType 여러 타입가능

begin
    --커서문을 오픈하여 쿼리문을 실행합니다
    open curEmp;
    --basic loop문을 통해 커서에 저장된 결과셋을 인출합니다.(질의결과물을)
    loop
        fetch curEmp            -- fetch 결과셋에서 하나의 행을 가져온다는것
            into varEmp.employee_id, varEmp.last_name, varEmp.salary;
            --인출할 결과셋이 없으면 loop문을 탈출한다.
        exit when curEmp%notfound;
        dbms_output.put_line(varEmp.employee_id ||' '||
                             varEmp.last_name||' '||
                             varEmp.salary);
    end loop;
    --커서의 인출 횟수 확인
    dbms_output.put_line('인출된행의갯수: '|| curEmp%rowcount);
    --커서닫아주기
    close curEmp;
end;
/

---------------------------------------------------------------------------------
---------------------------------------------------------------------------------
---- Collection  ----------------------------------------------------------------

/*
컬렉션(배열)
    : 일반 프로그래밍언어에서 사용하는 배열타입 PL/SQl에서는 테이블타입 이라고한다.
     1, 2 차원 배열을 생각해보면 테이블(표)와 같은 형태이기때문이다. 

    종류 : 연관배열 Varray 중첩테이블 

    
    1. 연관배열 ( Associative Array)
        : Key 와 Value 의 한 쌍으로 구성된 컬렉션으로 자바의  Hash map 과 같은 개념
          Key : 자료형은 주로 숫자를 사용합니다. binary_integer, pls_integer를 주로 사용하는데 number타입보다 크기는 작지만 산술연산에 빠른 특징을 가진다.
          Value : 문자형을 주로 사용합니다. varchar2를 사용하면 된다.
          
        형식 : Type 연관배열자료형 is
                table of 값의 타입 
                    index by 키의 타입;
    2. Varray 
        :  고정 길이를 가진 배열로 일반 프로그래밍 언어에서 사용하는 배열과 동일하다.
           크기에 제한이 있어서 선언할 때 크기(원소의갯수)를 지정하면 이보다 큰 배열로 만들수 없다.( 최초 선언후 수정불가??)
        형식 : Type 배열타입명 Is
                Array(배열크기) Of 값의 타입;
     
    3. 중첩테이블 ( Nested table )
        :  Varray와 비슷한 구조의 배열로써 배열의 크기를 명시하지 않으므로 동적으로 배열의 크기가 설정된다.
           여기서 말하는 테이블은 자료가 저장되는 실제 테이블이 아니라 컬렉션의 한 종류를 의미한다.
        형식 : Type 중첩태이블명 Is
                Table Of 값의 타입;
*/



--연관배열  Associative Array
--다음의 조건에 맞는 연관배열을 생성한 후 값을 할당하시오.
--    연관배열 자료형 명 : avType, 값의자료형:문자형, 키의자료형:문자형
--    key : girl, boy
--    value : 트와이스, 방탄소년단
--    변수명 : var_array

--화면상에 내용을 출력하고 싶을때 on으로 설정한다 off 일때는 출력되지않는다.
set serveroutput on;
--PL/SQL

declare
    --연관배열자료형 작성
    Type avType Is
        Table Of varchar2(30) -- value  의 자료형 선언
        Index By varchar2(10);--  key  의 자료형 선언
    -- 연관배열 타입의 변수를 선언합니다.
    var_array avType;
begin
    --연관배열의 값이 여기서 할당한다.  girl값에 트와이스 키를
    var_array('girl') := '트와이스';
    var_array('boy') := '방탄소년단';
    
    dbms_output.put_line(var_array('girl'));
    dbms_output.put_line(var_array('boy'));
end;
/

-- 연관배열(Associative Array)
--  100번 부서에 근무하는 사원의 이름을 저장하는 연관배열을 생성하시오.   
--   key는 숫자, value는 full_name 으로 지정하시오.

select * from employees where department_id = 100;

select first_name||' '||last_name
    from employees where department_id = 100;

--문제의 조건을 통한 쿼리에서 다수행이 인출되었으므로 Cursor를 사용합니다.    
declare
    -- 쿼리문을 통해 커서를 생성합니다.
    cursor emp_cur is
        select first_name||' '||last_name from employees
        where department_id = 100;
    -- 연관배열자료형 생성( 키- 숫자형 값-문자형 ) 
    Type nameAvType Is
        Table Of varchar2(30)
        Index By binary_integer;
        
    -- 자료형을 기반으로 변수를 생성합니다. 
    names_arr nameAvType;
    -- 사원의 이름과 인덱스로 사용할 변수 생성 
    fname varchar2(50);
    idx number := 1;

begin  
    --커서를 열어준다.얻어온 결과셋의 갯수만큼 반복하여 사원명을 인출합니다.
    open emp_cur;
    loop
        fetch emp_cur into fname;
        -- 더이상 인출할 내용이 없다면 loop를 탈출한다. 
        exit when emp_cur%notfound;
        -- 연관배열 변수에 사원이름을 입력합니다.
        names_arr(idx) := fname;
        -- 키로 사용될 인덱스를 증가시킨다. 
        idx := idx + 1;
    end loop;
    
    close emp_cur;
    -- 연관배열.count : 연관배열에 저장된 원소의 갯수만큼 반환합니다. 
    for i in 1 .. names_arr.count loop
        dbms_output.put_line(names_arr(i));
    end loop;
end;
/

--  VArray (Variable Array)

declare 
    -- Varray 타입 선언 : 크기는 5, 저장할 테이터는 문자형으로 지정한다.
    type varType is 
        array(5) of varchar2(20);
    -- Varray형 변수선언 
    v_arr varType;
    -- 인덱스로 사용할 변수선언 및 초기화 
    cnt number := 0;
    
    
begin
    --생성자를 통한 값의 초기화 v_arr에 값을 넣어주는것. 5개중 3개만 할당한다. 2개는 null?
    v_arr := varType('First','Second','Third','','');
    
    --basic loop문을 통해 배열의 원소를 출력한다. 인덱스는 1부터 시작이다. 
    loop
        cnt := cnt + 1;  -- 인덱스는 1부터 시작하기때문에 시작전 미리 1로 만들어주는 작업!
        -- 탈출조건은 where 대신 if를 사용할 수 있다.
        -- 5이하면 계속 돌 if
        if cnt>5 then
            exit;
        end if; 
        --배열처럼 인덱스를 통해서 출력한다. 1 2 3 4 5 
        dbms_output.put_line(v_arr(cnt));
    end loop;
    
    -- 배열의 값을 새로 지정하는 것.
    v_arr(3) := '우리는';
    v_arr(4) := 'JAVA';
    v_arr(5) := '개발자다';
    
    -- for loop문으로 출력한다.
    for i in 1 .. 5 loop
        -- 출력 1 2 3 4 5 12에는 위에서 이미 지정한 first second 가 있고 345 에는 위에서 바로 지정한 우리는 java개발자다가 새로 들어감
        dbms_output.put_line(v_arr(i));
    end loop;
end;
/
 
--VArray(Variable Array)
--  100번 부서에 근무하는 사원의 사원번호를 인출하여 VArray에 저장한 출력하는 PL/SQL을 작성하시오.

select * from employees where department_id =100;

declare    
    -- Varray 자료형 선언, 배열에 저장될 값은 사원아이디 컬럼을 참조하여 생성한다. 
    type vaType1 is
        array(6) of employees.employee_id%Type;
    --배열 변수 선언 및 생성자를 통한 초기화를 한다.
    va_one vaType1 := vaType1('','','','','','');
    cnt number := 1;
    
begin
    -- Java의 향상된 for문과 비슷하게 쿼리에 결과셋 갯수만큼 자동으로 반복하는 형태로 사용한다. 
    -- select 절에 employee_id가 변수i 에 할당되고 이를 통해 인출할 수 있다.
    for i in (select employee_id from employees where department_id = 100) loop
        --인출한 데이터 사원번호 를 배열에 순서대로 저장한다.
        va_one(cnt) := i.employee_id;
        cnt := cnt + 1;
    end loop;
        dbms_output.put_line(cnt);
    -- 배열의 크기만큼 반복하여 각 원소를 인출한다. 
    for j in 1 .. va_one.count loop
        dbms_output.put_line(va_one(j));
    end loop;
end;
/

--중첩테이블 ( Nested table )

declare 
    type ntType is
        -- 테이블크기를 설정하지 않고 자료형만 설정
        table of varchar2(30);
    nt_array ntType;
begin
    -- 생성자를 통해 값을 할당한다. 이때 크기 4인 중첩테이블이 생성된다.
    nt_array := ntType('첫번째','두번째','세번째','');
    
    dbms_output.put_line(nt_array(1));
    dbms_output.put_line(nt_array(2));
    dbms_output.put_line(nt_array(3));
    nt_array(4) := '네번째값할당';
    dbms_output.put_line(nt_array(4));
    -- 현재까지는 배열의 크기는 4이기 때문에 5번째 인덱스 공간은 존재하지않고 자동으로 확장되지는 않는다. 에러발생
--    nt_array(5) := '다섯번째값??할당??';

    -- 크기를 확장할때 생성자를 통해 배열의 크기를 동적으로 확장합니다. 생성자를 통해 크기확장 가능    
    nt_array := ntType('1a','2b','3c','4d','5e','6f','7g');
    
    for i in 1 .. 7 loop
        dbms_output.put_line(nt_array(i));
    end loop;
end;
/

--중첩테이블(Nested Table) 
--중첩테이블과 for문을 통해 사원테이블의 전체 레코드의 사원번호와 이름을 출력하시오.

declare
    --중첩테이블의 자료형 선언 및 변수 선언 : 사원테이블 전체 컬럼을 참조하는 참조변수의 형태이므로
    --하나의 레코드(Row)를 저장할 수 있는 형태로 선언된다.
    type ntType is
        table of employees%rowtype;
    nt_array ntType;
begin
    -- 크기를 저장하지 않는 상태로 생성자를 통해 중첩테이블을 초기화 한다.
    nt_array := ntType();
    --사원테이블의 레코드 수 만큼 반복하면서 레코드를 하나씩 변수 rec에 저장합니다.(for 변수는 사전에 지정하지 않고 바로 사용가능!)
    -- ㅈ
    for rec in (select * from employees order by employee_id desc) loop
        --중첩테이블의 끝부분을 확장하면서 null을 삽입합니다.
        nt_array.extend;
        -- 마지막 인덱스 값을 얻어온 후 사원정도 레코드를 삽입한다.
        nt_array(nt_array.last) := rec;
    end loop;
    -- 중첩테이블의 첫번째 인덱스부터 마지막 인덱스까지 출력합니다.
    for i in nt_array.first .. nt_array.last loop
        --사원번호와 이름을 출력한다 for i =  .first~.last까지~
        dbms_output.put_line (nt_array(i).employee_id || '>' || nt_array(i).first_name);
    end loop;
end;
/
    









