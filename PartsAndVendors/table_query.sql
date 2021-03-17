CREATE TABLE part (pid int PRIMARY KEY, pname varchar2(10), price int);
CREATE TABLE vendor (vid INT PRIMARY KEY, vanem VARCHAR2(10), vloc VARCHAR2(10));
CREATE TABLE supply (pid INT, vid INT, qty INT);

ALTER TABLE supply ADD CONSTRAINT part_fk FOREIGN KEY (pid) REFERENCES part(pid);
ALTER TABLE supply ADD CONSTRAINT vend_fk FOREIGN KEY (vid) REFERENCES vendor(vid);  
