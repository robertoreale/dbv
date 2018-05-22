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
