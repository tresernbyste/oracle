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
    values (2, 'boopyung3' , '오류발생'); -- idx (primary key) 가 반복되었다. 무결성 제약 조건 위배로 에러발생   
                                          -- PK로 지정된 컬럼 idx에는 중복된 값이 입력될 수 없다. 
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



--unique 유니크 
-- 값의 중복을 허용하지 않는 제약조건으로 
-- 숫자, 문자는 중복을 허용하지 않습니다.
-- 하지만 null값에 대해서는 중복을 허용한다.
-- unique 한 테이블에 2개이상 적용할 수 있다.

-- 2개의 컬럼을 합쳐서 지정한다.  이경우 동일한 제약조건으로 unique가 지정된다.

create table tb_unique ( 
    idx number unique not null, 
    name varchar2(30), 
    phone varchar2(30), 
    nickname varchar2(30),
    
    unique(phone,nickname));  -- 폰,닉네임을 유니크로 지정  숫자, 문자의 중복불가  null으로는 중복가능
    
insert into tb_unique (idx, name, phone, nickname)
    values(1, '아이린', '010-1111-1111', '레드벨벳');
insert into tb_unique (idx, name, phone, nickname)
    values(2, '웬디', '010-2222-2222', '');
insert into tb_unique (idx, name, phone, nickname)
    values(3, '슬기', '', '');
    
--unique는 중복을 허용하지않는 제약조건이지만 null은 여러개 입력할 수 있다.

select * from tb_unique;

-- idx 컬럼에 중복된 값이 입력되므로 오류가 발생된다.
insert into tb_unique (idx, name, phone, nickname) 
    values(1, '예리', '010-3333-3333', '');
insert into tb_unique values(4, '정우성', '010-4444-4444', '영화배우');
insert into tb_unique values(5, '이정재', '010-5555-5555', '영화배우');
insert into tb_unique values(6, '황정민', '010-4444-4444', '영화배우');   -- phone 이 같기때문에 불가능 

--phone 과 nickname은 동일한 제약명으로 설정되었으므로 두개의 컬럼이 동시에 동일한 값을 가지는 경우가 아니라면 중복된 값이 허용된다.
-- 즉, 4번가 5번은 서로다른 데이터로 인식되므로 입력이 되고 4번과 6번은 동일한 데이터로 인식되어 에러가 발생한다.
select * from user_cons_columns;











-- foreign key 외래키(참조키) : 외래키는 참조 무결성을 유지하기 위한 제약조건으로
-- 만약 테이블 간 외래키가 설정되어 있다면 자식테이블에 참조값이 존재할 경우 부모 테이블에 레코드는 삭제할수 없습니다. 

--형식 1(인라인 방식) : 라인 안에서 외래키설정
-- create table 테이블명 (  컬럼명 자료형 [constraints 제약명] references 부모테이블명 (참조할 컬럼명)   );

create table tb_foreign1(
    f_idx number(10) primary key,
    f_name varchar2(50),
    -- 자식테이블인 tb_foreign1에서 부모테이블인 tb_primary2에 user_id 컬럼을 참조하는 외래키를 생성합니다.
    f_id varchar2(30) constraint tb_foreign_fk1
        references tb_primary2( user_id)
    );
--부모테이블에는 레코드 1개 삽입되어 있음.
select * from tb_primary2;

--자식테이블에는 레코드가 없는 상태입니다.
select * from tb_foreign1;

--무결성 제약조건이 위배되었습니다. 부모키가 없습니다. (에러내용)
--부모테이블에는 gildong 이라는 아이디가없음 부모랑 맞춰야한다.
insert into tb_foreign1 values ( 1, '홍길동','gildong');

--데이터값이 맞아야 한다?? 테이블데이터간 활성화 
--입력성고. 부모테이블에 white라는 아이디가 있음.
insert into tb_foreign1 values ( 1, '하얀색','white');  

--자식테이블에서 참조하는 레코드가 있으므로 부모테이블에 레코드를 삭제할 수 없습니다.
--이 경우 반드시 자식테이블에 레코드를 먼저 삭제한 후 부모테이블에 레코드를 삭제할 수 있다.

--자식레코드가 발견되었습니다.  오류발생
delete from tb_primary2 where user_id = 'white';

--자식테이블의 레코드를 먼저 삭제한 후 
delete from tb_foreign1 where f_id = 'white'; -- 자식레코드 삭제완료 

--자식레코드 삭제후 부모레코드 삭제 실행
delete from tb_primary2 where user_id = 'white'; -- 삭제되었습니다.

-- 모든 레코드가 삭제된 상태이다.
select * from tb_foreign1;
select * from tb_primary2;

-- 2개의 테이블이 외래키(참조키)가  설정되어 있는 경우 
-- 부모테이블에 참조할 레코드가 없다면 자식테이블에 insert 할 수 없다.
-- 자식테이블에 부모를 참조하는 레코드가 남아있으면 부모테이블에 레코드를 삭제할 수 없다.



-- foreign key 아웃라인 방식 : 
-- 형식 : create table 테이블명 (   컬럼명 자료형 [constraint 제약명]  foreign key (컬럼명)  references 부모테이블 (참조할 컬럼)   );

create table tb_foreign2 ( 
    f_id number primary key,
    f_name varchar2(30) ,
    f_date date,
    foreign key(f_id) references tb_primary1 (idx)
    );
    
select * from user_cons_columns;
select * from user_constraints;

--데이터 사전에서 제약조건 확인시에 플래그
--  P : primary key 
--  R : references integrity  -- foreign key를 의미함
--  C : check 혹은 not null 
--  U : unique 

-- 테이블 생성후 alter 문으로 외래키 제약 조건 추가할 수 있다.
-- alter table 테이블명 add [constraint 제약명]  foreign key (컬럼명)   references 부모테이블 (참조할 컬럼)   );

create table tb_foreign3 ( 
    idx number primary key, 
    f_name varchar2(30),
    f_idx number(10)
    );

alter table tb_foreign3 add foreign key (f_idx) references tb_primary1 (idx) ;

select * from user_cons_columns;
select * from user_constraints;

-- 하나의 부모테이블에 둘 이상의 자식테이블이 외래키를 설정할 수 있다.  primary1 -부모테이블에 두개의 외래키를 등록할수 있다.


-- 외래키 삭제 옵션 
-- [on delete cascade]
-- 부모레코드 삭제시 자식레코드까지 같이 삭제된다. 
-- 형식 : 컬럼명 자료형 refrreences 부모테이블 (pk컬럼)
--      on delete cascade;

-- [on delete set null] 
-- 형식 : 컬럼명 자료형 references 부모테이블 (pk컬럼)
        --  on delete se null 
-- 실무에서 스펨게시물을 남긴 회원과 그 게시글을 일괄적으로 삭제해야할 때 사용할수 있는 옵션이다.
-- 단, 자식테이블의 모든 레코드가 삭제되므로 사용에 주의해야한다.

create table tb_primary4 (
    user_id varchar2(30) primary key,
    user_name varchar2(100)
    );

create table tb_foreign4 (
    f_id number(10) primary key, 
    f_name varchar2(30),
    user_id varchar2(30) constraint tb_foreign4_fk references tb_primary4 (user_id) on delete cascade);

-- 외래키가 설정된 경우 반드시 부모테이블에 레코드를 먼저 입력한 후 자식 테이블에 입력해야 한다.

insert into tb_primary4 values ('student','훈련생 1'); 
insert into tb_foreign4 values (1,'스팸1입니다.','student'); 
insert into tb_foreign4 values (2,'스팸2입니다.','student'); 
insert into tb_foreign4 values (3,'스팸3입니다.','student'); 
insert into tb_foreign4 values (4,'스팸4입니다.','student'); 
insert into tb_foreign4 values (5,'스팸5입니다.','student'); 
insert into tb_foreign4 values (6,'스팸6입니다.','student'); 
insert into tb_foreign4 values (7,'스팸7입니다.','student'); 

-- 부모키가 없으므로 레코드를 삽입할 수 없다. 오류발생 
insert into tb_foreign4 values (8,'난?? 누구???','teacher'); 


--앞에서 삽입한 레코드가 입력되어있는 상태임.
select * from tb_primary4;   -- 1개
select * from tb_foreign4;  -- 7개

--부모테이블에서 레코드를 삭제할 경우 on delete cascade 옵션에 의해 자식쪽까지 모든 레코드가 삭제된다.
-- 만약 해당 옵션을 주지않은 상태로 외래키를 생성했다면 레코드는 삭제되지 않고 오류가 발생됩니다.
delete from tb_primary4 where user_id = 'student';

-- 전부 삭제되는 것을 확인할 수 있다. 부모, 자식 테이블의 모든 레코드 삭제
select * from tb_primary4;   
select * from tb_foreign4;  




--///////////////////////////////////////////////////////////////////////////////////////////////////////////

-- on delete set null 옵션 테스트


create table tb_primary6 (
    user_id varchar2(30) primary key,
    user_name varchar2(100)
    );

create table tb_foreign6 (
    f_id number(10) primary key, 
    f_name varchar2(30),
    user_id varchar2(30) constraint tb_foreign6_fk references tb_primary6 (user_id) on delete set null);
    

insert into tb_primary6 values ('student','훈련생 1'); 
insert into tb_foreign6 values (1,'스팸1입니다.','student'); 
insert into tb_foreign6 values (2,'스팸2입니다.','student'); 
insert into tb_foreign6 values (3,'스팸3입니다.','student'); 
insert into tb_foreign6 values (4,'스팸4입니다.','student'); 
insert into tb_foreign6 values (5,'스팸5입니다.','student'); 
insert into tb_foreign6 values (6,'스팸6입니다.','student'); 
insert into tb_foreign6 values (7,'스팸7입니다.','student'); 

select * from tb_primary6;
select * from tb_foreign6;

-- on delete se null 옵션으로 자식테이블의 레코드는 삭제되지 않고, 참조키 부분만 null값으로 변경된다. 따라서 더이상 참조할 수 없는 레코드로 변경됩니다.
delete from tb_primary6 where user_id = 'student';


-- Ex 부모를 잘못 만든경우 자식의 레코드는 그대로 두고 부모레코드만 새로 변경하고 싶을때 변경하는 방법으로 사용될 수 있다.

select * from tb_primary6;   -- 부모레코드는 모두 삭제되는것을 확인할 수 있다.
select * from tb_foreign6;   -- user_id 가 모두 null로 바뀌어 있는것을 확인할 수 있다.  단, 참조 컬럼이 null로 변경됩니다.


/*
 게시판을 예로들어 생각하면 좋음 
 부모테이블로 회원정보를 가지고 있는 상태로 
    게시판별로 정리하기 위함 
*/


-- not null : null 값을 허용하지않는 제약조건 
/*
-- 형식 :  create table 테이블명 (  
    컬럼명 자료형 not null , 
    컬럼명 자료형 null,   -- null 을 허용한다는 의미로 작성했지만 이렇게 사용하지않는다. null을 기술하지않으면 자동으로 허용한다는 의미가 있다.*/

create table tb_not_null (
    m_idx number(10) primary key,    -- PK이므로 not null
    m_id varchar2(20) not null,
    m_pw varchar2(30) null,    -- 일반적으로 이렇게 사용하지 않는다.
    m_name varchar2(40)        -- null과 동일 
    );
    

desc tb_not_null;
/*
M_IDX  NOT NULL NUMBER(10)   
M_ID   NOT NULL VARCHAR2(20) 
M_PW            VARCHAR2(30) 
M_NAME          VARCHAR2(40)    
*/

insert into tb_not_null values ( 10, 'hong1', '1111', '홍길동');
insert into tb_not_null values ( 20, 'hong2', '2222', '');
insert into tb_not_null values ( 30, 'hong3', '', '');
insert into tb_not_null values ( 40, '3', '', '');
insert into tb_not_null values ( 50, '', '', ''); -- not null 에 null 삽입불가능 오류발생

insert into tb_not_null values ( 60, ' ', '6666', '육길동');   -- ' ' 공백은 아스키코드에서 문자로 인식한다.  공백 != not null


-- m_id는 primarykey 에는 null 값을 입력할 수 없습니다. 
-- 컬럼을 명시하지않으면 null이 입력됩니다.
insert into tb_not_null ( m_id, m_pw, m_name)    -- ( idx , m_id, m_pw, m_name) 
    values ('hong6','6666','육길동');

select * from tb_not_null;

----------------------------------------------------------------------------------------------------------------------------------

--default  : insert 시 아무런 값도 입력하지 않았을 때 자동으로 삽입되는 데이터를 지정할 수 있습니다.

create table tb_default ( 
    id varchar2(30) not null,
    pw varchar2(50) default 'gwer'
    );
    
insert into tb_default values ('aaa','1234');

select * from tb_default;
    
insert into tb_default (id) values ('bbb');
insert into tb_default (id, pw) values ('bbb','');  -- null 이 들어감 != 아무것도 입력하지않음 
insert into tb_default values ('dddd',' ');  -- 공백은 문자로 인식하기때문에 공백만 입력됨
insert into tb_default values ('eeee',default);  -- 미리 정해둔 default 값이 입력됨 qwer

-- default 값을 입력하려면 insert 문에서 컬럼 자체를 제외시키거나 default 키워드를 사용해야한다.



---------------------------------------------------------------------------------------------------


-- Check : Domain(자료형)  무결성을 유지하기 위한 제약조건으로 해당 컬럼에 잘못된 데이터가 입력되지 않도록 유지하는 제약조건이다.
-- M, F 만 입력을 허용하는  Check 제약조건 

create table tb_check1 (
    gender char(1) not null,
        constraint check_gender 
            check ( gender in ('M','F'))
            );
            
select * from tb_check1;

insert into tb_check1 values ('M');
insert into tb_check1 values ('F');
insert into tb_check1 values ('T');  -- 체크 제약조건이 위배 
insert into tb_check1 values ('여성');  --  입력된 데이터가 컬럼의 크기보다 크므로 오류 발생


-- 10이하의 값만 입력할 수 있는 check 제약조건 지정

create table tb_check2 (
    sale_count number not null check (sale_count<= 10)
    );
    
insert into tb_check2 values (9);
insert into tb_check2 values (10);
insert into tb_check2 values (11);      --  제약조건 위배로 입력이 실패됩니다.     
    
select * from tb_check2;















