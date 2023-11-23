/************************
���ϸ�: Or03SelectBasic.sql
ó������ ������ ���� ���Ǿ� (SQL�� Ȥ�� Query��)
�����ڵ� ���̿����� '����'�̶�� ǥ���ϱ⵵ �մϴ�.
���� : select, where �� ���� �⺻���� DQL�� ����غ���
************/
-- HR�������� �ϱ� 

/*
SQL Developr ���� �ּ� ����ϱ� 
    ������ �ּ�  : �ڹٿ� ������ 
    ���δ��� �ּ� :  -- ���๮��. ������ 2���� �������� ����մϴ�.
*/

--select�� : ���̺� ����� ���ڵ带 ��ȸ�ϴ� SQL������ DQL���� �ش��մϴ�.
--    ����- 
--    select �÷�1, �÷�2, ... Ȥ�� *
--    from ���̺�� 
--    where ����1 and ����2 or ����3
--    order by ������ �÷� asc (��������) desc (��������);



--������̺� ����� ��� ���ڵ带 ������� ��� �÷��� ��ȸ�ϱ�
--(�������� �񵵹��ڸ� �������� �ʴ´�.)
SELECT * from employees;
SELECT * FROM employees;  --��ҹ��� ������ ���� �ʴ´�.


--�÷����� �����ؼ� ��ȸ�ϰ� ���� �÷��� ��ȸ�ϱ�
--�����ȣ, �̸�, �̸���, �μ���ȣ�� ��ȸ�Ͻÿ�.
SELECT employee_id, first_name, last_name, email, department_id
    FROM    employees;      

    
-- ���̺��� ������ �÷��� �ڷ��� �� ũ�⸦ ����Ѵ�.
-- ��, ���̺��� ��Ű���� �� �� �ִ�.
desc employees;


-- as �� ������ �� �ִ�.   ������ ���� ��ҹ��ڴ� �з��Ѵ�.
select employee_id "������̵�", first_name as "�̸�", last_name "��"
    from employees where first_name = 'William';

    
--����Ŭ�� �⺻������ ��� ���� ��ҹ��ڸ� �������� �ʴ´�. ������� ��� ��ҹ��� ���о��� ����� �� �ִ�.
--������ ���ڵ��� ��� ��ҹ��ڸ� �����Ѵ�. ���� �Ʒ� SQL���� �����ϸ� �ƹ��� ����� ������ �ʴ´�.
select employee_id "������̵�", first_name as "�̸�", last_name "��"
    from employees where first_name = 'WilliAm';  --  ��ҹ��� ������ ���߱� ������ ����� ������ �ʴ´�.
    
    

--where ���� �̿��ؼ� ���ǿ� �´� ���ڵ� �����ϱ� 
--last_name �� Smith�� ���ڵ带 �����Ͻÿ�
select * from employees where last_name = 'Smith';



--where ���� 2�� �̻��� ������ �ʿ��Ҷ� and Ȥ�� or�� ����� �� �ִ�.
--last_name = Smith �̸鼭 �޿��� 8000�� ����� �����Ͻÿ� 
--�÷��� �������� ��� �̱������̼����� �����ְ� ������ ��� �����Ѵ�.
--�÷��� �������� ��� �̱������̼��� ������ �����߻� ���� 
--�÷��� �������� ��� �̱� �����̼� ��������(�־ ���� ��� ����)
select * from employees where last_name = 'Smith' and salary = 8000;



--�񱳿����ڸ� ���� Qurey�� �ۼ�
--�̻�, ���Ͽ� ���� ���ǿ� > <= �� ���� �񱳿����� 
--��¥�� ��� ����, ���� �� ���� ���ǵ� �����ϴ�.
--�޿��� 5000 �̸��� ����� ������ �����Ͻÿ�.
select * from employees where salary < 5000;



--�Ի����� 04�� 01�� 01�� ������ ����� �����Ͻÿ�
SELECT * from employees where hire_date >= '04/01/01';



--in ������ : or �����ڿ� ���� �ϳ��� �ķ��� �������� ������ ������ �ɰ� ���� �� ���
--�޿��� 4200, 6400, 8000�� ����� ������ �����Ͻÿ�
select * from employees where salary = 4200 or salary = 6400 or salary = 8000;  -- in�� ��������ʰ� �⺻�� or�� ���
select * from employees where salary in (4200, 6400, 8000);  -- or in�� ���



--not ������ : �ش� ������ �ƴ� ���ڵ带 �����Ѵ�.
--�μ���ȣ�� 50�� �ƴ� ��������� ��ȸ�ϴ� SQL���� �ۼ��Ͻÿ�
select * from employees where department_id <> 50;  -- 50�� �ƴ�~  
select * from employees where not (department_id = 50);



--between and ������ : �÷��� ������ ���� �˻��Ҷ� ���
--�޿��� 4000~8000 ������ ����� �����Ͻÿ�
select * from employees where salary >=4000 and salary <= 8000;
select * from employees where salary between 4000 and 8000;




--distinct : �÷����� �ߺ��Ǵ� ���ڵ带 ������ �� ���
--Ư���������� select ���� �� �ϳ��� �÷����� �ߺ��Ǵ� ���� �ִ� ��� �ߺ����� ������ �� ����� ����� �� �ִ�.
--��� ���� ���̵� �ߺ��� ������ �� ����Ͻÿ� 
--��ü ����� ���� ���������� ����ȴ�.
select job_id from employees;
select DISTINCT job_id from employees;



--like ������ _ % : Ư�� Ű���带 ���� ���ڿ��� �˻��� �� ����Ѵ�.
--% ��� ���� Ȥ�� ���ڿ��� ��ü�Ѵ�.  D% Da, Dda, Deawoo  %Z aZ asdZ adZ %c%  adCef 
--_ ���� �ϳ��� ��ü�Ѵ�.  D__ Dad ,Ddd 
--first_name�� D �� �����ϴ� ������ �˻��Ͻÿ�
select * from employees where first_name like 'D%';
--first_name�� ����° ���ڰ� a�� ������ �˻��Ͻÿ� 
select * from employees where first_name like '__a%'; 
--last_name y�� ������ ������ �˻��Ͻÿ�
select * from employees where last_name like '%y';
--phone_number 1344�� ���Ե� ������ �˻��Ͻÿ� 
select * from employees where phone_number like '%1344%';




--order by : ���ڵ� �����ϱ�.sorting
-- �������� : order by Į���� asc(default�� ��������)
-- �������� : order by Į���� desc
--2���̻��� �÷����� �����ؾ� �� ��� ,�� �����ؼ� �����Ѵ�. 
--���� �Է��� �÷����� ���ĵ� ���¿��� �ι�° �÷��� ���ĵ˴ϴ�
--������� ���̺��� �޿��� ���� �������� ���� ������ ��µǵ��� �����Ͻÿ�
--frist_name, salary, email, phone_number
select first_name, salary, email, phone_number from employees order by salary;
select first_name, salary, email, phone_number from employees order by salary desc;
--�μ���ȣ�� ������������ ������ �� �ش�μ����� �����޿� �޴� ������ ���� ��µǵ��� ����Ͻÿ�
select employee_id "�����ȣ", last_name "�̸�", first_name "��", department_id "�μ���ȣ", salary "�޿�"from employees
    order by department_id desc,salary;




--is null // is not null : ���� null �̰ų� null�� �ƴ� ���ڵ� ��������
--                         �÷��� null ���� ����ϴ� ��� ���� �Է����� ������ 
--                         null���� �Ǵµ� �̸� ������� select�� �� ����Ѵ�.
--���ʽ����� ���� ����� �˻��Ͻÿ�
select * from employees where commission_pct is null;
--��������̸鼭 �޿��� 8000�̻��� ����� ��ȸ�Ͻÿ�
select * from employees where salary >= 8000 and commission_pct is not null;

/***********************
��������(scott�������� �����մϴ�.)
************************/
/*
1. ���� �����ڸ� �̿��Ͽ� ��� ����� ���ؼ� $300�� �޿��λ��� ������� 
�̸�, �޿�, �λ�� �޿��� ����Ͻÿ�.
*/
select * from emp;
select ename"�̸�", sal"�޿�",(sal+300)"�λ�� �޿�" from emp;

/*
2. ����� �̸�, �޿�, ������ ������ �����ͺ��� ���������� ����Ͻÿ�. 
������ ���޿� 12�� ������ $100�� ���ؼ� ����Ͻÿ�.
*/
select ename, sal,(sal*12+100)"����" from emp order by (sal*12+100) desc;




/*
3. �޿���  2000�� �Ѵ� ����� �̸��� �޿��� ������������ �����Ͽ� ����Ͻÿ�
*/
select ename, sal from emp where sal > 2000 order by sal desc;


/*
4. �����ȣ��  7782�� ����� �̸��� �μ���ȣ�� ����Ͻÿ�.
*/
select ename, empno from emp where empno like '%7782%';

/*
5. �޿��� 2000���� 3000���̿� ���Ե��� �ʴ� ����� �̸��� �޿��� ����Ͻÿ�.
*/
select ename, sal from emp where 

/*
6. �Ի����� 81��2��20�� ���� 81��5��1�� ������ ����� �̸�, 
������, �Ի����� ����Ͻÿ�.
*/


/*
7. �μ���ȣ�� 20 �� 30�� ���� ����� �̸��� �μ���ȣ�� ����ϵ� �̸��� 
����(��������)���� ����Ͻÿ�
*/


/*
8. ����� �޿��� 2000���� 3000���̿� ���Եǰ� �μ���ȣ�� 20 �Ǵ� 30�� 
����� �̸�, �޿��� �μ���ȣ�� ����ϵ� �̸���(��������)���� ����Ͻÿ�
*/

    
/*
9. 1981�⵵�� �Ի��� ����� �̸��� �Ի����� ����Ͻÿ�. (like �����ڿ� ���ϵ�ī�� ���)
*/  


/*
10. �����ڰ� ���� ����� �̸��� �������� ����Ͻÿ�. 
*/


/*
11. Ŀ�̼��� ������ �ִ� �ڰ��� �Ǵ� ����� �̸�, �޿�, Ŀ�̼��� 
����ϵ� �޿� �� Ŀ�̼��� �������� ������������ �����Ͽ� ����Ͻÿ�.
*/


/*
12. �̸��� ����° ���ڰ� R�� ����� �̸��� ǥ���Ͻÿ�.
*/


/*
13. �̸��� A�� E�� ��� �����ϰ� �ִ� ����� �̸��� ǥ���Ͻÿ�.
*/

/*
�Ʒ��� ���� ��� A�� E�� ���ԵǱ� �ϳ� ������ �����Ƿ� E�� �����ϰ� A�� ������ 
�̸��� �˻����� �ʴ´�.
*/


/*
14. �������� �繫��(CLERK) �Ǵ� �������(SALESMAN)�̸鼭 �޿��� 
$1600, $950, $1300 �� �ƴ� ����� �̸�, ������, �޿��� ����Ͻÿ�. 
*/


/*
15. Ŀ�̼��� $500 �̻��� ����� �̸��� �޿� �� Ŀ�̼��� ����Ͻÿ�. 
*/


















