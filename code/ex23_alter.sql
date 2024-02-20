-- ex23_alter.sql

/*

    DDL > 객체 조작
    - 객체 생성: create
    - 객체 수정: alter
    - 객체 삭제: drop
    
    DML > 데이터 조작
    - 데이터 생성: insert
    - 데이터 수정: update
    - 데이터 삭제: delete

    테이블 수정하기
    - 테이블 수정 > 테이블 정의 수정 > 스키마 수정 > 컬럼 수정
        > 컬럼명 or 자료형(길이) or 제약사항 등
    - 되도록 테이블을 수정하는 상황을 발생시키면 안된다.
    
    테이블 수정해야 하는 상황 발생
    1. 테이블 삭제(drop) > 테이블 DDL(create) 수정 > 수정된 DDL로 다시 테이블 생성
        a. 기존 테이블에 데이터가 없었을 경우 > 아무 문제 없다.
        b. 기존 테이블에 데이터가 있었을 경우 > 미리 데이터 백업 > 테이블 삭제
            > 수정된 테이블 생성 > 데이터 복구
            - 개발 중에 사용 가능
            - 공부할 때 사용 가능
            - 서비스 운영 중에는 많이 부담되는 방법
        
        
    2. alter 명령어 사용 > 기존 테이블의 구조 변경
        a. 기존 테이블에 데이터가 없었을 경우 > 아무 문제 없음
        b. 기존 테이블에 데이터가 있었을 경우 > 상황에 따라 비용 차이 발생
            - 개발 중에 사용 가능
            - 공부할 때 사용 가능
            - 서비스 운영 중에는 덜 부담되는 방법
    

*/

create table tblEdit(
    seq number primary key,
    data varchar2(20) not null
);
drop table tblEdit;

insert into tblEdit values (1, '마우스');
insert into tblEdit values (2, '키보드');
insert into tblEdit values (3, '모니터');

-- Case 1. 새로운 컬럼을 추가하기
alter table tblEdite 
    add (컬럼 정의);

alter table tblEdit 
    add (price number);

alter table tblEdit 
    add (qty number not null);

select * from tblEdit;

alter table tblEdit
    add(color varchar2(30) default 'white' not null);

desc tblEdit;

delete from tblEdit;

insert into tblEdit values (1, '마우스', 1000, 1);
insert into tblEdit values (2, '키보드', 2000, 1);
insert into tblEdit values (3, '모니터', 3000, 2);

--Case 2. 컬럼을 삭제하기
alter table tblEdit
    drop column 컬럼명;

alter table tblEdit
    drop column color;

SELECT * from tblEdit;

alter table tblEdit
    drop column qty;

alter table tblEdit
    drop column seq; --PK 삭제 > 절대 금지

--Case 3. 컬럼을 수정하기






/*
    insert, update, delete > 복구 가능
    DML
*/

insert into tblEdit values (4, '맥북 M2 프로 2023 고급형');

-- Case 3.1 컬럼 길이 수정하기(확장/축소)
alter table tblEdit 
    modify (컬럼정의);

alter table tblEdit 
    modify (data varchar2(100)); --확장

desc tblEdit;

alter table tblEdit 
    modify (data varchar2(20)); --축소

-- Case 3.2 컬럼의 제약사항 수정하기(not null)
alter table tblEdit
    modify (data varchar2(100) null);

alter table tblEdit
    modify (data varchar2(100) not null);

alter table tblEdit
    modify (data varchar2(100) unique);

--Case 3.3  컬럼 자료형 바꾸기
alter table tblEdit
    modify (data number);

delete from tblEdit;


--Case 4. 제약 사항 조작
drop table tblEdit;

create table tblEdit (
    seq number,
    data varchar2(20)
);

alter table tblEdit
    add constraint tbledit_seq_pk primary key(seq);

alter table tblEdit
    add constraint tbledit_data_uq unique(data);

alter table tblEdit
    drop constraint tbledit_data_uq;
    
insert into tblEdit values(1, '강아지');
insert into tblEdit values(2, '고양이');
insert into tblEdit values(3, '고양이');
insert into tblEdit values(4, null);

desc tblEdit;

select * from tblEdit;
