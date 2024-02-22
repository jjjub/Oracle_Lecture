-- ex29_plsql.sql

/*

    PL/SQL
    - Oracle's Procedural Language extension to SQL
    - 기존의 ANSI-SQL + 절차 지향 언어 기능 추가(변수, 제어 흐름, 객체 정의 등)
    
    프로시저, Procedure
    - 메서드, 함수 등..
    - 순서가 있는 명령어들의 집합
    - 모든 PL/SQL 구문은 프로시저내에서만 작성/동작이 가능하다.
    - 프로시저 영역 <-> ANSI-SQL 영역
    
    1. 익명 프로시저
        - 1회용 코드 작성
        
    2. 실명 프로시저
        - 재사용
        - 저장
        - 데이터베이스 객체
    
    PL/SQL 프로시저 구조
    
    1. 4개의 블럭으로 구성
        - DECLARE
        - BEGIN
        - EXCEPTION
        - END
    
    2. DECLARE
        - 선언부
        - 프로시저내에서 사용할 변수, 객체 등을 선언하는 영역
        - 생략가능
        
    3. BEGIN ~ END
        - 구현부
        - 구현된 코드를 가지는 영역(메서드의 body 영역)
        - 생략 불가능
        - 구현된 코드? > ANSI-SQL + PL/SQL(연산, 제어 등)
        
    4. EXCEPTION
        - 예외 처리부
        - catch 역할
        - try는 BEGIN ~ END에서
        - 생략 가능
        
    DECLARE
        변수 선언;
        객체 선언;
    BEGIN
        업무 코드;
        업무 코드;
        업무 코드;
    EXCEPTION
        예외처리 코드;
    END;
        
    ANSI-SQL <> PL/SQL 
    
    자료형 or 변수 or 제어흐름....
    
    PL/SQL 자료형
    - ANSI-SQL과 동일
    
    변수 선언하기
    - 변수명 자료형(길이) [not null] [default 값];
    
    PL/SQL 연산자
    - ANSI-SQL과 동일
    
    대입 연산자
    - ANSI-SQL
        ex) update table set column = '값'
    - PL/SQL
        ex) 변수 := 값;
        
*/
set serveroutput on;    --현재 세션에서만 유효
set serverout on;
set serveroutput off;
-- 익명 프로시저 선언하기
begin  
    dbms_output.put_line('Hello World!');
end;
/--프로시저 구분

begin
    
    dbms_output.put_line('Hello World2!');

end;
/

declare
-- 변수명 자료형(길이) [not null] [default 값];
    num number;
    name varchar(20);
    today date;
begin

    num := 10;
    dbms_output.put_line(num);
    
    name := '홍길동';
    dbms_output.put_line(name);
    
    today := sysdate;
    dbms_output.put_line(today);

end;
/

declare
    num1 number;
    num2 number;
    num3 number := 30;
    num4 number default 40;
    num5 number not null := 50; --declare 블럭에서 초기화를 해야 한다.
begin
    
    dbms_output.put_line('num1' || num1); --null
    
    num2 := 20;
    dbms_output.put_line(num2);
    
    dbms_output.put_line(num3);
    
    dbms_output.put_line(num4);
    
    num5 := null;
    dbms_output.put_line(num5);
    
end;
/


/*

    변수 > 어떤 용도로 사용
    - 일반적인 값을 저장하는 용도 > 비중 낮음
    - select 결과를 담는 용도 > 비중 높음
    
    select into 절(PL/SQL)


*/

DECLARE
    vbuseo varchar2(15);
BEGIN
    
    select buseo into vbuseo from tblInsa where name = '홍길동';
    
    dbms_output.put_line(vbuseo);
    
    --insert into tblTodo
      --  values ((select max(seq) + 1 from tblTodo), '할일', sysdate, null);
    
END;
/

--성과급 받는 직원
create table tblBonus (
    name varchar(15)
);

-- 1. 개발부 + 부장 > select > name
-- 2. tblBonus > name > insert

insert into tblBonus (name)
    values ((select name from tblInsa where buseo = '개발부' and jikwi = '부장'));
    
select * from tblBonus;

DECLARE
    vname varchar2(15);
BEGIN

    --1. 
    select name into vname from tblInsa where buseo = '개발부' and jikwi = '부장';
    
    --2.
    insert into tblBonus (name) values (vname);
    
END;
/

DECLARE
    vname VARCHAR2(15);
    vbuseo VARCHAR2(15);
    vjikwi VARCHAR2(15);
    vbasicpay NUMBER;
BEGIN
    --select into 절
    -- into 사용 시
    -- 1. 컬럼의 개수와 변수의 개수 일치
    
    select name, buseo, jikwi, basicpay into vname, vbuseo, vjikwi, vbasicpay from tblInsa where num = 1001;
    dbms_output.put_line(vname);
    dbms_output.put_line(vbuseo);
    dbms_output.put_line(vjikwi);
    dbms_output.put_line(vbasicpay);
    
END;
/

/*
    타입 참조
    
    %type
    -사용하는 테이블의 특정 컬럼의 스키마를 알아내서 변수에 적용
    - 복사되는 정보
         a. 자료형
         b. 길이
         
    %rowtype
    - 행 전체 참조(여러개의 컬럼을 참조)

*/

DECLARE
    --vbuseo varchar(15);
    vbuseo tblInsa.buseo%type;
BEGIN
    select buseo from tblInsa where name = '홍길동';
    dbms_output.put_line(vbuseo);
END;
/

DECLARE
    vname tblInsa.name%type;
    vbuseo tblInsa.buseo%type;
    vjikwi tblInsa.jikwi%type;
    vbasicpay tblInsa.basicpay%type;
BEGIN
    select name, buseo, jikwi, basicpay 
        into vname, vbuseo, vjikwi, vbasicpay 
    from tblInsa where num = 1001;
    
    dbms_output.put_line(vname);
    dbms_output.put_line(vbuseo);
    dbms_output.put_line(vjikwi);
    dbms_output.put_line(vbasicpay);
    
END;
/

drop table tblBonus;

create table tblBonus(
    seq number primary key,
    num number(5) not null references tblInsa(num), -- 직원번호(FK)
    bonus number not null
);

--프로시저 선언하기
-- 1. 서울, 부장, 영업부
-- 2. tblBonus > 지급 > 보너스(급여 * 1.5)

declare
    vnum tblInsa.num%type;
    vbasicpay tblInsa.basicpay%type;
begin
    select 
        num, basicpay into vnum, vbasicpay
    from tblInsa
        where city = '서울' and jikwi = '부장' and buseo = '영업부';
        
    insert into tblBonus (seq, num, bonus)
        values ((select nvl(max(seq), 0) + 1 from tblBonus), vnum, vbasicpay * 1.5);
end;
/

select * from tblBonus b
    inner join tblInsa i
        on i.num = b.num;
        

select * from tblMen;   --10명
select * from tblWomen; --10명

-- 무명씨 > 성전환 수술 > tblMen > tblWomen 옮기기
-- 1. '무명씨' > tblMen > select
-- 2. tblWomen > insert
-- 3. tblMen > delete

declare
    --vname tblMen.name%type;
    --vage tblMen.age%type;
    --vheight tblMen.height%type;
    --vweight tblMen.weight%type;
    --vcouple tblMen.couple%type;
    vrow tblMen%rowtype;
begin
    --1. select name, age, height, weight, couple into vrow
    select * into vrow from tblMen where name = '무명씨';
    
    dbms_output.put_line(vrow.name);
    
    --2. 
    insert into tblWomen (name, age, height, weight, couple) values(vrow.name, vrow.age, vrow.height, vrow.weight, vrow.couple);
    
    --3.
    delete from tblMen where name = vrow.name;
    
end;
/


/*

    제어문
    1. 조건문
    
    2. 반복문
    
    3. 분기문
    
    
*/


declare
    vnum number := 10;
begin
    if vnum > 0 then
        dbms_output.put_line('양수');
    end if;
end;
/

declare
    vnum number := 10;
begin
    if vnum > 0 then
        dbms_output.put_line('양수');
    else
        dbms_output.put_line('음수');
    end if;
end;
/

declare
    vnum number := 10;
begin
    if vnum > 0 then
        dbms_output.put_line('양수');
    elsif vnum <0 then
        dbms_output.put_line('음수');
    else
        dbms_output.put_line('0');
    end if;
end;
/

-- tblInsa. 남자직원 / 여자직원 > 다른 업무
declare
    vgender char(1);
begin

    select substr(ssn, 8, 1) into vgender from tblInsa where num = 1008;
    
    if vgender = '1' then
        dbms_output.put_line('남자 업무');
    elsif vgender = '2' then
        dbms_output.put_line('여자 업무');
    end if;

end;
/

-- 직원 1명 선택 > 보너스 지급
-- 차등 지급
-- a. 과장/부장 > basicpay * 1.5
-- b. 사원/대리 > basicpay * 2
declare
    vnum tblInsa.num%type;
    vbasicpay tblInsa.basicpay%type;
    vjikwi tblInsa.jikwi%type;
    vbonus number;
begin
    select 
        num, basicpay, jikwi into vnum, vbasicpay, vjikwi
    from tblInsa
        where num = 1005;
    
    if vjikwi in ('과장', '부장') then
        vbonus := vbasicpay * 1.5;
    elsif vjikwi in ('사원', '대리') then
        vbonus := vbasicpay * 2;
    end if;
    
    insert into tblBonus (seq, num, bonus)
            values ((select nvl(max(seq), 0) + 1 from tblBonus), vnum, vbonus);
end;
/

/*

    case문
    - ANSI-SQL의 case와 동일
    - 자바: switch문, 다중 if문
    
*/

declare
    vcontinent tblCountry.continent%type;
    vresult varchar2(30);
begin
    
    select continent into vcontinent from tblCountry  tblCountry where name = '대한민국';
    
    case 
        when vcontinent = 'AS' then vresult := '아시아';
        when vcontinent = 'EU' then vresult := '유럽';
        when vcontinent = 'AF' then vresult := '아프리카';
        else vresult := '기타';
    end case;
    
    dbms_output.put_line(vresult);
    
end;
/

declare
    vcontinent tblCountry.continent%type;
    vresult varchar2(30);
begin
    
    select continent into vcontinent from tblCountry  tblCountry where name = '대한민국';
    
    case vcontinent
        when 'AS' then vresult := '아시아';
        when 'EU' then vresult := '유럽';
        when 'AF' then vresult := '아프리카';
        else vresult := '기타';
    end case;
    
    dbms_output.put_line(vresult);
    
end;
/

/*

    반복문
    
    1. loop
        - 단순 반복
        
    2. for loop
        - loop 기분
        - 횟수 반복(자바 for)
        
    3. while loop
        - loop 기반 
        - 조건 반복(자바 while)
*/

begin
    
    loop
        dbms_output.put_line('구현부');
    end loop;
    
end;
/


declare
    vnum number := 1;
begin

    loop
        dbms_output.put_line(vnum);
        vnum := vnum + 1;
        
        exit when vnum > 10;
        
    end loop;

end;
/


create table tblLoop(
    seq number primary key,
    data varchar2(100) not null

);

create sequence seqLoop;
drop table tblLoop;
drop sequence seqLoop;
-- data > 항목0001, 항목0002, .... 항목1000

declare
    vnum number := 1;
begin
    
    loop
        insert into tblLoop (seq, data) 
            values (seqLoop.nextVal, '항목' || lpad(vnum, 4, '0'));
            
            vnum := vnum + 1;
            
            exit when vnum > 1000;
            
    end loop;
    
end;
/
select * from tblLoop;

/*

    2. for loop
    for (int n : list){
    
    }
    
    for (int n in list){
    
    }
    
    foreach (){
    
    }
    
*/

begin
    for i in 1..10 loop
        dbms_output.put_line(i);
    end loop;
end;
/

create table tblGugudan(
    dan number not null,
    num number not null,
    result number not null,

);
alter table tblGuguda
    add constraint tblgugudan_dan_num_pk primary key(dan, num); --복합키(Composite Key)


begin
    for dan in 2..9 loop
        for num in 1..9 loop
            insert into tblGugudan (dan, num, result)
                values (dan, num, dan * num);
        end loop;
    end loop;
end;
/

select * from tblGugudan;


begin
    for i in reverse 1..10 loop
        dbms_output.put_line(i);
    end loop;
end;
/

-- 3, while loop

declare
    vnum number := 1;
begin
    while vnum <= 10 loop
        dbms_output.put_line(vnum);
        vnum := vnum + 1;
    end loop;
end;
/


/*

    select > 결과셋 > PL/SQL 변수 대입
    
    1. select into
        - 결과셋의 레코드가 1개일 때만 사용이 가능하다.
        
    2. cursor
        - 결과셋의 레코드가 N개일 떄만 사용이 가능하다.
        - 루프 사용
        
    declare
        변수 선언;
        커서 선언; --결과셋 참조 객체
    begin
        커서 열기;
            loop   
                데이터 접근(루프 1회전 > 레코드 1개 접근) <- 커서 사용
            end loop;
        커서 닫기;
    end;

*/
set serveroutput on;


declare
    vname tblInsa.name%type;
    vcnt number;
begin
    select count(*) into vcnt from tblInsa where num = 1001;
    
    if vcnt > 0 then
        select name into vname from tblInsa ; --where num = 1001;
        dbms_output.put_line(vname);
    else
        dbms_output.put_line('없음');
    end if;
end;
/

create view vwTest
as 
select문;

cursor vcusor
is
select문;

declare
    
    --cursor 커서명 is select문;
    cursor vcursor 
    is 
    select name from tblInsa; --정의O, 실행X
    
    vname tblInsa.name%type;
    
begin

    open vcursor; --커서 열기 > select 실행 > 결과셋을 커서가 참조
        
        -- fetch 커서 into 변수
        -- select 컬럼 into 변수
        --fetch vcursor into vname;
        --dbms_output.put_line(vname);
        
        --fetch vcursor into vname;
        --dbms_output.put_line(vname);
        
        loop
            fetch vcursor into vname;
            
            dbms_output.put_line(vname);
            
--            if vcursor%notfound then
--                dbms_output.put_line('O');
--            else
--                dbms_output.put_line('X');
--            end if;
            
        end loop;
        
    
    close vcursor; --커서 닫기

end;
/

-- '기획부' > 이름, 직위, 급여 > 출력

declare
    
    cursor vcurso
    is
     select name, jikwi, basicpay from tblInsa where buseo = '기획부';
    
    vname tblInsa.name%type;
    vjikwi tblInsa.jikwi%type;
    vbasicpay tblInsa.jikwi%type;
    
begin
    
    open vcurso;
    loop
        --select name, jikwi, basicpay into vname, vjikwi, vbasicpay
        fetch vcurso into vname, vjikwi, vbasicpay;
        exit when vcurso%notfound;
        
        --업무 > 기획부 직원 한명씩 접근
        dbms_output.put_line(vname || ',' || vjikwi || ',' || vbasicpay);
        
        
    end loop;
    close vcurso;
    
    
end;
/

-- 문제. tblBonus
-- 모든 직원에게 보너스 지급
-- 60명 전원
-- 과장/부장 > 1.5배
-- 사원/대리 > 2배

declare
    cursor vcurso
    is
    select num, basicpay, jikwi from tblInsa;
    

    vnum tblInsa.num%type;
    vbasicpay tblInsa.basicpay%type;
    vjikwi tblInsa.jikwi%type;
    vbonus number;
begin

    open vcurso;
        loop
            fetch vcurso into vnum, vbasicpay, vjikwi;
            exit when vcurso%notfound;
        
            --업무 > 기획부 직원 한명씩 접근
            if vjikwi in ('과장', '부장') then
                vbonus := vbasicpay * 1.5;
            elsif vjikwi in ('사원', '대리') then
                vbonus := vbasicpay * 2;
            end if;
    
            insert into tblBonus (seq, num, bonus)
                    values ((select nvl(max(seq), 0) + 1 from tblBonus), vnum, vbonus);
        
        end loop;
    close vcurso;
   
    

end;
/

select * from tblbonus b
inner join  tblInsa i
on b.num = i.num;


--커서 탐색
--1. 커서 + loop
--2. 커서 + for loop > 간단

-- 60명 직원 정보 전부 출력
declare

    cursor vcursor
    is 
    select * from tblInsa;
    
    vrow tblInsa%rowtype;
    
begin
    open vcursor;
    loop
        fetch vcursor into vrow;
        exit when vcursor%notfound;
        
        dbms_output.put_line(vrow.name || ',' || vrow.buseo);
        
    end loop;
    close vcursor;
end;
/


--for loop
declare

    cursor vcursor is select * from tblInsa;
   -- vrow tblInsa%rowtype;
    
begin
    --open vcursor;
    for vrow in vcursor loop
        --fetch vcusor into vrow;
        --exit when vcursor%notfound;
        
        dbms_output.put_line(vrow.name || ',' || vrow.buseo);
        
    end loop;
    --close vcursor;

end;
/

-- 예외처리
-- : 실행부에서(begin~end) 발생하는 예외를 처리하는 블럭 > exception블럭
-- : catch절 역할과 동일

declare
    vname tblInsa.name%type;
begin
--ORA-01403: 데이터를 찾을 수 없습니다.
    dbms_output.put_line('111');
    select name into vname from tblInsa where num = 1000;
    dbms_output.put_line('222');
    dbms_output.put_line(vname);
    dbms_output.put_line('333');
 
exception
     when others then
        dbms_output.put_line('예외처리');
        
end;
/

--예외 발생 > 기록(log)
create table tblLog(
    seq number primary key,                 --PK
    code varchar2(7) not null,              --상태코드
    message varchar2(1000) not null,       --예외 메시지
    regdate date default sysdate not null   --발생시각
);

create sequence seqLog;

declare
    vcnt number;
    vname varchar2(15);
begin
    select count(*) into vcnt from tblCountry;-- where name = '러시아';
    dbms_output.put_line(100 / vcnt);
    
    select name into vname from tblInsa where num = 1000;
    dbms_output.put_line(vname);

    exception
    
        when ZERO_DIVIDE then
            dbms_output.put_line('0으로 나누기');
            insert into tblLog
                values (seqLog.nextVal, 'A001', '가져온 레코드가 없습니다.', default);
        when NO_DATA_FOUND then
            dbms_output.put_line('데이터 없음');
            insert into tblLog
                values (seqLog.nextVal, 'B003', '직원이 존재하지 않습니다.', default);
        when others then
            dbms_output.put_line('나머지 예외');
            insert into tblLog
                values (seqLog.nextVal, 'Z009', '기타 예외가 발생했습니다.', default);
end;
/
select * from tblLog;

-----------------------------익명 프로시저-----------------------------------

-----------------------------실명 프로시저-----------------------------------
/*

    프로시저
    1. 익명 프로시저
        -1회용
        
    2. 실명 프로시저
        - 저장 > 재사용
        
    실명 프로시저
    - 저장 프로시저(Stored Procedure)
    
    1. 저장 프로시저, Stored Procedure
        - 매개변수 / 반환값 > 구성 자유
        
    2. 저장 함수,  Stored Function
        - 매개변수 / 반환값 > 필수
    
    익명 프로시저 선언
    
    [declare
        변수 선언;
        커서 선언;]
    [begin
        구현부;
    [exception
        예외처리;]
    end;
    
    
    
    저장 프로시저 선언
    
    create [or replace] procedure 프로시저명
    is(as)
    [    변수 선언;
        커서 선언;]
    [begin
        구현부;
    [exception
        예외처리;]
    end;

*/

--  즉시 실행
declare
    vnum number;
begin
    vnum:=100;
    dbms_output.put_line(vnum);
end;
/

--  저장 프로시저
create or replace procedure procTest
is
    vnum number;
begin
    vnum:=100;
    dbms_output.put_line(vnum);
end;
/

--프로시저 호출
begin
procTest;
end;
/

--메서드 > 매개변수 + 반환값

-- 1. 매개변수가 있는 프로시저
create or replace procedure procTest(pnum number) --매개변수
is
    vnum number; --일반변수
begin
    vnum := pnum * 2;
    dbms_output.put_line(vnum);

end procTest;
/

begin
    procTest(100);
end;
/


create or replace procedure procTest(pwidth number, pheight number)
is
    varea number;
begin
    varea := pwidth * pheight;
    dbms_output.put_line(varea);
end procTest;
/

begin
    procTest(100, 200);
end;
/

-- 1. 프로시저의 매개변수 > 길이 표현(X), not null 표현(X)
-- 2. is(as) 생략 불가능
create or replace procedure procTest(
    pname varchar2
)
is
begin
    dbms_output.put_line('안녕하세요. ' || pname || '님');
end procTest;
/

begin
    proctest('홍길동');
end;
/

create or replace procedure procTest(
    pwidth number,
    pheight number default 10 
)
is
    varea number;
begin
    varea := pwidth * pheight;
    dbms_output.put_line(varea);
end procTest;
/

begin
    --procTest(10, 20);
    procTest(10); --width(10) * height(10)
end;
/

/*

    매개변수 모드
    - 매개변수가 값을 전달하는 방식
    - Call by Value > 값을 넘기는 동작
    - Call by Reference > 주소를 넘기는 동작
    
    1. in > 기본
    2. out 
    3. in out > X
    

*/

create or replace procedure procTest(
    pnum1 number,           --in parameter'
    pnum2 in number,
    presult out number,     --out parameter
    presult2 out number,
    presult3 out number
)
is
begin
    presult := pnum1 + pnum2;
    presult2 := pnum1 - pnum2;
    presult3 := pnum1 * pnum2;
end procTest;
/

declare
    vtemp number;
    vtemp2 number;
    vtemp3 number;
begin
    procTest(10, 20, vtemp, vtemp2, vtemp3 ); --ORA-06550: 줄 2, 열22:PLS-00363: '0' 식은 피할당자로 사용될 수 없습니다
    dbms_output.put_line(vtemp);
    dbms_output.put_line(vtemp2);
    dbms_output.put_line(vtemp3);
end;
/

/*

    문제
    
    1. procTest1
        - 부서 전달(인자 1개) > in
        - 해당 부서의 직원 중 급여를 가장 많이 받는 사람의 번호를 반환 > out
        - 호출 + 번호 출력
    
    2. procTest2
        - 직원 번호 전달 > in
        - 같은 지역에 사는 직원의 수, 같은 직위의 직원 수, 해당 직원보다 급여를 더 많이 받는 사람의 수 > out x 3개
        - 호출 + 인원수x3 출력

*/

create or replace procedure procTest1(
    pbuseo varchar2,
    presult out number
)
is
begin
    select num into presult from tblInsa where buseo = pbuseo and basicpay = (select max(basicpay) from tblInsa where buseo = pbuseo);
    
end;
/

declare
    presult number;
begin
    procTest1('기획부', presult);
    dbms_output.put_line(presult);
end;
/

create or replace procedure procTest2(
    pnum in number,
    pcnt out number,
    pcnt2 out number,
    pcnt3 out number
)
is
begin

    select count(*) into pcnt from tblInsa
        where city = (select city from tblInsa where num = pnum);
    select count(*) into pcnt2 from tblInsa
        where jikwi = (select jikwi from tblInsa where num = pnum);
    select count(*) into pcnt3 from tblInsa
        where basicpay > (select basicpay from tblInsa where num = pnum);

end;
/

declare
    vcnt1 number;
    vcnt2 number;
    vcnt3 number;
begin
    procTest2(1001, vcnt1, vcnt2, vcnt3);
    dbms_output.put_line(vcnt1);
    dbms_output.put_line(vcnt2);
    dbms_output.put_line(vcnt3);
end;
/

-- 직원 퇴사 프로시저 procDeleteStaff
-- 1. 퇴사 직원 > 담당 프로젝트 유무 확인
-- 2. 담당 프로젝트 존재 > 위임
-- 3. 퇴사 직원 삭제
select * from tblStaff;
select * from tblProject;

create or replace procedure procDeleteStaff(
    pseq number,            --퇴사할 직원번호
    pstaff number,          --위임받을 직원번호
    presult out number      -- 성공(1) or 직원번호
)
is 
    vcnt number; --퇴사 직원의 담당 프로젝트 개수
    
begin
    --1. 퇴사 직원이 담당 프로젝트가 있는지
    select count(*) into vcnt from tblProject where staff_seq = pseq;
    
    --2. 조건 > 위임 유무 결정
    if vcnt > 0 then
        --3. 위임
        update tblProject set staff_seq = pstaff where staff_seq = pseq;
    else
        --3. 아무것도 안함
        null;
    end if;
    
    --4. 퇴사
    delete from tblStaff where seq = pseq;
    
    --5. 성공
    presult := 1;
    
exception
    --5. 실패
    when others then
        presult := 0;
    
end procDeleteStaff;
/

declare
    vresult number;
begin
    procDeleteStaff(1,2,vresult);
    if vresult = 1 then
        dbms_output.put_line('퇴사 성공');
    else 
        dbms_output.put_line('퇴사 실패');
    end if;
end;
/



-- 직원 퇴사 프로시저 procDeleteStaff
-- 1. 퇴사 직원 > 담당 프로젝트 유무 확인
-- 2. 담당 프로젝트 존재 > 위임
-- 3. 퇴사 직원 삭제

-- 2. 위임받을 직원 > 현재 프로젝트를 가장 적게 담당하는 직원에게 자동으로 위임
-- 동률 > rownum = 1

create or replace procedure procDeleteStaff (
    pseq number,        --퇴사할 직원번호
    presult out number  -- 성공(1) or 실패(0)
)
is 
    vcnt number; --퇴사 직원의 담당 프로젝트 개수
    vseq number; --위임받을 직원 번호
begin

    --1. 퇴사 직원이 담당 프로젝트가 있는지?
    select count(*) into vcnt from tblProject where staff_seq = pseq;
    
    --2. 조건 > 위임 유무 결정
    if vcnt > 0 then
    
        --2.5 가장 프로젝트를 적게 담당한 직원?
        select seq into vseq from
            (select seq, nvl(cnt, 0) as cnt from 
                    (select staff_seq, count(*) as cnt from tblProject
                        where staff_seq is not null
                            group by staff_seq) a
                                right outer join tblStaff s
                                    on a.staff_seq = s.seq
                                        order by cnt asc)
                                            where rownum = 1;
    
        
        --3. 위임
        update tblProject set staff_seq = vseq where staff_seq = pseq;        
        
    else
        --3. 아무것도 안함
        null; --개발자의 의도 표현
    end if;
    
    --4. 퇴사
    delete from tblStaff where seq = pseq;
    
    --5. 성공
    presult := 1;

exception
    
    -- 5. 실패
    when others then
        presult := 0;

end procDeleteStaff;
/


declare
    vresult number;
begin
    procDeleteStaff(3, vresult);
    if vresult = 1 then
        dbms_output.put_line('퇴사 성공');
    else 
        dbms_output.put_line('퇴사 실패');
    end if;
end;
/


select * from tblStaff;
select * from tblProject;

select staff_seq, count(*) as cnt from tblProject
    where staff_seq
    is not null
    group by staff_seq;
    

/*

    저장 프로시저
    1. 저장 프로시저
    2. 저장 함수
    
    저장 함수, Stored Function > 함수(function)
    - 저장 프로시저와 동일
    - 반환값이 반드시 존재
*/

--num1 + num2 > 합 반환

--프로시저
create or replace procedure procSum(
    pnum1 in number,
    pnum2 in number,
    presult out number
)
is
begin
    presult := pnum1 + pnum2;
    
end procSum;
/


--함수
create or replace function fnSum(
    pnum1 in number,
    pnum2 in number
) return number
is
begin
    return pnum1 + pnum2;
end fnSum;
/


declare
    vresult number;
begin
    procSum(10, 20, vresult);
    dbms_output.put_line(vresult);
    
    
    vresult := fnSum(30, 40); --PL/SQL에서 잘 사용안한다. > ANSI-SQL에서 사용한다.
    dbms_output.put_line(vresult);
end;
/

select
    name, buseo, jikwi, fnGender(ssn)
from tblInsa;

create or replace function fnGender(
    pssn varchar2
) return varchar2
is
begin
    return case
                when substr(pssn, 8, 1) = '1' then '남자'
                when substr(pssn, 8, 1) = '2' then '여자'
            end;
end fnGender;
/

--프로시저: 일련의 흐름을 가지는 명령어 집합 = 모듈
--함수 : ANSI-SQL의 반복되는 업무

/*
    프로시저
    1. 프로시저
    2. 함수
    3. 트리거
    
    트리거, Trigger
    - 프로시저의 한종류
    - 개발자의 호출이 아닌, 미리 지정한 특정 사건이 발생하면 시스템이 자동으로 호출하는 프로시저
    - 예약(사건) > 감시 > 사건 발생 > 프로시저 호출
    
    - 특정 테이블 지정 > 지정 테이블을 오라클 감시
        > 사건 발생(insert / update / delete) > 미리 준비한 프로시저 호출
        
    트리거 구문
    create or replace trigger 트리거명
        befor|after
        insert|update|delete
        on 테이블명
        [for each row]
    declare
        선언부;
    begin
        구현부;
    exception
        예외처리부;
    end;
    

*/


-- tblInsa > 직원 삭제
create or replace trigger trgInsa
    before      --삭제가 발생하기 직전에 구현부를 실행하라
    delete      --삭제가 발생하는지 검사
    on tblInsa  --tblInsa 테이블에서
begin
    dbms_output.put_line(to_char(sysdate, 'hh24:mi:ss') || '트리거가 실행되었습니다.');
    
    -- 목요일에는 퇴사가 불가능
    if to_char(sysdate, 'dy') = '목' then
        
        --강제로 에러 발생
        --throw new Exception()
        --: -20000 ~ -29999
        raise_application_error(-20001, '목요일에는 퇴사가 불가능합니다.'); --SQL 오류: ORA-20001: 목요일에는 퇴사가 불가능합니다.
        
    end if;
end trgInsa;
/

delete from tblInsa where num = 1006; --16:30:32트리거가 실행되었습니다.

delete from tblBonus;

-- *** 오라클 사용자가 생성한 모든 식별자(테이블명, 컬럼명, 등)을
-- 저장할 때 대문자로 저장한다.

-- 트리거 확인
select trigger_name, table_name, status from user_triggers where table_name = 'TBLINSA';

-- 트리거 중지
alter trigger TRGINSA disable;
--트리거 작동
alter trigger TRGINSA enable;

rollback;

-- 로그 기록
-- tblDiary > 감시 > 사건 > 로그
create table tblLogDiary(
    seq number primary key,                 --PK
    massage varchar2(1000) not null,        --메시지
    regdate date default sysdate not null   --시간
);

create sequence seqLogDiary;

create or replace trigger trgDiary
    after
    insert or update or delete
    on tblDiary
declare
    vmessage varchar2(1000);
begin
    
    --dbms_output.put_line('trgDiary 호출됨');
    
    if inserting then
        --dbms_output.put_line('trgDiary 호출됨 - 삽입');
        vmessage := '새로운 항목이 추가되었습니다.';
    elsif updating then
        --dbms_output.put_line('trgDiary 호출됨 - 수정');
        vmessage := '기존 항목이 수정되었습니다.';
    elsif deleting then
        --dbms_output.put_line('trgDiary 호출됨 - 삭제');
        vmessage := '기존 항목이 삭제되었습니다.';
    end if;
    
    insert into tblLogDiary values (seqLogDiary.nextVal, vmessage, default);
end trgDiary;
/

insert into tblDiary values(11, '눈이 많이 왔습니다.', '눈', sysdate);

update tblDiary set subject = '함박눈이 많이 왔습니다.' where seq = 11;

delete from tblDiary where seq = 11;

select * from tblDiary;
select * from tblLogDiary;

alter trigger trgDiary disable;

/*

    [for each row]
    
    1. 생략
        - 문장(Query) 단위 트리거. Table Level Trigger
        
    2. 사용
        - 행(Record) 단위 트리거
        
*/

create or replace trigger trgMen
    after
    delete
    on tblMen
    --for each row
--declare 생략 가능
begin
    dbms_output.put_line('레코드를 삭제했습니다.' || :old.name || ', ' || :old.age);
end trgMen;
/

select * from tblMen; --조세호

delete from tblMen where name = '조세호';
delete from tblMen;

rollback;

create or replace trigger trgMen
    before
    delete
    on tblMen
    for each row
begin
    dbms_output.put_line('레코드를 수정했습니다. > ' || :old.name);
    --dbms_output.put_line('수정 전 나이 > ' || :old.age);
    --dbms_output.put_line('수정 후 나이 > ' || :new.age);
    dbms_output.put_line('전 여친 > ' || :old.couple);
    dbms_output.put_line('현 여친 > ' || :new.couple);
end trgMen;
/

select * from tblMen;

update tblMen set age = age + 1 where name = '홍길동';
update tblMen set couple = '장도연' where name = '홍길동';
insert into tblMen  values('강호동', 30, 180, 90, '호호호');
delete from tblMen where name = '강호동';

-- insert > :old(x), :new(O)
-- update > :old(o), :new(o)
-- delete > :old(o), :new(x)

-- 퇴사 > 프로젝트 위임

delete from tblStaff;       --데이터 삭제
truncate table tblStaff;    --데이터 삭제

delete from tblProject;
truncate table tblProject;

drop table tblStaff;        --테이블 삭제

commit;
rollback;

select * from tblStaff;
select * from tblProject;

create or replace trigger trgDeleteStaff
    before          --3. 하기 전에
    delete          --2. 퇴사
    on tblStaff     --1. 직원 테이블에서
    for each row    --4. 해당 직원 정보
begin
    --5. 사용 > 위임
    update tblProject set
        staff_seq = 3
            where staff_seq = :old.seq; --퇴사하는 직원 번호
    
end trgDeleteStaff;
/

select * from tblStaff;

delete from tblStaff where seq = 1;
rollback;

