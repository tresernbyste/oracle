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
    values (2, 'boopyung3' , '�����߻�'); -- idx (primary key) �� �ݺ��Ǿ���. ���Ἲ ���� ���� ����� �����߻�   
                                          -- PK�� ������ �÷� idx���� �ߺ��� ���� �Էµ� �� ����. 
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



--unique ����ũ 
-- ���� �ߺ��� ������� �ʴ� ������������ 
-- ����, ���ڴ� �ߺ��� ������� �ʽ��ϴ�.
-- ������ null���� ���ؼ��� �ߺ��� ����Ѵ�.
-- unique �� ���̺� 2���̻� ������ �� �ִ�.

-- 2���� �÷��� ���ļ� �����Ѵ�.  �̰�� ������ ������������ unique�� �����ȴ�.

create table tb_unique ( 
    idx number unique not null, 
    name varchar2(30), 
    phone varchar2(30), 
    nickname varchar2(30),
    
    unique(phone,nickname));  -- ��,�г����� ����ũ�� ����  ����, ������ �ߺ��Ұ�  null���δ� �ߺ�����
    
insert into tb_unique (idx, name, phone, nickname)
    values(1, '���̸�', '010-1111-1111', '���座��');
insert into tb_unique (idx, name, phone, nickname)
    values(2, '����', '010-2222-2222', '');
insert into tb_unique (idx, name, phone, nickname)
    values(3, '����', '', '');
    
--unique�� �ߺ��� ��������ʴ� �������������� null�� ������ �Է��� �� �ִ�.

select * from tb_unique;

-- idx �÷��� �ߺ��� ���� �ԷµǹǷ� ������ �߻��ȴ�.
insert into tb_unique (idx, name, phone, nickname) 
    values(1, '����', '010-3333-3333', '');
insert into tb_unique values(4, '���켺', '010-4444-4444', '��ȭ���');
insert into tb_unique values(5, '������', '010-5555-5555', '��ȭ���');
insert into tb_unique values(6, 'Ȳ����', '010-4444-4444', '��ȭ���');   -- phone �� ���⶧���� �Ұ��� 

--phone �� nickname�� ������ ��������� �����Ǿ����Ƿ� �ΰ��� �÷��� ���ÿ� ������ ���� ������ ��찡 �ƴ϶�� �ߺ��� ���� ���ȴ�.
-- ��, 4���� 5���� ���δٸ� �����ͷ� �νĵǹǷ� �Է��� �ǰ� 4���� 6���� ������ �����ͷ� �νĵǾ� ������ �߻��Ѵ�.
select * from user_cons_columns;











-- foreign key �ܷ�Ű(����Ű) : �ܷ�Ű�� ���� ���Ἲ�� �����ϱ� ���� ������������
-- ���� ���̺� �� �ܷ�Ű�� �����Ǿ� �ִٸ� �ڽ����̺� �������� ������ ��� �θ� ���̺� ���ڵ�� �����Ҽ� �����ϴ�. 

--���� 1(�ζ��� ���) : ���� �ȿ��� �ܷ�Ű����
-- create table ���̺�� (  �÷��� �ڷ��� [constraints �����] references �θ����̺�� (������ �÷���)   );

create table tb_foreign1(
    f_idx number(10) primary key,
    f_name varchar2(50),
    -- �ڽ����̺��� tb_foreign1���� �θ����̺��� tb_primary2�� user_id �÷��� �����ϴ� �ܷ�Ű�� �����մϴ�.
    f_id varchar2(30) constraint tb_foreign_fk1
        references tb_primary2( user_id)
    );
--�θ����̺��� ���ڵ� 1�� ���ԵǾ� ����.
select * from tb_primary2;

--�ڽ����̺��� ���ڵ尡 ���� �����Դϴ�.
select * from tb_foreign1;

--���Ἲ ���������� ����Ǿ����ϴ�. �θ�Ű�� �����ϴ�. (��������)
--�θ����̺��� gildong �̶�� ���̵𰡾��� �θ�� ������Ѵ�.
insert into tb_foreign1 values ( 1, 'ȫ�浿','gildong');

--�����Ͱ��� �¾ƾ� �Ѵ�?? ���̺����Ͱ� Ȱ��ȭ 
--�Է¼���. �θ����̺� white��� ���̵� ����.
insert into tb_foreign1 values ( 1, '�Ͼ��','white');  

--�ڽ����̺��� �����ϴ� ���ڵ尡 �����Ƿ� �θ����̺� ���ڵ带 ������ �� �����ϴ�.
--�� ��� �ݵ�� �ڽ����̺� ���ڵ带 ���� ������ �� �θ����̺� ���ڵ带 ������ �� �ִ�.

--�ڽķ��ڵ尡 �߰ߵǾ����ϴ�.  �����߻�
delete from tb_primary2 where user_id = 'white';

--�ڽ����̺��� ���ڵ带 ���� ������ �� 
delete from tb_foreign1 where f_id = 'white'; -- �ڽķ��ڵ� �����Ϸ� 

--�ڽķ��ڵ� ������ �θ��ڵ� ���� ����
delete from tb_primary2 where user_id = 'white'; -- �����Ǿ����ϴ�.

-- ��� ���ڵ尡 ������ �����̴�.
select * from tb_foreign1;
select * from tb_primary2;

-- 2���� ���̺��� �ܷ�Ű(����Ű)��  �����Ǿ� �ִ� ��� 
-- �θ����̺� ������ ���ڵ尡 ���ٸ� �ڽ����̺� insert �� �� ����.
-- �ڽ����̺� �θ� �����ϴ� ���ڵ尡 ���������� �θ����̺� ���ڵ带 ������ �� ����.



-- foreign key �ƿ����� ��� : 
-- ���� : create table ���̺�� (   �÷��� �ڷ��� [constraint �����]  foreign key (�÷���)  references �θ����̺� (������ �÷�)   );

create table tb_foreign2 ( 
    f_id number primary key,
    f_name varchar2(30) ,
    f_date date,
    foreign key(f_id) references tb_primary1 (idx)
    );
    
select * from user_cons_columns;
select * from user_constraints;

--������ �������� �������� Ȯ�νÿ� �÷���
--  P : primary key 
--  R : references integrity  -- foreign key�� �ǹ���
--  C : check Ȥ�� not null 
--  U : unique 

-- ���̺� ������ alter ������ �ܷ�Ű ���� ���� �߰��� �� �ִ�.
-- alter table ���̺�� add [constraint �����]  foreign key (�÷���)   references �θ����̺� (������ �÷�)   );

create table tb_foreign3 ( 
    idx number primary key, 
    f_name varchar2(30),
    f_idx number(10)
    );

alter table tb_foreign3 add foreign key (f_idx) references tb_primary1 (idx) ;

select * from user_cons_columns;
select * from user_constraints;

-- �ϳ��� �θ����̺� �� �̻��� �ڽ����̺��� �ܷ�Ű�� ������ �� �ִ�.  primary1 -�θ����̺� �ΰ��� �ܷ�Ű�� ����Ҽ� �ִ�.


-- �ܷ�Ű ���� �ɼ� 
-- [on delete cascade]
-- �θ��ڵ� ������ �ڽķ��ڵ���� ���� �����ȴ�. 
-- ���� : �÷��� �ڷ��� refrreences �θ����̺� (pk�÷�)
--      on delete cascade;

-- [on delete set null] 
-- ���� : �÷��� �ڷ��� references �θ����̺� (pk�÷�)
        --  on delete se null 
-- �ǹ����� ����Խù��� ���� ȸ���� �� �Խñ��� �ϰ������� �����ؾ��� �� ����Ҽ� �ִ� �ɼ��̴�.
-- ��, �ڽ����̺��� ��� ���ڵ尡 �����ǹǷ� ��뿡 �����ؾ��Ѵ�.

create table tb_primary4 (
    user_id varchar2(30) primary key,
    user_name varchar2(100)
    );

create table tb_foreign4 (
    f_id number(10) primary key, 
    f_name varchar2(30),
    user_id varchar2(30) constraint tb_foreign4_fk references tb_primary4 (user_id) on delete cascade);

-- �ܷ�Ű�� ������ ��� �ݵ�� �θ����̺� ���ڵ带 ���� �Է��� �� �ڽ� ���̺� �Է��ؾ� �Ѵ�.

insert into tb_primary4 values ('student','�Ʒû� 1'); 
insert into tb_foreign4 values (1,'����1�Դϴ�.','student'); 
insert into tb_foreign4 values (2,'����2�Դϴ�.','student'); 
insert into tb_foreign4 values (3,'����3�Դϴ�.','student'); 
insert into tb_foreign4 values (4,'����4�Դϴ�.','student'); 
insert into tb_foreign4 values (5,'����5�Դϴ�.','student'); 
insert into tb_foreign4 values (6,'����6�Դϴ�.','student'); 
insert into tb_foreign4 values (7,'����7�Դϴ�.','student'); 

-- �θ�Ű�� �����Ƿ� ���ڵ带 ������ �� ����. �����߻� 
insert into tb_foreign4 values (8,'��?? ����???','teacher'); 


--�տ��� ������ ���ڵ尡 �ԷµǾ��ִ� ������.
select * from tb_primary4;   -- 1��
select * from tb_foreign4;  -- 7��

--�θ����̺��� ���ڵ带 ������ ��� on delete cascade �ɼǿ� ���� �ڽ��ʱ��� ��� ���ڵ尡 �����ȴ�.
-- ���� �ش� �ɼ��� �������� ���·� �ܷ�Ű�� �����ߴٸ� ���ڵ�� �������� �ʰ� ������ �߻��˴ϴ�.
delete from tb_primary4 where user_id = 'student';

-- ���� �����Ǵ� ���� Ȯ���� �� �ִ�. �θ�, �ڽ� ���̺��� ��� ���ڵ� ����
select * from tb_primary4;   
select * from tb_foreign4;  




--///////////////////////////////////////////////////////////////////////////////////////////////////////////

-- on delete set null �ɼ� �׽�Ʈ


create table tb_primary6 (
    user_id varchar2(30) primary key,
    user_name varchar2(100)
    );

create table tb_foreign6 (
    f_id number(10) primary key, 
    f_name varchar2(30),
    user_id varchar2(30) constraint tb_foreign6_fk references tb_primary6 (user_id) on delete set null);
    

insert into tb_primary6 values ('student','�Ʒû� 1'); 
insert into tb_foreign6 values (1,'����1�Դϴ�.','student'); 
insert into tb_foreign6 values (2,'����2�Դϴ�.','student'); 
insert into tb_foreign6 values (3,'����3�Դϴ�.','student'); 
insert into tb_foreign6 values (4,'����4�Դϴ�.','student'); 
insert into tb_foreign6 values (5,'����5�Դϴ�.','student'); 
insert into tb_foreign6 values (6,'����6�Դϴ�.','student'); 
insert into tb_foreign6 values (7,'����7�Դϴ�.','student'); 

select * from tb_primary6;
select * from tb_foreign6;

-- on delete se null �ɼ����� �ڽ����̺��� ���ڵ�� �������� �ʰ�, ����Ű �κи� null������ ����ȴ�. ���� ���̻� ������ �� ���� ���ڵ�� ����˴ϴ�.
delete from tb_primary6 where user_id = 'student';


-- Ex �θ� �߸� ������ �ڽ��� ���ڵ�� �״�� �ΰ� �θ��ڵ常 ���� �����ϰ� ������ �����ϴ� ������� ���� �� �ִ�.

select * from tb_primary6;   -- �θ��ڵ�� ��� �����Ǵ°��� Ȯ���� �� �ִ�.
select * from tb_foreign6;   -- user_id �� ��� null�� �ٲ�� �ִ°��� Ȯ���� �� �ִ�.  ��, ���� �÷��� null�� ����˴ϴ�.


/*
 �Խ����� ���ε�� �����ϸ� ���� 
 �θ����̺�� ȸ�������� ������ �ִ� ���·� 
    �Խ��Ǻ��� �����ϱ� ���� 
*/


-- not null : null ���� ��������ʴ� �������� 
/*
-- ���� :  create table ���̺�� (  
    �÷��� �ڷ��� not null , 
    �÷��� �ڷ��� null,   -- null �� ����Ѵٴ� �ǹ̷� �ۼ������� �̷��� ��������ʴ´�. null�� ������������� �ڵ����� ����Ѵٴ� �ǹ̰� �ִ�.*/

create table tb_not_null (
    m_idx number(10) primary key,    -- PK�̹Ƿ� not null
    m_id varchar2(20) not null,
    m_pw varchar2(30) null,    -- �Ϲ������� �̷��� ������� �ʴ´�.
    m_name varchar2(40)        -- null�� ���� 
    );
    

desc tb_not_null;
/*
M_IDX  NOT NULL NUMBER(10)   
M_ID   NOT NULL VARCHAR2(20) 
M_PW            VARCHAR2(30) 
M_NAME          VARCHAR2(40)    
*/

insert into tb_not_null values ( 10, 'hong1', '1111', 'ȫ�浿');
insert into tb_not_null values ( 20, 'hong2', '2222', '');
insert into tb_not_null values ( 30, 'hong3', '', '');
insert into tb_not_null values ( 40, '3', '', '');
insert into tb_not_null values ( 50, '', '', ''); -- not null �� null ���ԺҰ��� �����߻�

insert into tb_not_null values ( 60, ' ', '6666', '���浿');   -- ' ' ������ �ƽ�Ű�ڵ忡�� ���ڷ� �ν��Ѵ�.  ���� != not null


-- m_id�� primarykey ���� null ���� �Է��� �� �����ϴ�. 
-- �÷��� ������������� null�� �Էµ˴ϴ�.
insert into tb_not_null ( m_id, m_pw, m_name)    -- ( idx , m_id, m_pw, m_name) 
    values ('hong6','6666','���浿');

select * from tb_not_null;

----------------------------------------------------------------------------------------------------------------------------------

--default  : insert �� �ƹ��� ���� �Է����� �ʾ��� �� �ڵ����� ���ԵǴ� �����͸� ������ �� �ֽ��ϴ�.

create table tb_default ( 
    id varchar2(30) not null,
    pw varchar2(50) default 'gwer'
    );
    
insert into tb_default values ('aaa','1234');

select * from tb_default;
    
insert into tb_default (id) values ('bbb');
insert into tb_default (id, pw) values ('bbb','');  -- null �� �� != �ƹ��͵� �Է��������� 
insert into tb_default values ('dddd',' ');  -- ������ ���ڷ� �ν��ϱ⶧���� ���鸸 �Էµ�
insert into tb_default values ('eeee',default);  -- �̸� ���ص� default ���� �Էµ� qwer

-- default ���� �Է��Ϸ��� insert ������ �÷� ��ü�� ���ܽ�Ű�ų� default Ű���带 ����ؾ��Ѵ�.



---------------------------------------------------------------------------------------------------


-- Check : Domain(�ڷ���)  ���Ἲ�� �����ϱ� ���� ������������ �ش� �÷��� �߸��� �����Ͱ� �Էµ��� �ʵ��� �����ϴ� ���������̴�.
-- M, F �� �Է��� ����ϴ�  Check �������� 

create table tb_check1 (
    gender char(1) not null,
        constraint check_gender 
            check ( gender in ('M','F'))
            );
            
select * from tb_check1;

insert into tb_check1 values ('M');
insert into tb_check1 values ('F');
insert into tb_check1 values ('T');  -- üũ ���������� ���� 
insert into tb_check1 values ('����');  --  �Էµ� �����Ͱ� �÷��� ũ�⺸�� ũ�Ƿ� ���� �߻�


-- 10������ ���� �Է��� �� �ִ� check �������� ����

create table tb_check2 (
    sale_count number not null check (sale_count<= 10)
    );
    
insert into tb_check2 values (9);
insert into tb_check2 values (10);
insert into tb_check2 values (11);      --  �������� ����� �Է��� ���е˴ϴ�.     
    
select * from tb_check2;















