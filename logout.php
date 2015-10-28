<?php
require_once('assets/initialize.php');
if (!isset($_SESSION)){
	session_start();
}
if (isset($_SESSION['ID'])) {
//update tgl terakhir login 
$i = new laksanakan();		
$tdbase = " tgllogin = '". date("Y-m-d H:i:s"). "'";
$ndbase = "user";
$wheres = " id = ".$_SESSION['ID'];
$i->updatedb($tdbase,$ndbase,$wheres);

    session_unset();
    session_destroy();
    session_write_close();
    setcookie(session_name(),'',0,'/');
    session_regenerate_id(true);
	header("Location: index.php");
	} else {
	header("Location: login.php");
	}
?>
