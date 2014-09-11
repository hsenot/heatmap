-- query from staging to consumption (EnergyAustralia)
insert into consumption (client_id,day,prd,kwh)
select 
{$v_client_id} as client_id,
(date '{$v_date_start}'-date '01/01/2010') + (t.id-(select min(id) from staging_ea))/48+1 as day,
(case (time)
when '00:00' then 1
when '00:30' then 2 when '01:00' then 3 when '01:30' then 4 when '02:00' then 5
when '02:30' then 6 when '03:00' then 7 when '03:30' then 8 when '04:00' then 9
when '04:30' then 10 when '05:00' then 11 when '05:30' then 12 when '06:00' then 13
when '06:30' then 14 when '07:00' then 15 when '07:30' then 16 when '08:00' then 17
when '08:30' then 18 when '09:00' then 19 when '09:30' then 20 when '10:00' then 21
when '10:30' then 22 when '11:00' then 23 when '11:30' then 24 when '12:00' then 25
when '12:30' then 26 when '13:00' then 27 when '13:30' then 28 when '14:00' then 29
when '14:30' then 30 when '15:00' then 31 when '15:30' then 32 when '16:00' then 33
when '16:30' then 34 when '17:00' then 35 when '17:30' then 36 when '18:00' then 37
when '18:30' then 38 when '19:00' then 39 when '19:30' then 40 when '20:00' then 41
when '20:30' then 42 when '21:00' then 43 when '21:30' then 44 when '22:00' then 45
when '22:30' then 46 when '23:00' then 47 when '23:30' then 48 
else 999
end) as prd,
kwh::numeric as kwh
from
(
select 
id,
start_time as time,
usage as kwh
from staging_ea
) t;
