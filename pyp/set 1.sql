create user c##adi
identified by admin
default tablespace users
temporary tablespace temp;

grant create session to c##adi;
grant create table to c##adi;
grant create trigger to c##adi;
grant create procedure to c##adi;
grant create sequence to c##adi;
grant create cursor to c##adi;
grant create function to c##adi;

alter user c##adi quota unlimited on users;

create table product (prid int primary key, prname varchar(10), price int);
create table supplier (supid int primary key, supname varchar(10), suploc varchar(10));
create table supply (pid int, sid int, qty int);

alter table supply add constraint pk_supply primary key (pid, sid);
alter table supply add constraint fk_supply_product foreign key (pid) references product(prid);
alter table supply add constraint fk_supply_supplier foreign key (sid) references supplier(supid);

insert into product values (101, 'Scale', 30);
insert into product values (104, 'Sketch', 110);
insert into product values (105, 'Tape', 15);
insert into product values (107, 'Pad', 160);
insert into product values (110, 'Pad', 25);
insert into product values (112, 'Pin', 5);
insert into product values (124, 'Pin', 120);
insert into product values (135, 'Paper', 110);

insert into supplier values (3, 'Crown', 'Delhi');
insert into supplier values (5, 'Topper', 'Delhi');
insert into supplier values (7, 'Avon', 'Mumbai');
insert into supplier values (11, 'Swan', 'Hyderabad');
insert into supplier values (13, 'Rally', 'Chennai');
insert into supplier values (15, 'Buddy', 'Chennai');

insert into supply values (104, 7, 420);
insert into supply values (104, 13, 380);
insert into supply values (105, 13, 350);
insert into supply values (107, 5, 500);
insert into supply values (107, 11, 200);
insert into supply values (107, 7, 10);
insert into supply values (110, 3, 22);
insert into supply values (110, 5, 35);
insert into supply values (110, 13, 150);
insert into supply values (110, 15, 20);
insert into supply values (124, 7, 300);
insert into supply values (124, 11, 34);
insert into supply values (124, 13, 12);

-- 1
select p.prid, p.prname, sy.qty 
from product p, supplier s, supply sy
where p.prid not in (
	select distinct p1.prid
	from product p1, supplier s1, supply sy1
	where p1.prid = sy1.pid and s1.supid = sy1.sid and sy1.qty < 200
) and p.prid = sy.pid and s.supid = sy.sid;

-- 2
select p.prname, s.supname 
from product p, supplier s, supply sy
where p.prid = sy.pid and s.supid = sy.sid and sy.qty = (select max(qty) from supply);

-- 3
select s.supname
from product p, supplier s, supply sy
where p.prid = sy.pid and s.supid = sy.sid and sy.qty > 400 and p.price > 100;

-- 4
select p.prname, count(sy.sid)
from product p
left outer join supply sy on p.prid = sy.pid
group by p.prname, p.prid;

-- 5
create or replace function fun_0178(arg in number) return number is
	var number;
begin
	select NVL(sum(sy.qty), 0) into var
	from product p
	left outer join supply sy on p.prid = sy.pid
	group by p.prid having p.prid=arg;
	return var;
end;
/

declare
	n number;
begin 
	n := fun_0178(104);
	dbms_output.put_line('Quantity: ' || n);
end;
/

-- 6

create or replace procedure proc1(arg in number) is
	pr_name varchar(10);
	qty number;
	num_supplier number;
begin
	qty := fun_0178(arg);
	if qty > 0 then
		select p.prname into pr_name from product p where p.prid=arg;
		select count(sy.sid) into num_supplier from supply sy where pid=arg;
		dbms_output.put_line(pr_name || ' has supplied: ' || qty || ' by ' || num_supplier || ' number of suppliers');
	else
		dbms_output.put_line('Sorry not supplied');

	end if;
end;
/


exec proc1(104);


-- Write a trigger on supply table after insert, that prints the total quantity supplied by all vendors for the part recently inserted


create or replace trigger total_after_insert after insert 
on supply
for each row
declare 
	n number;
	pragma autonomous_transaction;

begin
	select nvl(sum(sy.qty), 0) into n 
	from supply sy 
	where :new.pid=sy.pid
	group by sy.pid;

	n := n + :new.qty;

	dbms_output.put_line('[' || :new.pid || '] Qty: ' || n);
end;
/



























