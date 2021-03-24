# SQL Cursor

Special Construct in PL/SQL to hold data rows returned by SQL Query

- Reserved Area of memory in which outut of a query can be stored
- Cursor Commands: `OPEN`, `FETCH`, 'CLOSE`
- Attributed: 
  - `%notfound`: 



# Sequences in PL-SQL

```sql
CREATE SEQUENCE bookid_seq START WITH 500;
```

```sql
INSERT INTO book VALUES (bookid_seq.nextval, <btitle>, <bprice>);
```