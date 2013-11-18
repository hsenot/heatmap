select min(kwh)*2,avg(kwh)*2,max(kwh)*2 from consumption 
where client_id=5
--and date '01/01/2010'+day-1 in (to_date('25/09/2013','DD/MM/YYYY'),to_date('26/09/2013','DD/MM/YYYY'))
