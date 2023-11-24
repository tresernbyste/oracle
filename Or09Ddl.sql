/************************   
system계정을 이용한 새로운 계정 생성, 새로운계정에 권한부여, 계정에 새로운 테이블 직접 추가 create 
파일명: Or09DDL
DDL : Data Defination Language 데이터 정의어 
설명 : 테이블 , 뷰 와 같은 객체를 생성 및 변경 하는 query문을 말한다.
************************/

-- System 계정으로 연결한 후 아래 명령을 실행합니다. 
-- 새로운 사용자 계정을 생성한 후 접속권한과 테이블 생성권한 등을 부여한다.

--orcle 21c 이상부터는 계정 생성전 해당 명령을 실행해야합니다.  -- C## 생략을위해
alter session set "_ORACLE_SCRIPT" = TRUE;
-- study 계정을 생성하고 패스워드를 1234로 부여한다.
create user study identified by 1234;
-- 생성한 계정에 몇가지 권한을 부여합니다. --그렇지 않으면 로그인이외 작업 불가능
grant connect, resource to study;


--study 계정을 연결한 후 실습을 진행합니다.

-- 모든 계정에 존재하는 논리적인 테이블
select * from dual;  -- 디폴트 테이블 확인 

-- 해당 계정에 생성된 테이블의 목록을 저장한 시스템 테이블 
-- 이와 같은 테이블을 "데이터 사전" 이라고 한다.
select * from tab; 

--테이블 생성하기 : 
--      create table 테이블명 (
--           칼럼1 자료형 [],
--           칼럼2 자료형 [],
--           primary key(칼럼필드명) 등 제약조건 추가 );

create table tb_number(
    idx number (10),  -- 10자리의 정수를 표현 
    userid varchar2(30), -- 문자형으로 30byte 저장가능
    passwd varchar2(50),  -- 
    username varchar2(30),
    mileage number(7,2) --  실수 표현, 전체자리7 소수자리 2
    );

-- 현재 접속한 계정에 생성된 테이블 목록을 확인한다.
select * from tab;


-- 테이블의 구조(스키마) 확인 컬럼명 자료형, 크기 등을 확인한다.
desc tb_number;

-- 기존 생성된 테이블에 새로운 컬럼 추가하기 
-- tb_number 테이블에 email column을 추가하시오.
-- alter table 테이블명 add 추가할 컬럼명 자료형(크기) 제약조건;
alter table tb_number add email varchar2(100);
desc tb_number;


--@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@


-- 기존 생성된 테이블에 컬럼 수정하기
-- tb_number 테이블에 email 컬럼의 사이즈를 200으로 확장하시오
-- 이름이 저장되는 username 컬럼도 60으로 확장하시오
-- 형식 : alter table 테이블명 modify 수정할컬럼명 자료형(크기); 

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


-- tb_employees 는 사용하지 않으므로 삭제하시오!

drop table tb_employees;
select * from tab;
drop table employ;
select * from employ;  -- 객체가 존재하지않기때문에 오류 
desc tb_number;

alter table tb_number drop column email;
desc tb_number;


-- tb_number에 테이블에 새로운 레코드를 삽입합니다. (DML부분에서 학습할 예정입니다.)
-- 하지만 table space 라는 권한이 없어서 삽입할 수가 없는 상태입니다.  ?? 레코드 생성도 못하는 study계정

insert into tb_number values
    (1, 'hing', '1234', '홍길동','20');
insert into tb_number values
    (2, 'yu', '5678', '유비','50');
    
select * from tb_number;
    

-- 오라클 11g에서는 새로운 계정을 생성한 후 connect, resource 를 Role만 부여하면 테이블생성, 삽입까지 되지만
-- 그 이후버전에서는 테이블 스페이스 관련 오류가 발생합니다.
-- 따라서 아래와 같이 테이블 스페이스에 대한 건한도 부여해야 한다. --- 해당명령은 system 계정으로 접속한후 실행!!

grant unlimited tablespace to study;

--@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@


-- table copy 1 : 레코드까지 함께 복사 
--@@@@ select 문을 기술할때 where절이 없으면 모든 레코드를 출력하라는 명령이므로 
--     아래에서는 모든 레코드를 가져와서 복사본 테이블을 생성한다. 즉, 레코드까지 복사한다.

create table tb_number_copy as select * from tb_number;
desc tb_number_copy;
select * from tb_number_copy;  -- 레코드까지 모두 복사됨!

-- table copy 2 : 속성만 복사.  레코드 제외하고 테이블 구조만 복사 

create table tb_number_empty as select * from tb_number where 1=0;
desc tb_number_empty;
select * from tb_number_empty;


--@@ DDL 테이블을 생성 및 조작하는 query문 
-- data defination language
-- 테이블 생성 
-- 테이블 수정.컬럼추가.수정.삭제
-- 테이블 삭제
-- 테이블 복사.레코드o.레코드x




--@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@

--연습문제 
-- study 계정으로 하시오.
/*
1. 다음 조건에 맞는 “pr_dept” 테이블을 생성하시오.
    dno number(2),
    dname varchar2(20),
    loc varchar2(35)
*/


/*
2. 다음 조건에 맞는 “pr_emp” 테이블을 생성하시오.



/*
3. pr_emp 테이블의 ename 컬럼을 varchar2(50) 로 수정하시오.
*/


/*
4. 1번에서 생성한 pr_dept 테이블에서 dname 칼럼을 삭제하시오.
*/


/*
5. “pr_emp” 테이블의 job 컬럼을 varchar2(50) 으로 수정하시오.
*/




























