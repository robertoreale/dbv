## First Steps

### Show the size of all the databases

[embedmd]:# (sql/size-of-all-databases.sql)
```sql
SELECT datname, 
       Pg_size_pretty(Pg_database_size(datname)) 
FROM   pg_database 
ORDER  BY Pg_database_size(datname) DESC;
```

### Display cache hit rates

[embedmd]:# (sql/cache-hit-rates.sql)
```sql
SELECT Sum(heap_blks_read)                                               AS heap_read, 
       Sum(heap_blks_hit)                                                AS heap_hit, 
       ( Sum(heap_blks_hit) - Sum(heap_blks_read) ) / Sum(heap_blks_hit) AS ratio 
FROM   pg_statio_user_tables; 
```

### Count index blocks in cache

[embedmd]:# (sql/index-blocks-in-cache.sql)
```sql
SELECT Sum(idx_blks_read)                                             AS idx_read,
       Sum(idx_blks_hit)                                              AS idx_hit,
       ( Sum(idx_blks_hit) - Sum(idx_blks_read) ) / Sum(idx_blks_hit) AS ratio
FROM   pg_statio_user_indexes;
```

### Display table index usage rates

[embedmd]:# (sql/table-index-usage-rates.sql)
```sql
SELECT relname                                  AS relname, 
       100 * idx_scan / ( seq_scan + idx_scan ) AS percent_of_times_index_used, 
       n_live_tup                               AS rows_in_table 
FROM   pg_stat_user_tables 
ORDER  BY n_live_tup DESC;
```

### Show running queries

[embedmd]:# (sql/running-queries.sql)
```sql
SELECT   pid, 
         Age(query_start, Clock_timestamp()), 
         usename, 
         query 
FROM     pg_stat_activity 
WHERE    query <> '<IDLE>' 
AND      query NOT ilike '%pg_stat_activity%' 
ORDER BY query_start DESC;
```
## Advanced Data Selection

In this chapter we will discuss analytical and aggregate functions.

### Sort the object types by their average name length

By sorting the object types by the average name length of their instances, we find a metric about how *exoteric* a given object type is.

[embedmd]:# (sql/sort-object-types-by-avg-name-length.sql)
```sql
SELECT pg_type.typname                      AS type_name, 
       Round(Avg(Length(pg_class.relname))) AS avg_name_length 
FROM   pg_class 
       JOIN pg_type 
         ON reltype = pg_type.oid 
GROUP  BY pg_type.typname 
ORDER  BY Round(Avg(Length(pg_class.relname))) DESC; 
```
## Numerical Recipes

In this chapter we will give examples of application of the database to numerical problems.

### Calculate the sum of a geometric series

We show that the sum of a geometric series of ratio 1/2 converges to 2.

[embedmd]:# (sql/sum-of-geometric-series.sql)
```sql
SELECT Sum(Power(2, -n)) 
FROM   Generate_series(0, 100) AS n; 
```

### Generate the Fibonacci sequence, recursively

The `NUMERIC` type is mandatory when doing arbitrary-precision math.

[embedmd]:# (sql/recursive-fibonacci.sql)
```sql
WITH recursive fibonacci(f_n, f_n_prev) AS 
( 
       SELECT 1, 
              0 
       UNION 
       SELECT 1 :: numeric, 
              1 :: numeric 
       UNION 
       SELECT f_n + f_n_prev, 
              f_n 
       FROM   fibonacci ) 
SELECT f_n AS nth_fibonacci_number 
FROM   fibonacci limit 100;
```
