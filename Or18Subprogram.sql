/************************   hr 계정
파일명: Or18 Subprogram 
서브프로그램
설명 : 저장프로시저, 함수 그리고 프로시저의 일종인 트리거를 학습합니다.
************************/

/*
Sub Program 서브 프로그램
    : PL/SQL 에서는 프로시져와 함수라는 두가지 유형의 서브프로그램이 있다.
      select를 포함해서 다른 DML문을 이용하여 프로그램적인 요소를 통해 사용가능하다.
      
      트리거 : 프로시져의 일종으로 특정 테이블에 레코드의 변화가 있을 경우 자동으로 실행됩니다.
      
      함수 : 쿼리문의 일부분으로 사용하기위해 생성한다.
      즉, 외부 프로그램에서 호출하는 경우는 거의 없다. 
      
      프로시져 : 외부 프로그램에서 호출하기위해 생성한다.
      따라서 자바 JSP 등에서  간단한 호출로 복잡한 쿼리를 실행할 수 있다.
      


 저장프로시져
         : 프로시져는 return문이 없는 대신 out parameter를 통해 값을 반환한다. 
           보안성을 높일 수 있고 네트워크의 부하를 줄일 수 있다.
  형식 :    create or replace procedure  프로시저명 
                  [(매개변수 in 자료형, 매개변수 out 자료형)]
                       is [변수선언]
                      begin 
                        실행문장
                      end;
     파라미터 설정시 자료형만 명시하고 크기는 명시하지않는다. 

 함수 Function 
          : 사용자가 PL/SQL문을 사용하여 오라클에서 제공하는 내장함수와 같은 기능을 정의한 것이다.
            함수는 in파라미터만 사용할 수 있고 반드시 반환될 값의 자료형을 명시해야한다.
            프로시져는 여러개의 결과값을 얻어올 수 있지만 함수는 반드시 하나의 값을 반환해야한다.
            함수는 쿼리문의 일부분으로 사용한다.
            파라미터의 반환타입을 명시할 때 크기는 기술하지 않는다. 

 트리거 Trigger
        : 자동으로 실행되는 프로시져로 직접 실행은 불가능하다. 
          주로 테이블에 입력된 레코드의 변화가 있을때 자동으로 실행한다.

*/






------------------------------------------------------------------------------------------------

-- 저장프로시져 stored procedure
--100번 사원의 급여를 가져와서 select하여 출력하는 프로시저 생성
--최초 실행이라면 set serveroutput on; 을 실행해줘야 결과를 화면에 인출할 수 있다. 

set serveroutput on;

create or replace procedure pcd_emp_salary
is
    --PL/SQL 은 declare에서 변수를 실행하지만 프로시져나 함수는 is절에서 변수를 실행합니다. 
    --만약 변수가 필요하지않다면 is절은 생략이 가능하다. 
    --사원테이블의 급여컬럼을 참조하는 참조변수로 생성한다.
    v_salary employees.salary%type;
begin
    --100번 사원의 급여를 into를 이용해서 변수에 할당한다.
    select salary into v_salary
    from employees
    where employee_id = 100;
    
    dbms_output.put_line('사원번호 100의 급여는 : ' || v_salary || '입니다');
    --프로시져 종료 
end;
/ 
-- 프로시져 컴파일 완료 
-- 데이터 사전에서 확인합니다. 저장시 대문자로 변환되므로 변환함수를 사용해야한다. 
select * from user_source where name like upper('%pcd_emp_salary%');

-- 프로시져의 실행은 호스트환경에서 execute 명령을 이용한다.
execute pcd_emp_salary;

-- 저장프로시져 stored procedure
--IN파라미터 사용하여 프로시저 생성
--사원의 이름을 매개변수로 받아서 사원테이블에서 레코드를 조회한후 해당사원의 급여를 출력하는 프로시저를 생성 후 실행하시오.
--해당 문제는 in파라미터를 받은후 처리한다. 사원이름(first_name) : Bruce, Neena

create or replace procedure pcd_in_param_salary
    (param_name in employees.first_name%type)
is
    valSalary number(10);
begin
    
    select salary into valSalary
    from employees where first_name = param_name;
    
    dbms_output.put_line (param_name||'의 급여는 '|| valSalary||' 입니다.');
end;
/
--사원의 이름을 파라미터로 전달하여 프로시저를 호출합니다.
execute pcd_in_param_salary('Bruce');
execute pcd_in_param_salary('Neena');

---- 저장프로시져 stored procedure
--OUT파라미터 사용하여 프로시저 생성
-- 위 문제와 동일하게 사원명을 매개변수로 전달받아서 급여를 조회하는 프로시저를 생성하시오. 
-- 단, 급여는 out파라미터를 사용하여 반환후 출력하시오.

create or replace procedure pcd_out_param_salary
-- 두가지 형식의 파라미터를 정의한다. 일반변수, 참조변수 각각 사용했다.
-- 파라미터의 용도에 따라 in oout을 사용한다 파라미터의 용도에 따라 설정해서 사용한다.
    (
        param_name in varchar2,
        param_salary out employees.salary%type
    )
    
is
    -- select한 결과를 out파라미터에 저장할 것이므로 별도의 변수가 필요하지 않아 is절은 비워둡니다.
    -- 추가적인 변수가 필요없는 상황에서 is절은 생략할 수가 있다. is구문 자체 생략도가능

begin

    -- in 파라미터는  where절에 조건으로 사용하고 
    -- select한 결과는 into절에서 out파라미터에 저장한다.
    select salary into param_salary -- out파라미터에 저장하는것.
    from employees where first_name =param_name;
end;
/
-- 호스트 환경에서 바인드 함수를 선언합니다.   var 또는 valuable 둘다 사용할 수 있습니다.
var v_salary varchar2(30);

-- 프로시져 호출시 각각의 파라미터를 전달한다. 특히 바인드 변수는 :을 붙여야한다.
-- out 파라미터인 param_salary 에 저장된 값이 v_salary로 전달된다.
execute pcd_out_param_salary('Matthew', :v_salary);  -- 여기서 out파라미터에 저장된값을 바인드 변수에 전달하는 구문

-- 프로시져 실행 후 out 파라미터를 통해 전달된 바인드 변수 안 의 값을 출력한다.
print v_salary;


-- 사원번호와 급여를 매개변수로 전달받아 해당사원의 급여를 수정하고, 
-- 실제 수정된 행의 갯수를 반환받아서 출력하는 프로시저를 작성하시오
-- 실습을위해 사원테이블을 레코드까지 복사합니다.

-- 테이블을 복사 생성합니다.
create table zcopy_employees
    as
    select * from employees;
select * from zcopy_employees;

-- in 파라미터는 사원번호와 급여를 전달한다. 
-- out 파라미터는 적용된 행의 갯수를 반환받는다
create or replace procedure pcd_update_salary
    (
        p_empid in number,
        p_salary in number,
        rCount out number
    )
is -- 추가적인 변수 선언이 필요없으므로 생략합니다.
begin
    --실제업데이트를 처리하는 쿼리문으로 in 파라미터를 통해 값을 설정합니다.
    update zcopy_employees
        set salary = p_salary
        where employee_id = p_empid;
     
     --SQL%notfound : 쿼리실행 후 적용된 행이 없을 경우 true 를 반환한다. 
     --     found : 반대의 경우를 반환한다.
     --SQL%rowcount : 쿼리실행 후 실제 적용된 행의 갯수를 반환합니다.
        
        if SQL%notfound then   --적용된행이 없을경우
            dbms_output.put_line(p_empid ||'은(는) 없는사원임다.');
        else   --적용된 행이 있을경우 
            dbms_output.put_line(SQL%rowcount || '명의 자료가 수정됐음');
            
            rCount := sql%rowcount;
        end if;
        --행의 변화가 있는 쿼리를 실행할 경우 반드시 커밋해야 실제 테이블에 적용되어 오라클 외부에서 확인할 수 있습니다.
        commit;
end;
/

--프로시져실행을 위한 바인드 변수 생성
variable r_count number;
-- 100 번사원의 이름과 급여를 확인한다. 
select first_name, salary from zcopy_employees where employee_id = 100;

--프로시져실행 바인드변수에는 :을 붙여야 한다. 
execute pcd_update_salary(100,20000,:r_count);

--update 가 적용된 행의 갯수를 확인합니다.
print r_count;

--update 된 내용을 확인한다.
select first_name, salary from zcopy_employees where employee_id = 100;


-----------------------------------------------------------------------
-----------------------------------------------------------------------
-----------------------------------------------------------------------


-- 함수 Function 
-- 2개의 정수를 전달받아서 두 정수사이의 모든수를 더해서 결과를 반환하는 함수를 정의하시오.
-- 실행예) 2, 7 -> 2+3+4+5+6+7 = ??
-- 함수는 in파라미터만 있으므로 in은 주로 생략한다.


create or replace function calSumBetween (
    num1 in number,
    num2 number
    )
    --함수는 반드시 반환 값이 있으므로 반환 타입을 명시해야한다.
return 
    number  -- 반환타입명시 
is
    sumNum number;
begin
    sumNum := 0;
     -- 숫자사이의 값을 저장후 반환한다.
    for i in num1 .. num2 loop
        sumNum := sumNum + i;
    end loop;
    
    --결과값 반환
    return sumNum;
end;
/
--실행방법 1  쿼리문의 일부로 사용한다
select calSumBetween(1,10) from dual;

--실행방법 2 바인드변수를 통한 실행명령으로 주로 디버깅용으로 사용한다.

var hapText varchar2(30);

execute :hapText := calSumBetween(1,100);

print hapText;

--데이터 사전에서 확인하기
select * from user_source where name = upper('calSumBetween');

/*
퀴즈] 주민번호를 전달받아서 성별을 판단하는 함수를 정의하시오.
999999-1000000 -> '남자' 반환
999999-2000000 -> '여자' 반환
단, 2000년 이후 출생자는 3이 남자, 4가 여자임.
함수명 : findGender()
*/
-- 해당 함수는 주민번호를 문자로 받아서 해당 성별을 판단한다.
-- 함수는 in파라미터만 있으므로 in은 생략가능
create or replace function findGender(
    juminN varchar2)
--함수는 반드시 반환 타입을 명시해야합니다. 성별 판단 후 남자 혹은 여자를 반환해야하므로 문자형으로 선언합니다. 
return varchar2
is 
    --주민번호에서 성별에 해당하는 문자를 저장할 변수 
    genderTxt varchar2(10);
    --성별을 저장한 후 반환할 변수 
    returnVal varchar2(10);
begin            -- 방법 1,2 모두 사용가능
    -- 방법 1 : 쿼리에서 실행된 결과를 into를 통해 저장한다. 
--    select substr(juminN, 8,1) into genderTxt from dual;
    -- 방법 2 : substr 함수를 직접사용 
    genderTxt := substr(juminN,8,1);

    if genderTxt = '1' then
        returnVal := '남자';
    elsif genderTxt = '2' then
        returnVal := '여자';
    elsif genderTxt = '3' then
        returnVal := '남자';
    elsif genderTxt = '4' then
        returnVal := '여자';
    else
        returnVal := '오류';
    end if;
        
    --함수는 반드시 반환값을 가집니다. 
    return returnVal;
end;
/
select findGender('990909-1234567') from dual;
select findGender('990909-2234567') from dual;
select findGender('990909-3234567') from dual;


-- 함수 Function
--사원의이름(first_name)을 매개변수로 전달받아서 부서명(department_name)을 반환하는 함수를 작성하시오. 함수명 : func_deptName


-- 1단계 : Nancy 의 부서명을 출력하기 위한 inner join문 작성 
select 
    first_name, last_name, department_id, department_name
from employees inner join departments using(department_id)
where first_name='Nancy';

--함수 작성 함수 이름설정 
create or replace function func_deptName(param_name varchar2)  -- 사원의 이름을 받기위한 파라미터 설정합니다.
-- 부서병을 반환하므로 문자형으로 설정 
return
    varchar2
is 
    --부서테이블의 부서명을 참조하는 참조변수로 선언 
    -- return_deptname 이라는 참조변수를 선언할건데 그 참조변수의 자료형은 오른쪽에서 가져올거야~
    return_deptname departments.department_name%type;
begin
    select
        department_name into return_deptname
    from employees inner join departments using(department_id)
    where first_name=param_name;
    
    return return_deptname;
end;
/

select func_deptname('Nancy') from dual;  -- Finance
select func_deptname('Diana') from dual;  -- IT

-----------------------------------------------------------------------
-----------------------------------------------------------------------
-----------------------------------------------------------------------
-- 트리거 실습을 위해 HR계정에서 아래 테이블을 복사한다.
 --테이블의 레코드까지 모두 복사한다. 
 
create table trigger_dept_original
as
select * from departments;

select * from trigger_dept_original;

--테이블의 스키마 (구조) 만 복사한다.where 절에 거짓의 조건을 주면 레코드는 select 되지않는다. 

create table trirg_dept_backup
as
select * from departments where 1=0;  -- where 절에 구조만 복사하는 1=0; 사용 
desc trigger_dept_backup;
select * from trigger_dept_backup;  


-- 트리거 trig_dept_backup
--테이블에 새로운 데이터가 입력되면 해당 데이터를 백업테이블에 저장하는 트리거를 작성해보자.

set serveroutput on;

create or replace trigger trigger_dept_backup
      after   --타이밍 : 이벤트 발생전 이벤트 발생후   
    INSERT     -- 이벤트 : insert update delete 와 같은 쿼리 실행 시 발생한다. 
    on trigger_dept_original      --트리거를 적용할 테이블명 
    for each row
    
    -- 행 단위 트리거 정의한다. 즉 하나의 행이 변화할때마다 트리거가 수행된다 
    -- 만약 문자단위 트리거로 정의하고 싶다면 해당 문장을 제거하면된다
    -- 이때는 쿼리를 한번 실행할때 트리거도 단한번만실행된다/.
begin
    -- insert 이벤트가 발생되면 true를 반환하여  if 문이 실행된다.
    if Inserting then
        dbms_output.put_line('insert 트리거 발생됨');
        
        --새로운 레코드가 입력되었으므로 임시 테이블 :new에 저장되고 해당 레코드를 통해 백업테이블에 입력 할수 있습니다.
        -- 이와 같은 임시테이블은 행 단위 트리거에서만 사용할 수 있습니다.
        
        
        insert into trigger_dept_backup
        values (
            :new.department_id,
            :new.department_name,
            :new.manager_id,
            :new.location_id
            );
    end if;
end;
/

insert into trigger_dept_original values(101,'개발팀', 10, 100);
insert into trigger_dept_original values(102,'전산팀', 20, 100);
insert into trigger_dept_original values(103,'영업팀', 30, 100);

select * from trigger_dept_original;
select * from trigger_dept_backup;

-- trigger delete
--원본테이블에서 레코드가 삭제되면 백업테이블의 레코드도 같이 삭제되는 트리거를 작성해보자.


create or replace trigger trig_dept_delete
    
    after
    delete
    on triger_dept_original
    for each row
begin
    dbms_output.put_line('delete 트리거 발생됨');
    -- 레코드가 삭제된 이휑 이벤트가 발생되어 트리거가 호출되므로 :old 임시테이블을 사용합니다.
    if deleting then
        delete from trigger_dept_backup
            where department_id = :old.department_id;
    end if;
end;
/
--아래와 같이 레코드를 삭제하면 트리거가 자동호출 됩니다. 
delete from trigger_dept_original where department_id = 101;
delete from trigger_dept_original where department_id = 102;

select * from trigger_dept_original;
select * from trigger_dept_backup;




-- trigger_update_test
--for each row 옵션에 따른 트리거 실행 횟수 테스트 

--생성1 : 오리지널 테이블에 업데이트 이후 행단위로 발생되는 트리거 생성 

create or replace trigger trigger_update_test
    after update
    on trigger_dept_original
    for each row
begin 
    -- 업데이트 이벤트가 감지되면 backup테이블에 트리거를 저장한다. 
    if updating then
        insert into trigger_dept_backup
        values(
            :old.department_id,
            :old.department_name,
            :old.manager_id,
            :old.location_id
            );
    end if;
end;
/
--5개의 레코드가 인출되는 것을 확인합니다. 

select * from trigger_dept_original where
    department_id>=10 and department_id <=50;
    
    --업데이트 실행 5개의 레코드가 업데이트됩니다.
update trigger_dept_original set department_name='5개업데이트'
    where department_id>=10 and department_id<=50;
    
    
select * from trigger_dept_original;
select * from trigger_dept_backup;


--생성 2 : 오리지널 테이블에 업데이트 이후 테이블(문장)단위로 발생하는 

create or replace trigger trigger_update_test2
    after update
    on trigger_dept_original
--    for each row  
-- 오지지널 테이브르이 레코드를 업데이트 한 이후 테이블단위로 트리거가 실행되므로 적용된 갯수의 상관없이 무조건 한번만
-- 트리거가 실행됩니다.
begin 
    
    if updating then
        insert into trigger_dept_backup
        values(
--            --테이블(문장) 단위 트리거에서는 임시테이블을 사용할 수가 없다. 
--            :old.department_id,
--            :old.department_name,
--            :old.manager_id,
--            :old.location_id
               999, to_char(sysdate,'yyyy-mm-dd hh24:mi:ss'),99,99
            );
    end if;
end;
/
    
update trigger_dept_original set department_name='5개업데이트2'
    where department_id>=10 and department_id<=50;
-- 5개의 레코드를 업데이트 했지만, 테이블단위 트리거이므로 한개만 입력됩니다.    
    
select * from trigger_dept_original;
select * from trigger_dept_backup;


--트리거 삭제하기
drop trigger  trigger_update_test;
drop trigger  trigger_update_test2;
