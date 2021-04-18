create user c##adico identified by admin default tablespace users temporary tablespace temp;

grant create session to c##adico;
grant create table to c##adico;
grant create procedure to c##adico;
grant create trigger to c##adico;
grant create function to c##adico;
grant create cursor to c##adico;
grant create sequence to c##adico;

alter user c##adico quota unlimited on users;


create table student (
    scode int primary key,
    sname varchar(15),
    sage int,
    sbranch char(5)
);


create table course (
    cid int primary key,
    cname char(7) unique,
    credit int
);

create table studentcourse (
    sid int,
    cno int,
    grade char(1),
    primary key(sid, cno)
);

alter table studentcourse add constraint sc_s foreign key (sid) references student(scode);
alter table studentcourse add constraint sc_c foreign key (cno) references course(cid); 

insert into student values (1001, 'Kriti', 18, 'MECH');
insert into student values (1003, 'Joginder', 19, 'MECH');
insert into student values (1006, 'Mani', 22, 'CSE');
insert into student values (1021, 'Farooq', 21, 'EEE');
insert into student values (1025, 'Girija', 19, 'MECH');
insert into student values (1032, 'Girija', 22, 'CSE');
insert into student values (1038, 'Rajanish', 21, 'MECH');
insert into student values (1056, 'Praneet', 23, 'EEE');
insert into student values (1059, 'Stephen', 19, 'CSE');
insert into student values (1068, 'Stephen', 20, 'CIVIL');

insert into course values (10, 'DBMS', 3);
insert into course values (20, 'CRPYT', 4);
insert into course values (50, 'ARCH', 5);
insert into course values (80, 'MATHS', 3);
insert into course values (90, 'CRYPTO', 3);

insert into studentcourse values (1001, 10, 'A');
insert into studentcourse values (1001, 50, 'A');

insert into studentcourse values (1006, 10, 'A');
insert into studentcourse values (1006, 20, 'B');
insert into studentcourse values (1006, 80, 'A');
insert into studentcourse values (1006, 90, 'D');

insert into studentcourse values (1021, 80, 'A');
insert into studentcourse values (1021, 90, 'D');

insert into studentcourse values (1025, 90, 'B');

insert into studentcourse values (1059, 10, 'A');

insert into studentcourse values (1056, 80, 'A');
insert into studentcourse values (1056, 90, 'D');

insert into studentcourse values (1068, 50, 'A');
insert into studentcourse values (1068, 90, 'B');



-- 1 Names of students with score 'A' in all subejcts they are enrolled in 

select s.sname 
from student s
where s.scode not in 
    (select distinct sid from studentcourse where grade <> 'A') 
    and s.scode in 
    (select distinct sid from studentcourse);


-- 2. Dept Name and course which have atleast 2 A Grades

-- 3. Get name, age and number of registered course


select s.sname, s.sage, count(sc.cno)
from student s, studentcourse sc
where sc.sid = s.scode
group by s.sname, s.sage;


-- 4. Get cname, credit for courses which have atleast 3 registrations 
-- and not registered by student from CSE

select cname, credit
from course where 
cid in (
    select cno from studentcourse group by cno having  count(sid) > 2
)
and cid not in (
    select cno from studentcourse, student where sid=scode and sbranch='CSE'
);

-- 5. Write a func taking student id as input and return number of registered courses
create or replace function get_reg_courses(f_sid in number) return number as
    qty number;

BEGIN
    select NVL(count(cno), 0) into qty from studentcourse where sid = f_sid;
    return qty;
end;
/

-- 6. WA procedure taking student_is as input, call function get_reg_courses and print number of courses.


create or replace procedure fancy(p_sid in number) as
    m_name varchar(15);
    m_qty number;
begin
    m_qty := get_reg_courses(p_sid);

    if m_qty > 0 then
        select sname into m_name from student where scode = p_sid;
        dbms_output.put_line('Student with ID: ' || p_sid || ' and Name: ' || m_name || ' has registered for: ' || m_qty || ' number of courses');
    else 
        dbms_output.put_line('Sorry Not registered to any course');
    end if;
end;
/