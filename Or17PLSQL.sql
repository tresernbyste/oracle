/************************   hr ����
���ϸ�: Or17 PLSQL
���� : ����Ŭ���� �����ϴ� ���α׷��־��
************************/

--PLSQL :  Procedural Language
--�Ϲ� ���α׷��� ���� ������ �ִ� ��Ҹ� ��� ������ ������ DB������ ó���ϱ� ���� ����ȭ�� ����̴�.

/* 
- ����1. PL/SQL ������
- ȭ��� ������ ����ϰ� ������ on���� �����Ѵ�.
- off �϶��� ��µ����ʴ´�.
*/

set serveroutput on; 

declare                             --����� �ַ� ������ ���� 
    cnt number;                     -- ����Ÿ���� ������ ���� 
begin                               --����� begin ~ end ���� ������ ���� ������ ����Ѵ�.
    cnt := 10;                      --������ 10�� �����Ѵ� (�ڹ��� �ʱ�ȭ) ���Կ�����  := �� ��� 
    cnt := cnt + 1;                 --���մ��Կ����� ���� ��� 
    dbms_output.put_line(cnt);      -- java�� println()�� ������ ����
end;
/

/*
PL/SQL ������ ������ /�� �ٿ����ϴµ� 
       ���� ������ ȣ��Ʈȯ������ ���������� ���Ѵ�. 
       ��, PL/SQL ������ ���� �ʿ��մϴ�.
       ȣ��Ʈȯ���̶�, query���� �Է��ϱ����� SQL>  ���¸� ���մϴ�.
*/
/*
���� 2 �Ϲݺ��� �� into
*/
--������̺��� �����ȣ�� 120�� ����� �̸��� ����ó�� ����ϴ� PL/SQL���� �ۼ��Ͻÿ� 

select * from employees where employee_id=120;

select concat(first_name||' ', last_name), phone_number
from employees where employee_id=120;

declare --�����
    empName varchar2(50);       --����ο��� ������ �����Ҵ�� ���̺�����ÿ� �����ϰ� �����Ѵ�.
    empPhone varchar2(30);      --������ �ڷ���(ũ��) ��, ������ ������ �÷��� Ÿ�԰� ũ�⸦ �����Ͽ� �������ִ� ���� ����.
begin  --����� : select������ ������ ����� ����ο��� ������ ������ 1:1�� �����Ͽ� ���� �����Ѵ�. �̶� into�� ����Ѵ�.
    select 
        concat(concat(first_name,' '),last_name),phone_number
    into
        empName, empPhone
    from employees
    where employee_id=120;
    
    dbms_output.put_line(empName || ' '|| empPhone);
end;
/











--����3. �������� (�ϳ��� �÷�����)
--�������� : Ư�����̺��� �÷��� �����ϴ� �����μ� ������ �ڷ����� ũ��� �����ϰ� ������ ����Ѵ�.
-- ���� : ���̺��.�÷��� %tpye
--        ���̺���  '�ϳ�'�� �÷��� �����մϴ�.
/*
�μ���ȣ 10�� ����� �����ȣ,�޿�, �μ���ȣ�� �����ͼ� �Ʒ� ������ ������ ȭ��� ����ϴ� PL/SQL���� �ۼ��Ͻÿ�.
��, ������ �������̺��� �ڷ����� �����ϴ� '��������'�� �����Ͻÿ�

�ó������� ���ǿ� �´� select���� �ۼ��� �Ŀ� �����Ѵ�.
*/
select employee_id, salary, department_id from employees     --�����ȣ, �޿�, �μ���ȣ�� ������̺�κ��� �ҷ����µ�
    where department_id =10;                                 --�μ���ȣ�� 10�� ����� ������ 
    
declare                                             --����� 
    empNo employees.employee_id%type;               --������̺��� �����ȣ�� �����ؿ��ڴ�  number(6,0)
    empSal employees.salary%type;                   --������̺��� �޿��� ������ �ڷ����� ũ��� �����ؿ��ڴ�.number(8,2)
    deptId employees.department_id%type;            --������̺��� �μ���ȣ�� �ڷ����� ũ��� �����ؿ��ڴ�. number(4,0)
begin  --select�� ����� into�� ���� ������ ������ �Ҵ��Ѵ�.
    select employee_id, salary, department_id
        into empNo, empSal,deptId
    from employees
    where department_id = 10;
    
    dbms_output.put_line(empNo || ' ' || empSal || ' '|| deptId);
end;
/

--����4 ��������2 
--  ��ü�÷��� �����ϴ� ���
--�����ȣ�� 100�� ����� ���ڵ带 �����ͼ� emp_row������ ��ü�÷��� ������ �� ȭ�鿡 ���� ������ ����Ͻÿ�.
--��, emp_row�� ������̺��� ��ü�÷��� ������ �� �ִ� ���������� �����ؾ��Ѵ�. 
--������� : �����ȣ, �̸�, �̸���, �޿�

select * from employees where employee_id = 100;

declare   --������̺� ��ü �÷��� �����ϴ� ���������� �����Ѵ�. �� �� ���̺�� �ڿ� %rowtype�� ���� �����Ѵ�.
    
    emp_row employees%rowtype;
begin 
    select * into emp_row
    from employees where employee_id =100;
    
    dbms_output.put_line(emp_row.employee_id || ' '|| emp_row.first_name||' '||emp_row.last_name|| emp_row.email||' '|| emp_row.salary);
end;
/

--����5 ���պ��� 
-- : class�� �����ϵ� �ʿ��� �ڷ����� ���� �ϳ��� �ڷ����� ���� �� �����ϴ� ������ ���Ѵ�. 
-- ���� : tpye �����ڷ��� is recode ( �÷�1 �ڷ��� (ũ��), �÷�2 ���̺��.�÷���%type );
-- �տ��� ������ �ڷ����� ������� ������ �����Ѵ�. 
-- ���պ��� �ڷ����� ���鶧�� �Ϲݺ����� �������� 2������ �����ؼ� ����� �� �ִ�.

--@@@@
--�����ȣ, �̸�(first_name+last_name), ���������� ������ �� �ִ� ���պ����� ������ ��, 100�� ����� ������ ����ϴ� PL/SQL�� �ۼ��Ͻÿ�.

select employee_id, first_name||' '||last_name, job_id
from employees where employee_id=100;

declare
    type emp_3type is record(
        emp_id employees.employee_id%type,
        emp_name varchar2(60),
        emp_job employees.job_id%type
        );
        record3 emp_3type;
--        �տ��� ������ ���պ��� �ڷ����� ���� ������ ���պ����� 3���� ���� ������ �� �ִ�.
begin           -- select������ ������ 3���� ���� ���պ����� �����Ѵ�.
    select employee_id, first_name||' '||last_name, job_id
        into record3
    from employees where employee_id=100;
    -- ��½� ���պ��� �ڷ����� �÷��� ����մϴ�. record3.emp~
    dbms_output.put_line(record3.emp_id||' '||
                        record3.emp_name||' '||
                        record3.emp_job);
end;
/


/*
�Ʒ� ������ ���� PL/SQL���� �ۼ��Ͻÿ�.
1.���պ�������
- �������̺� : employees
- ���պ����ڷ����� �̸� : empTypes
        ���1 : emp_id -> �����ȣ
        ���2 : emp_name -> �������ü�̸�(�̸�+��)
        ���3 : emp_salary -> �޿�
        ���4 : emp_percent -> ���ʽ���
������ ������ �ڷ����� �̿��Ͽ� ���պ��� rec2�� ������ �����ȣ 100���� ������ �Ҵ��Ѵ�.
2.1�� ������ ����Ѵ�.

3.�� ������ �Ϸ����� ġȯ�����ڸ� ����Ͽ� �����ȣ�� ����ڷκ��� �Է¹��� �� �ش� ����� ������ ����Ҽ��ֵ��� �����Ͻÿ�
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
    
    dbms_output.put_line('�����ȣ / ����� / �޿� / ���ʽ��� ');
    dbms_output.put_line(rec2.emp_id || ' '|| rec2.emp_name||' '|| rec2.emp_salary|| rec2.emp_percent);
end;
/


/* @@@@@@@@@@@@@@@@@@@@@@@@@
ġȯ������ : PL/SQL ���� ����ڷκ��� �����͸� �Է¹��� �� ����ϴ� �����ڷ� 
             �����տ� &(and)�� �ٿ��ָ� �ȴ�. ����� �Է�â�� ���. (Scanner, system in �� ���� �Է������� ���๮�� ��) 
*/
--3. �տ��� �ۼ��� PL/SQL���� 
--   ġȯ�����ڸ� ����Ͽ� �����ȣ�� ����ڷκ��� �Է¹����� �ش� ����� ������ ����� �� �ֵ��� �����Ͻÿ�.


declare
    type emp_Types is record(
        emp_id employees.employee_id%type,
        emp_name varchar2(60),
        emp_salary employees.salary%type,
        emp_percent employees.commission_pct%type
        );
        rec2 emp_Types;
        -- ġȯ�����ڸ� ���� �Է¹��� ���� �Ҵ��Ͽ� ������ �����Ѵ�.
        inputNum number(3);
        
begin 
    -- �Է¹��� �����ȣ�� ������ �����Ѵ�.
    select employee_id, first_name||' '||last_name, salary, nvl(commission_pct,0)
        into rec2
    from employees where employee_id =  &inputNum;
    
    dbms_output.put_line('�����ȣ / ����� / �޿� / ���ʽ��� ');
    dbms_output.put_line(rec2.emp_id || ' '|| rec2.emp_name||' '|| rec2.emp_salary|| rec2.emp_percent);
end;
/

----------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------

/*
���ε庯�� 
    : ȣ��Ʈȯ�濡�� ����� �����ν� �� PL/SQL �����̴�. 
      ȣ��Ʈȯ���̶� PL/SQL�� ���� ������ ������ �κ��� ���Ѵ�.
      �ܼ�(CMD)������ SQL> ���������Ʈ�� �ִ� ���¸� ���մϴ�.  ## declare�� ��� ȯ�� = ȣ��Ʈȯ��

���� : 
        var ������ �ڷ���;
        Ȥ�� 
        variable ������ �ڷ���;
*/

set serveroutput on;

var return_var number; -- ���ε庯�� declare��

declare                --  PL/SQL �� ����  ����ο� �ƹ������� ���� ���� ���� 
begin 
                       -- ���ε� ������ �Ϲݺ������� ���̰�??
    :return_var := 999;
    dbms_output.put_line(:return_var);
end;
/

print return_var;

----------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------


--����7 ��� (���ǹ� : if)
-- ������ ����� ���ڰ� Ȧ�� or ¦������ �Ǵ��ϴ� PL/SQL�� �ۼ��Ͻÿ� 
-- if then if elsif then
declare                                         --����ο��� ����Ÿ���� ������ ����
    num number;                                 
begin
    num := 10;
    
    if mod(num,2) = 0 then
        dbms_output.put_line(num || '�� ¦��');
    else
        dbms_output.put_line(num || '�� Ȧ��');
    end if;
end;
/
-- �� ������ ġȯ�����ڸ� ���� ���ڸ� �Է¹��� �� �ֵ��� �����Ͻÿ� 

declare                                         
    num number;             -- num ���� ����
    inputNum number;        -- ġȯ���꿡 ���� ������ ���� 
   
begin
    num := &inputNum;           -- num ������ ġȯ���꿡 ���� ������ ����
     
    if mod(num,2) = 0 then
        dbms_output.put_line(num || '�� ¦��');
    else
        dbms_output.put_line(num || '�� Ȧ��');
    end if;
end;
/

--�����ȣ�� ����ڷκ��� �Է¹��� �� �ش� ����� ��μ�����
--�ٹ��ϴ����� ����ϴ� PL/SQL���� �ۼ��Ͻÿ�. ��, if~elsif���� ����Ͽ� �����Ͻÿ�.


declare
    emp_id employees.employee_id%type := &emp_id;
    emp_name varchar2(50);
    emp_dept employees.department_id%type;
    dept_name varchar2(30) := '�μ���������';    -- �μ����� �ʱ�ȭ ���� ����
begin
    select employee_id, last_name, department_id
        into emp_id, emp_name, emp_dept
    from employees
    where employee_id = emp_id;
    
    
    -- �������� ������ ����� ��� �ڹٿ� ���� else if �� ��������ʰ�  elsif �� ����ؾ��մϴ�. 
    -- �߰�ȣ ��� then�� end if�� ���˴ϴ�. 
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
    
    dbms_output.put_line('�����ȣ'|| emp_id || '�� ����');
    dbms_output.put_line('�̸�:' || emp_name || ', �μ���ȣ: ' || emp_dept || ' , �μ���:'|| dept_name);
end;
/
    
----------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------

--����9 ��� ( ���ǹ� : case~when ) 
-- �տ��� if~elsif�� �ۼ��� PL/SQL���� case~when������ �����Ͻÿ� 

declare
    emp_id employees.employee_id%type := &emp_id;
    emp_name varchar2(50);
    emp_dept employees.department_id%type;
    dept_name varchar2(30) := '�μ���������';    -- �μ����� �ʱ�ȭ ���� ����
begin
    select employee_id, last_name, department_id
        into emp_id, emp_name, emp_dept
    from employees
    where employee_id = emp_id;
    
    -- case~when ���� if���� �ٸ����� �Ҵ��� ������ ���� ������ �� ���峻���� ������ �Ǵ��Ͽ�
    --    if���� ���̴� ��ó�� �Ź� �Ǵ����� �ʾƵ� �ȴ�. 
    
    dept_name :=
        case emp_dept
            when 50 then 'Shipping'
            when 60 then 'IT'
            when 70 then 'Public Relations'
            when 80 then 'Sales'
            when 90 then 'Excutive'
            when 100 then 'Finance'
        end;    
    dbms_output.put_line('�����ȣ'|| emp_id || '�� ����');
    dbms_output.put_line('�̸�:' || emp_name || ', �μ���ȣ: ' || emp_dept || ' , �μ���:'|| dept_name);
end;
/

----------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------

--��� (  �ݸ� : loop  )

--1. basic loop  : �ڹ��� do while ���� ���� ���� Ȯ�� ���� loop������ �� Ż�������� �ɶ� ���� �ݺ��մϴ�.
--                  Ż��ÿ��� exit�� ����մϴ�.


-- ����Ȯ�ξ���  ������ �����Ѵ�.
-- 0~10���� ����Ѵ�. ����������, ���մ��Կ����ڰ� �����Ƿ� �Ϲ����� ������� ������ �������Ѿ��Ѵ�. 
-- num�� 10�� �ʰ��ϸ� loop���� Ż���մϴ�.  Ż������ exit when ( java break;) �� ������ ����
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
-- basic loop ������ 1���� 10������ ������ ���� ���ϴ� ���α׷��� �ۼ��Ͻÿ� 

declare 
    i number := 1;
    sunNum number := 0;
begin 
    loop
        sunNum := sunNum + i;
        i := i + 1;
        exit when ( i > 10);
    end loop;
    dbms_output.put_line('1~10������ ���� : '|| sunNum);
end;
/

---------------------------------------------------------------------------------

--2. while loop 
--    : ������ ���� Ȯ���� �� �����Ѵ�.
--    ��, ���ǿ� ���� �ʴ´ٸ� ���ѹ��� ������� ���� �� �ִ�.
--    �ݺ��� ������ �����Ƿ� Ư���� ��찡 �ƴ϶�� exit�� ������� �ʾƵ� �˴ϴ�.

-- ��� ( �ݺ��� : while )

declare
    num1 number := 0;
begin
    while num1<11 loop
        dbms_output.put_line( '�̹����ڴ�:' || num1);
        num1 := num1 + 1;
    end loop;
end;
/

-- ���� ��� ( �ݺ��� : while loop ����� )
declare
    starStr varchar2(100);
    i number := 1;
    j number := 1;

begin       -- ��, �� ������ ���⶧���� i �����϶� ���� �� ���� �Ѿ�� �ְ� �������Ѵ� 
            -- �ڹ� �ʹ� �ٸ��� ������ �࿭������ ���� �̷������� ǥ��������Ѵ�. 
            
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

--��� ( �ݺ��� : while loop )
-- while loop������ 1���� 10������ ������ ���� ���ϴ� ���α׷��� �ۼ��Ͻÿ�. 

declare
    i number := 1;
    sunNum number := 0;
begin 
    while i<= 10 loop           -- i�� 10 �����϶��� �����ؼ� �����ش�..
        sunNum := sunNum + i;
        i := i + 1;
    end loop;
    dbms_output.put_line('1~10������ ����:'||sunNum);
end;
/

-- ��� ( �ݺ��� : for�� )
--    : �ݺ��� Ƚ���� �����Ͽ� ����� �� �ִ� �ݺ������� �ݺ��� ���� ������ ������ �������� �ʾƵ� �ȴ�. 
--      �׷��Ƿ� Ư���� ������ ������ �����( declare ) �� ������� �ʾƵ� �ȴ�. 

declare  -- ����� ���� ���� 
begin
    for num2 in 0 .. 10 loop
        dbms_output.put_line( 'for �� ¯�ε�: ' || num2);
    end loop
end;
/

-- Ư���ϰ� ����ΰ� �ʿ������ʱ⶧���� ����� ( declare ) �� ������� ����.
begin 
    for num3 in reverse 0 .. 10 loop
        dbms_output.put_line( '�Ųٷ� for��¯�ε�:' || num3);
    end loop;
end;
/


-- ��� ( �ݺ��� : for ������ )
-- for loop ������ �������� ����ϴ� ���α׷��� �ۼ��Ͻÿ� 

begin                                                               -- 2~9�� ���� �ݺ�
    for dan in 2..9 loop                                        
        dbms_output.put_line(dan||'��');                            -- �����
        for su in 1..9 loop                                         -- 1~9���� �ݺ�
            dbms_output.put_line(dan||'*'||su||'='||(dan*su));      -- �������� ��� ��� �� �ٹٲ� ó�� 
        end loop;
    end loop;
end;
/

declare
    guguStr varchar2(1000);  -- �迭ó�� �ϳ��� ���� �����ϱ� ���� ���� 
begin
     for dan in 2..9 loop
       
        for su in 1..9 loop
           guguStr := guguStr || dan||'*'||su||'='||(dan*su) || ' ';   -- ���ڿ��� ���������� �������� �迭�� ���� �ܿ� ���� �ٹٲ޾��� ���������Ŵ
        end loop;
        dbms_output.put_line(guguStr);
        guguStr := '';     -- �ϳ��� ���� ������ ������ �Ǹ� ���� ������ �Ѿ�� for���� �������� ������ �ʱ�ȭ�����ش�
    end loop;
end;
/
-- �ܰ� ���� �ٲ㼭 �࿭�� ��ȯ��Ŵ
declare
    guguStr varchar2(1000);  -- �迭ó�� �ϳ��� ���� �����ϱ� ���� ���� 
begin
     for su in 2..9 loop
       
        for dan in 1..9 loop
           guguStr := guguStr || dan||'*'||su||'='||(dan*su) || ' ';   -- ���ڿ��� ���������� �������� �迭�� ���� �ܿ� ���� �ٹٲ޾��� ���������Ŵ
        end loop;
        dbms_output.put_line(guguStr);
        guguStr := '';     -- �ϳ��� ���� ������ ������ �Ǹ� ���� ������ �Ѿ�� for���� �������� ������ �ʱ�ȭ�����ش�
    end loop;
end;
/


---------------------------------------------------------------------------------
---------------------------------------------------------------------------------
----Cursor ----------------------------------------------------------------------

/*
Cursor Ŀ�� 
 : select ���忡 ���� �������� ��ȯ�Ǵ� ��� �� �࿡ �����ϱ� ���� ������ �ݺ���ü
 
�������� 
    :  Cursor Ŀ���� is    
            select ������ ��, into ���� ���� ���·� ����մϴ�.
    
    Open Cursor 
        : ������ �����϶�� �ǹ�, ��, Open�Ҷ� Cursor����� select������ ����Ǿ� ������� ��� �˴ϴ�.
          Cursor�� �� ������� ù��° �࿡ ��ġ�ϰ� �˴ϴ�. 
    
    Fetch ~ into ~ 
        : ����¿� �ϳ��� ���� �о�帮�� �۾����� ������� ����(Fetch)�� �Ŀ� Cursor�� ���� ������ �̵��Ѵ�.
        
    Close Cursor
        : Ŀ�� �ݱ�� ������� �ڿ��� �ݳ��Ѵ�.select������ ��� ó���� �� Cursor�� �ݾ��ش�.

    Cursor�� �Ӽ� 
        &Found : ���� �ֱٿ� ����(Fetch) ���� Return�ϸ� True,
                    �ƴϸ� False�� ��ȯ�մϴ�.
                    
        &NotFound : &Found �ݴ��� ���� ��ȯ�Ѵ�.
        &RowCount : ���ݱ��� Return �� ���� ������ ��ȯ�մϴ�.       
*/

-- Cursor 
-- �μ����̺��� ���ڵ带 Cursor�� ���� ����ϴ� PL/SQL���� �ۼ��Ͻÿ� 

declare
    v_dept departments%rowtype;
    cursor cur1 is 
        select
            department_id, department_name, location_id
        from departments;
begin
    /*
    �ش� �������� �����ؼ� ������� �����´�. ������̶� �������� �����ϰ� ���ƿ��� �����.
    */
    open cur1;
    -- basic ���������� ���� ������� ������ŭ �ݺ��Ͽ� �����Ѵ�.
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
-- Cursor�� ����Ͽ� ������̺��� Ŀ�̼��� null�� �ƴ� ����� �����ȣ, �̸�, �޿��� ����Ͻÿ�.
-- ��½ÿ��� �̸��� ������������ �����Ͻÿ�.

--������ ���ǿ� �´� �������ۼ�
select employee_id, last_name, salary from employees where commission_pct is not null order by last_name;


declare 
    -- �ۼ��� ������ ���� Ŀ���� �����մϴ�.
    cursor curEmp is
        select employee_id, last_name, salary
        from employees
        where commission_pct is not null
        order by last_name asc;
        -- ������̺��� ��ü�÷��� �����ϴ� �������� ����
    varEmp employees%rowType;    -- rowType ���� Ÿ�԰���

begin
    --Ŀ������ �����Ͽ� �������� �����մϴ�
    open curEmp;
    --basic loop���� ���� Ŀ���� ����� ������� �����մϴ�.(���ǰ������)
    loop
        fetch curEmp            -- fetch ����¿��� �ϳ��� ���� �����´ٴ°�
            into varEmp.employee_id, varEmp.last_name, varEmp.salary;
            --������ ������� ������ loop���� Ż���Ѵ�.
        exit when curEmp%notfound;
        dbms_output.put_line(varEmp.employee_id ||' '||
                             varEmp.last_name||' '||
                             varEmp.salary);
    end loop;
    --Ŀ���� ���� Ƚ�� Ȯ��
    dbms_output.put_line('��������ǰ���: '|| curEmp%rowcount);
    --Ŀ���ݾ��ֱ�
    close curEmp;
end;
/

---------------------------------------------------------------------------------
---------------------------------------------------------------------------------
---- Collection  ----------------------------------------------------------------

/*
�÷���(�迭)
    : �Ϲ� ���α׷��־��� ����ϴ� �迭Ÿ�� PL/SQl������ ���̺�Ÿ�� �̶���Ѵ�.
     1, 2 ���� �迭�� �����غ��� ���̺�(ǥ)�� ���� �����̱⶧���̴�. 

    ���� : �����迭 Varray ��ø���̺� 

    
    1. �����迭 ( Associative Array)
        : Key �� Value �� �� ������ ������ �÷������� �ڹ���  Hash map �� ���� ����
          Key : �ڷ����� �ַ� ���ڸ� ����մϴ�. binary_integer, pls_integer�� �ַ� ����ϴµ� numberŸ�Ժ��� ũ��� ������ ������꿡 ���� Ư¡�� ������.
          Value : �������� �ַ� ����մϴ�. varchar2�� ����ϸ� �ȴ�.
          
        ���� : Type �����迭�ڷ��� is
                table of ���� Ÿ�� 
                    index by Ű�� Ÿ��;
    2. Varray 
        :  ���� ���̸� ���� �迭�� �Ϲ� ���α׷��� ���� ����ϴ� �迭�� �����ϴ�.
           ũ�⿡ ������ �־ ������ �� ũ��(�����ǰ���)�� �����ϸ� �̺��� ū �迭�� ����� ����.( ���� ������ �����Ұ�??)
        ���� : Type �迭Ÿ�Ը� Is
                Array(�迭ũ��) Of ���� Ÿ��;
     
    3. ��ø���̺� ( Nested table )
        :  Varray�� ����� ������ �迭�ν� �迭�� ũ�⸦ ������� �����Ƿ� �������� �迭�� ũ�Ⱑ �����ȴ�.
           ���⼭ ���ϴ� ���̺��� �ڷᰡ ����Ǵ� ���� ���̺��� �ƴ϶� �÷����� �� ������ �ǹ��Ѵ�.
        ���� : Type ��ø���̺�� Is
                Table Of ���� Ÿ��;
*/



--�����迭  Associative Array
--������ ���ǿ� �´� �����迭�� ������ �� ���� �Ҵ��Ͻÿ�.
--    �����迭 �ڷ��� �� : avType, �����ڷ���:������, Ű���ڷ���:������
--    key : girl, boy
--    value : Ʈ���̽�, ��ź�ҳ��
--    ������ : var_array

--ȭ��� ������ ����ϰ� ������ on���� �����Ѵ� off �϶��� ��µ����ʴ´�.
set serveroutput on;
--PL/SQL

declare
    --�����迭�ڷ��� �ۼ�
    Type avType Is
        Table Of varchar2(30) -- value  �� �ڷ��� ����
        Index By varchar2(10);--  key  �� �ڷ��� ����
    -- �����迭 Ÿ���� ������ �����մϴ�.
    var_array avType;
begin
    --�����迭�� ���� ���⼭ �Ҵ��Ѵ�.  girl���� Ʈ���̽� Ű��
    var_array('girl') := 'Ʈ���̽�';
    var_array('boy') := '��ź�ҳ��';
    
    dbms_output.put_line(var_array('girl'));
    dbms_output.put_line(var_array('boy'));
end;
/

-- �����迭(Associative Array)
--  100�� �μ��� �ٹ��ϴ� ����� �̸��� �����ϴ� �����迭�� �����Ͻÿ�.   
--   key�� ����, value�� full_name ���� �����Ͻÿ�.

select * from employees where department_id = 100;

select first_name||' '||last_name
    from employees where department_id = 100;

--������ ������ ���� �������� �ټ����� ����Ǿ����Ƿ� Cursor�� ����մϴ�.    
declare
    -- �������� ���� Ŀ���� �����մϴ�.
    cursor emp_cur is
        select first_name||' '||last_name from employees
        where department_id = 100;
    -- �����迭�ڷ��� ����( Ű- ������ ��-������ ) 
    Type nameAvType Is
        Table Of varchar2(30)
        Index By binary_integer;
        
    -- �ڷ����� ������� ������ �����մϴ�. 
    names_arr nameAvType;
    -- ����� �̸��� �ε����� ����� ���� ���� 
    fname varchar2(50);
    idx number := 1;

begin  
    --Ŀ���� �����ش�.���� ������� ������ŭ �ݺ��Ͽ� ������� �����մϴ�.
    open emp_cur;
    loop
        fetch emp_cur into fname;
        -- ���̻� ������ ������ ���ٸ� loop�� Ż���Ѵ�. 
        exit when emp_cur%notfound;
        -- �����迭 ������ ����̸��� �Է��մϴ�.
        names_arr(idx) := fname;
        -- Ű�� ���� �ε����� ������Ų��. 
        idx := idx + 1;
    end loop;
    
    close emp_cur;
    -- �����迭.count : �����迭�� ����� ������ ������ŭ ��ȯ�մϴ�. 
    for i in 1 .. names_arr.count loop
        dbms_output.put_line(names_arr(i));
    end loop;
end;
/

--  VArray (Variable Array)

declare 
    -- Varray Ÿ�� ���� : ũ��� 5, ������ �����ʹ� ���������� �����Ѵ�.
    type varType is 
        array(5) of varchar2(20);
    -- Varray�� �������� 
    v_arr varType;
    -- �ε����� ����� �������� �� �ʱ�ȭ 
    cnt number := 0;
    
    
begin
    --�����ڸ� ���� ���� �ʱ�ȭ v_arr�� ���� �־��ִ°�. 5���� 3���� �Ҵ��Ѵ�. 2���� null?
    v_arr := varType('First','Second','Third','','');
    
    --basic loop���� ���� �迭�� ���Ҹ� ����Ѵ�. �ε����� 1���� �����̴�. 
    loop
        cnt := cnt + 1;  -- �ε����� 1���� �����ϱ⶧���� ������ �̸� 1�� ������ִ� �۾�!
        -- Ż�������� where ��� if�� ����� �� �ִ�.
        -- 5���ϸ� ��� �� if
        if cnt>5 then
            exit;
        end if; 
        --�迭ó�� �ε����� ���ؼ� ����Ѵ�. 1 2 3 4 5 
        dbms_output.put_line(v_arr(cnt));
    end loop;
    
    -- �迭�� ���� ���� �����ϴ� ��.
    v_arr(3) := '�츮��';
    v_arr(4) := 'JAVA';
    v_arr(5) := '�����ڴ�';
    
    -- for loop������ ����Ѵ�.
    for i in 1 .. 5 loop
        -- ��� 1 2 3 4 5 12���� ������ �̹� ������ first second �� �ְ� 345 ���� ������ �ٷ� ������ �츮�� java�����ڴٰ� ���� ��
        dbms_output.put_line(v_arr(i));
    end loop;
end;
/
 
--VArray(Variable Array)
--  100�� �μ��� �ٹ��ϴ� ����� �����ȣ�� �����Ͽ� VArray�� ������ ����ϴ� PL/SQL�� �ۼ��Ͻÿ�.

select * from employees where department_id =100;

declare    
    -- Varray �ڷ��� ����, �迭�� ����� ���� ������̵� �÷��� �����Ͽ� �����Ѵ�. 
    type vaType1 is
        array(6) of employees.employee_id%Type;
    --�迭 ���� ���� �� �����ڸ� ���� �ʱ�ȭ�� �Ѵ�.
    va_one vaType1 := vaType1('','','','','','');
    cnt number := 1;
    
begin
    -- Java�� ���� for���� ����ϰ� ������ ����� ������ŭ �ڵ����� �ݺ��ϴ� ���·� ����Ѵ�. 
    -- select ���� employee_id�� ����i �� �Ҵ�ǰ� �̸� ���� ������ �� �ִ�.
    for i in (select employee_id from employees where department_id = 100) loop
        --������ ������ �����ȣ �� �迭�� ������� �����Ѵ�.
        va_one(cnt) := i.employee_id;
        cnt := cnt + 1;
    end loop;
        dbms_output.put_line(cnt);
    -- �迭�� ũ�⸸ŭ �ݺ��Ͽ� �� ���Ҹ� �����Ѵ�. 
    for j in 1 .. va_one.count loop
        dbms_output.put_line(va_one(j));
    end loop;
end;
/

--��ø���̺� ( Nested table )

declare 
    type ntType is
        -- ���̺�ũ�⸦ �������� �ʰ� �ڷ����� ����
        table of varchar2(30);
    nt_array ntType;
begin
    -- �����ڸ� ���� ���� �Ҵ��Ѵ�. �̶� ũ�� 4�� ��ø���̺��� �����ȴ�.
    nt_array := ntType('ù��°','�ι�°','����°','');
    
    dbms_output.put_line(nt_array(1));
    dbms_output.put_line(nt_array(2));
    dbms_output.put_line(nt_array(3));
    nt_array(4) := '�׹�°���Ҵ�';
    dbms_output.put_line(nt_array(4));
    -- ��������� �迭�� ũ��� 4�̱� ������ 5��° �ε��� ������ ���������ʰ� �ڵ����� Ȯ������� �ʴ´�. �����߻�
--    nt_array(5) := '�ټ���°��??�Ҵ�??';

    -- ũ�⸦ Ȯ���Ҷ� �����ڸ� ���� �迭�� ũ�⸦ �������� Ȯ���մϴ�. �����ڸ� ���� ũ��Ȯ�� ����    
    nt_array := ntType('1a','2b','3c','4d','5e','6f','7g');
    
    for i in 1 .. 7 loop
        dbms_output.put_line(nt_array(i));
    end loop;
end;
/

--��ø���̺�(Nested Table) 
--��ø���̺�� for���� ���� ������̺��� ��ü ���ڵ��� �����ȣ�� �̸��� ����Ͻÿ�.

declare
    --��ø���̺��� �ڷ��� ���� �� ���� ���� : ������̺� ��ü �÷��� �����ϴ� ���������� �����̹Ƿ�
    --�ϳ��� ���ڵ�(Row)�� ������ �� �ִ� ���·� ����ȴ�.
    type ntType is
        table of employees%rowtype;
    nt_array ntType;
begin
    -- ũ�⸦ �������� �ʴ� ���·� �����ڸ� ���� ��ø���̺��� �ʱ�ȭ �Ѵ�.
    nt_array := ntType();
    --������̺��� ���ڵ� �� ��ŭ �ݺ��ϸ鼭 ���ڵ带 �ϳ��� ���� rec�� �����մϴ�.(for ������ ������ �������� �ʰ� �ٷ� ��밡��!)
    -- ��
    for rec in (select * from employees order by employee_id desc) loop
        --��ø���̺��� ���κ��� Ȯ���ϸ鼭 null�� �����մϴ�.
        nt_array.extend;
        -- ������ �ε��� ���� ���� �� ������� ���ڵ带 �����Ѵ�.
        nt_array(nt_array.last) := rec;
    end loop;
    -- ��ø���̺��� ù��° �ε������� ������ �ε������� ����մϴ�.
    for i in nt_array.first .. nt_array.last loop
        --�����ȣ�� �̸��� ����Ѵ� for i =  .first~.last����~
        dbms_output.put_line (nt_array(i).employee_id || '>' || nt_array(i).first_name);
    end loop;
end;
/
    









