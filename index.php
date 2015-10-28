<?php

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
$G = new laksanakan();

#jumbotron/slideshow
$slide = $G->ambil("id, judul, konten, linkphoto ", " vslideshow " , " GROUP BY token ORDER BY id ");
$smarty->assign('slide',$slide);

#simpan komentar

if (isset($_POST['postkomen']) && isset($_SESSION['ID']) && !empty($_POST['komentar'])) {
	$komentar = htmlspecialchars(addslashes(nl2br($_POST['komentar'])));
	$inputdata = array ( 'idberita' => $_POST['idkomen'], 'tglkomen' => date("Y-m-d H:i:s"), 'user' => $_POST['user'], 'komentar' => $komentar);
	$_POST['update'] = 'false';
	$G->simpan($inputdata,'komentar');
	$helpers->setAlert('alert-success', "Komentar berhasil");
}

//tampilakan isi berita

$tdbase	= " * ";
$ndbase = " vberitaapprove ";
#paging
$limitdb =15;
if (isset($_GET['kat'])) {
	$detailpaging = " WHERE namakategori ='".$_GET['kat']."'";
} else {
	$detailpaging = " ";
}

$rowuser = $G->ambil(' count(id) AS jmlid ',$ndbase,$detailpaging);
$jml = $rowuser[0]->jmlid;
if (isset($_GET["page"])) 
	{ $page  = $_GET["page"]; } 
	else 
	{ $page=1; };
$offset = ($page-1) * $limitdb ; 
$totpag = ceil($jml / $limitdb);
$smarty->assign('totalpage',$totpag);
$smarty->assign('page',$page);
#endpaging

if (isset($_GET['r'])) {
	#readmore
	$smarty->assign('readmore',$_GET['r']);
	$detailquery 	= " WHERE id='".$_GET['r']."'  ";
	$imdetailquery 	= " WHERE token IN ( SELECT token FROM vberitaapprove  WHERE id='".$_GET['r']."' ) ";
	$kdetailquery  	= " WHERE idberita='".$_GET['r']."'  ";
	#hitung hits
	$hitquery = " WHERE idberita ='".$_GET['r']."' ";
	$hit = $G->ambil(" * ", " hits ", $hitquery);

	if (empty($hit)) {
		$jmlhit = 1;
		$_POST['update'] = 'false';
		$editid = '';
		$inputdata = array ( 'idberita' => $_GET['r'], 'hits' => $jmlhit, 'editid' => $editid, 'ip' =>IPADDRESS, 'waktu' => WAKTUMULAI);
		$G->simpan($inputdata,'hits');
	} else {
		$jmlhit = $hit[0]->hits + 1;
		$_POST['update'] = 'true';
		$editid = $hit[0]->id;
		if (($hit[0]->waktu <= WAKTUMULAI-(30*60)) &&  ($hit[0]->ip == IPADDRESS) ) 
		{
			$inputdata = array ( 'idberita' => $_GET['r'], 'hits' => $jmlhit, 'editid' => $editid, 'ip' =>IPADDRESS, 'waktu' => WAKTUMULAI);
			$G->simpan($inputdata,'hits');
		} elseif ($hit[0]->ip != IPADDRESS) {
			$inputdata = array ( 'idberita' => $_GET['r'], 'hits' => $jmlhit, 'editid' => $editid, 'ip' =>IPADDRESS, 'waktu' => WAKTUMULAI);
			$G->simpan($inputdata,'hits');
		}

	}
				
		
    //$inputdata = array ( 'idberita' => $_GET['r'], 'hits' => $jmlhit, 'editid' => $editid);
	//$G->simpan($inputdata,'hits');

} else {
	#view berita yang sudah di approve
	$detailquery 	= " ORDER BY tglpost DESC LIMIT $offset, ".$limitdb;
	$imdetailquery 	= " WHERE token IN ( SELECT token FROM vberitaapprove  ) ORDER BY tanggal ";
	$kdetailquery  	= " WHERE idberita IN ( SELECT id FROM vberitaapprove  ) ORDER BY tglkomen ";
	$hitquery		= " WHERE idberita IN ( SELECT id FROM vberitaapprove  )";
}

//select `b`.*,`u`.`nama`, `u`.`namapgl`,`u`.`photo`,`k`.`kategori` AS `namakategori`,`h`.`hits` from ((`berita` `b` join `user` `u` on((`u`.`id` = `b`.`user`))) join `kategori` `k` on((`k`.`id` = `b`.`kategori`)) join `hits` `h` on((`h`.`idberita` = `b`.`id`))) where (`b`.`approve` = 1) order by `b`.`tglpost`
if (isset($_GET['kat']) && !empty($_GET['kat'])) {
	//tampilkan data berdasar kategori
	$katquery 		= " WHERE namakategori ='".$_GET['kat']."' ORDER BY tglpost DESC LIMIT $offset, ".$limitdb;
	$liatberita = $G->ambil($tdbase,$ndbase,$katquery);
	//$smarty->assign('kategori',$_GET['kat']);

} else {
	$liatberita = $G->ambil($tdbase,$ndbase,$detailquery);
}
//slideshow readmore 
if (isset($_GET['j']) && !empty($_GET['j'])) {
	$smarty->assign('readmore',$_GET['j']);
	$jtdbase	= " * ";
	$jndbase = " vslideshow ";
	$jdetailquery = " WHERE id ='".$_GET['j']."' ";
	$imdetailquery 	= " WHERE token IN ( SELECT token FROM vslideshow  WHERE id='".$_GET['j']."' ) ";
	$kdetailquery  	= " WHERE idberita='".$_GET['j']."'  ";
	$liatberita = $G->ambil($jtdbase,$jndbase,$jdetailquery);

	$hitquery = " WHERE idberita ='".$_GET['j']."' ";
	$hit = $G->ambil(" * ", " hits ", $hitquery);

	if (empty($hit)) {
		$jmlhit = 1;
		$_POST['update'] = 'false';
		$editid = '';
		$inputdata = array ( 'idberita' => $_GET['j'], 'hits' => $jmlhit, 'editid' => $editid, 'ip' =>IPADDRESS, 'waktu' => WAKTUMULAI);
		$G->simpan($inputdata,'hits');
	} else {
		$jmlhit = $hit[0]->hits + 1;
		$_POST['update'] = 'true';
		$editid = $hit[0]->id;
	
		if (($hit[0]->waktu <= WAKTUMULAI-(30*60)) &&  ($hit[0]->ip == IPADDRESS) ) 
		{
			$inputdata = array ( 'idberita' => $_GET['j'], 'hits' => $jmlhit, 'editid' => $editid, 'ip' =>IPADDRESS, 'waktu' => WAKTUMULAI);
			$G->simpan($inputdata,'hits');
		} elseif ($hit[0]->ip != IPADDRESS) {
			$inputdata = array ( 'idberita' => $_GET['j'], 'hits' => $jmlhit, 'editid' => $editid, 'ip' =>IPADDRESS, 'waktu' => WAKTUMULAI);
			$G->simpan($inputdata,'hits');
		}
    }


}

$smarty->assign('berita',$liatberita);

#view hits
$vhits = $G->ambil(" idberita, hits ", " hits ", $hitquery);
$smarty->assign('vhits',$vhits);
//$helpers->printArray($liatberita);

#ambil data image
$imtdbase	= " namaphoto, linkphoto, thumbnail, token ";
$imndbase= " images ";
$images = $G->ambil($imtdbase, $imndbase, $imdetailquery);
$smarty->assign('listimage',$images);

#ambil komentar
$ktdbase = " * ";
$kndbase = " vkomentar ";
//select kom.* ,u.nama, u.namapgl, u.photo from komentar AS kom join user AS u on u.id = kom.user
$komentar = $G->ambil($ktdbase, $kndbase, $kdetailquery);
$smarty->assign('listkomentar',$komentar);

#ambil kategori
$kat = $G->ambil(" count(kategori) AS jmlkat, namakategori ", $ndbase , " GROUP BY kategori ");
$smarty->assign('listkat',$kat);


//$helpers->printArray($images);

/*
if(isset($_GET['action']) == 'delete') {
    $i->deleteInvoice($_GET['invoiceId']);
    $helpers->setAlert('alert-success', 'Invoice Deleted!');
    $helpers->redirect_to('http://' . SITE_URL);
}
*/
/*
 *  Get any invoices we have and assign it to the invoices variable in the template
 * Tampilkan invoice hari ini,
 */
//$waktu = "AND invDetails.date <= CURDATE()";
//$waktu = "AND CURDATE() - INTERVAL 1 month <= invDetails.date AND tutupBuku=0 ";
//$invoices = $i->getInvoices($waktu);
//$smarty->assign('invoices', $invoices);

//$helpers->printArray($invoices);

/*
 * If we have set the printAlert method then assign to the template variable message
 */
if (isset($_SESSION['alertMessage'])) {
    $smarty->assign('message', $helpers->printAlert());
    $helpers->unsetAlert();
}

// Finally, display the actual page
$smarty->display('index.tpl');
