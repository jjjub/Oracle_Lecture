-- ex13_ddl.sql

/*
    오라클 진행 과정
    1. 초반 DML (ex01 ~ ex12)
    2. DDL > 테이블(구조)
    3. 후반 DML
    4. 데이터 모델링
    5. PL/SQL
    
    
    DDL - 만들고 삭제하기
    - Data Definition Languge
    - 데이터 정의어
    - 테이블, 뷰, 사용자, 인덱스 등의 데이터베이스 오브젝트를 
        생성/수정/삭제하는 명령어
    - 구조를 생성/관리하는 명령어
    a. create: 생성
    b. drop: 삭제
    c. alter: 수정
    
    
    
    테이블 생성(create) > 스키마 정의하기 > 컬럼 정의하기 
                        > 컬럼의 이름, 자료형, 제약사항 정의
                        
    create table 테이블명(
        컬럼 정의,
        컬럼명 자료형(길이) null 제약사항
    );    
    
    제약 사항, Constraint
    - 해당 컬럼에 들어갈 데이터(값)에 대함 조건
        1. 조건을 만족하면 > 대입
        2. 조건을 불만족하면 > 에러 발생
    - 데이터 무결성을 보장하는 위한 도구(*****) 중요
    
    1. NOT NULL
        - 해당 컬럼이 반드기 값을 가져야 한다.
        - 해당 컬럼의 값이 없으면? > 에러 발생
        - 필수값 ***
    
    2. PRIMARY KEY, (PK)
        - 기본키
        - 테이블의 행을 구분하기 위한 제약 사항
        - 모든 테이블은 반드시 1개의 기본키가 존재해야 한다.(*******)
        - 1개의 기본 테이블이 없으면 생성의미가 없는 테이블 이다.
    
    3. FOREIGN KEY
    
    4. UNIQUE - 생각보다 많이쓰진 않는다.
        - 유일하다. > 레코드간의 중복값을 가질 수 없다.
        - null 을 가질 수 있다. > 식별자가 될수 없다.
        ex) 초등학교 교실
            - 학생(번호(PK), 이름(NN), 직책(UQ))
                1, 홍길동, 반장
                2, 아무개, null
                3, 하하하, 부반장
        - PK = UQ + NN 이다
        - null은 가능하지만 중복값은 불가능
    
    5. CHECK
        - 사용자 정의형
        - where절 조건 > 컬럼의 제약 사항으로 적용
    
    6. DEFAULT
        - 제약이라고 하긴 애매하다.
        - 기본값을 제공
        - insert/update 작업 시 > 컬럼에 값을 안넣으면 null 대신에 
                                        미리 설정한 값을 대입
    
    

*/
-- 1. NOT NULL
-- ex) 메모 테이블

delete from tblMemo;

create table tblMemo(
    -- 컬럼명 자료형(길이) null 제약사항
    seq number(3) null,         -- 메모 번호
    name varchar2(30) null,     -- 작성자
    memo varchar2(1000) null,   -- 메모
    regdate date null           -- 작성 날짜
); -- 생성 완료

select * from tblMemo;

insert into tblMemo (seq, name, memo, regdate)
            values(1, '홍길동', '메모입니다.', '2024-02-15'); -- 시간 불량
            
insert into tblMemo (seq, name, memo, regdate)
            values(1, '홍길동', '메모입니다.'
            , to_date('2024-02-15 16:29:15', 'yyyy-mm-dd hh24:mi:ss'));

insert into tblMemo (seq, name, memo, regdate)
            values(2, '아무개', '메모입니다.', sysdate);
            
insert into tblMemo (seq, name, memo, regdate)
            values(3, '아무개', '메모입니다.', null);

insert into tblMemo (seq, name, memo, regdate)
            values(4, '아무개', null, null);

insert into tblMemo (seq, name, memo, regdate)
            values(5, null, null, null);

insert into tblMemo (seq, name, memo, regdate)
            values(null, null, null, null);

select * from tblMemo; -- 아무런 제약이 없는 쓸모 없는 테이블 완성

drop table tblmemo;
------------------------------------------------------------------------

-- 제약을 넣어서 테이블 만들기
create table tblMemo(
    -- 컬럼명 자료형(길이) null 제약사항
    seq number(3) not null,           -- 메모 번호(NN)
    name varchar2(30) null,           -- 작성자
    memo varchar2(1000) not null,     -- 메모(NN)
    regdate date null                 -- 작성 날짜
); -- 생성 완료

select * from tblMemo;

insert into tblMemo (seq, name, memo, regdate)
            values(1, '홍길동', '메모입니다.', sysdate);
            
insert into tblMemo (seq, name, memo, regdate)
            values(2, '홍길동', null, sysdate); 
            -- 제약조건으로 인해 메모번호 or 메모부분이 null일 경우 에러
            -- ORA-01400: NULL을 ("HR"."TBLMEMO"."MEMO") 안에 삽입할 수 없습니다.

insert into tblMemo (seq, name, memo, regdate)
            values(3, '홍길동', '', sysdate); 
            -- 빈 문자열('')도 null로 취급하기에 에러
            -- ORA-01400: NULL을 ("HR"."TBLMEMO"."MEMO") 안에 삽입할 수 없습니다.

-------------------------------------------------------------------------------
-- 2. PRIMARY KEY, (PK)

drop table tblmemo;

create table tblMemo(
    seq number(3) primary key,        -- 메모 번호(PK)
    name varchar2(30) null,           -- 작성자
    memo varchar2(1000) not null,     -- 메모(NN)
    regdate date null                 -- 작성 날짜
); -- 생성 완료

select * from tblMemo;

insert into tblMemo (seq, name, memo, regdate)
            values(1, '홍길동', '메모입니다.', sysdate);
            
insert into tblMemo (seq, name, memo, regdate)
            values(1, '홍길동', '메모입니다.', sysdate);
            -- ORA-00001: 무결성 제약 조건(HR.SYS_C008544)에 위배됩니다
            -- 에러
            
insert into tblMemo (seq, name, memo, regdate)
            values(null, '홍길동', '메모입니다.', sysdate);
            -- ORA-01400: NULL을 ("HR"."TBLMEMO"."SEQ") 안에 삽입할 수 없습니다
            -- 에러

insert into tblMemo (seq, name, memo, regdate)
            values(2, '홍길동', '메모입니다.', sysdate);
            -- PK가 seq(메모번호)에 걸려있어서 나머지는 null이나 중복값이여도 된다.
            
select * from tblMemo where seq = 2; -- PK > 검색조건으로 많이 사용된다.

-----------------------------------------------------------------------------
-- 3. 건너뜀
-- 4. UNIQUE

drop table tblmemo;

create table tblMemo(
    seq number(3) primary key,        -- 메모 번호(PK)
    name varchar2(30) unique,         -- 작성자(UQ)
    memo varchar2(1000) not null,     -- 메모(NN)
    regdate date null                 -- 작성 날짜
); -- 생성 완료

insert into tblMemo (seq, name, memo, regdate)
            values(1, '홍길동', '메모입니다.', sysdate);
            
insert into tblMemo (seq, name, memo, regdate)
            values(2, '홍길동', '메모입니다.', sysdate); 
            -- 에러
            -- ORA-00001: 무결성 제약 조건(HR.SYS_C008546)에 위배됩니다
            
insert into tblMemo (seq, name, memo, regdate)
            values(2, null, '메모입니다.', sysdate);

select * from tblMemo;

--------------------------------------------------------------------------
-- 5. CHECK
drop table tblmemo;

create table tblMemo(
    seq number(3) primary key,        -- 메모 번호(PK)
    name varchar2(30),                -- 작성자
    memo varchar2(1000) not null,     -- 메모(NN)
    regdate date null,                 -- 작성 날짜
    
    -- 중요도 생성(1-중요, 2-보통, 3-안중요)
    --priority number(1) check (priority >= 1 and priority <= 3)
    priority number(1) check (priority between 1 and 3), -- 위와 같다.
    
    --카테고리(할일, 공부, 약속, 가족, 개인)
    category varchar2(10) check (category in ('할일', '공부', '약속'))
); -- 생성 완료

insert into tblMemo (seq, name, memo, regdate, priority, category)
            values(1, '홍길동', '메모입니다.', sysdate, 2, '공부');

insert into tblMemo (seq, name, memo, regdate, priority, category)
            values(2, '홍길동', '메모입니다.', sysdate, 5, '공부'); --에러(priority)
            -- ORA-02290: 체크 제약조건(HR.SYS_C008549)이 위배되었습니다
            
insert into tblMemo (seq, name, memo, regdate, priority, category)
            values(2, '홍길동', '메모입니다.', sysdate, 1, '여행'); -- 에러(category)
            -- ORA-02290: 체크 제약조건(HR.SYS_C008550)이 위배되었습니다
            

select * from tblMemo;

-------------------------------------------------------------------------------

-- 6. DEFAULT
drop table tblmemo;

create table tblMemo(
    seq number(3) primary key,          -- 메모 번호(PK)
    name varchar2(30) default '익명',   -- 작성자
    memo varchar2(1000),                -- 메모
    regdate date default sysdate        -- 작성 날짜
); -- 생성 완료

insert into tblMemo (seq, name, memo, regdate)
            values(1, '홍길동', '메모입니다.', sysdate);
            
insert into tblMemo (seq, name, memo, regdate)
            values(2, null, '메모입니다.', sysdate);
            
insert into tblMemo (seq, name, memo, regdate)
            values(3, '', '메모입니다.', sysdate);
            
insert into tblMemo (seq, memo, regdate)
            values(4, '메모입니다.', sysdate); -- default 동작
            -- name컬럼 자체를 삭제하면 default 동작
            
insert into tblMemo (seq, name, memo, regdate)
            values(5, default, '메모입니다.', sysdate); -- default 동작
            -- default가 정의된 함수에 적용 default 동작
            
insert into tblMemo (seq, name, memo, regdate)
            values(6, default, '메모입니다.', default);


select * from tblMemo;

/*

    제약 사항을 만드는 방법
    
    1. 컬럼 수준에서 만드는 방법
        - 이전에 수업했던 방식
        - 컬럼을 선언할 때 제약 사항도 같이 선언하는 방법
        
    2. 테이블 수준에서 만드는 방법
        - 컬럼 선언과 제약 사항은 선언을 분리시켜 선언하는 방법
        - 코드 관리
        
    3. 외부에서 만드는 방법
        - 테이블 수정 명령어 사용 > alter table



*/
-- 1. 컬럼 수준에서 만드는 방법
drop table tblMemo;

create table tblMemo(
    seq number constraint tblmeme_seq_pk primary key,
    name varchar2(20),
    memo varchar2(100),
    regdate date

);

insert into tblMemo(seq, name, memo, regdate) values (1, '홍길동', '메모', sysdate);

--ORA-00001: 무결성 제약 조건(HR.SYS_C008452)에 위배됩니다
----ORA-00001: 무결성 제약 조건(HR.SYS_C008452)에 위배됩니다 (constraint)
insert into tblMemo(seq, name, memo, regdate) values (1, '홍길동', '메모', sysdate);

select * from tblMemo;

--2. 테이블 수준에서 만드는 방법
drop table tblMemo;

create table tblMemo(
    seq number,
    name varchar2(20) not null,
    memo varchar2(100),
    regdate date,
    
    constraint tblmemo_seq_pk primary key(seq),
    constraint tblmemo_name_uq unique(name),
    constraint tblmemo_memo_check check(length(memo) >= 10)
);

insert into tblMemo(seq, name, memo, regdate) values (1, '홍길동', '메모', sysdate);












































