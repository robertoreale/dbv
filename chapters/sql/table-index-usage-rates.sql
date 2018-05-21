SELECT relname AS relname,

       100 * idx_scan / (seq_scan + idx_scan) AS percent_of_times_index_used,

       n_live_tup AS rows_in_table

  FROM pg_stat_user_tables

 ORDER BY n_live_tup DESC;
