drop user hr2 cascade;

create user hr2 identified by hr2;
grant connect, resource to hr2;

create table hr2.laborers(
    laborer_id number(12),
    name varchar2(50),
    hire_date date);    

alter table hr2.laborers
    add constraint laborers_laborerid_pk primary key(laborer_id);

create sequence hr2.laborerIdSqe
start with 1
increment by 1;