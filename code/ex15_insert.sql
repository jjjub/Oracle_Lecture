--ex15_insert.sql

/*

    insert 문
    - DML
    - 테이블에 데이터를 추가하는 명령어

    - insert into 테이블명 (컬럼리스트) values (값리스트);

*/
drop table tblMemo;

create table tblMemo(
    seq number constraint tblmeme_seq_pk primary key,
    name varchar2(30) default '익명',
    memo varchar2(1000),
    regdate date default sysdate not null
);

drop SEQUENCE seqMemo;
create SEQUENCE seqMemo;

--1. 표준
--: 원본 테이블의 정의된 컬럼 순서대로 컬럼리스트와 값 리스트를 작성하는 방법
--: 특별한 목적이 없으면 이 방식을 사용
insert into tblMemo(seq, name, memo, regdate) 
        values(seqMemo.nextVal, '홍길동', '메모입니다.', sysdate);

-- 2. 컬럼 리스트의 순서는 원본 테이블과 상관없다.
-- : 컬럼 리스트와 값 리스트의 순서만 동일하면 된다.
insert into tblMemo(regdate, seq, name, memo) 
        values(sysdate, seqMemo.nextVal, '홍길동', '메모입니다.');
        
-- 3. 
insert into tblMemo(seq, name, memo, regdate) 
        values(seqMemo.nextVal, '메모입니다.', sysdate);
        
-- 4.
insert into tblMemo(seq, name, memo) 
        values(seqMemo.nextVal, '홍길동', '메모입니다.', sysdate);

--5. null 컬럼 조작
--5.a null 상수 사용
insert into tblMemo(seq, name, memo, regdate) 
        values(seqMemo.nextVal, '홍길동', null, sysdate);
--5.b 컬럼 생략
insert into tblMemo(seq, name, regdate) 
        values(seqMemo.nextVal, '홍길동', sysdate);

-- 6. default 컬럼 조작
-- 6.a 컬럼 생략 > null 대입 > default 호출
insert into tblMemo(seq, memo, regdate) 
        values(seqMemo.nextVal, '메모입니다.', sysdate);
        
-- 6.b null 상수 > default 동작 안함
insert into tblMemo(seq, name, memo, regdate) 
        values(seqMemo.nextVal, null, '메모입니다.', sysdate);

-- 6.c default 상수
insert into tblMemo(seq, name, memo, regdate) 
        values(seqMemo.nextVal, default, '메모입니다.', sysdate);    
        
-- 7. 단축
-- 7.a 컬럼리스트를 생략할 수 있다.
insert into tblMemo values(seqMemo.nextVal, '홍길동', '메모입니다.', sysdate);

-- 7.b 컬럼리스트를 생략하면, 테이블의 원본 컬럼 순서대로 값리스트를 작성해야 한다.
--테이블 선언시 설정한 컬럼의 순서대로 해야함
insert into tblMemo values(sysdate, seqMemo.nextVal, '홍길동', '메모입니다.');

-- 7.c null 컬럼 생략 불가능
insert into tblMemo values(seqMemo.nextVal, '홍길동', sysdate);
insert into tblMemo values(seqMemo.nextVal, '홍길동', null, sysdate);

-- 7.d default 컬럼 생략 불가능
insert into tblMemo values(seqMemo.nextVal, default, '메모입니다.', sysdate);


-- 8.
--tblMemo 테이블 > 복사 > 새 테이블 생성(tblMemoCopy)
create table tblMemoCopy(
    seq number constraint tblmemecopy_seq_pk primary key,
    name varchar2(30) default '익명',
    memo varchar2(1000),
    regdate date default sysdate not null
);

insert into tblMemoCopy select * from tblMemo;
insert into tblMemoCopy select * from tblMemo where name = '홍길동';

-- 9.
-- tblMemo 테이블 > 복사 > 새 테이블 생성(tblMemoCopy)
-- 테이블 구조 복사(O)
-- 제약 사항 복사(X)
-- 임시 + 다량 데이터 용도
drop table tblMemoCopy;

create table tblMemoCopy as select * from tblMemo;

insert into tblMemoCopy(seq, name, memo, regdate) 
        values(1, '홍길동', '메모입니다.', sysdate);

select * from tblMemo;
select * from tblMemoCopy;
delete from tblMemoCopy;
















