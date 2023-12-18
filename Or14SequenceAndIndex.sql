/************************   study 계정으로 하기
파일명: Or14  sequence and index 
설명 : 테이블의 기본키 필드에 순차적인 일련번호를 부여하는 시퀀스와 
       검색속도를 향상시킬수 있는 인덱스 
************************/

/*
시퀀스 : 테이블의 컬럼(필드)에 중복되지 않는 순차적인 일련번호를 부여한다.
         시퀀스는 테이블 생성후 별도로 만들어야 합니다.
         즉, 시퀀스는 테이블과 독립적으로 저장되고 생성됩니다.

[시퀀스 생성 구문] 
    create sequence 시퀀스명 
        [increment by N]            증가치 설정
        [Start with N]              시작값 지정
        [Minvalue n | NoMinvalue]   시퀀스 최소값 지정  default 1
        [Maxvalue n | NoMaxvalue]   시퀀스 최대값 지정  default 1.0000E+28
        [Cycle | NoCycel]           최대값 도달시 반복 여부  Cycle로 지정하면 최대값까지 증가후 다시 시작값부터 재 시작됨
        [Cache | NoCache]           cache 메모리에 오라클 서버가 시퀀스 값을 할당하는  여부를 지정합니다.


주의사항 
    1. start with 에 minvalue 보다 작은값을 지정할 수 없다.   즉 start with 값은 minvalue와 같거나 커야한다. 
    2. Nocycle 로 설정하고 시퀀스를 계속 얻어올 때 maxvalue에 지정값을 초과하면 에러가 발생합니다.
    3. primary key에 cycle 옵션을 절대 지정하면 안된다. 
*/

create table tb_goods (
    g_idx number(10) primary key,
    g_name varchar2(30)
    );
    
insert into tb_goods values(1,'가나초콜릿');
insert into tb_goods values(1,'새우깡');       -- primary key 값이 같아서 무결성 제약조건 위배 

-- 시퀀스 설정 

create sequence seq_serial_number 
    increment by 1                  -- 증가치 1
    start with 100                  -- 초기값 100
    minvalue 99                     -- 최소값 99
    maxvalue 110                    -- 최대값 110
    cycle                           -- 최대값 도달시 반복 있음
    nocache;                        -- 캐시메모리 사용여부 NO

select * from user_sequences;       -- 데이터 사전으로 생성된 시퀀스 확인하기 

/*
시퀀스 생성 후 최초실행시 오류가 발생합니다. 
*/

-- 시퀀스 SEQ_SERIAL_NUMBER.CURRVAL은 이 세션에서는 정의 되어 있지 않습니다  
-- nextval을 먼저 실행한 후 실행합니다.
select seq_serial_number.currval from dual;   

-- 다음 입력할 시퀀스(일련번호)를 반환 합니다. 실행할때마다 다음으로 넘어갑니다.
select seq_serial_number.nextval from dual;
-- g_idx number 를 primary key로 설정해 두었기 때문에 에러발생   ## 기본키에 사이클을 두지 말라는 이유  
insert into tb_goods values ( seq_serial_number.nextval , '꿀꽈배기1');
insert into tb_goods values ( seq_serial_number.nextval , '꿀꽈배기2');
insert into tb_goods values ( seq_serial_number.nextval , '꿀꽈배기3');
insert into tb_goods values ( seq_serial_number.nextval , '꿀꽈배기4');
insert into tb_goods values ( seq_serial_number.nextval , '꿀꽈배기5');
insert into tb_goods values ( seq_serial_number.nextval , '꿀꽈배기6');
insert into tb_goods values ( seq_serial_number.nextval , '꿀꽈배기7');
insert into tb_goods values ( seq_serial_number.nextval , '꿀꽈배기8');
insert into tb_goods values ( seq_serial_number.nextval , '꿀꽈배기9');
insert into tb_goods values ( seq_serial_number.nextval , '꿀꽈배기10');
select * from tb_goods;

/*
시퀀스의 사이클 옵션에 의해 최대값에 도달하면 다시 처음부터 일련번호가 생성되므로 무결성 제약조건에 위배됩니다.
즉, 기본키에 사용할 시퀀스는 사이클 옵션을 사용하지 않아야 한다.
*/

select seq_serial_number.currval from dual;  -- 다음에 들어갈 현재 시퀀스의 시작 번호라고 할 수 있음

-------------------------------------------------------------------------------------------------------------

/*
시퀀스의 수정 : start with 는 수정되지 않는다. 초기에 설정한 값을 변경할 수 없다. 
*/

alter sequence seq_serial_number 
    increment by 10
    minvalue 1
    nomaxvalue
    nocycle
    nocache;
-- 수정후 데이터 사전에서 확인해야합니다.

select * from user_sequences;

--증가치가 10으로 적용된 것을 확인함   104 -- 114
select seq_serial_number.nextval from dual;

--시퀀스의 삭제 drop 
drop sequence seq_serial_number;
select * from user_sequences;   -- 삭제 완료 확인 

-- 일반적인 시퀀스 생성은 아래와 같이 하면 됩니다.
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
인덱스 (INDEX) 
    행의 검색속도를 향상시킬수 있는 객체 
    인덱스는 명시적(create index)와 자동적 ( primarykey, unique) 로 생성할 수 있다
    컬럼에 대한 인덱스가 없으면 테이블 전체를 검색하게 된다.
    즉, 인덱스는 쿼리의 성능을 향상시키는 것이 목적입니다.
    인덱스는 아래와 같은 경우에 설정합니다.
        1.where조건이나 join조건에 자주 사용하는 컬럼
        2.광범위한 값을 포함하는 컬럼
        3.많은 null값을 포함하는 컬럼
*/

desc tb_goods;
--G_IDX  NOT NULL NUMBER(10)   
--G_NAME          VARCHAR2(30)
select * from tb_goods;


--인덱스 생성 . 특정 테이블의 컬럼을 지정하여 생성한다. 
create index tb_goods_name_idx on tb_goods (g_name);

--생성한 인덱스 확인하기 
--데이터 사전에서 확인하면 PK 혹은 Unique 로 지정된 컬럼은 자동으로 인덱스가 생성됨으로 이미 생성된 인덱스도 같이 확인됩니다.
select * from user_ind_columns;

--특정 테이블의 인덱스 확인
--      테이터 사전에 등록시 대문자로 입력되기 때문에 upper와 같은 변환함수를 사용하면 편리하다.

select * from user_ind_columns where table_name = upper('tb_goods');

--굉장히 많은 레코드가 있다고 가정하면 검색속도의 향상이 있습니다.  빅데이터 시 유용 
select * from tb_goods where g_name like '%꿀%';

--인덱스 삭제 
drop index tb_goods_name_idx;

select * from user_ind_columns;

--인덱스 수정은 불가능합니다.  삭제후 다시 생성해야 합니다.




































