-- Create a trigger T1, invoked after insert on book

CREATE TRIGGER t1 AFTER INSERT
ON book
BEGIN
dbms_output.put_line('Inserted a new record into Book Table');
END;
/

-- Print Total Number of Books using triggers

CREATE OR REPLACE TRIGGER print_total_after_insert AFTER INSERT
ON book
DECLARE
    n NUMBER;
BEGIN
    SELECT COUNT(*) INTO n FROM book;
    dbms_output.put_line('Number of Books in table: ' || n);
END;
/


-- Create trigger for before inserting into book
CREATE OR REPLACE TRIGGER print_total_before_insert BEFORE INSERT
ON book
DECLARE
    n NUMBER;
BEGIN
    SELECT COUNT(*) INTO n FROM book;
    dbms_output.put_line('Number of Books in table: ' || n);
END;
/

-- 
CREATE OR REPLACE TRIGGER t2 BEFORE UPDATE OF price 
ON book
BEGIN
    dbms_output.put_line('Triggd: Update Finished!');
END;
/

-- Row Level Trigger version for previous triger 
CREATE OR REPLACE TRIGGER t2_row BEFORE UPDATE OF price 
ON book
FOR EACH ROW
BEGIN
    dbms_output.put_line('Triggd: Update Finished!');
END;
/

-- :old and :new
CREATE OR REPLACE TRIGGER t2_row BEFORE UPDATE OF price 
ON book
FOR EACH ROW
BEGIN
    dbms_output.put_line('Triggd: From: ' || :old.price || ' -> ' || :new.price );
END;
/

-- Insert into supply table and print sum of qty after insertion of the part that was inserted
CREATE OR REPLACE TRIGGER qty_after_insert AFTER INSERT 
ON supply
FOR EACH ROW
DECLARE
    n number;
    pragma autonomous_transaction; -- If this isn't there ORA 04091 
     -- https://docs.oracle.com/cd/B10501_01/server.920/a96525/e2100.htm#1002387
     -- https://docs.oracle.com/cd/E11882_01/appdev.112/e25519/triggers.htm#LNPLS2005
BEGIN
    SELECT SUM(qty) INTO n FROM supply where pid = :new.pid GROUP BY pid;
    dbms_output.put_line('[' || :new.pid || '] Qty: ' || n);
END;
/

