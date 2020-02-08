## Time is a Tyrant

In this chapter we will discuss time-related functions.

#### Show the first and last day of the current month

[embedmd]:# (sql/first-and-last-day-of-current-month.sql)
```sql
SELECT (date_trunc('month', CURRENT_DATE))::date AS first_day_curr_month,

       (date_trunc('month', CURRENT_DATE) + interval '1 month' - interval '1 day')::date AS last_day_curr_month;
```

#### Show the first and last day of the current year

[embedmd]:# (sql/first-and-last-day-of-current-year.sql)
```sql
SELECT (date_trunc('year', CURRENT_DATE))::date AS first_day_curr_year,

       (date_trunc('year', CURRENT_DATE) + interval '1 year' - interval '1 day')::date AS last_day_curr_year;
```

#### Calculate the calendar date of Easter, from 1583 to 2999

[embedmd]:# (sql/easter.sql)
```sql
WITH t0 AS

        (SELECT generate_series(1583, 2999) AS YEAR
       ),

       t1 AS

        (SELECT YEAR,

               CASE
              WHEN YEAR < 1700 THEN 22

                    WHEN YEAR < 1900 THEN 23

                    WHEN YEAR < 2200 THEN 24

                    ELSE 25

                     END AS m,

               CASE
              WHEN YEAR < 1700 THEN 2

                    WHEN YEAR < 1800 THEN 3

                    WHEN YEAR < 1900 THEN 4

                    WHEN YEAR < 2100 THEN 5

                    WHEN YEAR < 2200 THEN 6

                    ELSE 0

                     END AS n,

               mod(YEAR, 19) AS a,

               mod(YEAR, 4) AS b,

               mod(YEAR, 7) AS c

          FROM t0
       ),

       t2 AS

        (SELECT YEAR,

               m,

               n,

               a,

               b,

               c,

               mod(19 * a + m, 30) AS d

          FROM t1
       ),

       t3 AS

        (SELECT YEAR,

               m,

               n,

               a,

               b,

               c,

               d,

               mod(2 * b + 4 * c + 6 * d + n, 7) AS e

          FROM t2
       ),

       t4 AS

        (SELECT YEAR,

               m,

               n,

               a,

               b,

               c,

               d,

               e,

               22 + d + e AS DAY,

               3 AS
         MONTH

          FROM t3
       ),

       t5 AS

        (SELECT YEAR,

               m,

               n,

               a,

               b,

               c,

               d,

               e,

               CASE
              WHEN DAY > 31 THEN DAY - 31

                    ELSE DAY

                     END AS DAY,

               CASE
              WHEN DAY > 31 THEN MONTH + 1

                    ELSE MONTH

                     END AS
         MONTH

          FROM t4
       ),

       t6 AS

        (SELECT YEAR,

               CASE
              WHEN DAY = 26
                   AND MONTH = 4                                 THEN 19

                    WHEN DAY = 25
                   AND MONTH = 4
                   AND d = 28
                   AND e = 6
                   AND a > 10 THEN 18

                    ELSE DAY

                     END AS DAY,


         MONTH

          FROM t5
       ),

       t7 AS

        (SELECT YEAR,

               to_date(to_char(DAY, '00') || to_char(MONTH, '00') || to_char(YEAR, '0000'), 'DDMMYYYY') AS easter_sunday

          FROM t6
       )
SELECT YEAR AS YEAR,

       easter_sunday - 52 AS jeudi_gras,

       easter_sunday - 48 AS carnival_monday,

       easter_sunday - 47 AS mardi_gras,

       easter_sunday - 46 AS ash_wednesday,

       easter_sunday - 7 AS palm_sunday,

       easter_sunday - 3 AS maundy_thursday,

       easter_sunday - 2 AS good_friday,

       easter_sunday - 1 AS holy_saturday,

       easter_sunday AS easter_sunday,

       easter_sunday + 1 AS easter_monday,

       easter_sunday + 39 AS ascension_of_christ,

       easter_sunday + 49 AS whitsunday,

       easter_sunday + 50 AS whitmonday,

       easter_sunday + 60 AS corpus_christi

  FROM t7;
```


