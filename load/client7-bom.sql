
-- based on BOM analysis table
-- assumption: single location (pixel ref, data up to 20130630)
-- issue: not energy (kWh) but instant observation (DNI), hence the sum using half-hour doesn't work
insert into consumption (client_id,day,prd,kwh)
select 7,day_num,period,coalesce(val,0) as kwh from
(
select to_date(a.local_date,'YYYYMMDD')-to_date('20100101','YYYYMMDD') as day_num,a.period,b.local_obs_hr_nb,b.val from
(
select * from (select distinct local_date from bom_dni where local_date>'20120630') d, (select * from generate_series(1,48) period) t
) a LEFT OUTER JOIN (select * from bom_dni where local_date>'20120630') b
ON a.local_date = b.local_date and round((a.period-1)/2)=b.local_obs_hr_nb+3
order by a.local_date,a.period
) j
