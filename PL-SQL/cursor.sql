CREATE OR REPLACE PROCEDURE cursor1 AS
    id NUMBER;
    pr NUMBER;
    cursor book_cursor 
        IS SELECT bid, price FROM book;
    
BEGIN
    OPEN book_cursor;
    LOOP
        FETCH book_cursor INTO id, pr;
        EXIT WHEN book_cursor%notfound;
        dbms_output.put_line('[' || id || '] Price: ' || pr);
    END LOOP;
    CLOSE book_cursor;
END;
/