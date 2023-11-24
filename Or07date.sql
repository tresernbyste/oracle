/************************   HR계정
파일명: Or07Date
날짜 관련 함수  
설명 : 년, 월, 일, 시, 분, 초의 포멧으로 날짜형식을 지정하거나 
날짜를 계산할 때 활용하는 함수들 
************************/


-- Month_between() : 현재 날짜와 기준 날짜 사이의 개월수를 반환합니다.
-- month_between( 현재날짜, 기준날짜[과거 날짜])
-- 2020년 1월 20일( 코로나 첫 발병일) 부터 지금까지 지난 개월수는??

select 
    months_between(sysdate, '2020-01-20')"기본날짜서식",
    months_between(sysdate,to_date('2020년 01월 20일','yyyy"년" mm"월" dd"일"')),
   ceil(months_between(sysdate,to_date('2020년 01월 20일','yyyy"년"mm"월"dd"일"')))
    from dual;

--employees  테이블에 입력된 직원들의 근속개월수를 계산하여 출력하시오. 근속개월수의 오름차순

select
    first_name,hire_date,
    ceil(months_between(sysdate, hire_date))근속개월수1
    from employees
    order by 근속개월수1;
--select 결과를 정렬하기 위해 order by를 사용할 때 컬럼명은 위와같이 2가지 형태로 사용할수 있다.



--next_day 현재날짜를 기준으로 인자로 주어진 요일에 해당하는 미래의 날짜를 반환하는 함수
-- next_day(현재날짜, 미래인자요일) -- 다음주 월요일은 몇일일까요

select 
    to_char(sysdate, 'yyyy-mm-dd')오늘날짜,
    next_day(sysdate,'월요일')다음주월요일    
    from dual;
select   -- 함수안에 함수 넣어서 표현하기
    to_char(next_day(sysdate, '월요일'),'yyyy"년" mm"월" dd"일"')
    from dual;
    
--last_day() 해당월의 마지막 날짜를 반환 합니다.
select  -- 23년 12월의 마지막 31일
    last_day('23-12-01')
    from dual;

--단순 날짜 연산 : 날짜형 데이터에 숫자를 더하거나 빼면, 그 기간만큼의 날짜를 계산할 수 있다.
select
    sysdate"오늘" ,sysdate+1"내일",sysdate -1 "어제",sysdate+15"보름후"
    from dual;




















