<?php
/*
Uploadify
Copyright (c) 2012 Reactive Apps, Ronnie Garcia
Released under the MIT License <http://www.opensource.org/licenses/mit-license.php> 
*/
require_once('assets/initialize.php');

if (!isset($_SESSION['ID'])) {
	//cek apakah sudah ada session login kalau belum login arahkan form login
	header("Location: login.php");
 }

// Define a destination
$targetFolder = "images/uploads/".$_SESSION['ID']."/"; // Relative to the root
if(!is_dir($targetFolder)) { mkdir($targetFolder,0775);} 
        
$verifyToken = md5('unique_salt' . $_POST['timestamp']);

if (!empty($_FILES) && $_POST['token'] == $verifyToken) {

	$i = new laksanakan();
	$tempFile = $_FILES['Filedata']['tmp_name'];
    $FileData = strtolower(str_replace(' ', '_',$_FILES['Filedata']['name']));
	$targetPath = $_SERVER['DOCUMENT_ROOT'] . $targetFolder;
 
 	$imageFileType = pathinfo( $_FILES['Filedata']['name'],PATHINFO_EXTENSION);

	if (isset($_POST['renamefile']) && !empty($_POST['renamefile'])){
		$targetFile = $targetFolder. $_POST['renamefile'].".".$imageFileType;
		$namafile = $_POST['renamefile'].".".$imageFileType;
	} elseif  (isset($_POST['slideshow']) && ($_POST['slideshow'] == TRUE)) {
        $targetFile = "images/uploads/".$FileData; 
        $namafile = $FileData;
    } else {
        $targetFile = $targetFolder. $FileData; 
        $namafile = $FileData;
    }

	
	if (file_exists($targetFile)) {unlink($targetFile); }
            
	// Validate the file type
	$fileTypes = array('jpg','jpeg','gif','png','JPG','JPEG','GIF','PNG'); // File extensions

	if (in_array($imageFileType,$fileTypes)) {
		move_uploaded_file($tempFile,$targetFile);

//slideshow
        if (isset($_POST['slideshow']) && ($_POST['slideshow']==TRUE)) {
            $x_size = getimagesize($targetFile)[0];//width
            $y_size = getimagesize($targetFile)[1];//height
            if ($x_size >= 801 && $y_size >= 301)  {
                resizeImage($targetFile,$_POST['katslidew'],$_POST['katslideh'],$imageFileType,$targetFile);
                $x_size = getimagesize($targetFile)[0];//width
                $y_size = getimagesize($targetFile)[1];//height
            }
            if ($x_size <=800) {
                $xw =0;
            } else {
                $xw =  ceil($x_size/2)-(800/2);
                $x_size = 800;
            }
            if ($y_size <=300) {
                $yh =0;
            } else {
                $yh =  ceil($y_size/2)-(300/2);
                $y_size = 300;
            }

            $im= imagecreatefromjpeg($targetFile);
            $to_crop_array = array('x' =>$xw , 'y' => $yh, 'width' => $x_size, 'height'=> $y_size);
            $crop = imagecrop($im, $to_crop_array);
            imagejpeg($crop, $targetFile);
            $filethumb = $targetFile;
        }//end slideshow


        //$im=$targetFile;
        if (!isset($_POST['profile'])) {
        #watermark     
        //$watermark =$targetFolder.$namafile;
        $watermark =  $targetFile;      

        switch ($imageFileType) {
            case 'jpg':
            case 'JPG':
                $im= imagecreatefromjpeg($targetFile);
            break;
            case 'jpeg':
            case 'JPEG':
                $im= imagecreatefromjpeg($targetFile);
            break;
            case 'png':
            case 'PNG':
                $im= imagecreatefrompng($targetFile);
            break;
            case 'gif':
            case 'GIF':
                $im = imagecreatefromgif($targetFile);
            break;
        }

        $stamp = imagecreatefrompng('images/logohiluni.png');
        $marge_right = 5;
        $marge_bottom = 5;
        $dst_x = imagesx($im) - imagesx($stamp) - $marge_right ;
        $dst_y = imagesy($im) - imagesy($stamp) - $marge_bottom ;
        imagecopy($im, $stamp, $dst_x, $dst_y, 0, 0, imagesx($stamp), imagesy($stamp));
        switch ($imageFileType) {
            case 'jpg':
            case 'JPG':
                imagejpeg($im,$watermark);
                imagedestroy($im);
            break;
            case 'jpeg':
            case 'JPEG':
                imagejpeg($im,$watermark);
                imagedestroy($im);
            break;
            case 'png':
            case 'PNG':
                imagepng($im,$watermark);
                imagedestroy($im);
            break;
            case 'gif':
            case 'GIF':
                imagegif($im,$watermark);
                imagedestroy($im);
            break;
        }
        
        #endwatermark
    }

        if (isset($_POST['resize']) && $_POST['resize']==TRUE && isset($_POST['newwidth']) && isset($_POST['newheight'])) {
	        $execu = resizeImage($targetFile,$_POST['newwidth'],$_POST['newheight'],$imageFileType,$targetFile);
		}

		if(isset($_POST['thumbnail']) && $_POST['thumbnail']==TRUE && isset($_POST['thumbnewwidth']) && isset($_POST['thumbnewheight']) ){
			$dirthumb = $targetFolder."thumb/";
			if(!is_dir($dirthumb)) {mkdir($dirthumb,0775);}
	        $filethumb = $dirthumb.$FileData;
	        $execu = resizeImage($targetFile,$_POST['thumbnewwidth'],$_POST['thumbnewheight'],$imageFileType,$filethumb);
		}
    		if (isset($_POST['profile'])) {
               echo " <img  class='img-thumbnail' src=".$targetFile.">";
               $ndbases = " user ";
               $tdbases = " photo   =  '".$targetFile."'" ;
               $wheress = " id = ".$_SESSION['ID']." ";
              $i->updateDB($tdbases,$ndbases,$wheress);

            } else {
                #kembailkan nilai yang di upload
        		$li = "<div class='col-md-2'><div class='panel panel-default'><div class='panel-heading '><p class='heading-images'>".$namafile."</p></div>
        		  		<div class='panel-body'><img  class='img-thumbnail' src='".$filethumb."' >" ;	    
        		echo $li;
        		//simpan ke database
                $token =$_POST['tokenedit'];
        		$inputdata = array (
        	                'iduser' => $_SESSION['ID'],
        	                'namaphoto' => $namafile,
        	                'linkphoto' => $targetFile,
        	                'thumbnail' => $filethumb,
        	                'token' =>  $token,
        	                'tanggal' => date("Y-m-d H:i:s"),
        	                'statuss' => '0'
        	            );
        		$_POST['update'] = 'false';
        		$i->simpan($inputdata,'images');
            }//end isset profile
	} else {
		echo "<div><div><div><p class='bg-danger'>Invalid file type. </p>";
	}
}

//fugsi resize image
function resizeImage($filename,$newwidth,$newheight,$extension,$thumbnail){
        list($width, $height) = getimagesize($filename);
        if($width > $height && $newheight < $height){
            $newheight = $height / ($width / $newwidth);
        } else if ($width < $height && $newwidth < $width) {
            $newwidth = $width / ($height / $newheight);    
        } else {
            $newwidth = $width;
            $newheight = $height;
        }
        $thumb = imagecreatetruecolor($newwidth, $newheight);
        switch ($extension) {
            case 'jpg':
            case 'JPG':
                 $source = imagecreatefromjpeg($filename);
            break;
            case 'jpeg':
            case 'JPEG':
                 $source = imagecreatefromjpeg($filename);
            break;
            case 'png':
            case 'PNG':
                $source = imagecreatefrompng($filename);
                imagecolortransparent($thumb, imagecolorallocatealpha($thumb, 0, 0, 0, 127));
                imagealphablending($thumb, false);
                imagesavealpha($thumb, true);
            break;
            case 'gif':
            case 'GIF':
                $source = imagecreatefromgif($filename);
                imagecolortransparent($thumb, imagecolorallocatealpha($thumb, 0, 0, 0, 127));
                imagealphablending($thumb, false);
                imagesavealpha($thumb, true);
                 
            break;
        }
        if ($thumbnail !="false") {
            $filename = $thumbnail;
        }
        imagecopyresampled($thumb, $source, 0, 0, 0, 0, $newwidth, $newheight, $width, $height);
        switch ($extension) {
            case 'jpg':
            case 'JPG':
                $im=  imagejpeg($thumb,$filename);
                 imagedestroy($thumb);
            break;
            case 'jpeg':
            case 'JPEG':
                 $im=  imagejpeg($thumb,$filename);
                 imagedestroy($thumb);
            break;
            case 'png':
            case 'PNG':
                 $im=  imagepng($thumb,$filename);
                 imagedestroy($thumb);
            break;
            case 'gif':
            case 'GIF':
                $im= imagegif($thumb,$filename);
                imagedestroy($thumb);
            break;
        }
        return $im;
    }	
?>