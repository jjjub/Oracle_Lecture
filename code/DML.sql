--DML
--관람등급
Insert into tblAgeLimit (seq, name) values ((select nvl(max(seq), 0) + 1 from tblAgeLimit), '전체관람가');
Insert into tblAgeLimit (seq, name) values ((select nvl(max(seq), 0) + 1 from tblAgeLimit), '12세관람가');
Insert into tblAgeLimit (seq, name) values ((select nvl(max(seq), 0) + 1 from tblAgeLimit), '15관람가');
Insert into tblAgeLimit (seq, name) values ((select nvl(max(seq), 0) + 1 from tblAgeLimit), '청소년관람불가');

--영화
Insert into tblMovie (seq, name) values ((select nvl(max(seq), 0) + 1 from tblAgeLimit), '청소년관람불가');