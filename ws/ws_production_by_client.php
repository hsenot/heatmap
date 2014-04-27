<?php
/**
 * Returns the entire dataset for a given client
 */

# Includes
require_once("inc/error.inc.php");
require_once("inc/database.inc.php");
require_once("inc/security.inc.php");
require_once("inc/json.pdo.inc.php");

# Performs the query and returns XML or JSON
try {
	$p_client_id = $_REQUEST['client_id'];

	$sql = <<<ENDSQL
select 
system_size_kw,
sum(supply_pv_system_kwh) as total_supply_pv_system_kwh,
max(supply_pv_system_kwh) as max_supply_30mn_kwh,
max(demand_kwh) as max_demand_30mn,
sum(balance_30mn_kwh) as net_balance,
sum(demand_kwh) as total_demand,
sum(case when balance_30mn_kwh<0 then -balance_30mn_kwh else 0 end) as total_imports,
sum(case when balance_30mn_kwh>0 then demand_kwh else supply_pv_system_kwh end) as total_self_consumption,
sum(case when balance_30mn_kwh>0 then balance_30mn_kwh else 0 end) as total_exports,
round(
sum(case when balance_30mn_kwh>0 then demand_kwh else supply_pv_system_kwh end)/sum(demand_kwh)*100
,2) as self_to_demand_ratio,
round(
sum(case when balance_30mn_kwh>0 then demand_kwh else supply_pv_system_kwh end)/sum(case when balance_30mn_kwh>0 then balance_30mn_kwh else 0 end)*100
,2) as self_to_export_ratio
from
(
select *,
round(supply_pv_system_kwh-demand_kwh,4) as balance_30mn_kwh
from
(
select 
c.day as d,
c.prd as p,
c.kwh as demand_kwh,
sys_size.x as system_size_kw,
coalesce(round(sys_size.x*s.performance/(80*2),4),0.0) as supply_pv_system_kwh
from 
	(select * from consumption where client_id=$p_client_id) c
	 left outer join 
	(select * from solar_performance where region='VIC') s
on
	(
		extract(month from s.measure_date)=extract(month from to_date('20100101','YYYYMMDD')+ c.day - 1)
		and extract(day from s.measure_date)=extract(day from to_date('20100101','YYYYMMDD')+ c.day - 1)
		and extract(hour from s.measure_time)*2+(case extract(minute from s.measure_time) when '30' then 1 else 0 end) = c.prd
	),
	(select round(generate_series(2,20)/2.0,1) as x) sys_size
) t
order by 1,2
) s
group by system_size_kw
order by system_size_kw
ENDSQL;

	//echo $sql;
	$pgconn = pgConnection();

    /*** fetch into an PDOStatement object ***/
    $recordSet = $pgconn->prepare($sql);
    $recordSet->execute();

	// Required to cater for IE
	header("Content-Type: text/html");
	echo rs2json($recordSet);
}
catch (Exception $e) {
	trigger_error("Caught Exception: " . $e->getMessage(), E_USER_ERROR);
}

?>