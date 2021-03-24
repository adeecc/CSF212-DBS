# PL-SQL Triggers

PL-SQL Code that is automatically invoked by the rdb,s upon the occurence of a data manipulation event.

1. Invoked before or after a data row is inserted, deleted or updated
2. Associated with a database table
3. Each table may have one or more triggers

## Uses
1. Can be used to enforce constraints
2. Can be used to insert/update records and to caall stored procedures
3. Used for auditing (creating logs)
4. Generation of derived values

## Permissions

```sql
GRANT CREATE TRIGGER TO <user>
```

## Syntax
```sql
CREATE [OR REPLACE] TRIGGER <trig_name> [BEFORE | AFTER] <trig_event>
ON <table_name>
[FOR EACH ROW]
[WHEN condition]
[DECLARE]
--
-- Variables to declare
--
BEGIN
--
-- Stuff to do when trigger is called
--
END;
/
```
## Row Level vs Table Level Triggers

- By default table Level Triggers
- To enable Row Level Trigger use `FOR EACH ROW`
- Table Level Trigger: Triggered when there is a change to a table in a query
- Row Level Trigger: Triggered every time a change happens to a row
  - Allows the use of `:old` and `:new` params when updating(?)