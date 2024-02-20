-- ### group by ###################################
select * from tblZoo;
select * from tblAddressbook;
-- 1. tblZoo. 종류(family)별 평균 다리의 갯수를 가져오시오.
select  family, round(avg(leg)) from tblZoo group by family;

-- 2. traffic_accident. 각 교통 수단 별(지하철, 철도, 항공기, 선박, 자동차) 발생한 총 교통 사고 발생 수, 총 사망자 수, 사건 당 평균 사망자 수를 가져오시오.
select * from traffic_accident;

select 
    trans_type,
    sum(total_acct_num), 
    sum(death_person_num),
    round(avg(death_person_num))
from traffic_accident
    group by trans_type;
    
-- 3. tblZoo. 체온이 변온인 종류 중 아가미 호흡과 폐 호흡을 하는 종들의 갯수를 가져오시오.

select 
    breath,
    count(*) 
from tblZoo 
    where thermo = 'variable' 
        group by breath;
        
-- 4. tblZoo. 사이즈와 종류별로 그룹을 나누고 각 그룹의 갯수를 가져오시오.

select
    sizeof, 
    family,
    count(*)
from tblZoo
    group by sizeof, family;

-- 5. tblAddressBook. 관리자의 실수로 몇몇 사람들의 이메일 주소가 중복되었다. 중복된 이메일 주소만 가져오시오.
select
    email, count(*)
from tblAddressBook
    group by email
        having count(*) > 1;

-- 6. tblAddressBook. 성씨별 인원수가 100명 이상 되는 성씨들을 가져오시오.
select
    SUBSTR(name,1,1) as  성씨, count(*) as 인원수
from tblAddressBook
    group by SUBSTR(name,1,1)
        having count(*) >= 100;

-- 7. tblAddressBook. '건물주'와 '건물주자제분'들의 거주지가 서울과 지방의 비율이 어떻게 되느냐?
select  
    case
        when hometown =  '서울' then  '서울'
    else '지방'
    end as 도시,
    round((count(*)/(select count(*) from tblAddressBook where job in ('건물주', '건물주자제분')))*100) || '%' as 비율
from tbladdressbook
    where job in ('건물주', '건물주자제분')
        group by 
            case
                when hometown =  '서울' then '서울'
                else '지방'
            end;
        
select * from tbladdressbook;