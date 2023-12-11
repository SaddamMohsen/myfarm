create type month_report as(
  prod_date date,
  death int,
  income_feed numeric,
  intak_feed numeric,
  remain_feed numeric,
  prod_egg int[],
  out_egg int[],
  remain_egg int[]
);

--AMBER DAILY REPORT BY MONTH---
create type amber_daily_report2 as(
  prod_date date,
  death int,
  income_feed numeric,
  intak_feed numeric,
  remain_feed numeric,
  prod_tray int,
  prod_carton int,
  out_tray int,
  out_carton int,
  out_note text,
  remain_egg int[]
);