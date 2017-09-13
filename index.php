<?php
// Version

//ini_set('display_errors',1);
define('VERSION', '2.2.0.0');
// Configuration
if (is_file('config.php')) {
	require_once('config.php');
}


/*
// Install
if (!defined('DIR_APPLICATION')) {
	header('Location: ../install/index.php');
	exit;
}*/

// Startup
//echo "value of ".DIR_SYSTEM;exit;
require_once(DIR_SYSTEM . 'startup.php');

$application_config = 'admin';
error_reporting(0);
// Application
require_once(DIR_SYSTEM . 'framework.php');
//echo DB_DATABASE.'<pre>';print_r($_SESSION);'</pre>';
