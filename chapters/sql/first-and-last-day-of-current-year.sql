SELECT (date_trunc('year', CURRENT_DATE))::date AS first_day_curr_year,

       (date_trunc('year', CURRENT_DATE) + interval '1 year' - interval '1 day')::date AS last_day_curr_year;
