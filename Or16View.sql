/************************   hr ����
���ϸ�: Or16 View 
View ��
���� : ��� ���̺�κ��� ������ ������ ���̺�� ���������� ���������ʰ� �������� �����ϴ� ���̺��̴�. 
************************/

/*
���� ���� 
���� :
    create [or replace] view ���̸� [(�÷�1,�÷�2,..N)]
    as
    select * from ���̺�� where ���� 
        Ȥ�� join���� ������ 
*/

--@@@@
-- hr ������ ������̺��� �������� ST_CLERK�� ��������� ��ȸ�� �� �ִ� view�� �����Ͻÿ�
-- ����׸� : ������̵�, �̸�, �������̵�, �Ի���, �μ����̵�

--1.���Ǵ�� select �ϱ�
select employee_id, first_name, job_id, hire_date, department_id
    from employees
        where job_id = 'ST_CLERK';
        
--2.���� �������� view�����ϱ�
create view view_employees 
    as 
    select employee_id, first_name, job_id, hire_date, department_id
    from employees
        where job_id = 'ST_CLERK';
--3.������ view �����ϱ� : select ���� �����ϴ� �Ͱ� ������ ����� ����˴ϴ�.
select * from view_employees;

--4. ������ �������� �� Ȯ���ϱ� 
-- ������ ����� �������� �״�� ����Ǵ°��� �˼� �ִ�.

select * from user_views;

------�� ����-------------------------------------------------------------
------�� ����-------------------------------------------------------------


/*
�� �����ϱ� 
    : �� ���� ���忡 or replace �� �߰��ϸ� �˴ϴ�.
      �ش� �䰡 �����ϸ� ������ �ǰ� 
      �ش� �䰡 ���������ʴ´ٸ� ���� �����˴ϴ�.
      ���� ó�� �並 ������ ������ or replace�� ����ص� ����.(�ٵ� ����)
*/

--@@@@
--�տ��� ������ �並 ������ ���� �����Ͻÿ� 
--���� �÷��� employee_id,first_name,job_id, hire_date, department_id ��
-- id,fname, job_id, hdate, deptid�� �����Ͽ� �並 �����Ͻÿ� 

create or replace view view_employees 
    (id,fname, jobid, hdate, deptid)
    as 
    select employee_id, first_name, job_id, hire_date, department_id
    from employees
        where job_id = 'ST_CLERK';

select * from view_employees;

/*
����] ������ ������ view_employees �並 �Ʒ� ���ǿ� �°� �����Ͻÿ� 
    �������̵� ST_MAN �� ����� �����ȣ, �̸�, �̸���, �Ŵ������̵� �� ��ȸ�Ҽ� �ֵ��� �����Ͻÿ�
    ���� �÷����� e_id, name, email, m_id�� �����Ѵ�. 
    ��, �̸��� first_name �� last_name �� ����� ���·� ����Ͻÿ�
*/

--������ ���Ǵ�� select���ۼ� 

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
����]  �����ȣ, �̸�, ������ ����Ͽ� ����ϴ� �並 �����Ͻÿ�  
    �÷��� �̸��� emp_id, l_name, annul_sal�� �����Ͻÿ� 
    ���̸��� v_emp_salary
    ��, ������ 3�ڸ����� �ĸ� ��
*/

create or replace view  v_emp_salary (emp_id, l_name, annul_sal)
    as
    select employee_id, first_name || ' ' || last_name, to_char(salary*12 , '999,000')
    from employees;





/*
--������ ���� view ����
������̺�� �μ����̺�, �������̺��� �����Ͽ� ���� ���ǿ� �´� �並 �����Ͻÿ� 
    ����׸� : �����ȣ, ��ü�̸�, �μ���ȣ, �μ���, �Ի�����, ������
    ���� ��Ī : v_emp_join
    ���� �÷� : empid, fullname, deptid, deptname, hdate, locname
    �÷��� ������� : 
        fullnam == first_name + last_name
        hdate == 0000�� 00�� 00��
        locname == xxx���� yyy ( �ػ罺 ���� ��콺����ũ)
*/
 select employee_id,  first_name || ' ' || last_name, department_id,department_name,to_char(hire_date, 'yyyy"��" mm"��" dd"��"'), state_province || '����' || city
        from employees E
            inner join departments using(department_id)
            inner join locations using(location_id);




create or replace view v_emp_join 
    (  empid, fullname, deptid, deptname, hdate, locname )
    as
    select employee_id,  first_name || ' ' || last_name, department_id,department_name,to_char(hire_date, 'yyyy"��" mm"��" dd"��"'), state_province || '����' || city
        from employees E
            inner join departments using(department_id)
            inner join locations using(location_id);

            
            




