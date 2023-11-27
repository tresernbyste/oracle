/************************   HR �������� �ϱ�
���ϸ�: Or12Subquery
Query�� �ȿ� �Ǵٸ� Query���� ���� ������ Select��
where���� Select ���� ����ϸ� ����������� �Ѵ�.
************************/


--������ subquery
--      �� �ϳ��� �ุ ��ȯ�ϴ� ���������� �񱳿�����( = , < , <=, >, >=, <> )�� ����Ѵ�.
-- ���� 
--   select * from ���̺��
--      where �÷� = (  select �÷� from ���̺�� where ����  );

-- ��ȣ �� ���������� �ݵ�� �ϳ��� ����� �����ؾ� �Ѵ�.

--@@@@
-- ������̺��� ��ü ����� ��� �޿����� ���� �޿��� �޴� ������� �����Ͽ� ����Ͻÿ�
-- ��»��� �����ȣ, �̸�, �̸���, ����ó, �޿� 
select avg(salary) from employees;  -- ��ձ޿�
select * from employees where salary < avg(salary);  --  avgs�� �׷��Լ��̱� ������ �����࿡ ���⶧���� �����߻�
select * from employees where salary < 6462;  -- �ܼ� ���ڷ� ������� �����ϱ⶧���� �����ϴ�


select employee_id, first_name || employees.last_name, email, phone_number, trim(to_char(salary, '$999,000'))     
    from employees where salary < ( select avg(salary) from employees)         --�������� �ȿ����� �׷��Լ� ��밡���ϴ�.
    order by salary desc;
    
    
--@@@@
-- ��ü ��� �� �޿��� ���� ���� ����� �̸��� �޿��� ����ϴ� ������������ �ۼ��Ͻÿ� 
-- ����׸� : �̸�1, �̸�2 , �̸���, �޿� 

-- 1�ܰ� : �ּұ޿��� Ȯ���Ѵ�.
select min(salary) from employees;
--2�ܰ� : 2100�� ���ٴ� ������ ������ �Է��Ͻÿ�.
select * from employees where salary = 2100;
--3 �ܰ� : �ΰ��� ������ ���ļ� ���������� �����.
select * from employees where salary = (select min(salary) from employees );


--@@@@
-- ��ձ޿����� ���� �޿��� �޴� ������� ����� ��ȸ�� �� �ִ� ������������ �ۼ��Ͻÿ� 
-- ����׸� : �̸�1, �̸�2, ��������, �޿�
-- ## ���������� jobs ���̺� �����Ƿ� join�� ����ؾ��Ѵ�.

select round(avg(salary)) from employees;

select
    first_name, last_name, job_title, salary
    from employees inner join jobs using(job_id)
    where salary>6462;

select
    first_name, last_name, job_title, salary
    from employees 
    inner join jobs using(job_id)
    where salary>(select round(avg(salary)) from employees);
    
select first_name, last_name, job_title, salary
    from employees 
    inner join jobs using(job_id)
    where salary > (select avg(salary) from employees);
    











--#########################################################################

--������ �������� : ������ ����������� �ϰ� �������� ���� ��ȯ �ϴ� ������
--in any all exit�� ����ؾ��Ѵ�.

-- ���� 
-- select * from ���̺�� 
--      where �÷� in (  select �÷� from ���̺�� where ����...    )

--��ȣ �� ���������� �ΰ��̻��� ����� �����ؾ� �Ѵ�.


--@@@@
-- ������ ���� ���� ���� �޿��� �޴� ����� ����� ��ȸ�Ͻÿ�.
-- ��¸�� : ������̵�, �̸�, ���������̵�, �޿�

select job_id , max(salary) from employees group by job_id; 

select * from employees where ( job_id ='SH_CLERK' and salary = 4200) or (job_id= 'AD_ASST' and salary = 4400) or (job_id= 'MK_MAN' and salary = 13000);


--35���� �������� group by��  job_id�� ���� �ʾұ� ������  �������� �׷�ȭ�� �����ʾұ⶧���� ���� ���� �޿��� ���� ���� �������� ������� ������ ������ ��
select employee_id, first_name || last_name , job_id, salary
    from employees 
    where salary in ( select max(salary) from employees group by job_id )
    order by salary desc;
--������    
select employee_id, first_name || last_name , job_id, salary
    from employees 
    where (job_id,salary) in ( select job_id, max(salary) from employees group by job_id )
    order by salary desc;






--#########################################################################


-- ������ ������ any(������) ����̶� �� �������� or�� ����ϴ�
-- ���������� �������� ���������� �˻������ �ϳ��̻� ��ġ�ϸ� ���� �Ǵ� ������. 
-- ��, �� �� �ϳ��� �����ϸ� �ش� ���ڵ带 �����Ѵ�.

--@@@@
--��ü ��� �߿��� �μ���ȣ�� 20�� ������� �޿����� ���� �޿��� ���� �������� �����ϴ� ������������ �ۼ��Ͻÿ� 
--�� , �� �� �ϳ��� �����ϴ��� �����Ͻÿ�

-- 1�ܰ� : �μ���ȣ 20�� �μ����� �޿��� Ȯ���Ѵ�.

select first_name, salary from employees where department_id = 20;

-- 2�ܰ� : 1���� ����� �ܼ��� or ���� �ۼ��غ��ϴ�.

select first_name , salary from employees where salary > 13000 or salary > 6000;

--3�ܰ� : �� �� �ϳ��� �����ϸ� �Ǳ� ������ ������ ������ any�� �̿��ؼ� ������������ �ۼ��غ��� 

select first_name , salary from employees where salary >any ( select salary from employees where department_id = 20);

-- ��������� 6000���� ũ�� ���ǿ� �����մϴ�. ��� : 55�� 







--#########################################################################

--������ ������ all (������) : and�� ����� �����մϴ�.
--���������� �������� ���������� �˻������ ��� ��ġ�ؾ� ���ڵ带 �����մϴ�.
--@@@@
-- ��ü ��� �߿��� �μ���ȣ�� 20�� ������� �޿����� ���� �޿��� ���� �������� �����ϴ� ������������ �ۼ��Ͻÿ� 
-- �� �Ѵ� �����ϴ� ���ڵ常 �����Ͻÿ�

select first_name , salary from employees where salary > 13000 and salary > 6000;
select first_name , salary from employees where salary >all ( select salary from employees where department_id = 20);

-- 6000�� ���ÿ� 13000���� Ŀ���ϹǷ� ��������� 13000���� ū ���ڵ常 �����ϰ� �ȴ�.









--#########################################################################

--TOP QUERY : 


-- rownum : ���̺��� ���ڵ带 ��ȸ�� ������� ������ �ο��Ǵ� ������ �÷��� ���Ѵ�. �ش� �÷��� ��� ���̺��� �������� �����Ѵ�.
-- ��� ������ �����ϴ� ���̺� 
select * from dual;

-- ���ڵ��� ���ľ��� ��� ���ڵ带 �������� rownum���� �ο��Ѵ�.
-- �� ��� rownum�� ������� ��µȴ�. like index 
select employee_id ,first_name, rownum from employees;

--�̸��� ������������ �����ϸ� rownum�� ������ �̻��ϰ� ���´�.
select employee_id ,first_name, rownum from employees order by first_name;  -- why????  �̹� ���ľ��� �����Ա⶧��?/


-- rownum�� �츮�� ������ ������� ��ο��ϱ� ���� ���������� ����մϴ�.
-- from ������ ���̺��� ���;� �ϴµ� �Ʒ��� �������������� ������̺��� ��ü ���ڵ带 ������� �ϵ� 
-- �̸��� ������������ ���ĵ� ���·� ���ڵ带 �����ͼ� ���̺�ó�� ����մϴ�.  ???

select first_name, rownum from (select * from employees order by first_name asc);  -- rownum �� ������ �������ʴ´�.








--#########################################################################



12_��������

--------------------------------------------------------
--------------- Sub Query �� �� �� �� ------------------
--------------------------------------------------------

-- scott�������� �����մϴ�. 
/*
01.�����ȣ�� 7782�� ����� ��� ������ ���� ����� ǥ���Ͻÿ�.
��� : ����̸�, ��� ����
*/


/*
02.�����ȣ�� 7499�� ������� �޿��� ���� ����� ǥ���Ͻÿ�.
��� : ����̸�, �޿�, ������
*/


/*
03.�ּ� �޿��� �޴� �����ȣ, �̸�, ��� ���� �� �޿��� ǥ���Ͻÿ�.
(�׷��Լ� ���)
*/


/*
04.��� �޿��� ���� ���� ����(job)�� ��� �޿��� ǥ���Ͻÿ�.
*/

/*
��ձ޿��� ���������� �����ϴ� �÷��� �ƴϹǷ� where������ ����Ҽ�����
having���� ����ؾ� �Ѵ�. ��, ��ձ޿��� 1017�� ������ ����ϴ� �������
���������� �ۼ��ؾ� �Ѵ�. 
*/



/*
05.�� �μ��� �ּ� �޿��� �޴� ����� �̸�, �޿�, �μ���ȣ�� ǥ���Ͻÿ�.
*/


/*
06.��� ������ �м���(ANALYST)�� ������� �޿��� �����鼭 
������ �м���(ANALYST)�� �ƴ� ������� ǥ��(�����ȣ, �̸�, ������, �޿�)
�Ͻÿ�.
*/

/*
ANALYST ������ ���� ����� 1���̹Ƿ� �Ʒ��� ���� ������ �����ڷ� ����������
����� ������, ���� ����� 2���̻��̶�� ������ ������ all Ȥ�� any�� 
�߰��ؾ��Ѵ�. 
*/


/*
Ex) ���� �������� CLERK�� �־����ٸ� ������ �Ʒ��� ���� �ؾ��Ѵ�. 
*/



/*
07.�̸��� K�� ���Ե� ����� ���� �μ����� ���ϴ� ����� 
�����ȣ�� �̸�, �μ���ȣ�� ǥ���ϴ� ���Ǹ� �ۼ��Ͻÿ�
*/


/*
    or ������ in���� ǥ���� �� �ִ�. ���� ������������ ������ ��������
    in�� ����Ѵ�. 2�� �̻��� ����� or�� �����Ͽ� ����ϴ� ����� 
    ������. 
*/


/*
08.�μ� ��ġ�� DALLAS�� ����� �̸��� �μ���ȣ �� ��� ������ ǥ���Ͻÿ�.
*/


/*
09.��ձ޿� ���� ���� �޿��� �ް� �̸��� K�� ���Ե� ����� ���� 
�μ����� �ٹ��ϴ� ����� �����ȣ, �̸�, �޿��� ǥ���Ͻÿ�.
*/


/*
10.��� ������ MANAGER�� ����� �Ҽӵ� �μ��� ������ �μ��� ����� ǥ���Ͻÿ�.
*/



/*
11.BLAKE�� ������ �μ��� ���� ����� �̸��� �Ի����� ǥ���ϴ� 
���Ǹ� �ۼ��Ͻÿ�. (��, BLAKE�� ����)
*/




































