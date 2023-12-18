/************************   system ����
���ϸ�: Or15 DCL
DCL : Data Control Language (������ �����)
���� : ���ο� ����� ������ �����ϰ� �ý��۱����� �ο��ϴ� ����� �н�
************************/

/*
[����� ���� ���� �� ���� ����]
�ش� �κ��� DBA ������ �ִ� �ְ� ������ sys or system ���� ������ �� �����ؾ� �մϴ�.
���ο� ����� ������ ������ �� ���� �� �������� �׽�Ʈ�� CMD(���������Ʈ)â���� �����մϴ�.

1] ����� ���� ���� �� ��ȣ ����
���� : 
create user ���̵� identified  by ��й�ȣ ;

*/
--����Ŭ 12c ���� ���ʹ� �ش� ����� ���� ������ �� ������ �����ؾ� �Ѵ�.  C## 
--�̽��� ���¿��� ������ �����ϸ� �����߻� 
alter session set "_ORACLE_SCRIPT" = true; -- ���Ǻ�������������� ������ �տ� C##�� ���Խ��Ѿ߸��Ѵ�

-- ���� ���� ���� cmd���� sqlplus ������� ������ �õ��غ��� ���� ������ ���� ������ login denined ������ �߻��Ѵ�. 
create user test_user1 identified by 1234;

/*
2] ������ ����� ������ ���� Ȥ�� ���� �ο� 
���� :
grant �ý��۱���1,����2,,,,,N
    to ����ڰ����� 
        [with grant�ɼ�]
*/
--���ӱ����� �ο��Ѵ�.
--������ �ο��Ҷ��� to�� ����Ѵ�.

grant create session to test_user1;
--���� �ο��� ������ ���������� ���̺� ������ �Ұ����ϴ�.

--���̺� �������� �ο� 
grant create table to test_user1;

/*
3] ���� ��ȣ ���� 
���� : 
alter user ����ڰ����� identified by ������ ��ȣ;
*/
alter user test_user1 identified by 4321;

/* 
4] Role�� ���� �������� ������ ���ÿ� �ο��ϱ� 
    ���� ����ڰ� �پ��� ������ ȿ�������� ������ �� �ֵ��� ���õ� ���ѳ��� ������� ���� ���մϴ�
    �츮�� �ǽ��� ���� ���Ӱ� ������ ������ connect resource ���� �ַ� �ο��Ѵ�. 
*/

alter session set "_ORACLE_SCRIPT" = true; 
create user test_user2 identified by 1234;
grant connect, resource to test_user2;
/*
test_user2 ������ ���� ���� ������ �ο��� �� ���� �� ���̺� ������ ���������� �˴ϴ�.
*/
/*
4-1] �� �����ϱ� 
    ����ڰ� ���ϴ� ������ ���� ���ο� ���� �����մϴ�.
*/
create role my_role; 
/*
4-2] ������ �ѿ� ���� �ο��ϱ� 
    ���Ӱ� ������ �ѿ� ������ ������ �ο��մϴ�. 
*/
grant create session, create table, create view to my_role;

--���ο� ����� ������ �����մϴ�.
create user test_user3 identified by 1234;
--����ڿ��� ���� ���� ������ �ο��մϴ�. 
grant my_role to test_user3;
/*
test_user3 ��  ���� �� ���̺����, ��������� �����ϰ� �ȴ�.
*/

/*
4-3] �� �����ϱ� 
*/
drop role my_role;  --�� �ȿ� ������ ����ִ°�� �� ������ ������ �ִ� ���Ѹ�� ���� ����
                    --��, �� ���� �Ŀ��� ���� �̿� �Ұ����ϴ� 
                    
/*
5] �������� 
���� : revoke ����,���� from ����ھ��̵�; 
*/                    
revoke create session from test_user1;
-- test_user1�� ������ �� �����ϴ�. ���ӽ� ���� �߻�

/*
6] ����� ���� ����
���� : drop user ����ھ��̵� cascade;
## cascade ����ϸ� ����ڰ����� ���õ� ��� �����ͺ��̽� ��Ű���� �����ͻ������κ��� �����ǰ� ��罺Ű�� ��ü�� 
���������� ���� �����ȴ�. 
*/

--���� ������ ����� ����� Ȯ���� �� �ִ� �����ͻ��� 
select * from dba_users;

--������ �����Ϸ��� ��� �������� ��Ű������ ���� �����Ѵ�. 
alter session set "_ORACLE_SCRIPT"=true;

drop user test_user1 cascade;
select * from dba_users where lower(username) = 'test_user1';
select * from dba_users where lower(username) = 'test_user2';
select * from dba_users where upper(username) = 'TEST_USER3';


---------------------------------------------------------------
---------------------------------------------------------------

alter session set "_ORACLE_SCRIPT"=true;
create user test_user4 identified by 1234;
grant create session, create table to test_user4;

/*
���̺� �����̽���? 
    ��ũ ������ �Һ��ϴ� ���̺�� ��, �׸��� �� ���� �ٸ� �����ͺ��̽���ü���� ����Ǵ� ����̴�.
    ���� ��� ����Ŭ�� ������ ��ġ�ϸ� hr������ �����͸� �����ϴ� user��� ���̺� �����̽��� �ڵ����� �����ȴ�.
*/

-- ���̺� �����̽� ��ȸ�ϱ�
desc dba_tablespaces;

select tablespace_name, status, contents from dba_tablespaces;

--���̺� �����̽��� ��� ������ ����Ȯ���ϱ� 
select 
    tablespace_name, sum(bytes), max(bytes),
    trim(to_char(sum(bytes), '9,999,999,000'))"�հ�",
    trim(to_char(max(bytes), '9,999,999,000'))"�ִ�"
from dba_free_space
group by tablespace_name;

-- �տ��� ������ test_user4 ������� ���̺����̽� Ȯ���ϱ�
select username, default_tablespace from dba_users 
    where username in upper('test_user4');       -- users �� ���̺����̽� Ȯ��

--���̺� �����̽� ���� �Ҵ�
alter user test_user4 quota 2m on users;
/*
    test_user4�� system  ���̺����̽� ������ ���̺��� ������ �� �ֵ��� 
    2M�� �뷮�� �Ҵ��Ѵ�. 
*/
--cmd���� ���̺� insert �Ǵ��� Ȯ���غ��ϴ�. 
