<?php
//login.php
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

// cek password
if (isset($_POST['signin'])) {
$i = new laksanakan();	
	if (!empty($_POST['email']) || !empty($_POST['password']) ) 
		{
		$email =addslashes($_POST['email']);
        $pass = addslashes($_POST['password']);
        $inputdata = " `id`,`nama`, `password`, `email`, `hak`, `statuss` ";
        $wheres = " `email` = '" .$email. "' limit 1 ";
		$cekquery = $i->ambilDetail($inputdata,'user',$wheres);
		if (!empty($cekquery[0]->password) || !empty($cekquery[0]->email)) {
			$password = $cekquery[0]->password;		
			if (password_verify($pass, $password)) { 
				if (!isset($_SESSION)) { session_start();}
				$_SESSION['ID'] = $cekquery[0]->id;
			    $_SESSION['NAMA'] = $cekquery[0]->nama;
			    $_SESSION['HAK'] = $cekquery[0]->hak;
			    if ($_SESSION['HAK'] >= 22) {
			    	header("Location: index.php");
			    } elseif ($_SESSION['HAK']==11) {
			    	header("Location: userdashboard.php");
			    }
			} else { 
				$helpers->setAlert('alert-danger', ' Password Salah !! ');
			    //echo 'Invalid password.'; 
			} 
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
$smarty->display('login.tpl');
