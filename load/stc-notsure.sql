-- query from staging to consumption (AGL)
insert into consumption (client_id,day,prd,kwh)
select 
{$v_client_id} as client_id,
(date '{$v_date_start}'-date '01/01/2010') + (t.id-(select min(id) from staging_notsure))/48+1 as day,
(case time
	when '00:30:00' then 1
	when '01:00:00' then 2 when '01:30:00' then 3 when '02:00:00' then 4 when '02:30:00' then 5
	when '03:00:00' then 6 when '03:30:00' then 7 when '04:00:00' then 8 when '04:30:00' then 9
	when '05:00:00' then 10 when '05:30:00' then 11 when '06:00:00' then 12 when '06:30:00' then 13
	when '07:00:00' then 14 when '07:30:00' then 15 when '08:00:00' then 16 when '08:30:00' then 17
	when '09:00:00' then 18 when '09:30:00' then 19 when '10:00:00' then 20 when '10:30:00' then 21
	when '11:00:00' then 22 when '11:30:00' then 23 when '12:00:00' then 24 when '12:30:00' then 25
	when '13:00:00' then 26 when '13:30:00' then 27 when '14:00:00' then 28 when '14:30:00' then 29
	when '15:00:00' then 30 when '15:30:00' then 31 when '16:00:00' then 32 when '16:30:00' then 33
	when '17:00:00' then 34 when '17:30:00' then 35 when '18:00:00' then 36 when '18:30:00' then 37
	when '19:00:00' then 38 when '19:30:00' then 39 when '20:00:00' then 40 when '20:30:00' then 41
	when '21:00:00' then 42 when '21:30:00' then 43 when '22:00:00' then 44 when '22:30:00' then 45
	when '23:00:00' then 46 when '23:30:00' then 47 when '00:00:00' then 48
	else 999
end) as prd,
kwh::numeric as kwh
from
(
select 
id,
case
 when (length(endtime) <= 10) then '00:00:00'
 else
 (
	case length(split_part(endtime,' ',2))
	when 4 then '0'||substr(split_part(endtime,' ',2),0,5)||':00'
	when 5 then substr(split_part(endtime,' ',2),0,6)||':00'
	end
 )
end as time,
kwh as kwh
from staging_notsure
) t;
