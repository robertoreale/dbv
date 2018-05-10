SELECT datname, 
       Pg_size_pretty(Pg_database_size(datname)) 
FROM   pg_database 
ORDER  BY Pg_database_size(datname) DESC;
