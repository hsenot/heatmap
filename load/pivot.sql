/*
drop table daily_col cascade;

create table daily_col
( prd date,
p1 float,p2 float,p3 float,p4 float,p5 float,p6 float,p7 float,p8 float,p9 float,p10 float,
p11 float,p12 float,p13 float,p14 float,p15 float,p16 float,p17 float,p18 float,p19 float,p20 float,
p21 float,p22 float,p23 float,p24 float,p25 float,p26 float,p27 float,p28 float,p29 float,p30 float,
p31 float,p32 float,p33 float,p34 float,p35 float,p36 float,p37 float,p38 float,p39 float,p40 float,
p41 float,p42 float,p43 float,p44 float,p45 float,p46 float,p47 float,p48 float);

copy daily_col from '/opt/opengeo/suite/webapps/heatmap/data/Electricity_Consumption_Data_mod.csv' csv;
*/

copy (select to_char(prd,'DD/MM/YYYY') as "Day",p as "EndPeriod",p1 as "KW" from
(
select prd,'12:30:00 AM' as p,p1,1 as o from daily_col union
select prd,'01:00:00 AM',p2,2 from daily_col union
select prd,'01:30:00 AM',p3,3 from daily_col union
select prd,'02:00:00 AM',p4,4 from daily_col union
select prd,'02:30:00 AM',p5,5 from daily_col union
select prd,'03:00:00 AM',p6,6 from daily_col union
select prd,'03:30:00 AM',p7,7 from daily_col union
select prd,'04:00:00 AM',p8,8 from daily_col union
select prd,'04:30:00 AM',p9,9 from daily_col union
select prd,'05:00:00 AM',p10,10 from daily_col union
select prd,'05:30:00 AM',p11,11 from daily_col union
select prd,'06:00:00 AM',p12,12 from daily_col union
select prd,'06:30:00 AM',p13,13 from daily_col union
select prd,'07:00:00 AM',p14,14 from daily_col union
select prd,'07:30:00 AM',p15,15 from daily_col union
select prd,'08:00:00 AM',p16,16 from daily_col union
select prd,'08:30:00 AM',p17,17 from daily_col union
select prd,'09:00:00 AM',p18,18 from daily_col union
select prd,'09:30:00 AM',p19,19 from daily_col union
select prd,'10:00:00 AM',p20,20 from daily_col union
select prd,'10:30:00 AM',p21,21 from daily_col union
select prd,'11:00:00 AM',p22,22 from daily_col union
select prd,'11:30:00 AM',p23,23 from daily_col union
select prd,'12:00:00 PM',p24,24 from daily_col union
select prd,'12:30:00 PM',p25,25 from daily_col union
select prd,'01:00:00 PM',p26,26 from daily_col union
select prd,'01:30:00 PM',p27,27 from daily_col union
select prd,'02:00:00 PM',p28,28 from daily_col union
select prd,'02:30:00 PM',p29,29 from daily_col union
select prd,'03:00:00 PM',p30,30 from daily_col union
select prd,'03:30:00 PM',p31,31 from daily_col union
select prd,'04:00:00 PM',p32,32 from daily_col union
select prd,'04:30:00 PM',p33,33 from daily_col union
select prd,'05:00:00 PM',p34,34 from daily_col union
select prd,'05:30:00 PM',p35,35 from daily_col union
select prd,'06:00:00 PM',p36,36 from daily_col union
select prd,'06:30:00 PM',p37,37 from daily_col union
select prd,'07:00:00 PM',p38,38 from daily_col union
select prd,'07:30:00 PM',p39,39 from daily_col union
select prd,'08:00:00 PM',p40,40 from daily_col union
select prd,'08:30:00 PM',p41,41 from daily_col union
select prd,'09:00:00 PM',p42,42 from daily_col union
select prd,'09:30:00 PM',p43,43 from daily_col union
select prd,'10:00:00 PM',p44,44 from daily_col union
select prd,'10:30:00 PM',p45,45 from daily_col union
select prd,'11:00:00 PM',p46,46 from daily_col union
select prd,'11:30:00 PM',p47,47 from daily_col union
select prd,'12:00:00 AM',p48,48 from daily_col) t 
where prd >= '2013-02-01'
order by prd,o)
to '/opt/opengeo/suite/webapps/heatmap/data/Electricity_Consumption_Data_Flat.csv' CSV HEADER;