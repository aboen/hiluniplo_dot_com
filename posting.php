<?php
//posting.php

if (!isset($_SESSION['ID'])) {
	//cek apakah sudah ada session login kalau belum login arahkan form login
	header("Location: login.php");
 } else {
//tampilkan list data user
	$users = $i->ambil($tdbase, $ndbase, $detailquery);
	if (isset($_POST['approve'])) {
		if ($_POST['approve'] == 0){ $approve = " Unpublish";}
		if ($_POST['approve'] == 1){ $approve = " Publish ";}
	}
					
	if (isset($_POST['approve']) && $_SESSION['HAK'] <= 22) {
	//jika superadmin dan admin approve posting berita 
		$btdbases = " approve = '".$_POST['approve']."'";
		$bndbases = " berita ";	
		$bwheress = " id = '".$_POST['bid']."' ";
		$hasil = $i->updateDB($btdbases,$bndbases,$bwheress);
		$helpers->setAlert('alert-success', "Status Posting sudah di $approve");
	} 
	elseif (isset($_POST['approve']) && $_SESSION['HAK'] >= 33) 
	{
	# jika user bersangkutan
		$btdbases = " approve = '".$_POST['approve']."'";
		$bndbases = " berita ";	
		$bwheress = " id = '".$_POST['bid']."' AND user= '".$_SESSION['ID']."' ";
		$hasil = $i->updateDB($btdbases,$bndbases,$bwheress);
		$helpers->setAlert('alert-success', "Status Posting sudah di $approve");
	}

	$smarty->assign('publish', array(1 => 'Publish',0 => 'Unpublish'));

	//$limit = 20;
	if ($_SESSION['HAK'] <= 99) {
		$tdbase = " b.*, u.nama, u.namapgl, k.kategori ";
		$ndbase = " berita ";
		#paging
		$detailpaging = " ";
		$rowuser = $i->ambil(' count(id) AS jmlid ',$ndbase,$detailpaging);
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
	
		if ($_SESSION['HAK'] <= 22) {
			//hanya superadmin dan admin yang boleh melakukan approve berita
			$detailquery =" AS b JOIN user AS u ON u.id=b.user JOIN kategori AS k ON k.id=b.kategori ORDER BY tglpost DESC LIMIT $offset , ".LIMITDB;	
		} else {
			$detailquery =" AS b JOIN user AS u ON u.id=b.user JOIN kategori AS k ON k.id=b.kategori  WHERE user='".$_SESSION['ID']."' ORDER BY tglpost DESC LIMIT $offset , ".LIMITDB;
		}
		$listdata = $i->ambil($tdbase, $ndbase, $detailquery);
		$smarty->assign('listpost',$listdata);
	}

	#jika url posting (simpan)
	if ($_GET['l']=='posting' && isset($_GET['s']) && ($_GET['s']=='postingbaru' || $_GET['s']=='slideshow') ){
		$kattdbase= " * ";
		$katndbase = " kategori ";
		$katdetailquery = "  ORDER BY kategori ";
		$kategori = $i->ambil($kattdbase, $katndbase, $katdetailquery);
		$smarty->assign('kategori',$kategori);

		if (isset($_POST['postberita']) && $_POST['postberita']=='postberita') {
			#posting berita
			if (!empty($_POST['judul']) && !empty($_POST['txtEditorContent'])) {
				$judul = htmlspecialchars(addslashes($_POST['judul']));
				$konten = htmlspecialchars(addslashes(nl2br($_POST['txtEditorContent'])));

				if ($_SESSION['HAK'] <="22"){$approve=1;} else {$approve=0;}
					if (isset($_POST['editid'])){
						//$token=$_POST['tokenedit'];
						$_POST['update'] = 'true';
						$id = $_POST['editid'];
						$tgl =  $_POST['tglpost'];
					} else {
						//$token=$_POST['token'];
						$_POST['update'] = 'false';
						$id = "";
						$tgl = date("Y-m-d H:i:s");
					}
					$token=$_POST['tokenedit'];
					$inputdata = array ( 'editid' => $id,'tglpost' => $tgl,'user' => $_SESSION['ID'],'judul' => $judul,
				                'konten' =>  $konten,'token' => $token,'kategori' => $_POST['kategori'],'approve' => $approve );
							
					#simpan data user ke db
					$i->simpan($inputdata,'berita');
					#kirim email notifikasi ke Admin 	
					if ($_POST['update'] == 'false') { 
						$utdbase= " nama, email ";
						$undbase = " user ";
						$udetailquery = "  WHERE hak <= 22";
						$uemail = $i->ambil($utdbase, $undbase, $udetailquery);
						//$helpers->printArray($$uemail);
						$e = new sendEmail();
						foreach ($uemail as $key => $value) {
						 	echo $value->email;
						 	$bodyemail = " Dear Admin $value->nama, <br>
										Ada artikel baru yang di Posting oleh ". $_POST['userposting'].", <br>
										dengan Judul $judul <br>
										dan memerlukan persetujuan Admin untuk hal tersebut.<br>

										Silakan login dan approve posting tersebut pada link <br>". 
										SITE_URL."?l=posting&s=listpost

										<br><br>
										Terima Kasih.
										";
						 	$kirimE = $e->setToEmail($value->email);
							$kirimE = $e->setFromName("Admin hiluniplo.com");
							$kirimE = $e->setFromEmail("admin@hiluniplo.com");
							$kirimE = $e->setEmailSubject("Ada artikel baru yang perlu persetujuan pada ".WEBSITE);
							$kirimE = $e->setEmailBody($bodyemail);
							$kirimE = $e->send();
							//echo $kirimE;
						}
					}
					if ($_SESSION['HAK'] <=22) {
						$helpers->setAlert('alert-success', 'Posting Berhasil');
					} else {
						$helpers->setAlert('alert-success', 'Posting Menunggu Persetujan Admin');
					}				
			}
		}

		#edit posting	
		if (isset($_GET['editid'])) {
			$edtdbase= " * ";
			$edndbase = " berita ";
			$eddetailquery = " WHERE id='".$_GET['editid']."'";
			$edpost = $i->ambil($edtdbase, $edndbase, $eddetailquery);
			$smarty->assign('editpost',$edpost);
			//$helpers->printArray($edpost);
			#ambil data photo
			$imtdbase	= " id, namaphoto, linkphoto, thumbnail, token ";
			$imndbase	= " images ";
			$imdetailquery = " WHERE token = '".$edpost[0]->token."'";
			$images = $i->ambil($imtdbase, $imndbase, $imdetailquery);
			$smarty->assign('listimage',$images);
		}
	}
			
	#Hapus posting 
	if (isset($_GET['l']) && isset($_GET['s']) && isset($_GET['delid'])) {
		if (!empty($_GET['delid'])){
			$ndbase = ' berita ';
			$berid 	= " id = ".$_GET['delid']." ";
			$i->delete($ndbase,$berid);
			#hapus komentar
			$komndbase 	= " komentar ";
			$komid		= " idberita = ".$_GET['delid']." ";
			$i->delete($komndbase,$komid);
			#hapus link images
			$imtdbase	= " id,linkphoto,thumbnail,token ";
			$imndbase 	= ' images ';
			$qim 		= " WHERE token NOT IN ( SELECT token FROM berita) ";
			$image 		= $i->ambil($imtdbase, $imndbase, $qim);
			foreach ($image as $key => $value) {
				$imid 		= " id = ".$value->id." ";
				$i->delete($imndbase,$imid);
				unlink($value->linkphoto);
				if ($value->linkphoto != $value->thumbnail) {
					unlink($value->thumbnail);
				}
				
			}
			$helpers->setAlert('alert-success', 'Posting Sudah Dihapus');
		}
	}

#Komentar
	if ($_GET['l']=='posting' && isset($_GET['s']) && $_GET['s']=='komentar'){
		#Hapus komen 
		if (isset($_POST['hapuskomen']) && !empty($_POST['hapuskomen'])) {
			
				$ndbase = ' komentar ';
				$id 	= "id = ".$_POST['hapuskomen']." ";
				$i->delete($ndbase,$id);

		}
		$komtdbase = " * ";
		$komndbase = " vkomentar ";
		#paging
		$detailpaging = " ";
		$rowkomen = $i->ambil(' count(id) AS jmlid ',$komndbase,$detailpaging);
		$jml = $rowkomen[0]->jmlid;
		if (isset($_GET["page"])) 
			{ $page  = $_GET["page"]; } 
			else 
			{ $page=1; };
		$offset = ($page-1) * LIMITDB ; 
		$totpag = ceil($jml / LIMITDB);
		$smarty->assign('totalpage',$totpag);
		$smarty->assign('page',$page);
		#endpaging
	
		if ($_SESSION['HAK'] <= 22) {
			//hanya superadmin dan admin yang boleh melakukan approve berita
			$detailquery =" ORDER BY tglkomen DESC LIMIT $offset , ".LIMITDB;	
		} else {
			$detailquery =" WHERE user='".$_SESSION['ID']."' ORDER BY tglkomen DESC LIMIT $offset , ".LIMITDB;
		}
		$listkomen = $i->ambil($komtdbase, $komndbase, $detailquery);
		$smarty->assign('listkomen',$listkomen);
	}

#jumbotron/slideshow
	if ($_GET['l']=='posting' && isset($_GET['s']) && $_GET['s']=='slideshow'){	
		$komtdbase = " * ";
		$komndbase = " vslideshow ";
		#paging
		$detailpaging = "  ";
		$rowkomen = $i->ambil(' count(id) AS jmlid ',$komndbase,$detailpaging);
		$jml = $rowkomen[0]->jmlid;
		if (isset($_GET["page"])) 
			{ $page  = $_GET["page"]; } 
			else 
			{ $page=1; };
		$offset = ($page-1) * LIMITDB ; 
		$totpag = ceil($jml / LIMITDB);
		$smarty->assign('totalpage',$totpag);
		$smarty->assign('page',$page);

		$detailquery ="  LIMIT $offset , ".LIMITDB;	
//select `b`.*,`u`.`nama`, `u`.`namapgl`,`i`.`linkphoto` from (`berita` `b` join `user` `u` on(`u`.`id` = `b`.`user`) join `images` `i` on(`i`.`token` = `b`.`token`) ) where (`b`.`kategori` = 9999) group by `b`.`token` order by `b`.`tglpost`		$detailquery =" ORDER BY tglpost DESC LIMIT $offset , ".LIMITDB;	
		$listslide = $i->ambil($komtdbase, $komndbase, $detailquery);
		$smarty->assign('listslideshow',$listslide);
	}
} //end else session