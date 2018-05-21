SELECT pg_type.typname AS type_name,

       round(avg(length(pg_class.relname))) AS avg_name_length

  FROM pg_class

  JOIN pg_type
    ON reltype = pg_type.oid

 GROUP BY pg_type.typname

 ORDER BY round(avg(length(pg_class.relname))) DESC;
