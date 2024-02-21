-- ### subquery ###################################


-- 1. employees. 'Munich'(2700) 도시에 위치한 부서에 소속된 직원들 명단?
select * from employees where department_id = 
(select department_id from departments where location_id = 
(select location_id from locations  where city = 'Munich'));

-- 2. tblMan. tblWoman. 서로 짝이 있는 사람 중 남자와 여자의 정보를 모두 가져오시오.
--    [남자]        [남자키]   [남자몸무게]     [여자]    [여자키]   [여자몸무게]
--    홍길동         180       70              장도연     177        65
--    아무개         175       null            이세영     163        null
--    ..
select 
    name as 남자, height as 남자키, weight as 남자몸무게,
    (select name from tblWomen where couple = tblmen.name) as 여자,
    (select height from tblWomen where couple = tblmen.name) as 여자키,
    (select weight from tblWomen where couple = tblmen.name) as 여자몸무게
from tblmen
    where couple is not null;

-- 3. tblAddressBook. 가장 많은 사람들이 가지고 있는 직업은 주로 어느 지역 태생(hometown)인가?
    
select
    hometown, count(*)
from tblAddressBook
    where job = (select job from tbladdressbook group by job having count(*) = (select max(count(*)) from tblAddressbook group by job))
        group by hometown
            having count(*) = (select max(count(*)) from tblAddressbook where job = 
                                    (select job from tbladdressbook group by job having count(*) = (select max(count(*)) from tblAddressbook group by job)) group by hometown);

-- 4. tblAddressBook. 이메일 도메인들 중 평균 아이디 길이가 가장 긴 이메일 사이트의 도메인은 무엇인가?

select
email
from tblAddressBook
    where 
        group by substr(email,instr(email,'@')+1)
            having length;

-- 5. tblAddressBook. 평균 나이가 가장 많은 출신(hometown)들이 가지고 있는 직업 중 가장 많은 직업은?
select
    job
from tblAddressBook
    where hometown = (select hometown from tblAddressbook group by hometown having avg(age) = (select max(avg(age)) from tblAddressbook group by hometown))
        group by job
            having count(*) = (select max(count(*)) from tblAddressBook where hometown = (select hometown from tblAddressbook 
                                group by hometown having avg(age) = (select max(avg(age)) from tblAddressbook group by hometown)) group by job);

-- 6. tblAddressBook. 남자 평균 나이보다 나이가 많은 서울 태생 + 직업을 가지고 있는 사람들을 가져오시오.
select
    *
from tblAddressBook
    where age > (select avg(age) from tblAddressBook where gender = 'm')
    and address like '서울%' and job is not null;

-- 7. tblAddressBook. gmail.com을 사용하는 사람들의 성별 > 세대별(10,20,30,40대) 인원수를 가져오시오.
select
        case
            when gender = 'm' then '남자'
            when gender = 'f' then '여자'
        end as "성별",
        count(case
            when age BETWEEN 10 and 19 then 1
        end) as "10대",
        count(case
            when age BETWEEN 20 and 29 then 1
        end) as "20대",
        count(case
            when age BETWEEN 30 and 39 then 1
        end) as "30대",
        count(case
            when age BETWEEN 40 and 49 then 1
        end) as "40대"
from tblAddressBook
    where email like '%@gmail.com' 
        group by gender;
        
-- 8. tblAddressBook. 가장 나이가 많으면서 가장 몸무게가 많이 나가는 사람과 같은 직업을 가지는 사람들을 가져오시오.
select * from tblAddressBook
    where job = (select * from tblAddressBook 
                    where age = (select max(age) from tblAddressBook) 
                        and weight = (select max(weight) from tblAddressBook));

-- 9. tblAddressBook.  동명이인이 여러명 있습니다. 이 중 가장 인원수가 많은 동명이인의 명단을 가져오시오.(모든 이도윤)
select
    *
from tblAddressBook
    where name = (select name from tblAddressBook
                        group by name
                            having count(*) = (select max(count(*)) from tblAddressBook group by name));

-- 10. tblAddressBook. 가장 사람이 많은 직업의(332명) 세대별 비율을 구하시오.
--    [10대]       [20대]       [30대]       [40대]
--    8.7%        30.7%        28.3%        32.2%
select 
       round(count(case
            when age BETWEEN 10 and 19 then 1
        end)/count(*)*100,1) || '%' as "[10대]",
       round(count(case
            when age BETWEEN 20 and 29 then 1
        end)/count(*)*100,1) || '%' as "[20대]",
       round(count(case
            when age BETWEEN 30 and 39 then 1
        end)/count(*)*100,1) || '%' as "[30대]",
       round(count(case
            when age BETWEEN 40 and 49 then 1
        end)/count(*)*100,1) || '%' as "[40대]"
from tblAddressBook
    where job = (select job from tblAddressBook
                        group by job
                            having count(*) = (select max(count(*)) from tblAddressBook group by job));
