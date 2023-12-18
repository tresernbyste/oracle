/************************   hr ����
���ϸ�: Or18 Subprogram 
�������α׷�
���� : �������ν���, �Լ� �׸��� ���ν����� ������ Ʈ���Ÿ� �н��մϴ�.
************************/

/*
Sub Program ���� ���α׷�
    : PL/SQL ������ ���ν����� �Լ���� �ΰ��� ������ �������α׷��� �ִ�.
      select�� �����ؼ� �ٸ� DML���� �̿��Ͽ� ���α׷����� ��Ҹ� ���� ��밡���ϴ�.
      
      Ʈ���� : ���ν����� �������� Ư�� ���̺� ���ڵ��� ��ȭ�� ���� ��� �ڵ����� ����˴ϴ�.
      
      �Լ� : �������� �Ϻκ����� ����ϱ����� �����Ѵ�.
      ��, �ܺ� ���α׷����� ȣ���ϴ� ���� ���� ����. 
      
      ���ν��� : �ܺ� ���α׷����� ȣ���ϱ����� �����Ѵ�.
      ���� �ڹ� JSP ���  ������ ȣ��� ������ ������ ������ �� �ִ�.
      


 �������ν���
         : ���ν����� return���� ���� ��� out parameter�� ���� ���� ��ȯ�Ѵ�. 
           ���ȼ��� ���� �� �ְ� ��Ʈ��ũ�� ���ϸ� ���� �� �ִ�.
  ���� :    create or replace procedure  ���ν����� 
                  [(�Ű����� in �ڷ���, �Ű����� out �ڷ���)]
                       is [��������]
                      begin 
                        ���๮��
                      end;
     �Ķ���� ������ �ڷ����� ����ϰ� ũ��� ��������ʴ´�. 

 �Լ� Function 
          : ����ڰ� PL/SQL���� ����Ͽ� ����Ŭ���� �����ϴ� �����Լ��� ���� ����� ������ ���̴�.
            �Լ��� in�Ķ���͸� ����� �� �ְ� �ݵ�� ��ȯ�� ���� �ڷ����� ����ؾ��Ѵ�.
            ���ν����� �������� ������� ���� �� ������ �Լ��� �ݵ�� �ϳ��� ���� ��ȯ�ؾ��Ѵ�.
            �Լ��� �������� �Ϻκ����� ����Ѵ�.
            �Ķ������ ��ȯŸ���� ����� �� ũ��� ������� �ʴ´�. 

 Ʈ���� Trigger
        : �ڵ����� ����Ǵ� ���ν����� ���� ������ �Ұ����ϴ�. 
          �ַ� ���̺� �Էµ� ���ڵ��� ��ȭ�� ������ �ڵ����� �����Ѵ�.

*/






------------------------------------------------------------------------------------------------

-- �������ν��� stored procedure
--100�� ����� �޿��� �����ͼ� select�Ͽ� ����ϴ� ���ν��� ����
--���� �����̶�� set serveroutput on; �� ��������� ����� ȭ�鿡 ������ �� �ִ�. 

set serveroutput on;

create or replace procedure pcd_emp_salary
is
    --PL/SQL �� declare���� ������ ���������� ���ν����� �Լ��� is������ ������ �����մϴ�. 
    --���� ������ �ʿ������ʴٸ� is���� ������ �����ϴ�. 
    --������̺��� �޿��÷��� �����ϴ� ���������� �����Ѵ�.
    v_salary employees.salary%type;
begin
    --100�� ����� �޿��� into�� �̿��ؼ� ������ �Ҵ��Ѵ�.
    select salary into v_salary
    from employees
    where employee_id = 100;
    
    dbms_output.put_line('�����ȣ 100�� �޿��� : ' || v_salary || '�Դϴ�');
    --���ν��� ���� 
end;
/ 
-- ���ν��� ������ �Ϸ� 
-- ������ �������� Ȯ���մϴ�. ����� �빮�ڷ� ��ȯ�ǹǷ� ��ȯ�Լ��� ����ؾ��Ѵ�. 
select * from user_source where name like upper('%pcd_emp_salary%');

-- ���ν����� ������ ȣ��Ʈȯ�濡�� execute ����� �̿��Ѵ�.
execute pcd_emp_salary;

-- �������ν��� stored procedure
--IN�Ķ���� ����Ͽ� ���ν��� ����
--����� �̸��� �Ű������� �޾Ƽ� ������̺��� ���ڵ带 ��ȸ���� �ش����� �޿��� ����ϴ� ���ν����� ���� �� �����Ͻÿ�.
--�ش� ������ in�Ķ���͸� ������ ó���Ѵ�. ����̸�(first_name) : Bruce, Neena

create or replace procedure pcd_in_param_salary
    (param_name in employees.first_name%type)
is
    valSalary number(10);
begin
    
    select salary into valSalary
    from employees where first_name = param_name;
    
    dbms_output.put_line (param_name||'�� �޿��� '|| valSalary||' �Դϴ�.');
end;
/
--����� �̸��� �Ķ���ͷ� �����Ͽ� ���ν����� ȣ���մϴ�.
execute pcd_in_param_salary('Bruce');
execute pcd_in_param_salary('Neena');

---- �������ν��� stored procedure
--OUT�Ķ���� ����Ͽ� ���ν��� ����
-- �� ������ �����ϰ� ������� �Ű������� ���޹޾Ƽ� �޿��� ��ȸ�ϴ� ���ν����� �����Ͻÿ�. 
-- ��, �޿��� out�Ķ���͸� ����Ͽ� ��ȯ�� ����Ͻÿ�.

create or replace procedure pcd_out_param_salary
-- �ΰ��� ������ �Ķ���͸� �����Ѵ�. �Ϲݺ���, �������� ���� ����ߴ�.
-- �Ķ������ �뵵�� ���� in oout�� ����Ѵ� �Ķ������ �뵵�� ���� �����ؼ� ����Ѵ�.
    (
        param_name in varchar2,
        param_salary out employees.salary%type
    )
    
is
    -- select�� ����� out�Ķ���Ϳ� ������ ���̹Ƿ� ������ ������ �ʿ����� �ʾ� is���� ����Ӵϴ�.
    -- �߰����� ������ �ʿ���� ��Ȳ���� is���� ������ ���� �ִ�. is���� ��ü ����������

begin

    -- in �Ķ���ʹ�  where���� �������� ����ϰ� 
    -- select�� ����� into������ out�Ķ���Ϳ� �����Ѵ�.
    select salary into param_salary -- out�Ķ���Ϳ� �����ϴ°�.
    from employees where first_name =param_name;
end;
/
-- ȣ��Ʈ ȯ�濡�� ���ε� �Լ��� �����մϴ�.   var �Ǵ� valuable �Ѵ� ����� �� �ֽ��ϴ�.
var v_salary varchar2(30);

-- ���ν��� ȣ��� ������ �Ķ���͸� �����Ѵ�. Ư�� ���ε� ������ :�� �ٿ����Ѵ�.
-- out �Ķ������ param_salary �� ����� ���� v_salary�� ���޵ȴ�.
execute pcd_out_param_salary('Matthew', :v_salary);  -- ���⼭ out�Ķ���Ϳ� ����Ȱ��� ���ε� ������ �����ϴ� ����

-- ���ν��� ���� �� out �Ķ���͸� ���� ���޵� ���ε� ���� �� �� ���� ����Ѵ�.
print v_salary;


-- �����ȣ�� �޿��� �Ű������� ���޹޾� �ش����� �޿��� �����ϰ�, 
-- ���� ������ ���� ������ ��ȯ�޾Ƽ� ����ϴ� ���ν����� �ۼ��Ͻÿ�
-- �ǽ������� ������̺��� ���ڵ���� �����մϴ�.

-- ���̺��� ���� �����մϴ�.
create table zcopy_employees
    as
    select * from employees;
select * from zcopy_employees;

-- in �Ķ���ʹ� �����ȣ�� �޿��� �����Ѵ�. 
-- out �Ķ���ʹ� ����� ���� ������ ��ȯ�޴´�
create or replace procedure pcd_update_salary
    (
        p_empid in number,
        p_salary in number,
        rCount out number
    )
is -- �߰����� ���� ������ �ʿ�����Ƿ� �����մϴ�.
begin
    --����������Ʈ�� ó���ϴ� ���������� in �Ķ���͸� ���� ���� �����մϴ�.
    update zcopy_employees
        set salary = p_salary
        where employee_id = p_empid;
     
     --SQL%notfound : �������� �� ����� ���� ���� ��� true �� ��ȯ�Ѵ�. 
     --     found : �ݴ��� ��츦 ��ȯ�Ѵ�.
     --SQL%rowcount : �������� �� ���� ����� ���� ������ ��ȯ�մϴ�.
        
        if SQL%notfound then   --��������� �������
            dbms_output.put_line(p_empid ||'��(��) ���»���Ӵ�.');
        else   --����� ���� ������� 
            dbms_output.put_line(SQL%rowcount || '���� �ڷᰡ ��������');
            
            rCount := sql%rowcount;
        end if;
        --���� ��ȭ�� �ִ� ������ ������ ��� �ݵ�� Ŀ���ؾ� ���� ���̺� ����Ǿ� ����Ŭ �ܺο��� Ȯ���� �� �ֽ��ϴ�.
        commit;
end;
/

--���ν��������� ���� ���ε� ���� ����
variable r_count number;
-- 100 ������� �̸��� �޿��� Ȯ���Ѵ�. 
select first_name, salary from zcopy_employees where employee_id = 100;

--���ν������� ���ε庯������ :�� �ٿ��� �Ѵ�. 
execute pcd_update_salary(100,20000,:r_count);

--update �� ����� ���� ������ Ȯ���մϴ�.
print r_count;

--update �� ������ Ȯ���Ѵ�.
select first_name, salary from zcopy_employees where employee_id = 100;


-----------------------------------------------------------------------
-----------------------------------------------------------------------
-----------------------------------------------------------------------


-- �Լ� Function 
-- 2���� ������ ���޹޾Ƽ� �� ���������� ������ ���ؼ� ����� ��ȯ�ϴ� �Լ��� �����Ͻÿ�.
-- ���࿹) 2, 7 -> 2+3+4+5+6+7 = ??
-- �Լ��� in�Ķ���͸� �����Ƿ� in�� �ַ� �����Ѵ�.


create or replace function calSumBetween (
    num1 in number,
    num2 number
    )
    --�Լ��� �ݵ�� ��ȯ ���� �����Ƿ� ��ȯ Ÿ���� ����ؾ��Ѵ�.
return 
    number  -- ��ȯŸ�Ը�� 
is
    sumNum number;
begin
    sumNum := 0;
     -- ���ڻ����� ���� ������ ��ȯ�Ѵ�.
    for i in num1 .. num2 loop
        sumNum := sumNum + i;
    end loop;
    
    --����� ��ȯ
    return sumNum;
end;
/
--������ 1  �������� �Ϻη� ����Ѵ�
select calSumBetween(1,10) from dual;

--������ 2 ���ε庯���� ���� ���������� �ַ� ���������� ����Ѵ�.

var hapText varchar2(30);

execute :hapText := calSumBetween(1,100);

print hapText;

--������ �������� Ȯ���ϱ�
select * from user_source where name = upper('calSumBetween');

/*
����] �ֹι�ȣ�� ���޹޾Ƽ� ������ �Ǵ��ϴ� �Լ��� �����Ͻÿ�.
999999-1000000 -> '����' ��ȯ
999999-2000000 -> '����' ��ȯ
��, 2000�� ���� ����ڴ� 3�� ����, 4�� ������.
�Լ��� : findGender()
*/
-- �ش� �Լ��� �ֹι�ȣ�� ���ڷ� �޾Ƽ� �ش� ������ �Ǵ��Ѵ�.
-- �Լ��� in�Ķ���͸� �����Ƿ� in�� ��������
create or replace function findGender(
    juminN varchar2)
--�Լ��� �ݵ�� ��ȯ Ÿ���� ����ؾ��մϴ�. ���� �Ǵ� �� ���� Ȥ�� ���ڸ� ��ȯ�ؾ��ϹǷ� ���������� �����մϴ�. 
return varchar2
is 
    --�ֹι�ȣ���� ������ �ش��ϴ� ���ڸ� ������ ���� 
    genderTxt varchar2(10);
    --������ ������ �� ��ȯ�� ���� 
    returnVal varchar2(10);
begin            -- ��� 1,2 ��� ��밡��
    -- ��� 1 : �������� ����� ����� into�� ���� �����Ѵ�. 
--    select substr(juminN, 8,1) into genderTxt from dual;
    -- ��� 2 : substr �Լ��� ������� 
    genderTxt := substr(juminN,8,1);

    if genderTxt = '1' then
        returnVal := '����';
    elsif genderTxt = '2' then
        returnVal := '����';
    elsif genderTxt = '3' then
        returnVal := '����';
    elsif genderTxt = '4' then
        returnVal := '����';
    else
        returnVal := '����';
    end if;
        
    --�Լ��� �ݵ�� ��ȯ���� �����ϴ�. 
    return returnVal;
end;
/
select findGender('990909-1234567') from dual;
select findGender('990909-2234567') from dual;
select findGender('990909-3234567') from dual;


-- �Լ� Function
--������̸�(first_name)�� �Ű������� ���޹޾Ƽ� �μ���(department_name)�� ��ȯ�ϴ� �Լ��� �ۼ��Ͻÿ�. �Լ��� : func_deptName


-- 1�ܰ� : Nancy �� �μ����� ����ϱ� ���� inner join�� �ۼ� 
select 
    first_name, last_name, department_id, department_name
from employees inner join departments using(department_id)
where first_name='Nancy';

--�Լ� �ۼ� �Լ� �̸����� 
create or replace function func_deptName(param_name varchar2)  -- ����� �̸��� �ޱ����� �Ķ���� �����մϴ�.
-- �μ����� ��ȯ�ϹǷ� ���������� ���� 
return
    varchar2
is 
    --�μ����̺��� �μ����� �����ϴ� ���������� ���� 
    -- return_deptname �̶�� ���������� �����Ұǵ� �� ���������� �ڷ����� �����ʿ��� �����ðž�~
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
-- Ʈ���� �ǽ��� ���� HR�������� �Ʒ� ���̺��� �����Ѵ�.
 --���̺��� ���ڵ���� ��� �����Ѵ�. 
 
create table trigger_dept_original
as
select * from departments;

select * from trigger_dept_original;

--���̺��� ��Ű�� (����) �� �����Ѵ�.where ���� ������ ������ �ָ� ���ڵ�� select �����ʴ´�. 

create table trirg_dept_backup
as
select * from departments where 1=0;  -- where ���� ������ �����ϴ� 1=0; ��� 
desc trigger_dept_backup;
select * from trigger_dept_backup;  


-- Ʈ���� trig_dept_backup
--���̺� ���ο� �����Ͱ� �ԷµǸ� �ش� �����͸� ������̺� �����ϴ� Ʈ���Ÿ� �ۼ��غ���.

set serveroutput on;

create or replace trigger trigger_dept_backup
      after   --Ÿ�̹� : �̺�Ʈ �߻��� �̺�Ʈ �߻���   
    INSERT     -- �̺�Ʈ : insert update delete �� ���� ���� ���� �� �߻��Ѵ�. 
    on trigger_dept_original      --Ʈ���Ÿ� ������ ���̺�� 
    for each row
    
    -- �� ���� Ʈ���� �����Ѵ�. �� �ϳ��� ���� ��ȭ�Ҷ����� Ʈ���Ű� ����ȴ� 
    -- ���� ���ڴ��� Ʈ���ŷ� �����ϰ� �ʹٸ� �ش� ������ �����ϸ�ȴ�
    -- �̶��� ������ �ѹ� �����Ҷ� Ʈ���ŵ� ���ѹ�������ȴ�/.
begin
    -- insert �̺�Ʈ�� �߻��Ǹ� true�� ��ȯ�Ͽ�  if ���� ����ȴ�.
    if Inserting then
        dbms_output.put_line('insert Ʈ���� �߻���');
        
        --���ο� ���ڵ尡 �ԷµǾ����Ƿ� �ӽ� ���̺� :new�� ����ǰ� �ش� ���ڵ带 ���� ������̺� �Է� �Ҽ� �ֽ��ϴ�.
        -- �̿� ���� �ӽ����̺��� �� ���� Ʈ���ſ����� ����� �� �ֽ��ϴ�.
        
        
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

insert into trigger_dept_original values(101,'������', 10, 100);
insert into trigger_dept_original values(102,'������', 20, 100);
insert into trigger_dept_original values(103,'������', 30, 100);

select * from trigger_dept_original;
select * from trigger_dept_backup;

-- trigger delete
--�������̺��� ���ڵ尡 �����Ǹ� ������̺��� ���ڵ嵵 ���� �����Ǵ� Ʈ���Ÿ� �ۼ��غ���.


create or replace trigger trig_dept_delete
    
    after
    delete
    on triger_dept_original
    for each row
begin
    dbms_output.put_line('delete Ʈ���� �߻���');
    -- ���ڵ尡 ������ ���� �̺�Ʈ�� �߻��Ǿ� Ʈ���Ű� ȣ��ǹǷ� :old �ӽ����̺��� ����մϴ�.
    if deleting then
        delete from trigger_dept_backup
            where department_id = :old.department_id;
    end if;
end;
/
--�Ʒ��� ���� ���ڵ带 �����ϸ� Ʈ���Ű� �ڵ�ȣ�� �˴ϴ�. 
delete from trigger_dept_original where department_id = 101;
delete from trigger_dept_original where department_id = 102;

select * from trigger_dept_original;
select * from trigger_dept_backup;




-- trigger_update_test
--for each row �ɼǿ� ���� Ʈ���� ���� Ƚ�� �׽�Ʈ 

--����1 : �������� ���̺� ������Ʈ ���� ������� �߻��Ǵ� Ʈ���� ���� 

create or replace trigger trigger_update_test
    after update
    on trigger_dept_original
    for each row
begin 
    -- ������Ʈ �̺�Ʈ�� �����Ǹ� backup���̺� Ʈ���Ÿ� �����Ѵ�. 
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
--5���� ���ڵ尡 ����Ǵ� ���� Ȯ���մϴ�. 

select * from trigger_dept_original where
    department_id>=10 and department_id <=50;
    
    --������Ʈ ���� 5���� ���ڵ尡 ������Ʈ�˴ϴ�.
update trigger_dept_original set department_name='5��������Ʈ'
    where department_id>=10 and department_id<=50;
    
    
select * from trigger_dept_original;
select * from trigger_dept_backup;


--���� 2 : �������� ���̺� ������Ʈ ���� ���̺�(����)������ �߻��ϴ� 

create or replace trigger trigger_update_test2
    after update
    on trigger_dept_original
--    for each row  
-- �������� ���̺긣�� ���ڵ带 ������Ʈ �� ���� ���̺������ Ʈ���Ű� ����ǹǷ� ����� ������ ������� ������ �ѹ���
-- Ʈ���Ű� ����˴ϴ�.
begin 
    
    if updating then
        insert into trigger_dept_backup
        values(
--            --���̺�(����) ���� Ʈ���ſ����� �ӽ����̺��� ����� ���� ����. 
--            :old.department_id,
--            :old.department_name,
--            :old.manager_id,
--            :old.location_id
               999, to_char(sysdate,'yyyy-mm-dd hh24:mi:ss'),99,99
            );
    end if;
end;
/
    
update trigger_dept_original set department_name='5��������Ʈ2'
    where department_id>=10 and department_id<=50;
-- 5���� ���ڵ带 ������Ʈ ������, ���̺���� Ʈ�����̹Ƿ� �Ѱ��� �Էµ˴ϴ�.    
    
select * from trigger_dept_original;
select * from trigger_dept_backup;


--Ʈ���� �����ϱ�
drop trigger  trigger_update_test;
drop trigger  trigger_update_test2;
