SELECT sum(power(2, - n))

  FROM generate_series(0, 100) AS n;
