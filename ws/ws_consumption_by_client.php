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
select day as d,prd as p,kwh as k
from consumption
where client_id=$p_client_id
order by 1,2
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