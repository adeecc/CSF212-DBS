# PL SQL Procedure 

## Parts of PL-SQL

1. Declare Section
    - Starts with `DECLARE`
    - variables, consts, records

2. Execution Section
    - Must Have

3. Exception Section
    - Not required


## Calling a Procedure

- Stored Procedure = named collection of Procedural and SQL Statements
- Procedure can be stored in db
- Reduces Network Traffic

- User `SET serveroutput on;` to get output from the procedures

```sql
SET serveroutput on;
```

- To execute queries use `exec`:

```sql
EXEC <proc_name>
```

- Alternatively, use a `BEGIN...END` block

```sql
BEGIN
<proc_name>
END;
/ -- Important
```

## Grant Permissions to User to use procedures

```sql
GRANT CREATE PROCEDURE TO <user>
```

  - From the `sysdba` or `system` user 


## Parameters of a Procedure
  
- `IN` Mode
    - Default
    - Pass a value to the sub program
    - Formal Parameters acts like const: When the subprogram begins, its value is that of the either its actual param or default value, and sub program can not change its value
    - Actual Param can be a const, initialized variable, literal or expression

- `OUT` Mode
    - Must be specified
    - 'Pass by Result'
    - Returns a value to the invoker
    - Formal Parameter is initialized to the default value of its type. 
        - Defaault = `NULL` except for record type with `non-NULL` default value.
    - WHen the sub program begins, the formal parameter has its inital value regrdless of the value of its actual parameter.  
      - Oracle recommends that the sub program assign a value to the forma param.

    Ex: [Line 64 on Procedures.sql](procedure.sql)
    ```sql
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
    ```

- `IN OUT Mode`
    - Must be Specified
    - Pass an initial value to the sub program and returns updated value to the invoker
    - Pass by Value-Result

## Conditionsals in PL-SQL

## Looping in PL-SQL


## Creating a Function

- `FUNCTION` Keyword used.
- Similar to Procedures
- Explicityl returns a value
