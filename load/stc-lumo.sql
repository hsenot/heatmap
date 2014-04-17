-- staging 2 to consumption (Origin)
insert into consumption (client_id,day,prd,kwh)
select
{$v_client_id} as client_id,
(to_date(dt,'DD/Mon/YYYY')-date '01/01/2010')+1 as day,
p as prd,
k as kwh
from
(
select intervalreaddate as dt,p2 as k,1 as p from staging_lumo union
select intervalreaddate,p4,2 from staging_lumo union
select intervalreaddate,p6,3 from staging_lumo union
select intervalreaddate,p8,4 from staging_lumo union
select intervalreaddate,p10,5 from staging_lumo union
select intervalreaddate,p12,6 from staging_lumo union
select intervalreaddate,p14,7 from staging_lumo union
select intervalreaddate,p16,8 from staging_lumo union
select intervalreaddate,p18,9 from staging_lumo union
select intervalreaddate,p20,10 from staging_lumo union
select intervalreaddate,p22,11 from staging_lumo union
select intervalreaddate,p24,12 from staging_lumo union
select intervalreaddate,p26,13 from staging_lumo union
select intervalreaddate,p28,14 from staging_lumo union
select intervalreaddate,p30,15 from staging_lumo union
select intervalreaddate,p32,16 from staging_lumo union
select intervalreaddate,p34,17 from staging_lumo union
select intervalreaddate,p36,18 from staging_lumo union
select intervalreaddate,p38,19 from staging_lumo union
select intervalreaddate,p40,20 from staging_lumo union
select intervalreaddate,p42,21 from staging_lumo union
select intervalreaddate,p44,22 from staging_lumo union
select intervalreaddate,p46,23 from staging_lumo union
select intervalreaddate,p48,24 from staging_lumo union
select intervalreaddate,p50,25 from staging_lumo union
select intervalreaddate,p52,26 from staging_lumo union
select intervalreaddate,p54,27 from staging_lumo union
select intervalreaddate,p56,28 from staging_lumo union
select intervalreaddate,p58,29 from staging_lumo union
select intervalreaddate,p60,30 from staging_lumo union
select intervalreaddate,p62,31 from staging_lumo union
select intervalreaddate,p64,32 from staging_lumo union
select intervalreaddate,p66,33 from staging_lumo union
select intervalreaddate,p68,34 from staging_lumo union
select intervalreaddate,p70,35 from staging_lumo union
select intervalreaddate,p72,36 from staging_lumo union
select intervalreaddate,p74,37 from staging_lumo union
select intervalreaddate,p76,38 from staging_lumo union
select intervalreaddate,p78,39 from staging_lumo union
select intervalreaddate,p80,40 from staging_lumo union
select intervalreaddate,p82,41 from staging_lumo union
select intervalreaddate,p84,42 from staging_lumo union
select intervalreaddate,p86,43 from staging_lumo union
select intervalreaddate,p88,44 from staging_lumo union
select intervalreaddate,p90,45 from staging_lumo union
select intervalreaddate,p92,46 from staging_lumo union
select intervalreaddate,p94,47 from staging_lumo union
select intervalreaddate,p96,48 from staging_lumo
) s order by day,prd
