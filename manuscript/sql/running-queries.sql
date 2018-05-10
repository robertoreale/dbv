SELECT   pid, 
         Age(query_start, Clock_timestamp()), 
         usename, 
         query 
FROM     pg_stat_activity 
WHERE    query <> '<IDLE>' 
AND      query NOT ilike '%pg_stat_activity%' 
ORDER BY query_start DESC;
