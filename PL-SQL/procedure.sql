CREATE OR REPLACE PROCEDURE proc1 AS
-- DECLARE SECTION MIGHT BE PRESENT
BEGIN
    UPDATE book SET price=250 WHERE price=300;
    dbms_output.put_line('Update Done: '); -- printf like statement
END;
/
------------------------------------------------------------------------------------

CREATE OR REPLACE PROCEDURE proc2(d IN NUMBER) IS -- IS and AS kinda interchangeable
-- Declare keyword optional
    n NUMBER;
BEGIN
    SELECT price INTO n FROM book WHERE bid = d;
    dbms_output.put_line('Price of the Book with [ID: ' || d || ']: ' || n);
END;
/

------------------------------------------------------------------------------------

CREATE OR REPLACE PROCEDURE looper AS
-- DECLARE Not working for some reason
    x NUMBER := 10;

BEGIN
    LOOP 
        dbms_output.put_line('[' || x || '] ');
        x := x - 1;
        IF x < 5 THEN 
            EXIT;
        END IF;
    END LOOP;
    dbms_output.put_line('Final Value: ' || x);
END;
/

------------------------------------------------------------------------------------

CREATE OR REPLACE PROCEDURE proc3(n IN NUMBER, o OUT number) AS
BEGIN
    SELECT price INTO o FROM book WHERE bid = n;
END;
/

DECLARE pr
    NUMBER(5);
BEGIN 
    proc3(101, pr);
    dbms_output.put_line('Price of 101 is: ' || pr);
END;
/

------------------------------------------------------------------------------------

CREATE OR REPLACE PROCEDURE proc4(arg1 IN NUMBER, arg2 OUT NUMBER) AS
    n NUMBER;
BEGIN
    n := arg1 + 10;
    arg2 := 60;
END;
/

-- Anonmyous Procedure
DECLARE
    m NUMBER;
    p NUMBER;
BEGIN
    m := 20;
    p := 5;

    dbms_output.put_line('m: ' || m || ' p: ' || p);
    proc4(m, p);
    dbms_output.put_line('m: ' || m || ' p:' || p);
END;
/

-- Procedure to Insert a new Book Record into the Books Table
------------------------------------------------------------------------------------

CREATE OR REPLACE PROCEDURE insertpro(id IN NUMBER, name IN VARCHAR2, pri IN NUMBER) AS
BEGIN
    INSERT INTO book VALUES(id, name, pri);
    dbms_output.put_line('Inserted: [' || id || '] ' || name || ' @ ' || pri);
END;
/

-- Procedure to insert BOOK record into BOOK Table
-- If total Number of records is even after insertion, print ok, else error
------------------------------------------------------------------------------------

CREATE OR REPLACE PROCEDURE insertEvenOrError(id IN NUMBER, name IN VARCHAR2, pr IN NUMBER) AS
    n NUMBER := 0;
    m NUMBER := 0;
BEGIN
    INSERT INTO book VALUES (id, name, pr);
    SELECT COUNT(*) INTO n FROM book;
    SELECT MOD(n, 2) INTO m FROM dual;

    IF m <> 0 THEN
        dbms_output.put_line('Odd Number off Tuples (' || n || ') in Book Table');
    END IF;
END;
/

-- Get Price and Title of Book if bid is given as IN argument
------------------------------------------------------------------------------------
CREATE OR REPLACE PROCEDURE getPriceTitle(n IN NUMBER, tiOut OUT VARCHAR2, prOut OUT NUMBER) AS
BEGIN
    SELECT title, price INTO tiOut, prOut FROM book WHERE bid = n;
END;
/

DECLARE
    title varchar2(10);
    price NUMBER;
BEGIN
    getPriceTitle(107, title, price);
    dbms_output.put_line('[107] Title: ' || title || ' Price:' || price);
END;
/