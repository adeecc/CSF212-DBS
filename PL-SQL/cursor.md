# SQL Cursor

Special Construct in PL/SQL to hold data rows returned by SQL Query

- Reserved Area of memory in which outut of a query can be stored
- Cursor Commands: `OPEN`, `FETCH`, 'CLOSE`
- Attributes: 
  - `%rowcount`: Return number of rows fetched so far
  - `%found`: returns true if last fetch returned a row otherwise false
  - `%notfound`: returns true if last fetch did not return a row
  - `%isopen`: returns true if cursor is open



# Sequences in PL-SQL

```sql
CREATE SEQUENCE bookid_seq START WITH 500;
```

```sql
INSERT INTO book VALUES (bookid_seq.nextval, <btitle>, <bprice>);
```