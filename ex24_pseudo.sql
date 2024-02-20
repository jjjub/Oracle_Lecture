-- ex24_pseudo.sql

/*

    의사 컬럼, Pseudo Column
    - 실제 컬럼이 아닌데 컬럼처럼 행동하는 객체
    
    rownum
    - 행번호
    - 시퀀스 객체 상관X
    - 테이블의 행번호를 가져오는 역할


*/

select
    name, buseo, --컬럼(속성) > 객체(레코드)의 특석에 따라 다른 값을 가진다.
    100, --상수 > 모든 객체(레코드)가 동일한 값을 가진다.
    substr(name, 2), -- 함수 > I/O > 객체(레코드)의 특석에 따라 다른 값을 가진다.
    rownum --의사 컬럼
from tblInsa;


