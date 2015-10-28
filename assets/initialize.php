<?php
/*
 *
 * This information shouldn't need changed
 *
 */
session_start();
//if (!isset($_SESSION['nama'])) {
//	header("Location:login.php");
//exit;
//} else {
setlocale(LC_ALL, 'id_ID');	
$page = explode('/', $_SERVER['PHP_SELF']);
$scriptName = end($page);
$scriptPath = str_replace($scriptName, '', $_SERVER['PHP_SELF']);
date_default_timezone_set('Asia/Jakarta');
// Information shouldn't need changed
define ('DIRECT_PATH', $_SERVER['DOCUMENT_ROOT'] . $scriptPath); // path
define ('SITE_URL', $_SERVER['SERVER_NAME'] . $scriptPath.$scriptName); // url
define ('LIB_PATH', DIRECT_PATH);
define ('BASENAME', substr(strtolower(basename($_SERVER['PHP_SELF'])),0,strlen(basename($_SERVER['PHP_SELF']))-4));
define ('LINK_URL', $_SERVER['PHP_SELF']); // url			   
define ('WEBSITE','hiluniplo.com');

require_once('db_settings.php');
require_once('definisi.php');
require_once(LIB_PATH . 'assets/classes/dbHandler.class.php');
require_once(LIB_PATH . 'assets/classes/helpers.class.php');
require_once(LIB_PATH . 'assets/classes/crud.class.php');
require_once(LIB_PATH . 'assets/classes/email.class.php');
//require_once(LIB_PATH . 'assets/classes/item.class.php');

require_once(LIB_PATH . 'assets/plugins/smartylibs/Smarty.class.php');
require_once(LIB_PATH . 'assets/plugins/dompdf/dompdf_config.inc.php');

//}