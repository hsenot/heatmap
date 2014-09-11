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
     round(round(1-1/(12*avg(total_kwh/avg_daily_kwh_18to25)),4)*100) as aircon_probability,
     round(avg(max_kw-avg_max_kw_18to25),1) as aircon_size_kw
from
(
select * from
(
select dat,sum(kwh) as total_kwh,max(kwh)*2 as max_kw,max(temp_max) as temp_max from
(
select a.*,b.temp_max from
(
select 
to_date('01/01/2010','DD/MM/YYYY')+c.day-1 as dat,prd,kwh
from consumption c
where c.client_id=$p_client_id) a, bom_temp_max b
where a.dat = b.dat and b.temp_max > 30
) s group by dat
) t,
(
select round(avg(total_kwh),2) as avg_daily_kwh_18to25, round(avg(max_kw),2) as avg_max_kw_18to25 from
(
select 
sum(kwh) as total_kwh,max(kwh)*2 as max_kw
from consumption c, bom_temp_max b
where c.client_id=$p_client_id and to_date('01/01/2010','DD/MM/YYYY')+c.day-1 = b.dat and b.temp_max < 25 and b.temp_max > 18
group by b.dat
) u
) v
order by 4 desc
) w
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