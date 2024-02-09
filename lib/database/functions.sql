----------Function to calculate inventory quantity
create or replace function calculate_inventory_quantity() returns trigger language plpgsql  as $$
declare
in_feed numeric :=New.incom_feed;
out_feed numeric:=New.intak_feed;
prod_carton int :=New."prodCarton";
prod_tray int :=New."prodTray";
--out_carton int :=New."outCarton";
--out_tray int :=New."outTray";
no_death int :=New.death;

feed_amount numeric :=quantity from al_watania.inventory where (farm_id=New.farm_id and amber_id =New.amber_id) and item_code='001-002';
egg_carton_amount int :=quantity from al_watania.inventory where (farm_id=New.farm_id and amber_id =New.amber_id) and item_code='001-003';
egg_try_amount int :=small_quantity from al_watania.inventory where (farm_id=New.farm_id and amber_id =New.amber_id) and item_code='001-003';
no_of_hens int := quantity from al_watania.inventory where (farm_id=New.farm_id and amber_id =New.amber_id) and item_code='001-001';
bags int:=quantity from al_watania.inventory where (farm_id=New.farm_id and amber_id =New.amber_id) and item_code='001-007';
no_of_tray int:=quantity from al_watania.inventory where (farm_id=New.farm_id and amber_id =New.amber_id) and item_code='001-006';
no_of_carton int:=quantity from al_watania.inventory where (farm_id=New.farm_id and amber_id =New.amber_id) and item_code='001-005';

nums int[]=ARRAY[]::int[]; --:=select calculate_eggs(prod_tray,prod_carton);
begin
no_of_hens :=no_of_hens-no_death;
feed_amount :=feed_amount + in_feed - out_feed;
egg_carton_amount :=egg_carton_amount+prod_carton;
egg_try_amount := egg_try_amount+prod_tray;
no_of_tray :=no_of_tray-((prod_carton *14)+prod_tray);
no_of_carton :=no_of_carton-prod_carton;

nums :=array(select al_watania.calculate_egg(egg_try_amount,egg_carton_amount));
egg_carton_amount := elem from 
   unnest (nums)
             with ordinality as a(elem,idx)
         where idx = 2;
egg_try_amount :=elem from 
   unnest (nums)
             with ordinality as a(elem,idx)
         where idx = 1;

update al_watania.inventory set quantity = no_of_hens,updated_at=current_timestamp where (farm_id=New.farm_id and amber_id =New.amber_id) and item_code='001-001';
update al_watania.inventory set quantity = feed_amount,updated_at=current_timestamp where (farm_id=New.farm_id and amber_id =New.amber_id) and item_code='001-002'; 
update al_watania.inventory set quantity = egg_carton_amount,small_quantity=egg_try_amount,updated_at=current_timestamp where (farm_id=New.farm_id and amber_id =New.amber_id) and item_code='001-003';
update al_watania.inventory set quantity = bags+out_feed::INT,updated_at=current_timestamp where (farm_id=New.farm_id and amber_id =New.amber_id) and item_code='001-007';
update al_watania.inventory set quantity = no_of_tray::INT,updated_at=current_timestamp where (farm_id=New.farm_id and amber_id =New.amber_id) and item_code='001-006';
update al_watania.inventory set quantity = no_of_carton::INT,updated_at=current_timestamp where (farm_id=New.farm_id and amber_id =New.amber_id) and item_code='001-005';
return new;
end;    
$$;








-----------FUNCTION TO GET THE OUT ITEMS FROM FARM IN MONTH-------
------------------ARGS f_id int ,rep_date date,it_code varchar--------
----------------- return table (mov_date  date,code  varchar,amount numeric,description  text)--
  create or replace function get_outitems_monthly_by_farm(f_id int,rep_date date,it_code varchar)  
returns table (movement_date  date,item_code  varchar,quantity numeric,notes  text)
 language plpgsql 
as $body$

begin
return query
    WITH out_details AS (
    SELECT
      em.item_code,
        em.movement_date,
        TRIM(em.notes) AS name_of,
        SUM(em.quantity) AS summation
    FROM items_movement as em
    WHERE EXTRACT(MONTH FROM em.movement_date) = EXTRACT(MONTH FROM rep_date)
    and EXTRACT(YEAR FROM em.movement_date) = EXTRACT(YEAR FROM rep_date) and em.item_code=it_code
   
    GROUP BY em.movement_date, TRIM(em.notes),em.item_code
),
from_movement AS (
    SELECT p.farm_id, p.movement_date
    FROM items_movement as p
    WHERE EXTRACT(MONTH FROM p.movement_date) = EXTRACT(MONTH FROM rep_date)
    and    EXTRACT(YEAR FROM p.movement_date) = EXTRACT(Year FROM rep_date)
)
SELECT distinct
    p.movement_date,
    em.item_code,
    em.summation,
    em.name_of
FROM from_movement AS p
LEFT JOIN out_details AS em ON p.movement_date = em.movement_date
WHERE p.farm_id = f_id
    AND EXTRACT(MONTH FROM p.movement_date) = EXTRACT(MONTH FROM rep_date)
    AND EXTRACT(Year FROM p.movement_date) = EXTRACT(YEAR FROM rep_date) and em.item_code=it_code
order by p.movement_date asc;

end;
$body$
;
---------------FUNCTION TO GET THE OUT ITEMS FROM AMBER IN month--------
-------------- ARGS   f_id ,amber_id int ,rep_date ,item_code varchar------
------------ return setof record ----------
create or replace function get_outitems_monthly_by_amber(f_id int,amb_id int,rep_date date,it_code varchar) 
 returns setof items_movement
 language plpgsql
as $body$

begin
return query
select *  from items_movement where item_code=it_code and amber_id=amb_id 
and farm_id=f_id  AND EXTRACT(MONTH FROM movement_date) = EXTRACT(MONTH FROM rep_date)
order by movement_date asc;

end;
$body$
;

-----------------------------------------------





---------FUNCTION TO GET THE MONTHLY REPORT OF AMBER----------
-------args f_id int , into_date mean which date you want to get the remain egg to-----
--------- HOW TO USE select * from get_amber_monthly_report (2, 1, '2023-12-20'::date)------
---------- rETURN SET OF amber_daily_report2 -------------

create or replace function get_amber_monthly_report(f_id int,amb_id int,into_date date) returns setof amber_daily_report2 language plpgsql
as $func$
declare
today_report amber_daily_report2;

begin
for today_report in
 WITH egg_movement AS (
    SELECT
        item_code,
        farm_id,
        amber_id,
        SUM(CASE WHEN item_code = '001-003' THEN quantity ELSE 0 END) AS "outCarton",
        SUM(CASE WHEN item_code = '001-004' THEN quantity ELSE 0 END) AS "outtry",
        SUM(CASE WHEN item_code = '001-002' THEN quantity ELSE 0 END) AS "out_feed",
        STRING_AGG(quantity || '-' || notes, ',') AS notes,
        movement_date
    FROM items_movement
    WHERE amber_id = amb_id
        AND farm_id = f_id
        AND EXTRACT(MONTH FROM movement_date) = EXTRACT(MONTH FROM into_date)
    GROUP BY (item_code, movement_date, amber_id, farm_id)
),

production_data AS (
    SELECT
        farm_id,
        amber_id,
        "prodDate",
        COALESCE(death, 0) AS death,
        COALESCE(incom_feed, 0) AS incom_feed,
        COALESCE(intak_feed, 0) AS intak_feed,
        COALESCE("prodTray", 0) AS "prod_tray",
        COALESCE("prodCarton", 0) AS "prod_carton"
    FROM production
    WHERE farm_id = f_id
        AND amber_id = amb_id
        AND EXTRACT(MONTH FROM "prodDate") = EXTRACT(MONTH FROM into_date)
        AND EXTRACT(year FROM "prodDate") = EXTRACT(year FROM into_date)
)
 select
    COALESCE(em.movement_date, p."prodDate") AS in_date,
    COALESCE(p.death,0),
    COALESCE(p.incom_feed,0),
    COALESCE(p.intak_feed,0) + COALESCE(em.out_feed, 0) AS out_feed,
    COALESCE(
        (SELECT * FROM get_remaining_feed(f_id::INT, amb_id::INT, em.movement_date)),
        (SELECT * FROM get_remaining_feed(f_id::INT, amb_id::INT, p."prodDate"))
    ) AS remin_feed,
    COALESCE(p.prod_tray,0),
    COALESCE(p.prod_carton,0),
    COALESCE(em.outtry, 0) AS out_tray,
    COALESCE(em."outCarton", 0) AS out_carton,
    COALESCE(em.notes,'لايوجد'),
    (
        SELECT calculate_inventory_report(f_id::INT, amb_id::INT, COALESCE(em.movement_date, p."prodDate"))
    ) AS remin_egg
FROM egg_movement AS em
FULL JOIN production_data AS p ON em.movement_date = p."prodDate"
and  (p.amber_id=amb_id
    AND  p.farm_id=f_id)
      and (EXTRACT(month from p."prodDate") = extract(month from into_date)
  and EXTRACT(year from p."prodDate") = extract(year from into_date))
  order by in_date 
  loop
       return next today_report;
  end loop;
  --end if;
end
$func$
;

-----------------------FUNCTION TO GET REMAIN EGG BY FARM-----------
-------------------args f_id int , into_date mean which date you want to get the remain egg to
-------------------------how to use// select * from get_remain_egg_by_farm(2,'2023-10-12')-----
------------------------return int[]-------------------

create or replace function get_remain_egg_by_farm(f_id int,into_date date) returns int[] language plpgsql
as $body$
declare
egg_arr int[];
begin

WITH egg_from_items_movs(outtray,outcarton) AS (
    SELECT
        SUM(CASE WHEN i.item_code = '001-004' THEN i.quantity ELSE 0 END) AS outtray,
        SUM(CASE WHEN i.item_code = '001-003' THEN i.quantity ELSE 0 END) AS outcarton
    FROM items_movement AS i
    WHERE
        i.type_movement = 'خارج'
        AND i.movement_date <= into_date
        AND farm_id = f_id
    GROUP BY i.farm_id
), tray_carton AS (
    SELECT
        coalesce(SUM("prodCarton"), 0) - coalesce(SUM("outCarton"), 0) AS remCarton,
        coalesce(SUM("prodTray"), 0) - coalesce(SUM("outTray"), 0) AS remTray
    FROM production
    WHERE
        production."prodDate" <= into_date AND
        farm_id = f_id
),real_amount as(

SELECT
   coalesce( tray_carton.remTray,0)-(SELECT
   coalesce((select coalesce(outtray,0) as tray from egg_from_items_movs),0)) AS totalTray,
  coalesce( tray_carton.remCarton,0)-(SELECT
   coalesce((select coalesce(outcarton,0) as carton from egg_from_items_movs),0)) AS totalCarton
FROM tray_carton
)
 
  select 
  calculate_egg 
    (
      (select totalTray from real_amount)::INT,
       (select totalCarton from real_amount)::INT
  )into  egg_arr;
 return egg_arr;
end
$body$
/////////////
----------------------



-----------------Function to get the month report by farm-----------
---------------------args f_id int means farm_id and rep_date date means month of report---
-----------------select * from get_farm_month_report(1,'2023-11-20')------------
-------------retutn type of month report---------------
create or replace function get_farm_month_report(f_id int,rep_date date) returns setof month_report  language plpgsql
as $func$
declare
farm_month_rep month_report;
begin

 for farm_month_rep in select
  p."prodDate",
  sum(p.death) as death,
  sum(incom_feed) as incomFeed,
  sum(intak_feed) as intakFeed
  ,
  (
    select
      *
    from
      get_remaining_feed (farm_id::INT, 0::INT, "prodDate")
  ) as reminFeed,
 ( select * from calculate_egg(sum("prodTray")::INT, sum("prodCarton")::INT) )as prodEggs,
  --sum("prodCarton") as prodcarton,
  --sum("prodTray") as prodtray,
  (select *from calculate_egg((
    sum("outTray") + coalesce(
    (
      select
       sum( quantity)
      from
        items_movement
      where
        item_code = '001-004'
        and farm_id = p.farm_id
        and movement_date = p."prodDate"
    ),
    0
  ))::INT,
    (sum("outCarton") + coalesce(
    (
      select
        sum(quantity)
      from
        items_movement
      where
        item_code = '001-003'
        and farm_id = p.farm_id
        and movement_date = p."prodDate"
    ),
    0
  ))::INT))as outEgg,

 (select * from get_remain_egg_by_farm(p.farm_id::INT,p."prodDate"::Date)) as remainegg

from
  production as p
where
  p.farm_id = f_id
  and extract(
    month
    from
      p."prodDate"
  ) = extract(
    month
    from
     rep_date
  )
group by
  (p.farm_id, p."prodDate")
order by
  p."prodDate" asc
  loop
  return next farm_month_rep;
  end loop;
end;
$func$
////////////////////////







--select remCarton,remTray from tray_carton;

select calculate_egg(( select remTray::INT from tray_carton ),(select remCarton::INT from tray_carton));



------ after merge up select


////////////////////
----------- function to get remaining eggs in farm --------
---------- argument f_id int mean farm_id, into_date mean calculate the remaining egg into this date-------
--------- return array of int first tray second carton-------
create or replace function get_remain_egg_by_farm(f_id int,into_date date) returns int[] language plpgsql
as $body$
declare
egg_arr int[];
begin

WITH egg_from_items_movs(outtray,outcarton) AS (
    SELECT
        SUM(CASE WHEN i.item_code = '001-004' THEN i.quantity ELSE 0 END) AS outtray,
        SUM(CASE WHEN i.item_code = '001-003' THEN i.quantity ELSE 0 END) AS outcarton
    FROM items_movement AS i
    WHERE
        i.type_movement = 'خارج'
        AND i.movement_date <= into_date
        AND farm_id = f_id
    GROUP BY i.farm_id
), tray_carton AS (
    SELECT
        coalesce(SUM("prodCarton"), 0) - coalesce(SUM("outCarton"), 0) AS remCarton,
        coalesce(SUM("prodTray"), 0) - coalesce(SUM("outTray"), 0) AS remTray
    FROM production
    WHERE
        production."prodDate" <= into_date AND
        farm_id = f_id
),real_amount as(

SELECT
   coalesce( tray_carton.remTray,0)-(SELECT
   coalesce((select coalesce(outtray,0) as tray from egg_from_items_movs),0)) AS totalTray,
  coalesce( tray_carton.remCarton,0)-(SELECT
   coalesce((select coalesce(outcarton,0) as carton from egg_from_items_movs),0)) AS totalCarton
FROM tray_carton
)
 
  select 
  calculate_egg 
    (
      (select totalTray from real_amount)::INT,
       (select totalCarton from real_amount)::INT
  )into  egg_arr;
 return egg_arr;
end
$body$
////////////////

/////////////////////////////////////
----------Function to get the remaining eggs in carton and tray ----
---------argument farmId int,amberId int ,toDate timeStampe-----
------retutn array of remaining carton and tray to specific date selected in argument-----
------example of using function {select calculate_inventory_report(1,1,'2023-11-07');} ---

create or replace function calculate_inventory_report(farmId int,amberId int,toDate timestamp) returns INT[]  language plpgsql as
$body$
declare
egg_arr int[];


begin

--get trays and carton from items_movement
with
  egg_from_items_movs (outTray, outCarton) as (
    select coalesce(
      (
        select
          coalesce(sum(quantity),0)
        from
          items_movement
        where
          item_code = '001-004'
          and type_movement = 'خارج'
          and movement_date <=toDate
         -- and amber_id = i.amber_id
          and farm_id = i.farm_id
      ),0) as tray,
      coalesce(sum(quantity),0) as carton
    from
      items_movement as i
    where
      item_code = '001-003'
      and type_movement = 'خارج'
        and movement_date <=toDate
      --and amber_id = 3
      and farm_id = farmId
    -- group by
    --   ( i.farm_id)
  ),
  tray_carton (remCarton, remTray) as (
    select
      coalesce(sum("prodCarton"),0) - coalesce(sum("outCarton"),0) as carton,
      coalesce(sum("prodTray"),0) -coalesce(sum("outTray"),0) as tray
    from
      production
    where
      --amber_id = 3
      "prodDate" <=toDate and
       farm_id = farmId
  )
  select
  calculate_egg (
    (
      select coalesce(
        (
          (
            select
             coalesce(remTray,0)
            from
              tray_carton
          ) - (
            select
             coalesce(outTray,0)
            from
              egg_from_items_movs
          )
        ),0) as remainEgg
    )::INT,
    (
      select coalesce(
        (
          (
            select
             coalesce(remCarton,0)
            from
              tray_carton
          ) - (
            select
             coalesce(outCarton,0)
            from
              egg_from_items_movs
          )
        ),0) as remainCar
    )::INT
  ) into  egg_arr;
 return egg_arr;
 end;
 $body$
;



------------------ function to get the remaining_feed in amber----
------------- argument farm_id , amber_id ,toDate -----------
------ if ambid in argument is 0 then return remaining in the farm----
--------------retutn numeric value remain_feed--------
------------how to use  select * from get_remaining_feed(1,1,'2023-11-11)-----
create or replace function get_remaining_feed(fid int,ambid int,toDate timestamp) returns numeric language plpgsql
as $body$
declare
remain_feed numeric;
begin
--remain_feed :=
if(ambid>0) then
select
 coalesce(sum(incom_feed),0) - coalesce(sum(intak_feed),0) - (
    select
     coalesce(sum(quantity),0)
    from
      items_movement
    where
      item_code = '001-002'
      and type_movement = 'خارج'
      and movement_date <=toDate
      and amber_id = pro.amber_id
      and farm_id = pro.farm_id
  ) as remainFeed
from
  production as pro
where
  pro."prodDate" <=toDate
  and pro.farm_id = fid
  and pro.amber_id = ambid
group by
  (pro.amber_id, pro.farm_id) into remain_feed;
else
select
 coalesce(sum(incom_feed),0) - coalesce(sum(intak_feed),0) - (
    select
     coalesce(sum(quantity),0)
    from
      items_movement
    where
      item_code = '001-002'
      and type_movement = 'خارج'
      and movement_date <=toDate
      --and amber_id = pro.amber_id
      and farm_id = pro.farm_id
  ) as remainFeed
from
  production as pro
where
  pro."prodDate" <=toDate
  and pro.farm_id = fid
  --and pro.amber_id = ambid
group by
  ( pro.farm_id) into remain_feed;
  end if;
  
return remain_feed;

end;
$body$


--------------------- FUNCTION FOR GET DAILY REPORT BY AMBER AND DATE--------
----------------- argument f_id mean farm_id and amb_id mean amber_id and toDate mean date of report
-----------------how to use select * from get_daily_report(2,1,'2023-11-11')     ----------------------

create or replace function get_daily_report(f_id int,amb_id int,repDate date) returns setof amber_daily_report language plpgsql
as $func$
declare
today_report amber_daily_report;
--reportDate date := TO_DATE(repDate,'YYYYMMDD');
begin
if amb_id>0 then
  for today_report in select
  amber_id,
  death,
  incom_feed,
  intak_feed,
  (
    select * from
      get_remaining_feed(f_id::INT, amb_id::INT, "prodDate")
  )::numeric as remain_feed,
  "prodCarton",
  "prodTray",
  "outCarton"+coalesce((select quantity from items_movement where item_code='001-003' and amber_id=p.amber_id and farm_id=p.farm_id and movement_date=p."prodDate"),0),
  "outTray" + coalesce((select quantity from items_movement where item_code='001-004' and amber_id=p.amber_id and farm_id=p.farm_id and movement_date=p."prodDate"),0),
  "outEggsNote",
  (
    select 
      calculate_inventory_report(f_id::INT, amb_id::INT, "prodDate")
  ) as reminEgg
from
  production as p
where
  p.farm_id = f_id
  and p.amber_id = amb_id
  and p."prodDate" = repDate
  limit 1
  loop

       return next today_report;
  
  end loop;
  --return all ambers report
 else
 for today_report in select
  amber_id,
  death,
  incom_feed,
  intak_feed,
  (
    select * from
      get_remaining_feed(f_id::INT, p.amber_id::INT, "prodDate")
  )::numeric as remain_feed,
  "prodCarton",
  "prodTray",
  "outCarton"+coalesce((select quantity from items_movement where item_code='001-003' and amber_id=p.amber_id and farm_id=p.farm_id and movement_date=p."prodDate"),0),
  "outTray" + coalesce((select quantity from items_movement where item_code='001-004' and amber_id=p.amber_id and farm_id=p.farm_id and movement_date=p."prodDate"),0),
  "outEggsNote",
  (
    select 
      calculate_inventory_report(f_id::INT, p.amber_id::INT, "prodDate")
  ) as reminEgg
from
  production as p
where
  p.farm_id = f_id
  --and p.amber_id = amb_id
  and p."prodDate" = repDate
  --limit 1
  loop

       return next today_report;
  
  end loop;
  end if;



end
$func$
;

------------------------------------------