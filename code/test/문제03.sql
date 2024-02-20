-- ### 집계함수 ###################################

-- ### count() ###################################

-- 1. tblCountry. 아시아(AS)와 유럽(EU)에 속한 나라는 총 몇개국??
select count(*) from tblCountry where continent in('AS', 'EU');

-- 2. tblCountry. 인구수가 7000 ~ 20000 사이인 나라는 몇개국??
select count(*) from tblCountry where population between 7000 and 20000;

-- 3. employees. 'IT_PROG' 중에서 급여가 5000불이 넘는 직원은 몇명? > job_id
select count(*) from employees where job_id = 'IT_PROG' and salary > 5000;

-- 4. tblInsa. 010을 안쓰는 사람은 몇명?(연락처가 없는 사람은 제외) > tel
select count(*) from tblInsa where tel not like '010%' and tel is not null;

-- 5. tblInsa. 서울, 경기, 인천에 거주하는 직원수? > city
select  count(*) from tblInsa where city in('서울', '경기', '인천');

-- 6. tblInsa. 여름태생(7~9월) + 여자 직원 총 몇명?
select * from tblInsa;


-- 7. tblInsa. 개발부 + 직위별 인원수? -> 부장 ?명, 과장 ?명, 대리 ?명, 사원 ?명
select count(*) from tblInsa where buseo = '개발부' group by jikwi;

-- ### sum() ###################################


--1. tblCountry. 유럽과 아프리카에 속한 나라의 인구 수 합? 
select sum(population) from tblCountry where continent in ('AF', 'EU');

--2. employees. 매니저(108)이 관리하고 있는 직원들의 급여 총합?
select sum(salary) from employees where manager_id = 108;
select * from employees;

--3. employees. 직업(ST_CLERK, SH_CLERK)을 가지는 직원들의 급여 합?
select sum(salary) from employees where job_id in ('ST_CLERK', 'SH_CLERK');

--4. tblInsa. 서울에 있는 직원들의 급여 합(급여 + 수당)?
select sum(basicpay + sudang) from tblInsa where city = '서울';

--5. tblInsa. 장급(부장+과장)들의 급여 합?
select sum(basicpay) from tblInsa where jikwi like '%장';

-- ### avg() ###################################


--1. tblCountry. 아시아에 속한 국가의 평균 인구수?


--2. employees. 이름(first_name)에 'AN'이 포함된 직원들의 평균 급여?(대소문자 구분없이)


--3. tblInsa. 장급(부장+과장)의 평균 급여?


--4. tblInsa. 사원급(대리+사원)의 평균 급여?


--5. tblInsa. 장급(부장,과장)의 평균 급여와 사원급(대리,사원)의 평균 급여의 차액?


-- ### max(), min() ###################################


--1. tblCountry. 면적이 가장 넓은 나라의 면적은?


--2. tblInsa. 급여(급여+수당)가 가장 적은 직원은 총 얼마를 받고 있는가? 

