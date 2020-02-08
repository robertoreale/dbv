## Numerical Recipes

In this chapter we will give examples of application of the database to numerical problems.

#### Calculate the sum of a geometric series

We show that the sum of a geometric series of ratio 1/2 converges to 2.

[embedmd]:# (sql/sum-of-geometric-series.sql)
```sql
SELECT sum(power(2, - n))

  FROM generate_series(0, 100) AS n;
```

#### Generate the Fibonacci sequence, recursively

The `NUMERIC` type is mandatory when doing arbitrary-precision math.

[embedmd]:# (sql/recursive-fibonacci.sql)
```sql
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
```


