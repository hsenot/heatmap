-- query from staging to consumption (AGL)
insert into consumption (client_id,day,prd,kwh)
select 
{$v_client_id} as client_id,
(date '{$v_date_start}'-date '01/01/2010') + (t.id-(select min(id) from staging_agl1))/48+1 as day,
(case (time)
when '12:00:00 AM' then 1
when '12:30:00 AM' then 2 when '1:00:00 AM' then 3 when '1:30:00 AM' then 4 when '2:00:00 AM' then 5
when '2:30:00 AM' then 6 when '3:00:00 AM' then 7 when '3:30:00 AM' then 8 when '4:00:00 AM' then 9
when '4:30:00 AM' then 10 when '5:00:00 AM' then 11 when '5:30:00 AM' then 12 when '6:00:00 AM' then 13
when '6:30:00 AM' then 14 when '7:00:00 AM' then 15 when '7:30:00 AM' then 16 when '8:00:00 AM' then 17
when '8:30:00 AM' then 18 when '9:00:00 AM' then 19 when '9:30:00 AM' then 20 when '10:00:00 AM' then 21
when '10:30:00 AM' then 22 when '11:00:00 AM' then 23 when '11:30:00 AM' then 24 when '12:00:00 PM' then 25
when '12:30:00 PM' then 26 when '1:00:00 PM' then 27 when '1:30:00 PM' then 28 when '2:00:00 PM' then 29
when '2:30:00 PM' then 30 when '3:00:00 PM' then 31 when '3:30:00 PM' then 32 when '4:00:00 PM' then 33
when '4:30:00 PM' then 34 when '5:00:00 PM' then 35 when '5:30:00 PM' then 36 when '6:00:00 PM' then 37
when '6:30:00 PM' then 38 when '7:00:00 PM' then 39 when '7:30:00 PM' then 40 when '8:00:00 PM' then 41
when '8:30:00 PM' then 42 when '9:00:00 PM' then 43 when '9:30:00 PM' then 44 when '10:00:00 PM' then 45
when '10:30:00 PM' then 46 when '11:00:00 PM' then 47 when '11:30:00 PM' then 48 
else 999
end) as prd,
kwh::numeric as kwh
from
(
select 
id,
substring(startdate,position(' ' in startdate)+1,length(startdate)) as time,
profilereadvalue as kwh
from staging_agl1
) t;
