## Tables, Tables Everywhere

In the relational paradigm, the basic data structure is a table.

#### List all tables

[embedmd]:# (sql/list-all-tables.sql)
```sql
SELECT tablename

  FROM pg_catalog.pg_tables;
```

#### Display table index usage rates

[embedmd]:# (sql/table-index-usage-rates.sql)
```sql
SELECT relname AS relname,

       100 * idx_scan / (seq_scan + idx_scan) AS percent_of_times_index_used,

       n_live_tup AS rows_in_table

  FROM pg_stat_user_tables

 ORDER BY n_live_tup DESC;
```

#### Count number of relations for each order of magnitude

Relations are objects in the database such as tables and indexes. Tables which have both regular and TOAST pieces will be broken out into separate components.

Note: IEC prefixes are used.

[embedmd]:# (sql/count-relations-by-order-of-magnitude.sql)
```sql
WITH relation AS

        (SELECT nspname || '.' || relname AS "relname",

               trunc(log(1024, pg_relation_size(c.oid))) AS "order_of_magnitude"

          FROM pg_class c

          LEFT JOIN pg_namespace n
            ON (n.oid = c.relnamespace)

         WHERE nspname NOT IN ('pg_catalog',
                         'information_schema')

           AND pg_relation_size(c.oid) <> 0
       )
SELECT CASE
           WHEN order_of_magnitude = 0 THEN 'bytes'

            WHEN order_of_magnitude = 1 THEN 'KiB'

            WHEN order_of_magnitude = 2 THEN 'MiB'

            WHEN order_of_magnitude = 3 THEN 'GiB'

            WHEN order_of_magnitude = 4 THEN 'TiB'

            WHEN order_of_magnitude = 5 THEN 'PiB'

            WHEN order_of_magnitude = 6 THEN 'EiB'

            WHEN order_of_magnitude = 7 THEN 'ZiB'

            WHEN order_of_magnitude = 8 THEN 'YiB'

            ELSE 'UNKNOWN'

             END AS "order_of_magnitude",

       count(*) COUNT

  FROM relation

 GROUP BY order_of_magnitude

 ORDER BY order_of_magnitude;
```


