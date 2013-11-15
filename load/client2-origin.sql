-- query from staging to consumption (Origin)
insert into consumption (client_id,day,prd,kwh)
select 
2 as client_id,
(date '27/06/2012'-date '01/01/2010') + (t.id-(select min(id) from staging_origin1))/48+1 as day,
(case (time)
when '12:30:00 AM' then 1 when '01:00:00 AM' then 2 when '01:30:00 AM' then 3 when '02:00:00 AM' then 4
when '02:30:00 AM' then 5 when '03:00:00 AM' then 6 when '03:30:00 AM' then 7 when '04:00:00 AM' then 8
when '04:30:00 AM' then 9 when '05:00:00 AM' then 10 when '05:30:00 AM' then 11 when '06:00:00 AM' then 12
when '06:30:00 AM' then 13 when '07:00:00 AM' then 14 when '07:30:00 AM' then 15 when '08:00:00 AM' then 16
when '08:30:00 AM' then 17 when '09:00:00 AM' then 18 when '09:30:00 AM' then 19 when '10:00:00 AM' then 20
when '10:30:00 AM' then 21 when '11:00:00 AM' then 22 when '11:30:00 AM' then 23 when '12:00:00 PM' then 24
when '12:30:00 PM' then 25 when '01:00:00 PM' then 26 when '01:30:00 PM' then 27 when '02:00:00 PM' then 28
when '02:30:00 PM' then 29 when '03:00:00 PM' then 30 when '03:30:00 PM' then 31 when '04:00:00 PM' then 32
when '04:30:00 PM' then 33 when '05:00:00 PM' then 34 when '05:30:00 PM' then 35 when '06:00:00 PM' then 36
when '06:30:00 PM' then 37 when '07:00:00 PM' then 38 when '07:30:00 PM' then 39 when '08:00:00 PM' then 40
when '08:30:00 PM' then 41 when '09:00:00 PM' then 42 when '09:30:00 PM' then 43 when '10:00:00 PM' then 44
when '10:30:00 PM' then 45 when '11:00:00 PM' then 46 when '11:30:00 PM' then 47 when '12:00:00 AM' then 48
else 999
end) as prd,
kwh::numeric(8,2) as kwh
from
(
select 
id,
content,
substring(content,8,2) as date_month,
substring(content,5,2) as date_day,
substring(content,11,11) as time,
substring(content,position('M ' in content)+2,length(content)) as kwh
from staging_origin1
) t

