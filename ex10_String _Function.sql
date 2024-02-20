-- ex10_String _Function.sql

/*

    문자열 함수
    
    대소문자 변환
    - upper(), lower(), initcap()
    - vaechar2 upper(컬럼명)
    - vaechar2 lower(컬럼명)
    - vaechar2 initcap(컬럼명)
    

*/

select 
    first_name,
    upper(first_name),
    lower(first_name),
    initcap(first_name)
from employees;


select 
    'abc',
    upper('abc'),
    upper('ABC'),
    lower('abc'),
    lower('ABC'),
    initcap('abc'),
    initcap('ABC')
from dual;


-- 이름 (first_name)에 'an' 포함된 직원?

select 
    first_name
from employees
    where first_name like '%an%';
    
/*

    문자열 추출 함수
    - substr()
    - varchar2 substr(컬럼명, 시작위치, 가져올 위치)
    - varchar2 substr(컬럼명, 시작위치)
*/

SELECT 
    name,
    substr(name, 1,3),
    substr(name, 1)
from tblCountry;



select 
    name, ssn,
    substr(ssn, 1, 2) as 생년,
    substr(ssn, 3, 2) as 월,
    substr(ssn, 5, 2) as 생일,
    substr(ssn, 8, 1) as 성별
from tblInsa;

-- tbInsa > 김, 이, 박, 최, 정 > 각각 몇명?
select count(*) from tblInsa where substr(name, 1, 1) = '김';
select count(*) from tblInsa where substr(name, 1, 1) = '이';
select count(*) from tblInsa where substr(name, 1, 1) = '박';
select count(*) from tblInsa where substr(name, 1, 1) = '최';
select count(*) from tblInsa where substr(name, 1, 1) = '정';

select 
   count(case
        when substr(name, 1, 1) = '김' then 1
    end) as 김,
    count(case
        when substr(name, 1, 1) = '이' then 1
    end) as 이,
    count(case
        when substr(name, 1, 1) = '박' then 1
    end) as 박,
    count(case
        when substr(name, 1, 1) = '최' then 1
    end) as 최,
    count(case
        when substr(name, 1, 1) = '정' then 1
    end) as 정,
    count(case
        when substr(name, 1, 1) not in('김', '이', '박', '최', '정') then 1 
    end) as 나머지
from tblInsa;


/*

    문자열 길이
    - length()
    - number length(컬럼명)
    - 
    
    

*/

-- 컬럼 리스트에서 사용
select name, length(name) from tblCountry; -- 이름과 이름의 길이를 출력

-- 조건절에서 사용
select name, length(name) from tblCountry
    where length(name) > 3; -- 나라이름이 4자 이상일때 출력
    

select name, length(name) as length     -- 3.
from tblCountry                         -- 1.
    where length(name) > 3;             -- 2.
-- 이름 바꾼as는 where에서 찾을수 없다.(원문으로 찾기)
------------------------------------------------------
select name, length(name) as length     -- 3.
from tblCountry                         -- 1.
    where length(name) > 3              -- 2.
order by length desc;                   -- 4.
-- 하지만 정렬에서는 사용할수 있다.


select name, ssn from tblInsa;

select name, ssn, substr(ssn, 8, 1) from tblInsa; -- 컬럼 리스트(1이면 남자 2이면 여자)
select name, ssn from tblInsa where substr(ssn, 8, 1) = 1; -- 조건절(남자 직원만 가져와라)
select name, ssn from tblInsa order by substr(ssn, 8, 1) asc; -- 남자 > 여자 정렬

/*

    문자열 검색
    - instr()
    - 검색어의 위치를 반환
    - number instr(컬럼명, 검색어)
    - number instr(컬럼명, 검색어, 시작위치)
    - number instr(컬럼명, 검색어, 시작위치, -1) // lastIndexOf (-1붙이면 뒤부터 반환)
    - 못찾으면 0을 반환

*/

select 
    '안녕하세요. 홍길동님',
    instr('안녕하세요. 홍길동님', '홍길동') as r1,
    instr('안녕하세요. 홍길동님', '아무개') as r2,
    instr('안녕하세요. 홍길동님 홍길동님', '홍길동') as r3,
    instr('안녕하세요. 홍길동님 홍길동님', '홍길동', 11) as r3, -- 처음 길동이 찾고 다음 길동이 찾기
    instr('안녕하세요. 홍길동님 홍길동님', '홍길동', -1) as r3 -- 뒤쪽에서 부터 길동이 찾기
from dual;

/*

    패딩
    - lpad(), rpad()
    - left padding, right padding
    - varchar2 lapd(컬럼명, 개수, 문자)
    - varchar2 rapd(컬럼명, 개수, 문자)

*/
select 
    lpad('a', 5), -- '    a' == 자바에서는 %05d정도로 생각하면 된다.
    lpad('a', 5, 'b'), -- 빈 공백을 b로 채워라
    lpad('aa', 5, 'b'),
    lpad('aaa', 5, 'b'),
    lpad('aaaa', 5, 'b'),
    lpad('aaaaa', 5, 'b'),
    lpad('aaaaaa', 5, 'b'), -- 공백이 없으면 b 출력 X
    lpad('1', 3, '0'),
    rpad('1', 3, '0') -- 방향만 반대라고 생각하면 된다.
from dual;

/*

    공백제거
    - trim(), ltrim(), rtrim()
    - varchar2 trim(컬럼명) -- 좌우 공백 제거
    - varchar2 ltrim(컬럼명) -- 오른쪽 공백 제거
    - varchar2 rtrim(컬럼명) -- 왼쪽 공백 제거

*/
select
    trim('     하나     둘     셋     '),
    ltrim('     하나     둘     셋     '),
    rtrim('     하나     둘     셋     ')
from dual;


/*

    문자열 치환
    -- replacr()
    -- varchar2 replace(컬럼명, 찾을 문자열, 바꿀 문자열)
    
    -- regexp_replace(): 정규표현식 지원

*/

select
    replace('홍길동', '홍', '김'),
    replace('홍길동', '이', '김'),
    replace('홍길홍', '홍', '김')
from dual;
-- 자바에서 쓰는 replace와 같다(차이점 없음)

-- regexp_replace(): 정규표현식 지원
select
    name,
    regexp_replace(name, '김[가-힣]{2}', '대치어') -- 김씨는 모두 '대치어'로 변환
from tblInsa;

select
    name,
    regexp_replace(name, '김[가-힣]{2}', '김OO'), -- 김씨는 모두 '김OO'로 변환
    regexp_replace(tel, '(\d{3})-(\d{4})-\d{4}', '\1-\2-xxxx'),
    regexp_replace(tel, '(\d{3}-\d{4})-\d{4}', '\1-xxxx') -- ()로 묶는 부분을 \1로 확인
from tblInsa;

/*
    
    (오라클은 String[] split()이 없음)
    문자열 치환
    - dedode()
    - repalace()와 유사
    - varchar2 dedode(컬럼명, 찾을 문자열, 바꿀 문자열)
    - varchar2 dedode(컬럼명, 찾을 문자열, 바꿀 문자열, 찾을 문자열, 바꿀 문자열)
    - varchar2 dedode(컬럼명, [찾을 문자열, 바꿀 문자열], [찾을 문자열, 바꿀 문자열] x N)
    
*/
-- tblComedian 성별 > 남자, 여자
select
    gender,
    case
        when gender = 'm' then '남자'
        when gender = 'f' then '여자'
    end as g1,
    replace(replace(gender, 'm', '남자'), 'f', '여자') as g2,
    decode(gender, 'm', '남자') as g3, -- 'f'가 null로 나온다.
    decode(gender, 'm', '남자', 'f', '여자') as g3
from tblComedian;
----------------------------------------------------------------------

select 
    replace('자바코드', '자바', 'Java'),
    decode('자바코드', '자바', 'Java'), -- null, 찾지못하면 null반환
    decode('자바코드', '자바코드', 'Java') -- decode는 완벽하게 같은 문자열만 수정 가능
from dual;

-- tblComedian 남자수? 여자수?
select
    count(case
        when gender = 'm' then 1
    end) as m1,
    count(case
        when gender = 'f' then 1
    end) as f1,
    
    count(decode(gender, 'm', 1)) as m2,
    count(decode(gender, 'f', 1)) as f2
from tblComedian;

-- between, in 사용 > 컴파일 > 연산자 변환



















