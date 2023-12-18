/************************HR����
���ϸ�: Or06TypeConvert
����ȯ �Լ� /  ��Ÿ�Լ�
���� : ������ Ÿ���� �ٸ�Ÿ������ ��ȯ�ؾ� �� �� ����ϴ� �Լ��� ��Ÿ �Լ� 
************************/

--sysdate : ���� ��¥�� �ð��� �ʴ����� ��ȯ���ش�. 
--�ַ� �Խ����̳� ȸ�����Կ��� ���ο� �Խù��� ���� �� �Է��� ��¥�� ǥ���ϱ����� ���˴ϴ�.

select sysdate from dual;

-- ��¥ ���� : ����Ŭ�� ��ҹ��ڸ� �������������Ƿ� ���Ĺ��� ���� ���������ʴ´�. 



-- ���� mm�� MM�� ������ ����� ����Ѵ�.
-- ���Ĺ��ڸ� ���δ°� �ƴԿ� ���� �ؾ��մϴ�.
-- ������ ������ ���� ���ڴ� �ν����� ���ϹǷ� ���Ĺ��ڸ� ������ ������ ���ڿ��� ��.���� ��������Ѵ�.
--���� ��¥�� '������ 0000�� 00�� 00�� �Դϴ�.' �� ���� ���·� ����Ͻÿ� 
select to_char(sysdate   , 'yy-mm-dd') from dual;
select to_char(sysdate, '"������" yyyy"��" mm"��" dd"�� �Դϴ�."') from dual;   --@@@@
select to_char(sysdate, 'yyyy/mm/dd') from dual;

--�����̳� �⵵�� ǥ���ϴ� ���Ĺ��ڵ� 
select to_char(sysdate,'day')"day",  -- just day ����� ���� ��¥ 
 to_char(sysdate,'dy')"dy",  
 to_char(sysdate,'mon')"mon",  
 to_char(sysdate,'mm')"mm",   
 to_char(sysdate,'month')"month", 
 to_char(sysdate,'yy')"yy",    
 to_char(sysdate,'dd')"dd" ,
 to_char(sysdate,'ddd')"dd" from dual;

--������̺��� ����� �Ի����� ������ ���� ����� �� �ֵ��� �����������Ͽ� �������� �ۼ��Ͻÿ� 

--0000�� 00�� 00�� 0����

select first_name, last_name, hire_date,salary,
to_char(hire_date, 'yyyy"��" mm"��" dd"��" dy"����"')�Ի��� from employees order by hire_date;

--�ð� ���� : ����ð��� 00:00:00 ���·� ǥ���ϱ�
--  �Ǵ� ��¥�� �ð��� ���ÿ� ǥ���� ���� �ִ�.

select
to_char(sysdate, 'HH:MI:SS')A, 
to_char(sysdate, 'hh24:mi:ss')B ,
to_char(sysdate, 'hh:mi:ss')C ,
to_char(sysdate, 'YYYY--MM--DD hh24:mi:ss')D ,
to_char(sysdate, 'hh24:mi:ss')E ,
to_char(sysdate, 'hh24:mi:ss')F
from dual;

-- ���� ���� 
--   0 :  ������ �ڸ����� ��Ÿ���� �ڸ����� ���� �ʴ� ��� 0���� �ڸ��� ä���.
--   9 : 0�� ���������� �ڸ����� �����ʴ� ��� �������� ä���.

select 
    to_char(123,'0000'),
    to_char(123,'9999'),  -- 9�� �������� ����ϸ� ������ ����Ƿ� trim���� �����Ҽ��ִ�.
    trim(to_char(123,'9999'))  --���������� �����ϴ�
    from dual;


-- ������ 3�ڸ� ���� , ǥ���ϱ� 
--  �ڸ����� Ȯ���� ����ȴٸ� 0�� ����ϰ�, �ڸ����� �ٸ� �κп����� 9�� ����Ͽ� ������ �����Ѵ�. 
-- ��� ������ trim ���� �����ϸ�ȴ�. 

select 12345,
    to_char(12345, '000,000'), to_char(12345, '999,999'),
    ltrim(to_char(12345, '999,999')),    ltrim(to_char(12345, '990,000'))
    from dual;

-- ��ȭǥ�� L  ==> �� ���� �´� ��ȭ ǥ�ð� �ȴ� ������ ǥ�� 
select to_char(1000000,'L9,999,000') 
from dual;


-- ���� ��ȯ �Լ� 
-- to_number() : ������ �����͸� ���������� ��ȯ�Ѵ�.
-- �ΰ��� ���ڰ� ���ڷ� ��ȯ�Ǿ� ������ ����� ����Ѵ�.
select to_number('123')+to_number('456') from dual;  -- ���ڷ� �ٲ�� ������ ����

select to_number('123a')+to_number('456') from dual;  -- ���ڰ� �ƴ� ���ڰ� �����־� �����߻�

--��¥ ��ȯ �Լ�
-- to_date() : ������ �����͸� ��¥�������� ��ȯ�ؼ� ����Ѵ�.
-- �⺻������ ����� ������ �����ȴ�.

select
    to_date('2023-06-16')��¥�⺻����1, 
    to_date('20230616')��¥�⺻����2,
    to_date('2023/06/16')��¥�⺻����3 
from dual;

-- ��¥ ������ ����� ���� �ƴ� ��쿡�� ����Ŭ�� ��¥�� �ν����� ���Ͽ� ������ �߻��Ѵ�.
-- �� ���� ��¥������ �̿��� ����Ŭ�� �ν��� �� �ֵ��� ó���ؾ� �մϴ�.

select 
    to_date('16-06-2023') from dual;-- ����Ŭ�� ������ ��¥ ������ �ƴϱ� ������ �����߻� 
   
--@@ 2023-11-23 17:49:30 �� ���� ������ ���ڿ��� ��¥�� �ν��� �� �ֵ��� query���� �ۼ��Ͻÿ� 

select 
    to_date('2023-11-23 17:49:30') from dual; --���� 
    
--@@ ���ڿ��� �߶� ����Ѵ�.
select to_date('2023-11-23') from dual; -- �νİ���
-- substr �Լ��� ���ڿ��� ��¥�κи� �߶� to_date�� ���ڷ� ����Ѵ�.
select 
    substr('2023-11-23 17:49:30',1,10)���ڿ��ڸ���,     -- 1�������� 10���� ���
    to_date( substr('2023-11-17:49:30',1,10))
    from dual;
-- ��¥�� �ð��� ������ Ȱ���Ѵ�. 
select 
    to_date('2023-11-23  17:49:30','yyyy-mm-dd hh24:mi:ss')
from dual;

-- 2022/12/25 �� � �������� ��ȯ�Լ��� ���� ����ϱ�
-- ��, ���ڿ��� ���Ƿ� ������ �� ����.

select 
    to_date('2022/12/25')��¥����Ȯ��,
    to_char(sysdate, 'day')���ϼ���Ȯ��,
    to_char(to_date('2022/12/25'),'day')����
from dual;

--@@ ���ڿ� 2024�� 01�� 01�� �� � �������� 
select
    to_date('2024�� 01�� 01��','yyyy"��" mm"��" dd"��"'),
    to_char(to_date('2024�� 01�� 01��','yyyy"��" mm"��" dd"��"'),'day') 
    from dual;


--nvl() : null���� �ٸ� �����ͷ� �����ϴ� �Լ�    (�÷���, ��ü�� ��)
-- �̿� ���� ������ �ϸ� ��������� �ƴ� ��� �޿��� null�� ��µȴ٤�.
-- ���� ���� null�ķ��� ������ ó���� �ʿ��ϴ�.
select salary+commission_pct from employees;
-- null ���� 0���� ������ �� ������ �����ϹǷ� �������� ����� ��µ˴ϴ�.
select first_name, commission_pct, salary*nvl(commission_pct,0)
from employees;
--�������� �̷��� ������ 1+null = null  null���� ���갪�� 
--���� null�̱⶧���� null�� ������ �ʿ��� ��Ȳ�̶�� 0���� ������ ����


--decode java�� switch ���� ����� ������ �ϴ� �Լ��� ����ϰ� Ư������ �ش��ϴ� ��¹��� �ִ� ��� ����մϴ�.
-- dedcode(�÷���, ��1, ���1, ��2, ���2, �⺻��)
-- �������� �ڵ尪�� ���ڿ��� ��ȯ�Ͽ� ����Ҷ� ���� ���˴ϴ�. 

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
    110, 'Accountind','�μ��� Ȯ�ξȵ�')DP_ID
    from employees;


-- case Java��  if-esle���� ���� ������ �ϴ� �Լ� 
-- case when ����1 then��1   else �⺻��
--������̺��� �� �μ���ȣ�� �ش��ϴ� �μ����� ����ϴ� query���� case���� ���� 
--��ǥ ����  when else end

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
    else '�μ��� ����'
    end team_nameDP_ID  --  case �󸮾 ����
    from employees
    order by department_id;



/*************************
��������
*************************/
--scott�������� �����մϴ�.

/*
1. substr() �Լ��� ����Ͽ� ������� �Ի��� �⵵�� �Ի��� �޸� ����Ͻÿ�.
*/
select substr(hiredate,1,2) �Ի�⵵,substr(hiredate,4,2) �Ի�� from emp order by �Ի�⵵, �Ի��; 

/*
2. substr()�Լ��� ����Ͽ� 4���� �Ի��� ����� ����Ͻÿ�. 
��, ������ ������� 4���� �Ի��� ������� ��µǸ� �ȴ�.
*/
select ename, hiredate from emp where substr(hiredate,5,1) = 4;

/*
3. mod() �Լ��� ����Ͽ� �����ȣ�� ¦���� ����� ����Ͻÿ�.
*/
select empno, ename from emp where mod(empno,2)=0;

/*
4. �Ի����� ������ 2�ڸ�(YY), ���� ����(MON)�� ǥ���ϰ� ������ 
���(DY)�� �����Ͽ� ����Ͻÿ�.
*/


/*
5. ���� ��ĥ�� �������� ����Ͻÿ�. ���� ��¥���� ���� 1��1���� �� ����� 
����ϰ� TO_DATE()�Լ��� ����Ͽ� ������ ���� ��ġ ��Ű�ÿ�. 
��, ��¥�� ���´� ��01-01-2020�� �������� ����Ѵ�. 
�� sysdate - ��01-01-2020�� �̿Ͱ��� ������ �����ؾ��Ѵ�. 
*/


 
  



/*
6. ������� �޴��� ����� ����ϵ� ����� ���� ����� ���ؼ��� 
NULL�� ��� 0���� ����Ͻÿ�.
*/


/*
7. decode �Լ��� ���޿� ���� �޿��� �λ��Ͽ� ����Ͻÿ�. 
'CLERK'�� 200, 'SALESMAN'�� 180, 'MANAGER'�� 150, 'PRESIDENT'�� 100��
�λ��Ͽ� ����Ͻÿ�.

*/











