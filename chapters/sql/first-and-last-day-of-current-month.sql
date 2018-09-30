SELECT (date_trunc('month', CURRENT_DATE))::date AS first_day_curr_month,

       (date_trunc('month', CURRENT_DATE) + interval '1 month' - interval '1 day')::date AS last_day_curr_month;
