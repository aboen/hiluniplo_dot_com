<?php
//userdashboar.php
require_once('assets/initialize.php');
//require_once('assets/classes/fungsi.class.php');

if (!isset($_SESSION['ID'])) {
	//cek apakah sudah ada session login kalau belum login arahkan form login
	header("Location: login.php");
 }
$helpers = new helpers();
$smarty = new Smarty();
$smarty->template_dir = 'theme';
$smarty->compile_dir = 'cache';
//$smarty->debugging = true;
//$smarty->caching = true;
//$smarty->cache_lifetime = 220;
$smarty->assign('basename',  BASENAME);
$timestamp = time();
$smarty->assign('timestamp',  $timestamp);
$md5salt = md5('unique_salt' . $timestamp);
$smarty->assign('md5salt', $md5salt);

$i = new laksanakan();

$tdbase= " u.*, h.nama AS hakakses ";
$ndbase= " user ";
#paging
$rowuser = $i->ambil(' count(id) AS jmlid ',$ndbase," ");
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
if ($_SESSION['HAK'] == 11) {
	$detailquery = " AS u JOIN hak AS h ON u.hak=h.hak  ORDER BY nama LIMIT $offset, ".LIMITDB;
	$tdbasehak= " hak,nama ";
	$ndbasehak= " hak ";
	$detailqueryhak = " ";
	$usershak = $i->ambil($tdbasehak, $ndbasehak, $detailqueryhak);
	$smarty->assign('userhak',$usershak);
} else {
	$detailquery= " AS u JOIN hak AS h ON u.hak=h.hak WHERE id = '". $_SESSION['ID']."'  ";
}

if (!empty($_GET['l'])) {
	//$urllink = 	$_GET['l'];
	switch ($_GET['l']) {
		case "profile":	
			if (isset($_POST['hak']) && $_SESSION['HAK'] == 11 ){				
				//rubah hak user
				$tdbases = " hak = '".$_POST['hak']."'";
				$ndbases = " user ";
				$wheress = " id = ".$_POST['uid']." ";
				$hasil = $i->updateDB($tdbases,$ndbases,$wheress);

			}
			#hapus user 
			if (isset($_GET['l']) && isset($_GET['delid'])){
				if (($_GET['l']==='profile') && !empty($_GET['delid'])) {
				 	$delndbase = ' user ';
					$delid 	= "id = ".$_GET['delid']." ";
					#cek apakah pernah posting
					$cquery = " WHERE user = ".$_GET['delid'];
					$cekpost = $i->ambil(' id, user ', ' berita ', $cquery);

					if ($_SESSION['HAK'] <=11) {
						
						$helpers->setAlert('alert-success', "User Sudah di Hapus");
						if(!empty($cekpost)) {
							
							foreach ($cekpost as $key => $value) {
								$upquery = "  id='".$value->id."'";
								$i->updateDB(" user = 1 "," berita ",$upquery);
							}
							$helpers->setAlert('alert-success', "berita sudah di pindah");
							
						}
						$i->delete($delndbase,$delid);
					}
					if ($_SESSION['HAK'] >=22 ) {

						if(!empty($cekpost)) {
							//$helpers->printArray($cekpost);
							foreach ($cekpost as $key => $value) {
								$upquery = "  id='".$value->id."'";
								$i->updateDB(" user = 1 "," berita ",$upquery );
							}
							
						}
						$i->delete($delndbase,$delid);
						session_unset();
	    				session_destroy();
					    session_write_close();
					    setcookie(session_name(),'',0,'/');
					    session_regenerate_id(true);
					    $helpers->setAlert('alert-success', "User Sudah di Hapus");
						header("Location: index.php");
							
						
					}
				}
			}

			$users = $i->ambil($tdbase, $ndbase, $detailquery);
		break;

		case "profiledetail":

			if (isset($_GET['id'])) {
					$detailquery= " AS u JOIN hak AS h ON u.hak=h.hak WHERE id = '". $_GET['id']."'  ";
					
				$users = $i->ambil($tdbase, $ndbase, $detailquery);
			}
		break;

		case "profile_edit":		
			if (isset($_GET['id'])) {
				$detailquery= " AS u JOIN hak AS h ON u.hak=h.hak WHERE id = '". $_GET['id']."'  ";
			} else {
				$detailquery= " AS u JOIN hak AS h ON u.hak=h.hak WHERE id = '". $_SESSION['ID']."'  ";

			}
			if (isset($_POST['simpanedit']) && ($_POST['simpanedit']=='simpanedit') ) {	
			$users = $i->ambil($tdbase, $ndbase, $detailquery);	
				//upload photo
			
			//end upload photo
			//simpan hasil edit
				$ndbases = " user ";
				$tdbases = " nama 		=  '".$_POST['nama']."',
							email 		=  '".$_POST['email']."',
							namapgl 	=  '".$_POST['namapgl']."',
							tgllahir	=  '".$_POST['tgllahir']."',
							pekerjaan	=  '".$_POST['pekerjaan']."',
							namaperusahaan 	=  '".$_POST['namaperusahaan']."',
							alamat 		=  '".$_POST['alamat']."',
							kodepos 	=  '".$_POST['kodepos']."',
							kota 		=  '".$_POST['kota']."',
							propinsi 	=  '".$_POST['propinsi']."',
							jeniskelamin 	=  '".$_POST['jeniskelamin']."',
							tahunlulus 	=  '".$_POST['tahunlulus']."',
							jurusan 	=  '".$_POST['jurusan']."',
							sekolah 	=  '".$_POST['sekolah']."',
							basis 		=  '".$_POST['basis']."',
							fb 			=  '".$_POST['fb']."',
							ym 			=  '".$_POST['ym']."',
							aboutme		=  '".$_POST['aboutme']."'
							";
				$wheress = " id = ".$_POST['iduser']." ";
				$hasil = $i->updateDB($tdbases,$ndbases,$wheress);

				if ($hasil) {
					$helpers->setAlert('alert-success', "Data Profile Berhasil di update");
					if (isset($pesangagal) ) {
						$smarty->assign('gagaluploadphoto',$pesangagal);
					} 					
				} else {
					$helpers->setAlert('alert-danger', 'Update Profile Gagal');
				}
			}		
			$users = $i->ambil($tdbase, $ndbase, $detailquery);		
			$smarty->assign('jenisk', array(1 => 'Pria',2 => 'Wanita'));
		break;

		case "messages":
		//admini user
			//header("Location: userdashboard.php");
			$users = $i->ambil($tdbase, $ndbase, $detailquery);
		break;

		case "posting":
		//admin user
			include_once('posting.php');
			
		break;

		case "gantipassword":
		//admini user
			$users = $i->ambil($tdbase, $ndbase, $detailquery);
			if (isset($_POST['savepass']) && ($_POST['savepass']=='ok') && (!empty($_POST['password']))) {
				$ndbase = " user ";
				$password =  password_hash($_POST['password'], PASSWORD_DEFAULT);
				$tdbase = " password = '".$password."' ";
				$wheres = " id = ".$_SESSION['ID']." ";
				$hasil = $i->updateDB($tdbase,$ndbase,$wheres);
				if ($hasil) {
					$helpers->setAlert('alert-success', 'Ganti Password Berhasil, silakan logout dan login kembali');
				} else {
					$helpers->setAlert('alert-danger', 'Ganti Password Gagal');
				}
				
			}
			
		break;
	}

	$smarty->assign('GETURL',$_GET['l']);
	if ($_GET['l'] == 'posting'  && isset($_GET['s'])) {
		$smarty->assign('GETsubURL',$_GET['s']);
	} else {
		$smarty->assign('GETsubURL'," ");
	}
	

} else {
	$smarty->assign('GETURL'," ");
//	$detailquery= " AS u JOIN hak AS h ON u.hak=h.hak WHERE id = '". $_SESSION['ID']."'  ";
	$users = $i->ambil($tdbase, $ndbase, $detailquery);
	//$helpers->printArray($users);
} 


// cek User
switch ($_SESSION['HAK']) {
	case 11:
	//Super Admin
		$smarty->assign('users',$users);
		
		$tdbase= " photo ";
		$ndbase= " user ";
		$detailquery= " WHERE id = '". $_SESSION['ID']."'  ";
		$users = $i->ambil($tdbase, $ndbase, $detailquery);
		$smarty->assign('photo',$users);
		//header("Location: userdashboard.php");
		break;

	case 22:
	//Admin
		//header("Location: userdashboard.php");
		$smarty->assign('users',$users);
		break;

	case 33:
	//Kontributor
		//header("Location: userdashboard.php");
		$smarty->assign('users',$users);
		break;
	
	case 44:
	//Penjual
		//header("Location: userdashboard.php");
		$smarty->assign('users',$users);
		break;

	case 99:
	//User
		//	header("Location: index.php")
		$smarty->assign('users',$users);;
		break;	
	default:
			header("Location: index.php");
		break;
}
/*
if ($_SESSION['HAK']==99) {
//	header("Location: index.php");
} elseif ($_SESSION['HAK']=11) {
	//header("Location: userdashboard.php");
}
*/
//$helpers->printArray($invoices);

/*
 * If we have set the printAlert method then assign to the template variable message
 */
if (isset($_SESSION['alertMessage'])) {
    $smarty->assign('message', $helpers->printAlert());
    $helpers->unsetAlert();
}

// Finally, display the actual page
$smarty->display('userdashboard.tpl');
