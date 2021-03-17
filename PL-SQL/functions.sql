CREATE FUNCTION func1(arg IN NUMBER) RETURN NUMBER IS
    var NUMBER;
BEGIN
    SELECT price INTO var  FROM BOOK WHERE bid = arg;
    RETURN var;
END;
/

-- Calling the Function
DECLARE 
    n NUMBER;
BEGIN
    n := func1(107);
    dbms_output.put_line('Price is: ' || n);
END;
/

-- Write a Function to take two numbers and return their sum
-------------------------------------------------------------------

CREATE OR REPLACE FUNCTION myAdder(x IN NUMBER, y IN NUMBER) RETURN NUMBER IS
    s NUMBER;
BEGIN
    s := x + y;
    RETURN s;
END;
/

DECLARE 
    n NUMBER;
BEGIN
    n := myAdder(400, 20);
    dbms_output.put_line('Sum is: ' || n);
END;
/

-------------------------------------------------------------------