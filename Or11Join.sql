/************************   HR �������� �ϱ�
���ϸ�: Or11Join
TABLE JOIN 
���� : 2�� �̻��� ���̺��� ���ÿ� �����ϴ� �����͸� �����;� �� �� ����ϴ� SQL��
************************/

/*
inner join
    ���� ���� ���Ǵ� ���ι����� ���̺��� ���������� ��� �����ϴ� ���ڵ带 �˻��� �� ���ȴ�.
    �Ϲ������� �⺻Ű(primary key)�� �ܷ�Ű (foriegn)�� ����Ͽ� join�ϴ� ��찡 ��κ��̴�.
    �ΰ��� ���̺� ������ �̸��� �÷��� �����ϸ� "���̺��.�÷���" ���·� ����մϴ�.
    ���̺��� ��Ī�� ����ϸ� "��Ī.�÷���"�� ���µ� ��밡���ϴ�.
   
    ����(ǥ�ع��)
    select �÷�1,�÷�2....
      from ���̺�1 inner join ���̺�2
        on ���̺�1.�⺻�÷� = ���̺�2.�ܷ�Ű�÷�
          where  ����1 and ����2
    
*/


-- ������̺�� �μ����̺��� �����Ͽ� �� ������ � �μ����� �ٹ��ϴ��� ����Ͻÿ�. ��, ǥ�ع������ �ۼ��Ͻÿ�..
-- ��°���� ������̵�, �̸�1, �̸�2, �̸���, �μ���ȣ, �μ���

desc employees;
desc departments;

/*
ORA-00918: ���� ���ǰ� �ָ��մϴ�
department_id�� ������ ���� ���̺��� �����ϴ� �÷��̹Ƿ� � ���̺��� ������ ������� �����ؾ��մϴ�. 
�������ǰ� �ָ��� ��� �÷��տ� ���̺���� �߰��Ѵ�.(�ΰ��߿� �ϳ��� ���̺��� �����;������� ��Ȯ�ϰ� ǥ�����ش�.
AS(�󸮾)�� ���� ���̺� ��Ī�� �ο��Ͽ� query���� ����Ҽ� �ִ�.
*/

select 
    employee_id, first_name, last_name, email, Emp.department_id, department_name
    from employees Emp inner join departments Dep
     on Emp.department_id = Dep.department_id;
        
/* @@@
������������ �Ҽӵ� �μ��� ���� 1���� ������ ������ 106���� ���ڵ尡 ����ȴ�.
��, inner join �� ���̺��� ���� ��� �����Ǵ� ���ڵ常 �������� �˴ϴ�.
*/
      
-- 3���̻� ���̺� �����ϱ� 
--seattle(�þֵ�)�� ��ġ�� �μ����� �ٹ��ϴ� ������ ������ ����ϴ� query���� �ۼ��Ͻÿ� ��, ǥ�ع���� �̿��ؼ� �ۼ��Ͻÿ�.
--��°���� ����̸�, �̸���, �μ����̵�, �μ���, ���������̵�, ��������, �ٹ�����
--��°���� �������̺� �����մϴ�.
-- ������̺� : ����̸�, �̸���, �μ����̵�, ������ ���̵�
-- �μ����̺� : �μ����̵�(����), �μ���, �����Ϸù�ȣ(����)
-- ���������̺� : ��������, ���������̵�(����)
-- �������̺� : �ٹ��μ�, �����Ϸù�ȣ(����)


--1. �������̺��� ���� ���ڵ�Ȯ���ϱ�. �����Ϸù�ȣ 1700 Ȯ���߽��ϴ�.
select * from locations where lower(city) = 'seattle';

--2.Ȯ���� �����Ϸù�ȣ�� ���� �μ����̺��� ���ڵ� Ȯ���ϱ�    21���� �μ��� Ȯ���߽��ϴ�.
select * from departments where location_id = 1700;

--3.�μ��Ϸù�ȣ�� ���� ������̺��� ���ڵ带 Ȯ���մϴ�. --6�� Ȯ��
select * from employees where department_id = 30;
--4.�������� Ȯ���ϱ� 
select * from jobs where job_id ='PU_MAN';
select * from jobs where job_id ='PU_CLERK';
--5.join query���� �ۼ�


select  
    first_name, email, D.department_id, department_name, E.job_id, job_title, city, state_province
    from locations L 
    inner join departments D on L.location_id = D.location_id
    inner join employees E on D.department_id = E.department_id
    inner join jobs J on E.job_id = J.job_id
    where lower(city) = 'seattle';
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
-- //////////////////////////////////////////////////////////////////////////////////////////////////////



    
--@@@@@ ����2 : ����Ŭ ���
-- select �÷�1,�÷�2 
-- from ���̺�1,���̺�2
-- where ���̺�1.�⺻Ű�÷� = ���̺�2.�ܷ�Ű�÷�
--  and ���� 1, and ����2

--������̺�� �μ����̺��� �����Ͽ� �� ������ � �μ����� �ٹ��ϴ��� ����Ͻÿ� 
-- ��, ����Ŭ������� ����Ͻÿ� 
-- ��°�� : ������̵�, �̸�1, �̸�2, �̸���, �μ���ȣ, �μ���



select 
    employee_id, first_name, last_name, email, department_id, department_name
    from departments D, employees E
    where
     D.department_id = E.department_id;
--ORA-00918: ���� ���ǰ� �ָ��մϴ�
    
select 
    employee_id, first_name, last_name, email, D.department_id, department_name   -- �⺻Ű�� �������� ������� �������ش�.
    from departments D, employees E
    where
     D.department_id = E.department_id;


--seattle�� ��ġ�� �μ����� �ٹ��ϴ� ������ ������ ����ϴ� query���� �ۼ��Ͻÿ�.
-- �� , ����Ŭ ������� �ۼ��Ͻÿ� 
-- ��°�� : ����̸�, �̸���, �μ����̵�, �μ���, ���������̵�, ��������, �ٹ�����
-- �� ��� ����� ���� ���̺� �����մϴ�.
-- ������̺� : ����̸�, �̸���, �μ����̵�, ���������̵�
-- �μ����̺� : �μ����̵�(����), �μ���, �����Ϸù�ȣ(����)
-- ���������̺� : ���������̵�(����), ��������
-- �������̺� : �ٹ��μ�, �����Ϸù�ȣ(����)

select 
    first_name, last_name, email, D.department_id, department_name,J.job_id, job_title, city, state_province
    from employees E,departments D, jobs J, locations L
    where 
    D.department_id = E.department_id and
    D.location_id = L.location_id and
    J.job_id = E.job_id and lower(city) = 'seattle'; 
    
    
    
    
    
    
    
    
    
    
    
    
    
-- //////////////////////////////////////////////////////////////////////////////////////////////////////

    
--@@@@@@@@@  outer join @@@@@@@@@@@@@@@@@


-- outer join (�ܺ� ����)

/*
 outer join �� inner join ���� �޸� �� ���̺��� ���� ������ ��Ȯ�� ��ġ�����ʾƵ� �����̵Ǵ� ���̺��� 
 ���ڵ带 �����ϴ� join ����Դϴ�.
 
 outer join �� ����� ������ �ݵ�� outer���� ������ �Ǵ� ���̺��� �����ϰ� query���� �ۼ��ؾ��մϴ�.

--> left right full ����, ������, ���� ���̺������ �ִ�.

    (ǥ������) ����1.
    select �÷�1, �÷�2...
    from ���̺�1
        left[right,full] outer join ���̺�2 
            on ���̺�1.�⺻Ű = ���̺�2.����Ű(�ܷ�Ű)
        where ����1 and ����2 or ���� 3
*/

--@@@@ 
--��ü������ �����ȣ, �̸�, �μ����̵�, �μ���, ������ 
--�ܺ������� ���� ����Ͻÿ�

select employee_id, first_name, last_name, E.department_id, department_name, city
    from  employees E  -- �갡 ������ �Ǳ⶧���� 
     left outer join departments D 
        on E.department_id = D.department_id
     left outer join locations L on D.location_id = L.location_id;
--�������� ���� �������ΰ��� �ٸ��� 106���� �ƴ� 107���� ����ȴ�.
--�μ��� ������������ ������� ����Ǳ� �����̴�.
--�� ��� �μ��ʿ� ���ڵ尡 �����Ƿ� null�� ��µȴ�.


select employee_id, first_name, last_name, E.department_id, department_name, city
    from  employees E
     left outer join departments D on E.department_id = D.department_id
     left outer join locations L on D.location_id = L.location_id;
    
--outer join oracle--
/*
    ����2(����Ŭ���)
    select Į��1, Į��2....
    from ���̺�1,���̺�2
    where
        ���̺�1.�⺻Ű = ���̺�2.����Ű(+)
        and ����1 or ����2;
*/
--## ���̺�1.�⺻Ű (+)  = ���̺�2.����Ű  -- ���̺��� �ٲ����ʰ� right outer join �̴�! 
-- ����Ŭ ������� ����ÿ��� outer join �������� (+)�� �����ش�.
-- ���� ��� ���� ���̺��� �����̵ȴ�.  ������ �Ǵ� ���̺��� ������ ���� ���̺��� ��ġ�� �Ű��ش�.(+)�� �ű����ʴ´�.  left outer join �̶�� ���̺���ġ�� �ٲٶ�°�

--@@@@ 
-- ��ü������ �����ȣ, �̸� , �μ����̵�, �μ���, ������ outer join left�� ����Ͻÿ� ��, ����Ŭ������� �ۼ��Ͻÿ�

select 
    employee_id, first_name, D.department_id, department_name, city  -- ������ �������� �����⶧���� 107�� ���� ����Ű���� �ҷ��°��� ������� null������ ��ü 
    from employees E, departments D, locations L
    where E.department_id = D.department_id (+) and
    D.location_id = L.location_id (+);
    
    
    
    
    
    
    
    
    
-- 2007�⿡ �Ի��� ����� ��ȸ�Ͻÿ� 
--��, �μ��� ��ġ�������� ������ ��� <�μ�����>���� ����Ͻÿ�. ǥ�ع������
-- ����׸� : ���, �̸�, �μ���

--����� ���ڵ� Ȯ��
select first_name, hire_date, to_char(hire_date, 'yyyy') from employees;

--2007�⿡ �Ի��� ����� �����Ͻÿ�
-- ��� 1 like�� �̿��Ͽ� 07�� �����ϴ� ���ڵ带 �����Ѵ�.
select first_name, hire_date from employees where hire_date like '07%';
--��� 2 to_char()�� ���� ��¥������ ���� �� ���ڵ带 ����Ѵ�.
select first_name, hire_date from employees where to_char(hire_date,'yyyy') = '2007';

-- �ܺ�����(ǥ�ع��) ���� ����� Ȯ��
-- nvl(�÷���, '�����Ұ�') : null ���� �����͸� Ư���� ������ �������ݴϴ�.

select employee_id, first_name, last_name, nvl(department_name, '<�μ�����>')
    from employees E
     left outer join departments D on 
     E.department_id =D.department_id
     where to_char(hire_date, 'yyyy') = '2007';



--@@@@ 
--2007�⿡ �Ի��� ����� ��ȸ�Ͻÿ� ��, �μ��� ��ġ�������� ������ ��� <�μ�����> ���� ����Ͻõ�  ����Ŭ��� ���
-- ����׸� : ���, �̸�, �μ���


select employee_id, first_name, last_name, nvl(department_name, '<�μ�����>')  -- employees �� �����̱⶧���� null���� ������ ���� ������ �ȴ�.

    from employees E, departments D 
    where E.department_id =D.department_id (+) and
     to_char(hire_date, 'yyyy') = '2007';

select employee_id, first_name, last_name, nvl(department_name, '<�μ�����>')  -- right join oracle�� �����. department �� �����̱⶧���� �μ������� ���ڵ� ���� ������������
    from employees E, departments D 
    where E.department_id (+) =D.department_id and
     to_char(hire_date, 'yyyy') = '2007';   
      
      
      
      
      
--/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////



--self join (��������) : ���������� �ϳ��� ���̺��� �ִ� �÷����� �����ؾ� �ϴ� ��� ����Ѵ�. 
--��, �ڱ� �ڽ��� ���̺�� ������ �δ� ���̴�. self join������ ��Ī�� ���̺��� �����ϴ� �������� ������ �ϹǷ� ������ �߿��ϴ�.

/*
����
    select 
        ��Ī1.�÷�, ��Ī2.�÷� ...
        from ���̺�Ī1, ���̺�Ī2
        where ��Ī1.�÷� = ��Ī2.�÷�
*/

--@@@@ 
--������̺��� �� ����� �Ŵ������̵�� �Ŵ��� �̸��� ����Ͻÿ� �� �̸��� first_name �� last_name �� �ϳ��� �����ؼ� ����Ͻÿ�

--���⼭�� ��������� ���̺� empClerk�� �Ŵ��������� ���̺� empManager�� ��Ī���� �������� where���� self join������ ����Ѵ�. 


--select (first_name || last_name), manager_id, employees
      

select empClerk.employee_id �����ȣ, empClerk.first_name || ' ' || empClerk.last_name ����̸�, empManager.employee_id �Ŵ��������ȣ,
    concat(empManager.first_name ||' ',empManager.last_name) �Ŵ����̸�
 from employees empClerk, employees empManager
    where empClerk.manager_id = empManager.employee_id;


--@@@@2
-- self join �� ����Ͽ� "kimberely / Grant " ������� �Ի����� ���� ����� �̸��� �Ի����� ����Ͻÿ�
-- ����׸� : �̸� �Ի��� 



--select * from employees where lower(first_name) = 'kimberely';    -- �Ի��� 07-05-24 Ȯ��

select * from employees where hire_date >'07/05/24';

select notKim.first_name, notKim.last_name, notKim.hire_date
from employees Kim, employees notKim
    where Kim.hire_date < notKim.hire_date
    and Kim.first_name = 'Kimberely' and Kim.last_name = 'Grant'
    order by hire_date;
      
      
      
      


--/////////////////////////////////////////////////////////////////////////////////////////////////

--using : join ������ �ַ� ����ϴ� on���� ��ü�� �� �ִ� ����
-- ���� : on ���̺�1.�÷� = ���̺�2.�÷�
--          using(�÷�)


--@@@@  seattle �� ��ġ�� �μ����� �ٹ��ϴ� ������ ������ ����ϴ� query���� �ۼ��Ͻÿ�
-- ��, using �� ����ؼ� �ۼ��Ͻÿ�
-- ����׸� : ����̸� , �̸���, �μ����̵�, �μ���, ���������̵�, ��������, �ٹ�����



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

--using ���� ���� �����÷��� ��� select������ ���̺��� ��Ī�� ���̸� ������ ������ �߻��Ѵ�.
--using ���� ���� �÷��� ������ ���̺� ���ÿ� �����ϴ� �÷��̶�� ���� ������ �ۼ��Ǳ� ������ �� ��Ī�� ����� ������ ���� �����̴�.
--


-- ���� using ���� ����� �Ͱ� ������ ���  ## using �� ����ؼ� join������ ���� �����ϰ� ǥ���� �� �ִ�.
select  
    first_name, email, D.department_id, department_name, E.job_id, job_title, city, state_province 
    from locations L 
    inner join departments D on L.location_id = D.location_id
    inner join employees E on D.department_id = E.department_id
    inner join jobs J on E.job_id = J.job_id
    where lower(city) = 'seattle';   
      
      
--@@@@ 
-- 2005�⿡ �Ի��� ����� �� California(stste_provinve) / South San Francisco(City) ���� �ٹ��ϴ� ������� ������ ����Ͻÿ�.
-- ��, ǥ�ع�İ� using�� ����ؼ� �ۼ��Ͻÿ�
-- ��°�� : �����ȣ, �̸�, ��, �޿�, �μ���, �����ڵ�, ������(Contry_name), �޿�(���ڸ����� , ǥ��) 
-- ���� : �������� contries ���̺� �ԷµǾ��ִ�.



select * from employees where hire_date like '05%';
select * from locations where state_province = 'California' and lower(city) = 'south san francisco'; -- 1500 location_id == 1500
select * from departments where location_id = 1500;

select * from employees 
    where department_id = 50 and substr(hire_date,1,2)='05';

--ȥ�� �ǽ� 
select employee_id, first_name || last_name �̸�, salary, department_name, country_id, country_name, city
    from locations L   --������ �Ǵ� ���� Ȯ���� �����ؾ��Ѵ�.  ũ�� ����� ����.
    inner join departments using(location_id)
    inner join employees using(department_id)
    inner join countries using(country_id)
     where department_id = 50 and hire_date like '05%' ;
 
 
--�������ۼ�     
select employee_id, first_name || last_name, trim(to_char(salary,'$990,000')), department_name, country_id, country_name, city
    from employees 
    inner join departments using(department_id)
    inner join locations using(location_id)
    inner join countries using(country_id)
     where department_id = 50 and hire_date like '05%' ;

      
--11_����

------------------------------------------------------------��������





/*
1. inner join ����� ����Ŭ����� ����Ͽ� first_name �� Janette �� 
����� �μ�ID�� �μ����� ����Ͻÿ�.
��¸��] �μ�ID, �μ���
*/

select department_id D, department_name 
    from employees 
        inner join departments on employees.department_id = D.department_id
    where employees.first_name = Janette;




/* ����Ŭ ����� ǥ�ع�Ŀ����� inner join��� �޸��� �̿��ؼ� ���̺��� 
�����ϰ� on�� ��� where���� ���ε� �÷��� ����Ѵ�. */    

/*
2. inner join ����� SQLǥ�� ����� ����Ͽ� ����̸��� �Բ� �� ����� 
�Ҽӵ� �μ���� ���ø��� ����Ͻÿ�
��¸��] ����̸�, �μ���, ���ø�
*/


/*
3. ����� �̸�(FIRST_NAME)�� 'A'�� ���Ե� ������� �̸��� �μ����� 
����Ͻÿ�.
��¸��] ����̸�, �μ���
*/    


/*
4. ��city : Toronto / state_province : Ontario�� ���� �ٹ��ϴ� ��� 
����� �̸�, ������, �μ���ȣ �� �μ����� ����Ͻÿ�.
��¸��] �̸�, ������, �μ�ID, �μ���
*/


/*
5. Equi Join�� ����Ͽ� Ŀ�̼�(COMMISSION_PCT)�� �޴� ��� 
����� �̸�, �μ���, ���ø��� ����Ͻÿ�. 
��¸��] ����̸�, �μ�ID, �μ���, ���ø�
*/



/*
6. inner join�� using �����ڸ� ����Ͽ� 50�� �μ�(DEPARTMENT_ID)�� 
���ϴ� ��� ������(JOB_ID)�� �������(distinct)�� �μ��� ���ø�(CITY)�� 
�����Ͽ� ����Ͻÿ�.
��¸��] ������ID, �μ�ID, �μ���, ���ø�
*/



/*
7. ������ID�� FI_ACCOUNT�� ������� �޴����� �������� ����Ͻÿ�. 
��, ���ڵ尡 �ߺ��ȴٸ� �ߺ��� �����Ͻÿ�. 
��¸��] �̸�, ��, ������ID, �޿�
*/

select * from employees;


select EA.first_name, EA.last_name, EA.department_id, EA.salary
    from employees E , employees EA
        where E.department_id = EA.manager_id
        and E.department_id = 108;
        
    


/*
8. �� �μ��� �޴����� �������� ����Ͻÿ�. ��°���� �μ���ȣ�� 
�������� �����Ͻÿ�.
��¸��] �μ���ȣ, �μ���, �̸�, ��, �޿�, ������ID
�� departments ���̺� �� �μ��� �޴����� �ֽ��ϴ�.
*/

select department_id from employees; 

select D.department_id , D.department_name, E.first_name, last_name, salary, job_id ,D.manager_id
    from departments D, employees E
        where D.manager_id = E.employee_id;
       
        
       


/*
9. ���������� Sales Manager�� ������� �Ի�⵵�� 
�Ի�⵵(hire_date)�� ��� �޿��� ����Ͻÿ�. ��½� �⵵�� �������� 
�������� �����Ͻÿ�. 
����׸� : �Ի�⵵, ��ձ޿�
*/

        


      
      
      
      
      
      
      
      
      
      