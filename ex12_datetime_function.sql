-- ex12_datetime_function.sql

/*

    날짜 시간 함수
    
    sysdate
    - 현재 시스템의 시각을 반화
    - Calender.getInstance()
    - date sysdate

*/

select sysdate from dual;


/*

    날짜 연산
    1. 시각 - 시각 = 시간
    2. 시각 + 시간 = 시각
    3. 시각 - 시간 = 시각

*/

-- 1. 시각 - 시각 = 시간(일)
-- 현재 - 입사일 = ?
select 
    name,
    to_char(ibsadate, 'yyyy-mm-dd') as 입사일,
    round(sysdate - ibsadate) as 근무일수, -- 근무일수(일)
    round(sysdate - ibsadate) * 24 as 근무시수, -- 시간
    round(sysdate - ibsadate) * 24 * 60 as 근무분수,
    round(sysdate - ibsadate) * 24 * 60 * 60 as 근무초수,
    round((sysdate - ibsadate) / 365) as 근무년수 -- 정확하지 않음(윤년)
from tblInsa;

select
    title,
    adddate,
    completedate,
    round((completedate - adddate) * 24) as "실행하기까지 걸린 시간"
from tblTodo
    order by "실행하기까지 걸린 시간" desc; -- ""쌍따운표 따라다녀야 함(주의)

-------------------------------------------------------------------------------

-- 2. 시각 + 시간 = 시각
-- 3. 시각 - 시간 = 시각

select
    sysdate,
    sysdate + 100 as "100일 뒤",
    sysdate - 100 as "100일 전",
    to_char(sysdate + (3 / 24), 'hh24:mi:ss') as "3시간 후",
    to_char(sysdate + (30 / 24 / 60), 'hh24:mi') as "30분 후"
from dual;


/*

    months_between()
    - 시각 - 시각 = 시간(월)
    - number month_betweens(date, date)
    

*/
select
    name,
    round(sysdate - ibsadate) as 근무일수,
    round((sysdate - ibsadate) / 365) as 근무년수, -- 정확하지 않음(윤년)
    round(months_between(sysdate, ibsadate)) as 근무월수,
    round(months_between(sysdate, ibsadate) / 12) as 근무년수 -- 정확함
from tblInsa;

/*

    add_months()
    - 사각 + 시각(월) = 시각
    - 사각 - 시각(월) = 시각
    - date add_months(date, 시간)

*/

select
    sysdate,
    add_months(sysdate, 3), -- 3개월 후
    add_months(sysdate, -2), -- 2개월 전
    add_months(sysdate, 3 * 12) -- 3년 후
from dual;

/*

    시각 - 시각
    1. 일, 시 ,분, 초 > 연산자(-)
    2. 월, 년 > months_between()
    
    시각 + / - 시간
    1. 일, 시, 분, 초 > 연산자(+)
    2. 월, 년 > ass_months()
    
    
    마지막 날짜
    - number last_day(날짜)
    - 해당년월의 마지막 일?

*/
select
    last_day(sysdate) -- 24/02/29 (해당 월의 마지막 일)
from dual;





















