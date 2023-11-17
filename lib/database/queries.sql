--- select sum of quantity from items movement table and show the names of items from items table
select i.item_code, sum(quantity),item_name from items_movement as i left join items
on i.item_code=items.item_code
  where farm_id=1 and amber_id=1
group by(i.item_code,items.item_name)