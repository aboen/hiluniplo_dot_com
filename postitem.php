<?php

require_once('assets/initialize.php');
if (!isset($_SESSION['ID'])) {
	//cek apakah sudah ada session login kalau sudah login arahkan ke dashboard user
	header("Location: index.php");
 }
$smarty = new Smarty();
$smarty->template_dir = 'theme';
$smarty->compile_dir = 'cache';
//$smarty->debugging = true;
//$smarty->caching = true;
//$smarty->cache_lifetime = 220;
$smarty->assign('basename',  BASENAME);
/*
 * Located in the assets/classes folder
 */
$helpers = new helpers();


//cek apakah submit di klik 
//jika isset submit terisi maka proses data untuk masukan pendaftaran ke db
if (isset($_POST['submit'])) {
$i = new laksanakan();		
	//cek jika data yang di $_POST tidak kosong
	if (!empty($_POST['nama']) || 
		!empty($_POST['email']) ||
		!empty($_POST['notelp']) ||
		!empty($_POST['tgllahir']) ||
		!empty($_POST['alamat']) ||
		!empty($_POST['kodepos']) ||
		!empty($_POST['jeniskelamin']) ||
		!empty($_POST['password']) 
		) {
		//rubah passwoar menjadi hash
		
		$nama = addslashes($_POST['nama']);
        $email = addslashes($_POST['email']);
        $pass = addslashes($_POST['password']); 
		$password =  password_hash($pass, PASSWORD_DEFAULT);
		//form input masukan dalam satu array
		$inputdata = array (
                'nama' => $nama,
                'email' => $email,
                'notelp' => $_POST['notelp'],
                'tgllahir' => $_POST['tgllahir'],
                'alamat' => $_POST['alamat'],
                'kodepos' => $_POST['kodepos'],
                'jeniskelamin' => $_POST['jeniskelamin'],
                'password' => $password,
                'tgldaftar' => date("Y-m-d"),
                'hak' => '99',
                'status' => '0'
            );
		//set update=false
		$_POST['update'] = 'false';
		//simpan data user ke db
		$i->simpan($inputdata,'user');
		//tampilkan pesan bila pendaftaran berhasil
		$helpers->setAlert('alert-success', 'Pendaftaran Berhasil');
	}
	
}
/*
 * Post back when delete is selected
 */
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
$smarty->display('postitem.tpl');
