## String Manipulation

#### Count the client sessions with a FQDN

The table `pg_stat_activity` lists the current sessions and outputs information about the connected sessions.

Assume a FQDN has the form `N_1.N_2.....N_t`, where `t > 1` and each `N_i` can contain lowercase letters, numbers and the dash.
 
[embedmd]:# (sql/count-fqdn-client-hostnames.sql)
```sql
SELECT count(*)

  FROM pg_stat_activity

 WHERE client_hostname SIMILAR TO '([[:alnum:]]+\.)+[[:alnum:]-]+';
```

#### Calculate the edit (or Levenshtein) distance between a table name and the names of its dependent indexes

The `fuzzystrmatch` module must be installed.

[embedmd]:# (sql/levenshtein-table-indexes.sql)
```sql
SELECT auth.rolname AS OWNER,

       tbl.relname AS TABLE_NAME,

       idx.relname AS index_name,

       levenshtein(tbl.relname, idx.relname)

  FROM pg_class tbl

  JOIN pg_index
    ON tbl.oid = pg_index.indrelid

  JOIN pg_class idx
    ON idx.oid = pg_index.indexrelid

  JOIN pg_authid auth
    ON auth.oid = tbl.relowner

 ORDER BY levenshtein;
```


