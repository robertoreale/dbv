## Advanced Data Selection

In this chapter we will discuss analytical and aggregate functions.

#### Display cache hit rates

[embedmd]:# (sql/cache-hit-rates.sql)
```sql
SELECT sum(heap_blks_read) AS heap_read,

       sum(heap_blks_hit) AS heap_hit,

       (sum(heap_blks_hit) - sum(heap_blks_read)) / sum(heap_blks_hit) AS ratio

  FROM pg_statio_user_tables;
```

#### Count index blocks in cache

[embedmd]:# (sql/index-blocks-in-cache.sql)
```sql
SELECT sum(idx_blks_read) AS idx_read,

       sum(idx_blks_hit) AS idx_hit,

       (sum(idx_blks_hit) - sum(idx_blks_read)) / sum(idx_blks_hit) AS ratio

  FROM pg_statio_user_indexes;
```

#### Sort the object types by their average name length

By sorting the object types by the average name length of their instances, we find a metric about how *exoteric* a given object type is.

[embedmd]:# (sql/sort-object-types-by-avg-name-length.sql)
```sql
SELECT pg_type.typname AS type_name,

       round(avg(length(pg_class.relname))) AS avg_name_length

  FROM pg_class

  JOIN pg_type
    ON reltype = pg_type.oid

 GROUP BY pg_type.typname

 ORDER BY round(avg(length(pg_class.relname))) DESC;
```

#### Rank tables based on their cardinality

We partition the result set by tablespace.

[embedmd]:# (sql/rank-tables-by-cardinality.sql)
```sql
SELECT tbs.spcname AS TABLESPACE,

       cl.relname AS tablename,

       auth.rolname AS tableowner,

       reltuples AS numrows,

       rank() OVER (PARTITION BY reltablespace
                    ORDER BY reltuples DESC) AS rank

  FROM pg_class cl

  JOIN pg_tablespace tbs
    ON cl.reltablespace = tbs.oid

  JOIN pg_authid auth
    ON cl.relowner = auth.oid;
```


