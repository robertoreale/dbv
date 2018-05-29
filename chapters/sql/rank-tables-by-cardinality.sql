SELECT tbs.spcname AS TABLESPACE,

       cl.relname AS tablename,

       auth.rolname AS tableowner,

       reltuples AS numrows,

       rank() OVER ( PARTITION BY reltablespace
                    ORDER BY reltuples DESC ) AS rank

  FROM pg_class cl

  JOIN pg_tablespace tbs
    ON cl.reltablespace = tbs.oid

  JOIN pg_authid auth
    ON cl.relowner = auth.oid;
