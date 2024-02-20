-- ex11_casting_function.sql

/*

    형변환
    1. varchar2 to_char(숫자형): 숫자 > 문자 - 잘 안씀
    2. varchar2 to_char(날짜형): 날짜 > 문자 - 중요
    3. number to_number(문자형): 문자 > 숫자
    4. date to_number(문자형): 문자 > 날짜
    
    1. varchar2 to_char(숫자형 [, 형식문자열]): 숫자 > 문자
    
    형식문자열 구성요소
    a. 9: 숫자 1개를 문자 1개로 바꾸는 역할. 빈자리는 동백으로 치환 > %5d
    b. 0: 숫자 1개를 문자 1개로 바꾸는 역할. 빈자리는 0으로 치환 > %05d
    c. $: L과 같다. (통화기호)
    d. L: $와 같다. (통화기호)
    e. .: 소수점
    f. ,: 천단위 표기
    

*/

-- varchar2 to_char(숫자형 [, 형식문자열]): 숫자 > 문자
-- 형식문자열 사용

select 
    basicpay as aaaaaaaaaaaaa,
    to_char(basicpay) as aaaaaaaaaaaaa
from tblInsa;

select
    weight,
    '@' || to_char(weight) || '@',
    '@' || to_char(weight, '99999') || '@',
    '@' || to_char(weight, '00000') || '@',
    '@' || to_char(-weight, '99999') || '@',
    '@' || to_char(-weight, '00000') || '@'
from tblComedian;

select
    100,
    to_char(100, '$999'),
    --to_char(100, '999 달라') -- 에러(정해진 형식 문자 외에는 에러)
    --to_char(100) || '달라'-- 가능
    to_char(100, '$9999'),
    to_char(100, '$99999'),
    to_char(100, 'L999') -- 사용자 지역의 돈의 기호가 표기되지만 지금은 깨짐
from dual;

select
    3.14,
    to_char(3.15, '99.9'), -- 3.2(반올림),
    to_char(3.15, '9.99'), -- 3.15(반올림),
    1000000,
    to_char(1000000, '9,999,999') -- 직접 찍어야 한다.
from dual;

---------------------------------------------------------------------
/*

    **************
    2. varchar2 to_char(날짜형 [, 형식문자열]): 날짜 > 문자 - 중요
    
    형식문자열 구성요소
    a. yyyy
    b. yy
    c. month
    d. mon
    e. mm
    f. day
    g. dy
    h. ddd
    i. dd
    j. d
    k. hh
    l. hh24
    m. mi
    n. ss
    o. am(pm)

*/
select sysdate from dual; -- 현재 날짜(24/02/15)
select to_char(sysdate) from dual; -- 현재 날짜(24/02/15)
select to_char(sysdate, 'yyyy') from dual; -- 2024년
select to_char(sysdate, 'yy') from dual; -- 24년
select to_char(sysdate, 'month') from dual; -- 2월(월 풀네임)
select to_char(sysdate, 'mon') from dual; -- 2월(월 약어)
select to_char(sysdate, 'mm') from dual; -- 02(월)
select to_char(sysdate, 'day') from dual; -- 목요일(요일 풀네임)
select to_char(sysdate, 'dy') from dual; -- 목(요일 약어)
select to_char(sysdate, 'ddd') from dual; -- 046 > 일(올해의 며칠)
select to_char(sysdate, 'dd') from dual; -- 15(일, 이번달의 며칠)
select to_char(sysdate, 'd') from dual; -- 5 (일 > 이번주의 며칠, 요일)
select to_char(sysdate, 'hh') from dual; -- 02 시(12시)
select to_char(sysdate, 'hh24') from dual; -- 14 시(24시)
select to_char(sysdate, 'mi') from dual; -- 40 분
select to_char(sysdate, 'ss') from dual; -- 11 초
select to_char(sysdate, 'am') from dual; -- 오후 오전/오후
select to_char(sysdate, 'pm') from dual; -- 오후 오전/오후

-- 자주쓰는 형태 조합
select 
    sysdate,
    to_char(sysdate, 'yyyy-mm-dd'), -- 2024-02-15
    to_char(sysdate, 'hh24:mi:ss'), -- 14:45:11 > 시 분 초
    to_char(sysdate, 'yyyy-mm-dd hh24:mi:ss'), -- 2024-02-15 14:45:48
    to_char(sysdate, 'day am hh:mi:ss') -- 목요일 오후 02:46:34
from dual;


select
    name,
    to_char(ibsadate, 'yyyy-mm-dd') as ibsadate,
    to_char(ibsadate, 'day') as day,
    case
        when to_char(ibsadate, 'd') in ('1', '7') then '휴일 입사'
    end
from tblInsa;

-- 요일별 입사 인원수?
select
    count(case
        when to_char(ibsadate, 'd') in '1' then 1
    end) as 일요일,
    count(decode(to_char(ibsadate, 'd'), '2', 1)) as 월요일,
    count(decode(to_char(ibsadate, 'd'), '3', 1)) as 화요일,
    count(decode(to_char(ibsadate, 'd'), '4', 1)) as 수요일,
    count(decode(to_char(ibsadate, 'd'), '5', 1)) as 목요일,
    count(decode(to_char(ibsadate, 'd'), '6', 1)) as 금요일,
    count(decode(to_char(ibsadate, 'd'), '7', 1)) as 토요일
from tblInsa;

------------------------------------------------------------------
-- tblInsa 2010년도 입사한 직원?
select * from tblInsa
    where ibsadate >= '2010-01-01' and ibsadate <= '2010-12-31'; -- 오답 (문자열이여서 시 분 초 형성이 안됌)
    
select * from tblInsa
    where ibsadate >= '2010-01-01 00:00:00' and ibsadate <= '2010-12-31 00:00:00'; -- 에러
    
select * from tblInsa
    where ibsadate between '2010-01-01' and '2010-12-31'; -- 오답 (문자열이여서 시 분 초 형성이 안됌)
------------------------------------------------------------------   
select * from tblInsa
    where to_char(ibsadate, 'yyyy') = '2010'; -- 정답


/*

    3. number to_number(문자형): 문자 > 숫자(하나도 안씀)

*/

select 
    '123',
    to_number('123')
from dual;

/*
    **************
    4. date to_number(문자형, 형식문자열): 문자 > 날짜(많이 쓰임)

*/

select
    '2024-02-15', -- 문자열 (2024-02-15)
    to_date('2024-02-15'), -- (24/02/15)
    -- to_date('2024-02-15 15:14:45') -- (에러)
    to_date('2024-02-15 15:14:45', 'yyyy-mm-dd hh24:mi:ss'),
    to_date('2024-02-15', 'yyyy-mm-dd'),
    to_date('20240215'),
    to_date('20240215', 'yyyymmdd'),
    to_date('02152024', 'mmddyyyy'),
    to_date(20240215),
    to_date(20240215, 'yyyymmdd')
from dual;

select * from tblInsa
    where ibsadate >= to_date('2010-01-01 00:00:00', 'yyyy-mm-dd hh24:mi:ss')
        and ibsadate <= to_date('2010-12-31 23:59:59', 'yyyy-mm-dd hh24:mi:ss');


-- 중요도
-- to_char(숫자형) > *
-- to_char(날짜형) > *****
-- to_number(문자형) > X
-- to_number(문자형) > ***
































