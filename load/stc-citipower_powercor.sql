-- query from staging to consumption (Citpower/Powercor)
insert into consumption (client_id,day,prd,kwh)
select 
{$v_client_id} as client_id,
(date '{$v_date_start}'-date '01/01/2010') + (t.id-(select min(id) from staging_citipower_powercor))/48+1 as day,
(case (time)
	when '0:30' then 1
	when '1:00' then 2 when '1:30' then 3 when '2:00' then 4 when '2:30' then 5
	when '3:00' then 6 when '3:30' then 7 when '4:00' then 8 when '4:30' then 9
	when '5:00' then 10 when '5:30' then 11 when '6:00' then 12 when '6:30' then 13
	when '7:00' then 14 when '7:30' then 15 when '8:00' then 16 when '8:30' then 17
	when '9:00' then 18 when '9:30' then 19 when '10:00' then 20 when '10:30' then 21
	when '11:00' then 22 when '11:30' then 23 when '12:00' then 24 when '12:30' then 25
	when '13:00' then 26 when '13:30' then 27 when '14:00' then 28 when '14:30' then 29
	when '15:00' then 30 when '15:30' then 31 when '16:00' then 32 when '16:30' then 33
	when '17:00' then 34 when '17:30' then 35 when '18:00' then 36 when '18:30' then 37
	when '19:00' then 38 when '19:30' then 39 when '20:00' then 40 when '20:30' then 41
	when '21:00' then 42 when '21:30' then 43 when '22:00' then 44 when '22:30' then 45
	when '23:00' then 46 when '23:30' then 47 when '0:00' then 48
	else 999
end) as prd,
kwh::numeric as kwh
from
(
select 
id,
end_time as time,
kwh
from staging_citipower_powercor
) t;
