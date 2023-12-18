/************************   system 계정
파일명: Or15 DCL
DCL : Data Control Language (데이터 제어어)
설명 : 새로운 사용자 계정을 생성하고 시스템권한을 부여하는 방법을 학습
************************/

/*
[사용자 계정 생성 및 권한 설정]
해당 부분은 DBA 권한이 있는 최고 관리자 sys or system 으로 접속한 후 실행해야 합니다.
새로운 사용자 계정이 생성된 후 접속 및 쿼리실행 테스트는 CMD(명령프롬포트)창에서 진행합니다.

1] 사용자 계정 생성 및 암호 설정
형식 : 
create user 아이디 identified  by 비밀번호 ;

*/
--오라클 12c 이후 부터는 해당 명령을 먼저 실행한 후 계정을 생성해야 한다.  C## 
--미실행 상태에서 계정을 생성하면 오류발생 
alter session set "_ORACLE_SCRIPT" = true; -- 세션변경하지않을경우 계정명 앞에 C##을 포함시켜야만한다

-- 계정 생성 직후 cmd에서 sqlplus 명령으로 접속을 시도해보면 접속 권한이 없기 때문에 login denined 에러가 발생한다. 
create user test_user1 identified by 1234;

/*
2] 생성된 사용자 계정에 권한 혹은 역할 부여 
형식 :
grant 시스템권한1,권한2,,,,,N
    to 사용자계정명 
        [with grant옵션]
*/
--접속권한을 부여한다.
--권한을 부여할때는 to를 사용한다.

grant create session to test_user1;
--권한 부여후 접속은 성공했지만 테이블 생성은 불가능하다.

--테이블 생성권한 부여 
grant create table to test_user1;

/*
3] 계정 암호 변경 
형식 : 
alter user 사용자계정명 identified by 변경할 암호;
*/
alter user test_user1 identified by 4321;

/* 
4] Role을 통한 여러가지 권한을 동시에 부여하기 
    여러 사용자가 다양한 권한을 효과적으로 관리할 수 있도록 관련된 권한끼리 묶어놓은 것을 말합니다
    우리는 실습을 위해 새롭게 생성한 계정에 connect resource 롤을 주로 부여한다. 
*/

alter session set "_ORACLE_SCRIPT" = true; 
create user test_user2 identified by 1234;
grant connect, resource to test_user2;
/*
test_user2 계정에 롤을 통해 권한을 부여한 후 접속 및 테이블 생성이 정상적으로 됩니다.
*/
/*
4-1] 롤 생성하기 
    사용자가 원하는 권한을 묶어 새로운 롤을 생성합니다.
*/
create role my_role; 
/*
4-2] 생성된 롤에 권한 부여하기 
    새롭게 생성한 롤에 세가지 권한을 부여합니다. 
*/
grant create session, create table, create view to my_role;

--새로운 사용자 계정을 생성합니다.
create user test_user3 identified by 1234;
--사용자에게 롤을 통해 권한을 부여합니다. 
grant my_role to test_user3;
/*
test_user3 은  접속 및 테이블생성, 뷰생성까지 가능하게 된다.
*/

/*
4-3] 롤 삭제하기 
*/
drop role my_role;  --롤 안에 권한이 들어있는경우 롤 삭제시 가지고 있던 권한모두 삭제 제거
                    --즉, 롤 삭제 후에는 권한 이용 불가능하다 
                    
/*
5] 권한제거 
형식 : revoke 권한,역할 from 사용자아이디; 
*/                    
revoke create session from test_user1;
-- test_user1는 접속할 수 없습니다. 접속시 오류 발생

/*
6] 사용자 계정 삭제
형식 : drop user 사용자아이디 cascade;
## cascade 명시하면 사용자계정과 관련된 모든 데이터베이스 스키마가 데이터사전으로부터 삭제되고 모든스키마 객체도 
물리적으로 전부 삭제된다. 
*/

--현재 생성된 사용자 목록을 확인할 수 있는 데이터사전 
select * from dba_users;

--계정을 삭제하려면 모든 물리적인 스키마까지 같이 삭제한다. 
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
테이블 스페이스란? 
    디스크 공간을 소비하는 테이블과 뷰, 그리고 그 밖의 다른 데이터베이스객체들이 저장되는 장소이다.
    예를 들어 오라클을 최조로 설치하면 hr계정의 데이터를 저장하는 user라는 테이블 스페이스가 자동으로 생성된다.
*/

-- 테이블 스페이스 조회하기
desc dba_tablespaces;

select tablespace_name, status, contents from dba_tablespaces;

--테이블 스페이스별 사용 가능한 공간확인하기 
select 
    tablespace_name, sum(bytes), max(bytes),
    trim(to_char(sum(bytes), '9,999,999,000'))"합계",
    trim(to_char(max(bytes), '9,999,999,000'))"최대"
from dba_free_space
group by tablespace_name;

-- 앞에서 생성한 test_user4 사용자의 테이블스페이스 확인하기
select username, default_tablespace from dba_users 
    where username in upper('test_user4');       -- users 의 테이블스페이스 확인

--테이블 스페이스 영역 할당
alter user test_user4 quota 2m on users;
/*
    test_user4가 system  테이블스페이스 영역에 테이블을 생성할 수 있도록 
    2M의 용량을 할당한다. 
*/
--cmd에서 테이블에 insert 되는지 확인해봅니다. 
