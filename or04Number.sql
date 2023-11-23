/************************
���ϸ�: Or04Number.sql
����(����) ���� �Լ�
���ڵ����͸� ó���ϱ� ���� ���ڰ��� �Լ��� �˾ƺ���
�˻�,������ ���� �������� ���� ��Ȯ�ϰ� �����ϱ� �������� ���� �̿��.
���̺� ������ number Ÿ������ ����� �÷��� ����� �����͸� ������� �Ѵ�.
************/
-- HR�������� �ϱ� 
--���� ������ ������ ������ ���̺�, �並 �����ش�.
select * from tab;
select * from seoulit; -- ������ ���̺� �Ǵ� �䰡 �������� �ʽ��ϴ�. ��� ���;���

select * from dual; --dummy data �� ������ �� 
-- �ϳ��� ������ ����� ����ϱ� ���� �����Ǵ� ���̺�� ����Ŭ���� �ڵ����� �����Ǵ� ���� ���̺� dual
-- VARCHAR1�� ���ǵ� dummy data ��� �� �ϳ��� �÷����� �����Ǿ� �ֽ��ϴ�.

select 1+2 from dual;  -- �̷������� ���

--abs() ���밪���ϱ� 
select abs(12000) from dual;
select abs(-9000) from dual;  -- ���밪�̱� ������ �ڵ���ȯ 
select abs(salary)"�޿��� ���밪" from employees order by salary desc;

--trunc(a,b) �Ҽ����� Ư���ڸ������� �߶󳻱�
select trunc(3.145912345,2) from dual; -- 3.14
select trunc(3.14591234) from dual; --- 3
select trunc(1233.142515,-2) from dual; --1200  �ݾ��̶�� 100�������� ����� ���� ���·� Ȱ���� �� �ִ�.

--!!������̺��� ��������� 1000�ҿ� ���� Ŀ�̼��� ����Ͽ� �޿��� ���� ����� ����ϴ� query���� �ۼ��Ͻÿ�
-- �޿� 1000, ���ʽ���0.1 ����ϴ¹� 
--��������� ���� ã�Ƽ� �˻��Ͻÿ�
select * from employees where job_id like 'SA_%';
--��������� Ŀ�̼��� �ޱ� ������ ���� ����Ǿ� �ֽ��ϴ�. �̷��Ե� ��������� ���Ⱑ��
select * from employees where commission_pct is not null; 
--Ŀ�̼��� ����Ͽ� �̸��� �Բ� ����Ѵ�.
select first_name, salary,trunc(commission_pct,2)"comm", (salary*(1+trunc(commission_pct,2)))"totalsal" from employees where commission_pct is not null ;
--Ŀ�̼��� �Ҽ��� 1�ڸ����� �ݾ� ����ϱ�


--�Ҽ��� �����Լ� ceil() : �Ҽ��� ���ϸ� ������ �ø�ó��
--                floor() : �Ҽ��� ���ϸ� ������ ����ó��
--                round() : ������ ���ϸ� ������ �ݿø�ó��
--                       ������ : ���ڸ�ŭ �Ҽ����� ǥ���ǹǷ� �� �������� 5�̻��̸� �ø�, 5�̸��̸� ����.
--                       ������ : �Ҽ��� ù��°�ڸ��� 5�̻��̸� �ø�, 5�̸��̸� ����

select ceil(32.8) from dual;
select ceil(32.2) from dual;

select floor(32.8) from dual;
select floor(32.2) from dual;

select round(32.8), round(0.533) from dual; -- �ι�° �μ��� ������� �Ҽ��� ù°�ڸ����� �ø� �ݿø�
--ù��° �׸�: �Ҽ����� 6�ڸ����� ǥ��
select round(0.1234567, 6) , round(2.345612,4) from dual;


--mod()    ������ ���ϴ� �Լ�
select mod(99,4) from dual;
--power()  �ŵ� ���� ���ϴ� �Լ�
select power(2,10) from dual;
--sqrt()   �������� ���ϴ� �Լ�
select sqrt(49) from dual; 


--4_���ڰ����Լ�
--HR �����̿�
/*
��������] ������̺��� ���ʽ����� �ִ� ����� ������ �� ���ʽ����� 
    �Ҽ��� 1�ڸ��� ǥ���Ͻÿ�. 
    ��³��� : �̸�, �޿�, ���ʽ���
*/
-- 1.Ŀ�̼��� �ִ� ����� ����

-- 2.�Ҽ��� ó���ϱ�




