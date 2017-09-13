<?php
session_start();
 
function getAccountDetails(){
	if($_SERVER['REQUEST_METHOD']=='POST' && isset($_POST['poizxc']) && $_POST['poizxc']=='login'){
	//echo "inside";exit;
$servername = "eggps.cloudapp.net";
	$username = "root";
	$password = "098ioplkjbNm";
	$dbname = "transporterp_master";

		// Create connection
		$conn = new mysqli($servername, $username, $password, $dbname);
		// Check connection
		if ($conn->connect_error) {
			die("Connection failed: " . $conn->connect_error);
		}

		$sql = "SELECT id_client,gps_account_id FROM erp_client where accountid='".$_POST['account']."'";
		//echo $sql;
		$result = $conn->query($sql);
		$row=$result->fetch_assoc();
		//echo '<pre>';print_r($result);print_r($row);
		//exit($result->id_client."here");
		unset($_SESSION['gps_account_id']);
		if((int)$row['id_client']){
			$_SESSION['account']=$row['id_client'];
			$_SESSION['gps_account_id']=$row['gps_account_id'];
		}
		$conn->close();
	//return $result->fetch_assoc();
	}
}

