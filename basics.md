# User Handing

## Creating a user
```sql
CREATE USER <uname>

```

## Ganting Permissions
```sql
GRANT <permission> TO <uname>;
```

### Granting connect Permission and Data Transfer Quota
```sql
GRANT CONNECT TO <uname> identified by <uname>
ALTER USER <uname> quota unlimited on users;
GRANT 
```