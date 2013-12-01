-- defines client 7 as the Melbourne hourly DNI averages over 23+ years
-- based on BOM analysis table
-- assumption: single location (single pixel ref in bom_dni)
-- issue: not energy (kWh) but instant observation (DNI), hence the sums using half-hour don't work in the UI
insert into consumption (client_id,day,prd,kwh)
select 7,day_num,period,coalesce(val,0) as kwh from
(
select to_date(a.local_date,'YYYYMMDD')-to_date('20100101','YYYYMMDD') as day_num,a.period,b.local_obs_hr_nb,b.val from
(
select * from (
select distinct '2013'||substr(local_date,5,4) as local_date from bom_dni group by substr(local_date,5,4),local_obs_hr_nb
) d, (select * from generate_series(1,48) period) t
) a LEFT OUTER JOIN (
select '2013'||substr(local_date,5,4) as local_date,local_obs_hr_nb,avg(val) as val
from bom_dni group by substr(local_date,5,4),local_obs_hr_nb
) b
ON a.local_date = b.local_date and round((a.period-1)/2)=b.local_obs_hr_nb+3
order by a.local_date,a.period
) j;

