/************************   
system������ �̿��� ���ο� ���� ����, ���ο������ ���Ѻο�, ������ ���ο� ���̺� ���� �߰� create 
���ϸ�: Or09DDL
DDL : Data Defination Language ������ ���Ǿ� 
���� : ���̺� , �� �� ���� ��ü�� ���� �� ���� �ϴ� query���� ���Ѵ�.
************************/

-- System �������� ������ �� �Ʒ� ����� �����մϴ�. 
-- ���ο� ����� ������ ������ �� ���ӱ��Ѱ� ���̺� �������� ���� �ο��Ѵ�.

--orcle 21c �̻���ʹ� ���� ������ �ش� ����� �����ؾ��մϴ�.  -- C## ����������
alter session set "_ORACLE_SCRIPT" = TRUE;
-- study ������ �����ϰ� �н����带 1234�� �ο��Ѵ�.
create user study identified by 1234;
-- ������ ������ ��� ������ �ο��մϴ�. --�׷��� ������ �α����̿� �۾� �Ұ���
grant connect, resource to study;


--study ������ ������ �� �ǽ��� �����մϴ�.

-- ��� ������ �����ϴ� ������ ���̺�
select * from dual;  -- ����Ʈ ���̺� Ȯ�� 

-- �ش� ������ ������ ���̺��� ����� ������ �ý��� ���̺� 
-- �̿� ���� ���̺��� "������ ����" �̶�� �Ѵ�.
select * from tab; 

--���̺� �����ϱ� : 
--      create table ���̺�� (
--           Į��1 �ڷ��� [],
--           Į��2 �ڷ��� [],
--           primary key(Į���ʵ��) �� �������� �߰� );

create table tb_number(
    idx number (10),  -- 10�ڸ��� ������ ǥ�� 
    userid varchar2(30), -- ���������� 30byte ���尡��
    passwd varchar2(50),  -- 
    username varchar2(30),
    mileage number(7,2) --  �Ǽ� ǥ��, ��ü�ڸ�7 �Ҽ��ڸ� 2
    );

-- ���� ������ ������ ������ ���̺� ����� Ȯ���Ѵ�.
select * from tab;


-- ���̺��� ����(��Ű��) Ȯ�� �÷��� �ڷ���, ũ�� ���� Ȯ���Ѵ�.
desc tb_number;

-- ���� ������ ���̺� ���ο� �÷� �߰��ϱ� 
-- tb_number ���̺� email column�� �߰��Ͻÿ�.
-- alter table ���̺�� add �߰��� �÷��� �ڷ���(ũ��) ��������;
alter table tb_number add email varchar2(100);
desc tb_number;


--@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@


-- ���� ������ ���̺� �÷� �����ϱ�
-- tb_number ���̺� email �÷��� ����� 200���� Ȯ���Ͻÿ�
-- �̸��� ����Ǵ� username �÷��� 60���� Ȯ���Ͻÿ�
-- ���� : alter table ���̺�� modify �������÷��� �ڷ���(ũ��); 

alter table tb_number modify email varchar2(200);

create table tb_employees(
    employee_id	number(6,0),
    first_name	varchar2(20 byte),
    last_name	varchar2(25 byte),
    email	varchar2(25 byte),
    phone_number	varchar2(20 byte),
    hire_date date,
    job_id	varchar2(10 byte),
    salary	number(8,2),
    commission_pct	number(2,2),
    manager_id	number(6,0),    
    department_id	number(4,0)
);

desc tb_employees;
select * from tab;


-- tb_employees �� ������� �����Ƿ� �����Ͻÿ�!

drop table tb_employees;
select * from tab;
drop table employ;
select * from employ;  -- ��ü�� ���������ʱ⶧���� ���� 
desc tb_number;

alter table tb_number drop column email;
desc tb_number;


-- tb_number�� ���̺� ���ο� ���ڵ带 �����մϴ�. (DML�κп��� �н��� �����Դϴ�.)
-- ������ table space ��� ������ ��� ������ ���� ���� �����Դϴ�.  ?? ���ڵ� ������ ���ϴ� study����

insert into tb_number values
    (1, 'hing', '1234', 'ȫ�浿','20');
insert into tb_number values
    (2, 'yu', '5678', '����','50');
    
select * from tb_number;
    

-- ����Ŭ 11g������ ���ο� ������ ������ �� connect, resource �� Role�� �ο��ϸ� ���̺����, ���Ա��� ������
-- �� ���Ĺ��������� ���̺� �����̽� ���� ������ �߻��մϴ�.
-- ���� �Ʒ��� ���� ���̺� �����̽��� ���� ���ѵ� �ο��ؾ� �Ѵ�. --- �ش����� system �������� �������� ����!!

grant unlimited tablespace to study;

--@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@


-- table copy 1 : ���ڵ���� �Բ� ���� 
--@@@@ select ���� ����Ҷ� where���� ������ ��� ���ڵ带 ����϶�� ����̹Ƿ� 
--     �Ʒ������� ��� ���ڵ带 �����ͼ� ���纻 ���̺��� �����Ѵ�. ��, ���ڵ���� �����Ѵ�.

create table tb_number_copy as select * from tb_number;
desc tb_number_copy;
select * from tb_number_copy;  -- ���ڵ���� ��� �����!

-- table copy 2 : �Ӽ��� ����.  ���ڵ� �����ϰ� ���̺� ������ ���� 

create table tb_number_empty as select * from tb_number where 1=0;
desc tb_number_empty;
select * from tb_number_empty;


--@@ DDL ���̺��� ���� �� �����ϴ� query�� 
-- data defination language
-- ���̺� ���� 
-- ���̺� ����.�÷��߰�.����.����
-- ���̺� ����
-- ���̺� ����.���ڵ�o.���ڵ�x




--@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@

--�������� 
-- study �������� �Ͻÿ�.
/*
1. ���� ���ǿ� �´� ��pr_dept�� ���̺��� �����Ͻÿ�.
    dno number(2),
    dname varchar2(20),
    loc varchar2(35)
*/


/*
2. ���� ���ǿ� �´� ��pr_emp�� ���̺��� �����Ͻÿ�.



/*
3. pr_emp ���̺��� ename �÷��� varchar2(50) �� �����Ͻÿ�.
*/


/*
4. 1������ ������ pr_dept ���̺��� dname Į���� �����Ͻÿ�.
*/


/*
5. ��pr_emp�� ���̺��� job �÷��� varchar2(50) ���� �����Ͻÿ�.
*/




























