## Functions

#### Show the size of all the databases

[embedmd]:# (sql/size-of-all-databases.sql)
```sql
SELECT datname,

       pg_size_pretty(pg_database_size(datname))

  FROM pg_database

 ORDER BY pg_database_size(datname) DESC;
```

#### Show running queries

[embedmd]:# (sql/running-queries.sql)
```sql
SELECT pid,

       age(query_start, clock_timestamp()),

       usename,

       query

  FROM pg_stat_activity

 WHERE query <> '<IDLE>'

   AND query NOT ILIKE '%pg_stat_activity%'

 ORDER BY query_start DESC;
```


