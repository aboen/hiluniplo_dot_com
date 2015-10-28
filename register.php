<?php
//register.php
require_once('assets/initialize.php');
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


//cek apakah submit di klik 
//jika isset submit terisi maka proses data untuk masukan pendaftaran ke db
if (isset($_POST['submit']) && ($_POST['submit'])=='daftar') {
$i = new laksanakan();		
	//cek jika data yang di $_POST tidak kosong
	if (!empty($_POST['nama']) && 
		!empty($_POST['email']) &&
		!empty($_POST['notelp']) &&
		!empty($_POST['datepicker']) &&
		!empty($_POST['alamat']) &&
		!empty($_POST['kodepos']) &&
		!empty($_POST['jeniskelamin']) &&
		!empty($_POST['password']) 
		) {
		//rubah password menjadi hash
		$nama = addslashes($_POST['nama']);
        $email = addslashes($_POST['email']);
        $pass = addslashes($_POST['password']); 
		//cek email apakah sudah di pakai..
        $inputdata = " `email` ";
        $wheres = " `email` = '" .$email. "' limit 1 ";
		$cekquery = $i->ambilDetail($inputdata,'user',$wheres);
		if (empty($cekquery[0]->email)) {
			$password =  password_hash($pass, PASSWORD_DEFAULT);
			//form input masukan dalam satu array
			$inputdata = array (
	                'nama' => $nama,
	                'email' => $email,
	                'notelp' => $_POST['notelp'],
	                'tgllahir' => $_POST['datepicker'],
	                'alamat' => $_POST['alamat'],
	                'kodepos' => $_POST['kodepos'],
	                'jeniskelamin' => $_POST['jeniskelamin'],
	                'password' => $password,
	                'tgldaftar' => date("Y-m-d"),
	                'hak' => '99',
	                'statuss' => '0'
	            );
			//set update=false
			$_POST['update'] = 'false';
			//simpan data user ke db
			$i->simpan($inputdata,'user');
			//tampilkan pesan bila pendaftaran berhasil
			$helpers->setAlert('alert-success', 'Pendaftaran Berhasil');
		} else {
			$helpers->setAlert('alert-danger', 'Email Sudah Digunakan. Bila Lupa password gunakan menu reset password pada halaman login ');
		}

	} else {
		$helpers->setAlert('alert-danger', 'Pendaftaran Gagal atau data belum di isikan');
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
$smarty->display('register.tpl');
