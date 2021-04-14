# User Handing

## Creating a user
```sql
CREATE USER <username> 
IDENTIFIED BY <password>
DEFAULT TABLESPACE <default_tablespace_name>
TEMPORARY TABLESPACE <temp_tablespace_name>;
```

ex: 
```sql
CREATE USER c##adichopra 
IDENTIFIED BY admin
DEFAULT TABLESPACE users
TEMPORARY TABLESPACE temp;
```

 - You need to prefix c## to the username field if you are in a Container DB rather than a pluggable DB
 - To check if you are in a CDB:
  ```sql
  SELECT CDB FROM V$DATABASE;
  ```

  if output is yes, then you are in a CDB.

## Ganting Permissions
```sql
GRANT <permission> TO <uname>;
```

### Granting connect Permission and Data Transfer Quota
```sql
GRANT CONNECT TO <uname> IDENTIFIED BY <password>; 
GRANT CREATE SESSION TO <uname>; -- <-- If previous does not work use this

GRANT CREATE TABLE to <uname>;

ALTER USER <uname> QUOTA unlimited ON <default_tablespace>;

```


- ie entire workflow: 

```sql
CREATE USER c##adichopra 
IDENTIFIED BY admin
DEFAULT TABLESPACE users
TEMPORARY TABLESPACE temp;

GRANT CREATE SESSION TO c##adichopra;
GRANT CREATE TABLE to c##adichopra;
GRANT CREATE TRIGGER to c##adichopra;
GRANT CREATE SEQUENCE to c##adichopra;
GRANT CREATE PROCEDURE to c##adichopra;

ALTER USER c##adichopra QUOTA unlimited ON users;



```
