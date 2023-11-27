/************************   study 계정으로 하기
파일명: Or13Constraint
제약조건 Constraint
설명 : 테이블 생성시 필요한 여러가지 제약조건에 대해 학습합니다.
************************/

--primary key 기본키 : 참조 무결성을 유지하기 위한 제약조건 
--                     하나의 테이블에 하나의 기본키만 설정할 수 있다.
--                     기본키로 설정된 컬럼은 중복된 값이나 Null값을 입력할 수 없다.
--                     주로 레코드 하나를 특정하기 위해 사용된다.

-- 형식 1 : 인라인방식 : 컬럼 생성시 우측에 제약 조건을 기술한다.
-- create table 테이블명 ( 컬럼명 자료형(크기) [constraint 제약명] primary key );
-- ## []대괄호 부분은 생략가능하고 생략시 제약명을 시스템이 자동으로 부여한다.

create table tb_primary1 ( idx number(10) primary key, user_id varchar2(30), user_name varchar2(50) );

desc tb_primary1;
--이름        널?       유형           
----------- -------- ------------  ## not null
--IDX       NOT NULL NUMBER(10)   
--USER_ID            VARCHAR2(30) 
--USER_NAME          VARCHAR2(50) 

-- 제약조건 및 테이블 목록 확인하기 
-- tab : 현재 계정에 생성된 테이블의 목록을 확인할 수 있다.
-- user_cons_columns : 테이블에 지정된 제약조건과 컬럼명의 간략한 정보를 저장한다.
-- user_constraints : 테이블에 지정된 제약조건의 상세한 정보를 저장한다.
-- ## 이와 같이 제약 조건이나 뷰, 프로시저등의 정보를 저장하고 있는 시스템 테이블을 "데이터 사전"이라고 합니다.

select * from tab;
select * from user_cons_columns;
select * from user_constraints;

-- 레코드 입력 
insert into tb_primary1 ( idx , user_id , user_name)
    values (1, 'boopyung1' , '부평'); 
insert into tb_primary1 ( idx , user_id , user_name)
    values (2, 'boopyung2' , '부평로');     
insert into tb_primary1 ( idx , user_id , user_name)
    values (2, 'boopyung3' , '오류발생'); -- idx (primary key) 가 반복되었다. 무결성 제약 조건 위배로 에러발생    PK로 지정된 컬럼 idx에는 중복된 값이 입력될 수 없다. 
insert into tb_primary1  values (3, 'white' , '화이트');     
insert into tb_primary1  values ('', 'black' , '블랙');   --에러발생 null 값이므로 입력할 수 없다.

select * from tb_primary1;


update tb_primary1 set idx = 2 where user_name ='유산슬';   --update문은 정상이지만 idx 값이 이미 존재하는 2로 변경했으므로 제약조건위배로 오류가 발생한다.





-- 아웃라인 방식 
-- create table 테이블명 (   컬럼명 자료형 (크기) [constraint 제약명] primary key (컬럼명)    );

create table tb_primary2 ( idx number(10), user_id varchar2(30), user_name varchar(50) , constraint my_pk1 primary key(user_id) );
desc tb_primary2;
--이름        널?       유형           
--IDX                NUMBER(10)   
--USER_ID   NOT NULL VARCHAR2(30) 
--USER_NAME          VARCHAR2(50) 

select * from user_cons_columns;
select * from user_constraints;

insert into tb_primary2  values (1, 'white' , '화이트');     
insert into tb_primary2  values (2, 'white' , '화이트2');   --  user_name 이 primary key 이기때문에 오류 발생

select * from tb_primary2;








-- 형식 3 : 테이블을 생선한후 alter문으로 제약조건 추가 
-- alter table 테이블명 add [constraint 제약명] primary key (컬럼명) ;


create table tb_primary3 ( idx number(10), user_id varchar2(30), user_name varchar(50) );

-- 테이블을 생성한 후 alter 명령을 통해 제약조건을 부여할 수 있다.
-- 제약명의 경우 생략이 가능하다.

alter table tb_primary3 add constraint tb_primary3_pk
    primary key (user_name);
    -- "데이터 사전"에서 제약조건 확인하기 
    
select * from user_cons_columns;
select * from user_constraints;
-- 제약조건은 테이블을 대상으로 하므로 테이블이 삭제되면 같이 삭제된다.

drop table tb_primary3;  -- 확인시 휴지통에 들어간 것을 볼 수 있습니다.

select * from user_cons_columns;



-- PK는 테이블당 하나만 생성할 수 있다. 따라서 해당 문장은 에러가 발생합니다. 
create table tb_primary4 ( idx number(10)primary key , user_id varchar2(30) primary key, user_name varchar(50) );  -- 테이블당 하나만 PK를 지정할 수 있다.




















    
    