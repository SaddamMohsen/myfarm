
----------select ramining carton and tray the calculate cartons and tray---
with tray_carton(remCarton,remTray) as
(
select sum("prodCarton")-sum("outCarton") as carton ,sum("prodTray")-sum("outTray") as tray from production where amber_id=1 and farm_id=1
)

--select remCarton,remTray from tray_carton;

select calculate_egg(( select remTray::INT from tray_carton ),(select remCarton::INT from tray_carton));

---------select out tray and cartons from items_movement table---
--get trays and carton from items_movement
with egg_from_items_movs(outTray,outCarton) as
(
    select (select sum(quantity) from items_movement where item_code='001-004' and type_movement='خارج' and amber_id=i.amber_id and farm_id=i.farm_id  ) as tray, sum(quantity) as carton from items_movement as i  where item_code='001-003' and type_movement='خارج' and amber_id=1 and farm_id=1
    group by(i.amber_id,i.farm_id)
)

------ after merge up select
--get trays and carton from items_movement

--get trays and carton from items_movement
with
  egg_from_items_movs (outTray, outCarton) as (
    select
      (
        select
          sum(quantity)
        from
          items_movement
        where
          item_code = '001-004'
          and type_movement = 'خارج'
          and amber_id = i.amber_id
          and farm_id = i.farm_id
      ) as tray,
      sum(quantity) as carton
    from
      items_movement as i
    where
      item_code = '001-003'
      and type_movement = 'خارج'
      and amber_id = 2
      and farm_id = 1
    group by
      (i.amber_id, i.farm_id)
  ),
  tray_carton (remCarton, remTray) as (
    select
      sum("prodCarton") - sum("outCarton") as carton,
      sum("prodTray") - sum("outTray") as tray
    from
      production
    where
      amber_id = 2
      and farm_id = 1
  )
  

  --call calculate_egg function to get the result of remaining eggs 
select
  calculate_egg (
    (
      select
        (
          (
            select
              remTray
            from
              tray_carton
          ) - (
            select
              outTray
            from
              egg_from_items_movs
          )
        ) as remainEgg
    )::INT,
    (
      select
        (
          (
            select
              remCarton
            from
              tray_carton
          ) - (
            select
              outCarton
            from
              egg_from_items_movs
          )
        ) as remainCar
    )::INT
  );


/////////////////////////////////////
----------Function to get the remaining eggs in carton and tray ----
---------argument farmId int,amberId int ,toDate timeStampe-----
------retutn array of remaining carton and tray to specific date selected in argument-----
------example of using function {select calculate_inventory_report(1,1,'2023-11-07');} ---

create or replace function calculate_inventory_report(farmId int,amberId int,toDate timestamp) returns INT[]  language plpgsql as
$body$
declare
egg_arr int[];



--get trays and carton from items_movement
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
    group by
      ( i.farm_id)
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
--------------retutn numeric value remain_feed--------
------------how to use  select * from get_remaining_feed(1,1,'2023-11-11)-----
create or replace function get_remaining_feed(fid int,ambid int,toDate timestamp) returns numeric language plpgsql
as $body$
declare
remain_feed numeric;
begin
--remain_feed :=
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
return remain_feed;
end;
$body$


--------------------- FUNCTION FOR GET DAILY REPORT BY AMBER AND DATE--------
----------------- argument f_id mean farm_id and amb_id mean amber_id and toDate mean date of report
-----------------how to use select * from get_daily_report(2,1,'2023-11-11')     ----------------------
create or replace function get_daily_report(f_id int,amb_id int,toDate data) returns setof amber_daily_report language plpgsql
as $func$
declare
today_report amber_daily_report;
begin
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
  ) as remainEgg
from
  production as p
where
  p.farm_id = f_id
  and p.amber_id = amb_id
  and p."prodDate" = toDate
  limit 1
  loop

       return next today_report;
  
  end loop;

end;
$func$
------------------------------------------