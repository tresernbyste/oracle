/************************   study �������� �ϱ�
���ϸ�: Or13Constraint
�������� Constraint
���� : ���̺� ������ �ʿ��� �������� �������ǿ� ���� �н��մϴ�.
************************/

--primary key �⺻Ű : ���� ���Ἲ�� �����ϱ� ���� �������� 
--                     �ϳ��� ���̺� �ϳ��� �⺻Ű�� ������ �� �ִ�.
--                     �⺻Ű�� ������ �÷��� �ߺ��� ���̳� Null���� �Է��� �� ����.
--                     �ַ� ���ڵ� �ϳ��� Ư���ϱ� ���� ���ȴ�.

-- ���� 1 : �ζ��ι�� : �÷� ������ ������ ���� ������ ����Ѵ�.
-- create table ���̺�� ( �÷��� �ڷ���(ũ��) [constraint �����] primary key );
-- ## []���ȣ �κ��� ���������ϰ� ������ ������� �ý����� �ڵ����� �ο��Ѵ�.

create table tb_primary1 ( idx number(10) primary key, user_id varchar2(30), user_name varchar2(50) );

desc tb_primary1;
--�̸�        ��?       ����           
----------- -------- ------------  ## not null
--IDX       NOT NULL NUMBER(10)   
--USER_ID            VARCHAR2(30) 
--USER_NAME          VARCHAR2(50) 

-- �������� �� ���̺� ��� Ȯ���ϱ� 
-- tab : ���� ������ ������ ���̺��� ����� Ȯ���� �� �ִ�.
-- user_cons_columns : ���̺� ������ �������ǰ� �÷����� ������ ������ �����Ѵ�.
-- user_constraints : ���̺� ������ ���������� ���� ������ �����Ѵ�.
-- ## �̿� ���� ���� �����̳� ��, ���ν������� ������ �����ϰ� �ִ� �ý��� ���̺��� "������ ����"�̶�� �մϴ�.

select * from tab;
select * from user_cons_columns;
select * from user_constraints;

-- ���ڵ� �Է� 
insert into tb_primary1 ( idx , user_id , user_name)
    values (1, 'boopyung1' , '����'); 
insert into tb_primary1 ( idx , user_id , user_name)
    values (2, 'boopyung2' , '�����');     
insert into tb_primary1 ( idx , user_id , user_name)
    values (2, 'boopyung3' , '�����߻�'); -- idx (primary key) �� �ݺ��Ǿ���. ���Ἲ ���� ���� ����� �����߻�    PK�� ������ �÷� idx���� �ߺ��� ���� �Էµ� �� ����. 
insert into tb_primary1  values (3, 'white' , 'ȭ��Ʈ');     
insert into tb_primary1  values ('', 'black' , '��');   --�����߻� null ���̹Ƿ� �Է��� �� ����.

select * from tb_primary1;


update tb_primary1 set idx = 2 where user_name ='���꽽';   --update���� ���������� idx ���� �̹� �����ϴ� 2�� ���������Ƿ� ������������� ������ �߻��Ѵ�.





-- �ƿ����� ��� 
-- create table ���̺�� (   �÷��� �ڷ��� (ũ��) [constraint �����] primary key (�÷���)    );

create table tb_primary2 ( idx number(10), user_id varchar2(30), user_name varchar(50) , constraint my_pk1 primary key(user_id) );
desc tb_primary2;
--�̸�        ��?       ����           
--IDX                NUMBER(10)   
--USER_ID   NOT NULL VARCHAR2(30) 
--USER_NAME          VARCHAR2(50) 

select * from user_cons_columns;
select * from user_constraints;

insert into tb_primary2  values (1, 'white' , 'ȭ��Ʈ');     
insert into tb_primary2  values (2, 'white' , 'ȭ��Ʈ2');   --  user_name �� primary key �̱⶧���� ���� �߻�

select * from tb_primary2;








-- ���� 3 : ���̺��� �������� alter������ �������� �߰� 
-- alter table ���̺�� add [constraint �����] primary key (�÷���) ;


create table tb_primary3 ( idx number(10), user_id varchar2(30), user_name varchar(50) );

-- ���̺��� ������ �� alter ����� ���� ���������� �ο��� �� �ִ�.
-- ������� ��� ������ �����ϴ�.

alter table tb_primary3 add constraint tb_primary3_pk
    primary key (user_name);
    -- "������ ����"���� �������� Ȯ���ϱ� 
    
select * from user_cons_columns;
select * from user_constraints;
-- ���������� ���̺��� ������� �ϹǷ� ���̺��� �����Ǹ� ���� �����ȴ�.

drop table tb_primary3;  -- Ȯ�ν� �����뿡 �� ���� �� �� �ֽ��ϴ�.

select * from user_cons_columns;



-- PK�� ���̺�� �ϳ��� ������ �� �ִ�. ���� �ش� ������ ������ �߻��մϴ�. 
create table tb_primary4 ( idx number(10)primary key , user_id varchar2(30) primary key, user_name varchar(50) );  -- ���̺�� �ϳ��� PK�� ������ �� �ִ�.




















    
    