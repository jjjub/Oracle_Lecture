--ex30_transaction.sql

/*

    트랜잭션, Transaction
    - 데이터를 조작하는 업무의 물리적(시간적) 단위
    - 1개 이상의 명령어를 묶어 놓은 단위
    - *** 트랜잭션을 어떻게 처리할 것인가?
    
    트랜잭션 명령어(DCL > TCL)
    1. commit
    2. rollback
    3. savepoint



*/

create table tblTrans
as
select name, buseo, jikwi from tblInsa where city = '서울';

select * from tblTrans;

--우리가 하는 행동(SQL) > 시간순으로 기억(***********)

--로그인 직후(접속) > 트랜잭션이 시작됨
-- 트랜잭션 > 모든 명령어(X) > insert, update, delete 명령어만 트랜잭션에 포함된다.
-- insert, update, delete 작업 > 오라클(HDD) 적용(X), 임시 메모리 적용(O)

delete from tblTrans where name = '박문수'; --현재 트랜잭션에 포함

select * from tblTrans;

--박문수 되살리기
rollback;

select * from tblTrans;

delete from tblTrans where name = '박문수';

rollback;

delete from tblTrans where name = '박문수';

commit;


insert into tblTrans values ('호호호', '기획부', '사원');
update tblTrans set jikwi = '상무' where name ='홍길동';

select * from tblTrans;

commit;

/*

    트랜잭션이 언제 시작해서 ~ 언제 끝나는지
    
    새로운 트랜잭션이 시작하는 시점
    1. 클라이안트 접속 직후
    2. commit 실행 직후
    3. rollback 실행 직 후
    4. DDL 실행 직후
    
    현재 트랜잭션이 종료되는 시점
    1. commit > DB에 반영O
    2. rollback > DB에 반영 X
    3. 클라이언트 접속 종료
        a. 정상 종료
            - 현재 트랜잭션에 반영이 안된 명령어가 남아 있으면  > 질문
        b. 비정상 종료
            - 트랜잭션을 처리할만한 시간적인 여유가 없는 경우
            -  rollback
    4. DDL 실행(**** 주의)
        - create, alter, drop > 실행 > 즉시 commit 실행
        - DDL 성격 > 구조 변경 > 데이터 영향 미침 > 사전에 미리 저장(commit)
        
    
*/
delete from tblTrans where name = '홍길동';
select * from tblTrans;

-- 새접속
select * from tblTrans;

delete from tblTrans where name = '홍길동';

select * from tblTrans;

commit;

update tblTrans set jikwi = '사장' where name = '홍길동';

select * from tblTrans;

-- 시퀀스 객체 생성
create sequence seqTrans; --commit 호출

rollback;

select * from tblTrans; -- 홍길동 기획부 사장

-- savepoint 

select * from tblTrans;

insert into tblTrans values ('후후후', '기획부', '사원');

savepoint a;

delete from tblTrans where name = '홍길동';

savepoint b;

update tblTrans set buseo = '개발부' where name = '후후후';

select * from tblTrans;

rollback to b;

rollback to a;

rollback;



--SQL 작성 + 트랜잭션 활용
-- 






