<?php
// HTTP
date_default_timezone_set("Asia/Kolkata"); 
define('HTTP_SERVER', 'http://www.easygaadi.com/erp/');
define('HTTP_CATALOG', 'http://www.easygaadi.com/erp/');

// HTTPS
define('HTTPS_SERVER', 'http://www.easygaadi.com/erp/');
define('HTTPS_CATALOG', 'http://www.easygaadi.com/erp/');

// DIR
define('DIR_APPLICATION', '/var/www/html/erp/');
define('DIR_SYSTEM', '/var/www/html/erp/system/');
define('DIR_IMAGE', '/var/www/html/erp/image/');
define('DIR_LANGUAGE', '/var/www/html/erp/language/');
define('DIR_TEMPLATE', '/var/www/html/erp/view/template/');
define('DIR_CONFIG', '/var/www/html/erp/system/config/');
define('DIR_CACHE', '/var/www/html/erp/system/storage/cache/');
define('DIR_DOWNLOAD', '/var/www/html/erp/system/storage/download/');
define('DIR_LOGS', '/var/www/html/erp/system/storage/logs/');
define('DIR_MODIFICATION', '/var/www/html/erp/system/storage/modification/');
define('DIR_UPLOAD', '/var/www/html/erp/system/storage/upload/');
define('DIR_CATALOG', '/var/www/html/erp/catalog/');

// DB
define('DB_DRIVER', 'mysqli');
define('DB_HOSTNAME', 'eggps.cloudapp.net');
define('DB_USERNAME', 'root');
define('DB_PASSWORD', '098ioplkjbNm');
//define('DB_DATABASE', 'oc2.2');
//define('DB_PREFIX', 'oc_');

//start find db
require_once '/var/www/html/erp/system/config/masterdb.php';
$info=getAccountDetails();
//echo '<pre>';print_r($info);echo '</pre>';exit("atlast");
//end find db

if(isset($_SESSION['account']) && $_SESSION['account']!=""){
	define('DB_DATABASE', "erp_".$_SESSION['account']);
}else{
	define('DB_DATABASE', 'transporterp');
}

define('DB_PREFIX', 'erp_');
define('DB_PORT', '3306');

//messages
define('FLASH_ADD_SUCCESS_MSG','New row added successfully!!');
define('FLASH_EDIT_SUCCESS_MSG','Selected row update successfully!!');
define('FLASH_DELETE_SUCCESS_MSG','Selected rows deleted successfully!!');
define('FLASH_ERROR_MSG','Please try again.Unable to do selected action!!');
define('FLASH_PERMISSION_ERROR_MSG','You do not have permission to do this action!!');

define('FORMAT_DATE_FORMAT','M jS-y'); //date(DATE_FORMAT, strtotime($result['date_start']))
define('FORMAT_DATETIME_FORMAT','M-j H:i'); 
define('FORMAT_DECIMAL_POINT','.'); //need to check number format in oc and apply
define('FORMAT_THOUSAND_POINT',',');

/*$_['date_format_short']             = 'd/m/Y';
$_['date_format_long']              = 'l dS F Y';
$_['time_format']                   = 'h:i:s A';
$_['datetime_format']               = 'd/m/Y H:i:s';*/

define('NEWDB_PORT', '3306');
define('NEWDB_DRIVER', 'mysqli');
define('NEWDB_HOSTNAME', 'eggps.cloudapp.net');
define('NEWDB_USERNAME', 'root');
define('NEWDB_PASSWORD', '098ioplkjbNm');
define('NEWDB_DATABASE', 'gts');
define('NEWDB_PREFIX', '');