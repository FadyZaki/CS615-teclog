<?php
error_reporting(-1);
ini_set('display_errors', 'On');

require_once "database.php";
$db = new Db();
//Code used to drop the table Notes from the database
if($db->dropTable())
    echo "<h3>Table dropped.</h3>";
?>