-- staging 2 to consumption (Origin)
insert into consumption (client_id,day,prd,kwh)
select
{$v_client_id} as client_id,
((case when (length(dt)=7) then to_date('0'||dt,'DD/MM/YY') when (length(dt)=8) then to_date(dt,'DD/MM/YY') when (length(dt)=9) then to_date('0'||dt,'DD/MM/YYYY') when (length(dt)=10) then to_date(dt,'DD/MM/YYYY') else to_date(dt,'DD/Mon/YYYY') end)-date '01/01/2010')+1 as day,
p as prd,
k as kwh
from
(
select date as dt,p1 as k,1 as p from staging_origin2 union
select date,p2,2 from staging_origin2 union
select date,p3,3 from staging_origin2 union
select date,p4,4 from staging_origin2 union
select date,p5,5 from staging_origin2 union
select date,p6,6 from staging_origin2 union
select date,p7,7 from staging_origin2 union
select date,p8,8 from staging_origin2 union
select date,p9,9 from staging_origin2 union
select date,p10,10 from staging_origin2 union
select date,p11,11 from staging_origin2 union
select date,p12,12 from staging_origin2 union
select date,p13,13 from staging_origin2 union
select date,p14,14 from staging_origin2 union
select date,p15,15 from staging_origin2 union
select date,p16,16 from staging_origin2 union
select date,p17,17 from staging_origin2 union
select date,p18,18 from staging_origin2 union
select date,p19,19 from staging_origin2 union
select date,p20,20 from staging_origin2 union
select date,p21,21 from staging_origin2 union
select date,p22,22 from staging_origin2 union
select date,p23,23 from staging_origin2 union
select date,p24,24 from staging_origin2 union
select date,p25,25 from staging_origin2 union
select date,p26,26 from staging_origin2 union
select date,p27,27 from staging_origin2 union
select date,p28,28 from staging_origin2 union
select date,p29,29 from staging_origin2 union
select date,p30,30 from staging_origin2 union
select date,p31,31 from staging_origin2 union
select date,p32,32 from staging_origin2 union
select date,p33,33 from staging_origin2 union
select date,p34,34 from staging_origin2 union
select date,p35,35 from staging_origin2 union
select date,p36,36 from staging_origin2 union
select date,p37,37 from staging_origin2 union
select date,p38,38 from staging_origin2 union
select date,p39,39 from staging_origin2 union
select date,p40,40 from staging_origin2 union
select date,p41,41 from staging_origin2 union
select date,p42,42 from staging_origin2 union
select date,p43,43 from staging_origin2 union
select date,p44,44 from staging_origin2 union
select date,p45,45 from staging_origin2 union
select date,p46,46 from staging_origin2 union
select date,p47,47 from staging_origin2 union
select date,p48,48 from staging_origin2
) s order by day,prd
