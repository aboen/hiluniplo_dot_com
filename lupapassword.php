<?php
//lupapassword.php
require_once('assets/initialize.php');
require_once('assets/classes/fungsi.class.php');
if (isset($_SESSION['ID'])) {
	//cek apakah sudah ada session login kalau sudah login arahkan ke dashboard user
	header("Location: userdashboard.php");
 }
$smarty = new Smarty();
$smarty->template_dir = 'theme';
$smarty->compile_dir = 'cache';
$smarty->assign('basename',  BASENAME);
$smarty->assign('link',LINK_URL);
/*
 * Located in the assets/classes folder
 */
$helpers = new helpers();
$i = new laksanakan();
//cek jiga reset mempunyai nilai
if(isset($_GET['reset'])){
	$inputdata = " `id`,`email`,`resetpasswd` ";
    $wheres = " `resetpasswd` = '" .$_GET['reset']. "' limit 1 ";
    $cekquery = $i->ambilDetail($inputdata,'user',$wheres);
    if (!empty($cekquery[0]->id)) {
    	$smarty->assign('resetpass',$cekquery[0]->id);

    	//jika pass di simpan
		if (isset($_POST['savepass']) && ($_POST['savepass']=='ok') && (!empty($_POST['password']))) {
			$ndbase = " user ";
			$password =  password_hash($_POST['password'], PASSWORD_DEFAULT);
			$tdbase = " password = '".$password."' , resetpasswd = '' ";
			$wheres = " id = ".$cekquery[0]->id." ";
			$hasil = $i->updateDB($tdbase,$ndbase,$wheres);

			if ($hasil) {
				$helpers->setAlert('alert-success', 'Reset Password Berhasil, silakan logout dan login kembali');
			} else {
				$helpers->setAlert('alert-danger', 'Ganti Password Gagal');
			}			
		}
    }
}
// cek password
if (isset($_POST['lupapassword'])) {
	if (!empty($_POST['email']) ) 
		{
		$emailpost =addslashes($_POST['email']);
        $inputdata = " `nama`,`email` ";
        $wheres = " `email` = '" .$emailpost. "' limit 1 ";
		$cekquery = $i->ambilDetail($inputdata,'user',$wheres);
		if (!empty($cekquery[0]->email)) {
			$email = $cekquery[0]->email;
			$f = new fungsi();
			$random = $f->random_text();
			$bodyemail = 	$cekquery[0]->nama." Anda meminta reset password untuk akun anda pada ".WEBSITE.
							"<br> silakan klik link berikut atau copy paste pada browser kode untuk mereset password anda. <br>
							http://".SITE_URL."?reset=".$random."<br> <br> Bila anda tidak merasa melakukan reset password abaikan email ini <br>
							<br>Terima Kasih <br> Admin";
			
			$e = new sendEmail();
			$kirimP = $e->setToEmail($email);
			$kirimP = $e->setFromName("Admin hiluniplo.com");
			$kirimP = $e->setFromEmail("admin@hiluniplo.com");
			$kirimP = $e->setEmailSubject("Konfirmasi Reset Password ".$cekquery[0]->email." pada ".WEBSITE);
			$kirimP = $e->setEmailBody($bodyemail);
			$kirimP = $e->send();
			//echo $kirimP;
			$ndbase = " user ";
			$tdbase = " resetpasswd = '$random' ";
			$wheres = " email = '$email' ";
			$hasil = $i->updateDB($tdbase,$ndbase,$wheres);

		 } else {
		 	$helpers->setAlert('alert-danger', ' Email Tidak terdaftar  !! ');
		 	//echo 'Email Tidak terdaftar.'; 
		 }
	}
}




/*
 * If we have set the printAlert method then assign to the template variable message
 */
if (isset($_SESSION['alertMessage'])) {
    $smarty->assign('message', $helpers->printAlert());
    $helpers->unsetAlert();
}

// Finally, display the actual page
$smarty->display('lupapassword.tpl');
