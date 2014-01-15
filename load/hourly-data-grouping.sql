-- hourly grouping query
select dt,hr_end||':00' as time,kwh from
(
select dt,cast((prd-1)/2 as int)+1 as hr_end,sum(kwh) as kwh from 
(
select to_date('20100101','YYYYMMDD')+ day - 1 as dt, prd, kwh from consumption 
where client_id=2 and to_date('20100101','YYYYMMDD')+ day - 1 <> to_date('20120627','YYYYMMDD')
) t
group by dt,cast((prd-1)/2 as int)
) s
order by dt,hr_end

-- normal 30mn interval query
select to_date('20100101','YYYYMMDD')+ day - 1 as dt, prd, kwh from consumption 
where client_id=2 and to_date('20100101','YYYYMMDD')+ day - 1 <> to_date('20120627','YYYYMMDD')
