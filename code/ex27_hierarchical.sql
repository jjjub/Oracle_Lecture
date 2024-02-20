-- ex27_hierarchical.sql

/*

    계층형 쿼리, Hierarchical Query
    - 오라클 전용 쿼리
    - 레코드의 관계가 서로간의 상하 수직 구조인 경우에 사용한다.
    - 자기 참조를 하는 테이블에서 사용(셀프 조인)
    - 자바(= 트리 구조)
    
    tblSelf
    홍사장
        - 김부장
            - 박과장
                - 최대리
                    - 정사원
        - 이부장

*/

create table tblComputer(
    seq number primary key,
    name varchar2(50) not null,
    qty number not null,
    pseq number null references tblComputer(seq)
);

select * from tblComputer;

--직원 가져오기 + 상사명
--부품 가져오기 + 부모 부품의 정보
select
    c2.name as 부품명,
    c1.name as 부모부품명
from tblComputer c1             --부모부품(부모 테이블)
    inner join tblComputer c2   --부품(자식 테이블)
        on c1.seq = c2.pseq;
        
--계층형 쿼리
--1. start with절 + connect by절
--2. 계층형 쿼리에서만 사용 가능한 의사 컬럼들
--  a. prior : 자신과 연관된 부모 레코드를 참조 객체
--  b. level : 세대수 or depth

-- prior : 부모 레코드 참조
-- connect_by_root : 최상위 레코드 참조
-- connect_by_isleaf : 말단 노드


select 
    seq as 번호,
    lpad(' ', (level - 1) *5) || name as 부품명,
    prior name as  부모부품명,
    level
from tblComputer
    start with seq = 1 --루트 레코드 지정
        connect by prior seq = pseq --현재 레코드와 부모 레코드를 연결하는 조건
            order siblings by name asc;     --siblings > 같은 형제끼리

select 
    seq as 번호,
    lpad(' ', (level - 1) *5) || name as 부품명,
    prior name as  부모부품명,
    level,
    connect_by_root name,
    connect_by_isleaf,
    sys_connect_by_path(name, '▷')
from tblComputer
    --start with seq = (select seq from tblComputer where name = '컴퓨터') --루트 레코드 지정
    --start with seq = 1
    start with pseq is null
        connect by prior seq = pseq --현재 레코드와 부모 레코드를 연결하는 조건
            order siblings by name asc;     --siblings > 같은 형제끼리    
        
        
        
        
        
        


