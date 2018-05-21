SELECT sum(idx_blks_read) AS idx_read,

       sum(idx_blks_hit) AS idx_hit,

       (sum(idx_blks_hit) - sum(idx_blks_read)) / sum(idx_blks_hit) AS ratio

  FROM pg_statio_user_indexes;
