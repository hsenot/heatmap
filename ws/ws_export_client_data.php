<?php
/**
 * Returns the entire dataset for a given client
 */

# Includes
require_once("inc/error.inc.php");
require_once("inc/database.inc.php");
require_once("inc/security.inc.php");
require_once("inc/csv.pdo.inc.php");

# Performs the query and returns XML or JSON
try {
	$p_client_id = $_REQUEST['client_id'];

	$sql = <<<ENDSQL
select to_char(to_date('01/01/2010','DD/MM/YYYY') + day - 1,'YYYY/MM/DD') as date,prd as period,kwh as consumption_kwh
from consumption
where client_id=$p_client_id
order by 1,2
ENDSQL;

	//echo $sql;
	$pgconn = pgConnection();

    /*** fetch into an PDOStatement object ***/
    $recordSet = $pgconn->prepare($sql);
    $recordSet->execute();

	// Exporting as CSV	
	header("Content-Type: text/csv");
	header("Content-Disposition: attachment; filename=smd-".$p_client_id.".csv");
	echo rs2csv($recordSet);
}
catch (Exception $e) {
	trigger_error("Caught Exception: " . $e->getMessage(), E_USER_ERROR);
}

?>