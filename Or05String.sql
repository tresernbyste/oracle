/************************HR계정
파일명: Or05String
문자열 처리 관련 함수 
문자열에 대해 대소문자를 반환하거나 문자열에 길이를 반환하는 등 문자열을 조작하는 함수
************/



--concat(S,S)  || 로도 사용가능 문자열과 문자열을 연결해서 출력하는 함수 3개이상은 || 사용
select concat('a','b') from dual;
select 'a'||'b' from dual;
select 'sun'||'woo'||'sun' from dual;
--사원테이블에서 사원의 이름을 연결해서 아래와 같이 출력하시오.
select first_name||last_name"이름",salary, job_id from employees; -- 가능은 하나 가독성이 떨어짐 띄어쓰기
select first_name||' '||last_name"이름",salary, job_id from employees;

--initcap() 문자열의 첫문자만 대문자로 변환하는 함수 
-- 첫문자를 인식하는 기준: 공백문자 다음에 나오는 첫문자를 변환!
--                         알파벳과 숫자를 제외한 나머지 문자 다음에 나오는 첫번째 문자를 대문자로 변환합니다.???
--                         알파벳과 숫자 바로뒤에오는 문자는 변환되지않는다. ??응답! 
-- hi, hello 의 첫번째를 대문자로 변경 
select initcap('hi hello 안녕') from dual;  --Hi Hello 안녕
select initcap('or5hi hello 안녕') from dual;  
select initcap('good/bad/mornig') from dual; -- g b m 이 대문자로 변환
select initcap('naver6say*good가bye') from dual; --숫자바로뒤에오는 문자는 변환되지않는다.
--사원테이블에서 fistname 이 john인 사원을 찾아 인출하시오
select * from employees where first_name = initcap('john');
--이와같이 query하면 결과가 인출되지않습니다. 데이터는 대소문자를 구분하기때문 initcap을 씌워주면 가능 이름같은경우에는!


--lower() 문자열을 소문자로 변환
--upper() 문자열을 대문자로 변환 
select lower('SUNWOO') from dual;
select upper('sunwoo') from dual;
--위와 같이 john을 검색 하기위해 다음과 같이 활용할 수 있습니다.
--이름 이나 문자 검색시 많이 이용됨 
select * from employees where lower(first_name)='john';  --소문자로 바꾼 자료 = 소문자
select * from employees where upper(first_name)='JOHN'; -- 컬럼자체를 소대문자로 변경한 후 query합니다.

--lpad() rpad() 문자열의 왼쪽 오른쪽을 특정한 기호로 채울때 사용한다.
-- 형식 lpad('문자열',전체자리수,'채울 문자열')
-- 전체자리중에서 문장열의 길이만큼을 채워주는 함수
select 'good',lpad('good',7,'#'), rpad('good',7,'#'), lpad('good',7) from dual; --추가문자열자리가 공백시 공백추가
select lpad('문자열',7, 'L') from dual;    --??
--이름 전체를 12자로 간주하여 이름을 제외한 나머지 부분을 *로 채운다
select rpad(first_name,12, '*') from employees;
select rpad(first_name,12) || rpad(last_name,12) from employees;  -- 활용버전
--!!사원테이블의 first_name 을 첫글자를 제외한 나머지 부분 *로 마스킹 처리하는 query문을 작성하시오

--select lpad(first_name ,1)||substr(first_name,2)


--substr() 문자열에서 시작인덱스부터 길이만큼 잘라서 문자열을 출력합니다.
--  substr(컬럼,시작인덱스,길이) from dual;  
-- 오라클의 인덱스는 1부터 시작한다.
-- 길이의 해당하는 인자가 없으면 문자열의 끝까지를 의미합니다.
-- 시작인덱스가 음수면 우측 끝부터 좌측으로 인덱스를 적용합니다.  (앞에 마이너스부르면 반대로)
select substr('good morning john' ,8,4 )from dual;
select substr('abcdefg',1,1)from dual;
select substr(first_name,1,1)from dual;
select rpad('ellen',5,'*')from dual;
--lenght() 문자열 혹은 컬럼의 길이를 반환한다.
-- 연구 ㄱ
select first_name,
    rpad(substr(first_name,1,1), length(first_name), '*') "마스킹" 
    from employees;



--trim() : 공백을 제거할때 사용한다.
-- 옵션   trim([leading | trailing | both] 제거할문자 from 컬럼명)
--leading : 왼쪽에서 제거함
--trailing : 오른쪽에서 제거함
--both : 양쪽에서 제거함. 설정값이 없으면 both가 디폴트
--  주의 : 양쪽에 문자만 제거되고 중간에 있는 문자는 제거되지않습니다.
--         문자만 제거할 수 있고 '문자열'은 제거할 수 없습니다. 에러발생
--         중간의 문자는 제거할 수 없고, 양쪽의 문자만 제거할 수 있다.

select ' 공백제거테스트' trim1,
        trim(' 공백제거테스트 ')trim2,  -- 양쪽공백제거 
        trim('다' from '다람쥐가 나무를 탑니다')trim3,  -- both 생략이기때문에 양쪽 다 제거
        trim(both '다' from '다람쥐가 나무를 탑니다')trim4,  -- 3과 동일
        trim(leading '다' from '다람쥐가 나무를 탑니다')trim5, -- 왼쪽 문자열의 다 제거
        trim(trailing '다' from '다람쥐가 나무를 탑니다')trim6 from dual;  -- 오른쪽 문자열의 다 제거
--      trim(trailing '다람쥐' from '다람쥐가 나무를 탑니다')trim6 from dual;  -- 문자열제거는 불가능 문자만 가능!!
        
--ltrim() rtrim() : 좌측, 우측 문자 혹은 문자열을 제거할 때 사용합니다.
--trim 은 문자열 제거 불가능하지만 lrtrim은 문자 혹은 문자열 제거도 가능하다.
--좌우측 문자열전에 공백이 있으면 문자열이 맞아도 제거되지 않는다. 
-- 문자열의 좌우측끝에 공백이 없어야한다.
-- 문자열 중간도 제거되지않는다.
select ltrim(' 좌측공백제거 '),-- 좌측에 있는 공백만 제거
       ltrim(' 좌측공백제거 ','좌측')trim1,
       ltrim(' 좌측공백제거','좌측')trim2,
       ltrim('좌측공백제거 ','좌측')trim3,
       rtrim(' 좌측공백제거','제거')trim4,
       rtrim(' 좌측공백제거','공백')trim5 from dual;

--substrb() 문자열을 바이트(byte) 단위로 잘라냄
-- 형식 : substrb(문자열, 시작위치, 길이)
select substrb('안녕하세요',1,4) from dual;  -- 유니코드 하나당 4byte이기 때문에 '안' 을 잘라낸것  녕하세요???
--                                                    4바이트부터 출력    
select substrb('JONES',2,4) from dual;
-- substrb 는 구글링으로 확인 ## 필요하다면 @@



--replace() : 문자열을 다른 문자열로 대체할 때 사용합니다
-- 만약 공백으로 문자열을 대체한다면 문자열이 삭제되는 결과가 됩니다. 
-- replace( 컬럼 혹은 문자열 , '변경 전 문자 ', '변경 후 문자')
-- trim ltrim rtrim 함수의 기능을 replace 함수 하나로 대체할 수 있으므로 trim함수의 비해 replace함수가 더 많이 사용됨
select replace('good morning sun', 'morning', 'evening') from dual;  --문자열 변경 
select replace('good morning sun','sun','') from dual; --  변경할 문자열에 ''싱.쿼 사용시 삭제가능

select trim('   good morning sun   ') 공백 from dual; --trim 은 양쪽의 공백만 제거된다.
select replace('   good morning sun   ',' ','') 공백 from dual; ---  문자열 내에 모든 공백 제거

-- 102번 사원의 레코드를 대상으로 문자열 변경을 해보자.
select first_name, last_name,
    ltrim(first_name,'L')좌측L제거,
    rtrim(first_name,'ex')우측ex제거,
    replace(last_name,' ', '')모든공백제거,
    replace(last_name,'De', 'Dea')성표기변경 from employees where employee_id =102;

-- instr() : 해당 문자열에서 특정문자가 위치한 인덱스값을 반환 
--  (컬럼명, '찾을문자')   문자열의 처음부터 문자를 찾는다
-- (컬럼몇, '찾을문자' ,검색시작 인덱스)
-- (컬럼몇, '찾을문자',탐색시작할 인덱스 ,'몇번째 문자') 
-- 탐색할 인덱스부터 문자를 찾는다. 단, 찾는 문장중 몇번째에 있는 문자인지 지정할 수있다.
--탐색을 시작할 인덱스가 음수인 경우 우측에서 좌측으로 찾게된다. 

--n이 발견된 첫번째 인덱스 반환 
select instr('good morning john', 'h') from dual;

select instr('good morning john', 'h',1,2) from dual;

select instr('good morning john', 'h',8, 1) from dual;






