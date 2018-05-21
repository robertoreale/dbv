WITH RECURSIVE fibonacci(f_n, f_n_prev) AS

        (SELECT 1,

               0

         UNION SELECT 1 :: numeric,

               1 :: numeric

         UNION SELECT f_n + f_n_prev,

               f_n

          FROM fibonacci
       )
SELECT f_n AS nth_fibonacci_number

  FROM fibonacci

 LIMIT 100;
