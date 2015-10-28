<?php
//request.php
if (isset($_POST['komentar'])){
	echo "fungsin POST = ". $_POST['komentar'];
}
if (isset($_GET['zipcode'])){
	echo "fungsi GET kode post = ". $_GET['zipcode'];
	echo " <br>Jakarta ok";
}
?>