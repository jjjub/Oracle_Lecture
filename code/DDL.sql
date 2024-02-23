--DDL
create table tblProducer(
    seq number primary key,
    name varchar2(50) not null
);

create table tblImporter(
    seq number primary key,
    name varchar2(50) not null
);

create table tblDistributor(
    seq number primary key,
    name varchar2(50) not null
);

create table tblprovider(
    seq number primary key,
    name varchar2(50) not null
);

create table tblcoProducCompany(
    seq number primary key,
    name varchar2(50) not null
);

create table tbldepart(
    seq number primary key,
    departname varchar2(30) not null
);

create table tblWorker(
    seq number primary key,
    name varchar2(50) not null,
    depart number not null,
    constraint worker_FK foreign key(depart) references tbldepart(seq)
);

create table tblHiredWorker(
    seq number primary key,
    mseq number not null,
    wseq number not null,
    constraint mseq_HiredWorker_FK foreign key(mseq) references tblMovie(mseq),
    constraint wseq_FK foreign key(wseq) references tblWorker(seq)
);

create table tblMovie(
    mseq number primary key,
    firstRelease number not null,
    koreaRelease date not null,
    runningTime number not null,
    cumulativeaudience number not null,
    periodaudience number not null,
    summary varchar2(1000) not null,
    agelimit number not null,
    constraint agelimit_FK foreign key(agelimit) references tblAgeLimit(seq)
);

create table tblParticCompanies(
    seq number primary key,
    partiCompanyNum number not null,
    mseq number not null,
    constraint mseq_FK foreign key(mseq) references tblMovie(mseq)
);



