/************************   study �������� �ϱ�
���ϸ�: Or14  sequence and index 
���� : ���̺��� �⺻Ű �ʵ忡 �������� �Ϸù�ȣ�� �ο��ϴ� �������� 
       �˻��ӵ��� ����ų�� �ִ� �ε��� 
************************/

/*
������ : ���̺��� �÷�(�ʵ�)�� �ߺ����� �ʴ� �������� �Ϸù�ȣ�� �ο��Ѵ�.
         �������� ���̺� ������ ������ ������ �մϴ�.
         ��, �������� ���̺�� ���������� ����ǰ� �����˴ϴ�.

[������ ���� ����] 
    create sequence �������� 
        [increment by N]            ����ġ ����
        [Start with N]              ���۰� ����
        [Minvalue n | NoMinvalue]   ������ �ּҰ� ����  default 1
        [Maxvalue n | NoMaxvalue]   ������ �ִ밪 ����  default 1.0000E+28
        [Cycle | NoCycel]           �ִ밪 ���޽� �ݺ� ����  Cycle�� �����ϸ� �ִ밪���� ������ �ٽ� ���۰����� �� ���۵�
        [Cache | NoCache]           cache �޸𸮿� ����Ŭ ������ ������ ���� �Ҵ��ϴ�  ���θ� �����մϴ�.


���ǻ��� 
    1. start with �� minvalue ���� �������� ������ �� ����.   �� start with ���� minvalue�� ���ų� Ŀ���Ѵ�. 
    2. Nocycle �� �����ϰ� �������� ��� ���� �� maxvalue�� �������� �ʰ��ϸ� ������ �߻��մϴ�.
    3. primary key�� cycle �ɼ��� ���� �����ϸ� �ȵȴ�. 
*/

create table tb_goods (
    g_idx number(10) primary key,
    g_name varchar2(30)
    );
    
insert into tb_goods values(1,'�������ݸ�');
insert into tb_goods values(1,'�����');       -- primary key ���� ���Ƽ� ���Ἲ �������� ���� 

-- ������ ���� 

create sequence seq_serial_number 
    increment by 1                  -- ����ġ 1
    start with 100                  -- �ʱⰪ 100
    minvalue 99                     -- �ּҰ� 99
    maxvalue 110                    -- �ִ밪 110
    cycle                           -- �ִ밪 ���޽� �ݺ� ����
    nocache;                        -- ĳ�ø޸� ��뿩�� NO

select * from user_sequences;       -- ������ �������� ������ ������ Ȯ���ϱ� 

/*
������ ���� �� ���ʽ���� ������ �߻��մϴ�. 
*/

-- ������ SEQ_SERIAL_NUMBER.CURRVAL�� �� ���ǿ����� ���� �Ǿ� ���� �ʽ��ϴ�  
-- nextval�� ���� ������ �� �����մϴ�.
select seq_serial_number.currval from dual;   

-- ���� �Է��� ������(�Ϸù�ȣ)�� ��ȯ �մϴ�. �����Ҷ����� �������� �Ѿ�ϴ�.
select seq_serial_number.nextval from dual;
-- g_idx number �� primary key�� ������ �ξ��� ������ �����߻�   ## �⺻Ű�� ����Ŭ�� ���� ����� ����  
insert into tb_goods values ( seq_serial_number.nextval , '�ܲʹ��1');
insert into tb_goods values ( seq_serial_number.nextval , '�ܲʹ��2');
insert into tb_goods values ( seq_serial_number.nextval , '�ܲʹ��3');
insert into tb_goods values ( seq_serial_number.nextval , '�ܲʹ��4');
insert into tb_goods values ( seq_serial_number.nextval , '�ܲʹ��5');
insert into tb_goods values ( seq_serial_number.nextval , '�ܲʹ��6');
insert into tb_goods values ( seq_serial_number.nextval , '�ܲʹ��7');
insert into tb_goods values ( seq_serial_number.nextval , '�ܲʹ��8');
insert into tb_goods values ( seq_serial_number.nextval , '�ܲʹ��9');
insert into tb_goods values ( seq_serial_number.nextval , '�ܲʹ��10');
select * from tb_goods;

/*
�������� ����Ŭ �ɼǿ� ���� �ִ밪�� �����ϸ� �ٽ� ó������ �Ϸù�ȣ�� �����ǹǷ� ���Ἲ �������ǿ� ����˴ϴ�.
��, �⺻Ű�� ����� �������� ����Ŭ �ɼ��� ������� �ʾƾ� �Ѵ�.
*/

select seq_serial_number.currval from dual;  -- ������ �� ���� �������� ���� ��ȣ��� �� �� ����

-------------------------------------------------------------------------------------------------------------

/*
�������� ���� : start with �� �������� �ʴ´�. �ʱ⿡ ������ ���� ������ �� ����. 
*/

alter sequence seq_serial_number 
    increment by 10
    minvalue 1
    nomaxvalue
    nocycle
    nocache;
-- ������ ������ �������� Ȯ���ؾ��մϴ�.

select * from user_sequences;

--����ġ�� 10���� ����� ���� Ȯ����   104 -- 114
select seq_serial_number.nextval from dual;

--�������� ���� drop 
drop sequence seq_serial_number;
select * from user_sequences;   -- ���� �Ϸ� Ȯ�� 

-- �Ϲ����� ������ ������ �Ʒ��� ���� �ϸ� �˴ϴ�.
create sequence seq_serial_num 
    start with 1
    increment by 1
    minvalue 1
    nomaxvalue 
    nocycle
    nocache;
    
-----------------------------------------------------------
-----------------------------------------------------------
-----------------------------------------------------------


/* 
�ε��� (INDEX) 
    ���� �˻��ӵ��� ����ų�� �ִ� ��ü 
    �ε����� �����(create index)�� �ڵ��� ( primarykey, unique) �� ������ �� �ִ�
    �÷��� ���� �ε����� ������ ���̺� ��ü�� �˻��ϰ� �ȴ�.
    ��, �ε����� ������ ������ ����Ű�� ���� �����Դϴ�.
    �ε����� �Ʒ��� ���� ��쿡 �����մϴ�.
        1.where�����̳� join���ǿ� ���� ����ϴ� �÷�
        2.�������� ���� �����ϴ� �÷�
        3.���� null���� �����ϴ� �÷�
*/

desc tb_goods;
--G_IDX  NOT NULL NUMBER(10)   
--G_NAME          VARCHAR2(30)
select * from tb_goods;


--�ε��� ���� . Ư�� ���̺��� �÷��� �����Ͽ� �����Ѵ�. 
create index tb_goods_name_idx on tb_goods (g_name);

--������ �ε��� Ȯ���ϱ� 
--������ �������� Ȯ���ϸ� PK Ȥ�� Unique �� ������ �÷��� �ڵ����� �ε����� ���������� �̹� ������ �ε����� ���� Ȯ�ε˴ϴ�.
select * from user_ind_columns;

--Ư�� ���̺��� �ε��� Ȯ��
--      ������ ������ ��Ͻ� �빮�ڷ� �ԷµǱ� ������ upper�� ���� ��ȯ�Լ��� ����ϸ� ���ϴ�.

select * from user_ind_columns where table_name = upper('tb_goods');

--������ ���� ���ڵ尡 �ִٰ� �����ϸ� �˻��ӵ��� ����� �ֽ��ϴ�.  ������ �� ���� 
select * from tb_goods where g_name like '%��%';

--�ε��� ���� 
drop index tb_goods_name_idx;

select * from user_ind_columns;

--�ε��� ������ �Ұ����մϴ�.  ������ �ٽ� �����ؾ� �մϴ�.




































