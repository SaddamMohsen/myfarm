
----query to update inventory from function
UPDATE inventory
SET quantity = r.result[2],
 small_quantity = r.result[1]
FROM (
   SELECT calculate_inventory_report(2, 2, '2023-12-10') AS result
) AS r
 where farm_id=2 and amber_id=2 and item_code='001-003' 


--- select sum of quantity from items movement table and show the names of items from items table
select i.item_code, sum(quantity),item_name from items_movement as i left join items
on i.item_code=items.item_code
  where farm_id=1 and amber_id=1
group by(i.item_code,items.item_name)


---- query to get the monthly report by farm 
select
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
  ))::INT))as outEggs,

 (select * from get_remain_egg_by_farm(p.farm_id::INT,p."prodDate"::Date)) as remainegg

from
  production as p
where
  p.farm_id = 1
  and extract(
    month
    from
      p."prodDate"
  ) = 11
group by
  (p.farm_id, p."prodDate")
order by
  p."prodDate" asc




----------select ramining carton and tray the calculate cartons and tray---
with tray_carton(remCarton,remTray) as
(
select sum("prodCarton")-sum("outCarton") as carton ,sum("prodTray")-sum("outTray") as tray from production where amber_id=1 and farm_id=1
)

---------select out tray and cartons from items_movement table---
--get trays and carton from items_movement
with egg_from_items_movs(outTray,outCarton) as
(
    select (select sum(quantity) from items_movement where item_code='001-004' and type_movement='خارج' and amber_id=i.amber_id and farm_id=i.farm_id  ) as tray, sum(quantity) as carton from items_movement as i  where item_code='001-003' and type_movement='خارج' and amber_id=1 and farm_id=1
    group by(i.amber_id,i.farm_id)
)



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