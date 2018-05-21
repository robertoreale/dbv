SELECT count(*)

  FROM pg_stat_activity

 WHERE client_hostname SIMILAR TO '([[:alnum:]]+\.)+[[:alnum:]-]+';
