## String Manipulation

#### Count the client sessions with a FQDN

The table `pg_stat_activity` lists the current sessions and outputs information about the connected sessions.

Assume a FQDN has the form `N_1.N_2.....N_t`, where `t > 1` and each `N_i` can contain lowercase letters, numbers and the dash.
 
[embedmd]:# (sql/count-fqdn-client-hostnames.sql)

#### Calculate the edit (or Levenshtein) distance between a table name and the names of its dependent indexes

The `fuzzystrmatch` module must be installed.

[embedmd]:# (sql/levenshtein-table-indexes.sql)


<!-- vim: set fenc=utf-8 spell spl=en ts=4 sw=4 et filetype=markdown : -->
