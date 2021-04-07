# Builtin Functions in SQL

- [SQL Functions Reference](https://docs.oracle.com/cd/B19306_01/server.102/b14200/functions001.htm)

1. `chr(n)`
2. `concat(string, string)`
3. `instr(string, string)`
4. `length(n)`
5. `lpad(string, n [, string])`
6. `ltrim(string [, string])`
7. `rpad(string, n [, string])`
8. `rtrim(string [, string])`
9. `replace(string, search_string, replacement_string)`
10. `substr(string, position, substring_length)`
11. `initcap(string)`
12. `lower(string)`
13. `upper(string)`
14. `translate(expr, from_string, to_string)`
15. `abs(n)`
16. `celi(n)`
17. `cos(n)`
18. `exp(n)`
19. `floor(n)`
20. `mod(m, n)`
21. `power(x, y)`
22. `round(x [, y])`
23. `sign(n)`

```sql
select chr(97) from dual; -- prints 'a'

select concat('H', '1') from dual; -- 'h1'

select instr('Hello', 'e') from dual; -- 2; 1 indexing

select length(12) from dual; -- 2

select lpad('s', 4, 'd') from dual; -- lpad(string, required length, character to pad with) => ddds
```