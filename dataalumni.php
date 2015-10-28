<?php
//dataalumni.php
require_once('assets/initialize.php');
$helpers = new helpers();
$smarty = new Smarty();
$smarty->template_dir = 'theme';
$smarty->compile_dir = 'cache';
//$smarty->debugging = true;
//$smarty->caching = true;
//$smarty->cache_lifetime = 220;
//set format tanggal 
$config['date'] = ' %A, %d %B %Y jam %H:%M:%S';
//$config['time'] = '';
$smarty->assign('config', $config);

$smarty->assign('basename',  BASENAME);
$smarty->assign('link',LINK_URL);

//tampilakn isi berita
$G = new laksanakan();

#view user 
$tdbase	= " * ";
$ndbase = " user ";
#paging
$detailpaging = " ";
$rowuser = $G->ambil(' count(id) AS jmlid ',$ndbase,$detailpaging);
$jml = $rowuser[0]->jmlid;
if (isset($_GET["page"])) 
	{ $page  = $_GET["page"]; } 
	else 
	{ $page=1; };
$offset = ($page-1) * LIMITDB ; 
$totpag = ceil($jml / LIMITDB);
$smarty->assign('totalpage',$totpag);
$smarty->assign('page',$page);
#endpaging

#cari berdasar
if (isset($_POST['submit'])) {
$tabel = $_POST['submit'];
$cari = $_POST['carialumni'];
$cariberdasar = " WHERE ".$tabel. " LIKE '%".$cari."%' ORDER BY nama ";
$smarty->assign('cari',"TRUE");
} else {
	$cariberdasar = " ORDER BY nama  LIMIT $offset ,". LIMITDB;
}
$detailquery = $cariberdasar;
$user = $G->ambil($tdbase,$ndbase,$detailquery);
$smarty->assign('users',$user);



/*
 * If we have set the printAlert method then assign to the template variable message
 */
if (isset($_SESSION['alertMessage'])) {
    $smarty->assign('message', $helpers->printAlert());
    $helpers->unsetAlert();
}

// Finally, display the actual page
$smarty->display('dataalumni.tpl');
