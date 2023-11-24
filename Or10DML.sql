/************************   study �������� �ϱ�
���ϸ�: Or10DML
Data Manipulation Language --  ������ ���۾�
���� : ���ڵ带 ������ �� ����ϴ� query�� �տ��� �н��ߴ� select���� ����Ͽ�  update,delete,insert�� �ִ�.

************************/

--���ڵ� �Է��ϱ� : insert
--    ���ڵ� �Է��� ���� query�� �������� �ݵ�� ' �� ���ξ��Ѵ�.
--    �������� ' ���� �׳� ����ȴ�. ���� �������� ' �� ���θ� �ڵ����� 
--    ��ȯ�Ǿ� �Էµȴ�.
    
-- ���ο� ���̺� �����ϱ� 

create table tb_sample(
    dept_no number(10),
    dept_name varchar2(20),
    dept_loc varchar2(15),
    dept_manager varchar2(30)
    );    
desc tb_sample;

-- data insert ������ �Է�
-- 1. �÷��� ������ �� insert
insert into tb_sample ( dept_no,dept_name, dept_loc, dept_manager)
    values(10, '��ȹ��', '����', '����');
select * from tb_sample;
insert into tb_sample ( dept_no,dept_name, dept_loc, dept_manager)
    values(20, '������', '����', '����');
select * from tb_sample;

-- 2. �÷� �������� ��ü �÷��� ������� insert�Ѵ�.
insert into tb_sample values(30, '������', '�뱸', '���');
insert into tb_sample values(40, '�λ���', '�λ�', '�糪');
select * from tb_sample;

--@@@   �÷��� �����ؼ� insert�ϴ� ��� �����͸� �������� ���� �÷��� ������ �� �ִ�.
--      �Ʒ��� ���� dept_name�� null�� �ȴ�.
insert into tb_sample ( dept_no, dept_loc, dept_manager)
    values(20, '����', '����');
select * from tb_sample;  -- ������ null�� ����.  �÷��� ���� ��� ���ٸ� null �̶�� ��.

-- ���ݱ����� �۾�(Ʈ�����)�� �״�� �����ϰڴٴ� ������� Ŀ���� �������� �ʴ´ٸ� 
-- �ܺο����� ����� ���ڵ带 Ȯ���� �� ����.    Ŀ���� ���ٸ�  ����ǻ�� �ȿ��� ���ڵ����� 
-- ���⿡�� ���ϴ� �ܺδ� java/jsp �� ���� orcle �̿��� ���α׷��� ���Ѵ�.
-- ## Ʈ������̶� �۱ݰ� ���� �ϳ��� �����۾��� ���Ѵ�.   JUST TEST

commit;   -- Ŀ�� �Ϸ�!  ���� �ܺο��� ������ ��밡�� 

-- commit ���� ���ο� ���ڵ带 �����ϸ� �ӽ����̺� ����˴ϴ�.

insert into tb_sample values(60, '������', '����', '�����');
-- oracle���� Ȯ���ϸ� ���� ���Ե� ��ó�� �������� ������ �ݿ����� ���� �����̴�.
-- ���̴� ������ �ܼ��� �ϵ忡 ����� �� ��ǻ�Ϳ� ������ �������� �ܺο����� Ȯ���� �� ����.


-- �ѹ� ������� ������ Ŀ�� ���·� �ǵ����� �ִ�.
rollback;
select * from tb_sample;  -- ������ �Է��� ����� ���� ����������
-- 48���� �����ʹ� �������� �ȴ�. �� commit �ٷ� ���ķ� ���ư���.

-- rollback ��ɤ��� ������ Ŀ�� ���·� �ǵ����ش�.
-- commit �� ������ ���·δ� rollback �� �� ����. 


-- data update : ���ڵ� �����ϱ�
-- update tablename set colmn1=value1,colmnN=valueN  where ���� 
-- ���̺�� �տ� from �� ���� �ʴ´� @@@@@

-- �μ���ȣ 40�� ���ڵ��� ������ �̱����� �����Ͻÿ�.
update tb_sample set dept_loc ='�̱�' where dept_no = 40;
-- ������ ������ ���ڵ��� �Ŵ������� ' ������' ���� �����Ͻÿ� 
update tb_sample set dept_manager ='������' where dept_loc = '����';
select * from tb_sample;



-- ��� ���ڵ带 ������� ������ '����'���� �����Ͻÿ� 
update tb_sample set dept_loc = '����';
-- ��ü ���ڵ尡 ����̹Ƿ� where �������� �߰����� �ʴ´�.
select * from tb_sample;


-- data delete : ���ڵ� �����ϱ�
-- ���ڵ带 �����ϹǷ� delete �ڿ� �÷��� ��������ʴ´�.

--@ �μ���ȣ�� 10�� ���ڵ带 �����Ͻÿ�
delete from tb_sample where dept_no = 20;
select *from tb_sample;

--@ ���ڵ� ��ü�� �����Ͻÿ�
-- where ���� ������ ��� ���ڵ尡 �����ȴ�. 
delete from tb_sample;


-- �������� commit �ߴ� �������� �ǵ����ϴ�. 
rollback;
select *from tb_sample; --



-- DML ( Data Manipulation Language)  ������ ���۾� : ���ڵ带 �Է� �� �����ϴ� query���Դϴ�.
-- ���ڵ� �Է� ���� ����  #INSERT #UPDATE #DELETE 
--INSERT �� ��� �÷��� ������ �� �ִ�.
--DELETE �� ��� ������ ��� ���ڵ� ��������


--@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@��������

/*
1. DDL�� �������� 2������ ���� ��pr_emp�� ���̺� ������ ���� ���ڵ带 
�����Ͻÿ�.
1, '���¿�', '��¹�', to_date('1975-11-21') -- ���1
2, '������', '���л��¹�', to_date('1978-07-23') 
3, '�Ѱ���', '�����', to_date('1982-10-24')  -- ���2
4, '�����', '���л�����', to_date('1988-05-21')
*/


/*
2. pr_emp ���̺��� eno�� ¦���� ���ڵ带 ã�Ƽ� job �÷��� 
������ ������ ���� �����Ͻÿ�.
job=job||'(¦��)'
job=concat(job,'(Ȧ��)')
*/

/*
3. pr_emp ���̺��� job �� ���л��� ���ڵ带 ã�� �̸��� �����Ͻÿ�. 
���ڵ�� �����Ǹ� �ȵ˴ϴ�.
*/



/*
4.  pr_emp ���̺��� ������� 10���� ��� ���ڵ带 �����Ͻÿ�.
*/


/*
5. pr_emp ���̺��� �����ؼ� pr_emp_clone ���̺��� �����ϵ� ���� ���ǿ� �����ÿ�. 
����1 : ������ �÷����� idx, name, nickname, regidate �Ͱ��� �����ؼ� �����Ѵ�. 
����2 : ���ڵ���� ��� �����Ѵ�. 
*/



/*
6. 5������ ������ pr_emp_clone ���̺���� pr_emp_rename ���� �����Ͻÿ�.
*/


/*
7. pr_emp_rename ���̺��� �����Ͻÿ�
*/

    
    
    



































