WITH relation AS

        (SELECT nspname || '.' || relname AS "relname",

               trunc(log(1024, pg_relation_size(c.oid))) AS "order_of_magnitude"

          FROM pg_class c

          LEFT JOIN pg_namespace n
            ON (n.oid = c.relnamespace)

         WHERE nspname NOT IN ('pg_catalog',
                         'information_schema')

           AND pg_relation_size(c.oid) <> 0
       )
SELECT CASE
           WHEN order_of_magnitude = 0 THEN 'bytes'

            WHEN order_of_magnitude = 1 THEN 'KiB'

            WHEN order_of_magnitude = 2 THEN 'MiB'

            WHEN order_of_magnitude = 3 THEN 'GiB'

            WHEN order_of_magnitude = 4 THEN 'TiB'

            WHEN order_of_magnitude = 5 THEN 'PiB'

            WHEN order_of_magnitude = 6 THEN 'EiB'

            WHEN order_of_magnitude = 7 THEN 'ZiB'

            WHEN order_of_magnitude = 8 THEN 'YiB'

            ELSE 'UNKNOWN'

             END AS "order_of_magnitude",

       count(*) COUNT

  FROM relation

 GROUP BY order_of_magnitude

 ORDER BY order_of_magnitude;
