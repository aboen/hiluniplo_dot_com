<?php
/**
 * Aug 2015
 * fungsi kelas kelas baru
 */
class fungsi
{
    /*fungsi upload photo
    **
    */
    public function uploadimage($target_dir,$nama_file,array $file_upload,$sizemax,$resize,$newwidth="200", $newheight="200",$thumbnail){
        //buat direktori kalau belum ada           
        if(!is_dir($target_dir)) {
            mkdir($target_dir,0775);
        } 
        $imageFileType = pathinfo( $file_upload['name'],PATHINFO_EXTENSION);
        $target_file = $target_dir . $nama_file.'.' . $imageFileType;
       //$target_file = $target_dir . $nama_file;
        $uploadOk = 1;
        // Check if image file is a actual image or fake image
        if(exif_imagetype($file_upload['tmp_name']) !== false) {
            $uploadOk = 1;
        } else {
            $uploadOk = 0;
        }
        // Check file size
        if ($file_upload['size'] > $sizemax) {
            $uploadOk = 0;
        }
        // Allow certain file formats
        if($imageFileType != "jpg" && $imageFileType != "png" && $imageFileType != "jpeg"
            && $imageFileType != "gif" ) {
            $uploadOk = 0;
        }
        // Check if $uploadOk is set to 0 by an error
        if ($uploadOk == 0) {
            $size = $sizemax/1000 . "KB";
            $pesan ="Bukan file Image atau Besar File melebihi ketentuan $size dan hanya file JPG, JPEG, PNG dan GIF yang dibolehkan"; 
            $result_image ="Gagal upload : $pesan"; 
            //return $result_image;       
        // if everything is ok, try to upload file
        } else {
        // Check if file already exists and delete
            if (file_exists($target_file)) {
                    unlink($target_file); 
            }
            if (move_uploaded_file($file_upload['tmp_name'], $target_file)) {
                //$uphoto = new fungsi();
                if ($resize == "true") {

                    $this->resizeImage($target_file,$newwidth,$newheight,$imageFileType,"false");
                     $result_image = $target_file;
                   
                } else {
                    if ($thumbnail =='true'){
                        $dirthumb = $target_dir."/thumb/";
                        if(!is_dir($dirthumb)) {
                            mkdir($dirthumb,0775);
                        }
                        $filethumb = $dirthumb.$nama_file;
                        $this->resizeImage($target_file,$newwidth,$newheight,$imageFileType,$filethumb);
                        $result_image = $filethumb;
                    }
                   // $result_image = $target_file;
                    //return $result_image;
                }

            } 
          
        }
        return $result_image;

}//end uploadimage

    /*fungsi untuk resize ukuran gambar
    **
    */
    public function resizeImage($filename,$newwidth,$newheight,$extension,$thumbnail){
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
                 $source = imagecreatefromjpeg($filename);
            break;
            case 'jpeg':
                 $source = imagecreatefromjpeg($filename);
            break;
            case 'png':
                 $source = imageCreateFromPng($filename);
                    imagecolortransparent($thumb, imagecolorallocatealpha($thumb, 0, 0, 0, 127));
                    imagealphablending($thumb, false);
                    imagesavealpha($thumb, true);
            break;
            case 'gif':
                    imagecolortransparent($thumb, imagecolorallocatealpha($thumb, 0, 0, 0, 127));
                    imagealphablending($thumb, false);
                    imagesavealpha($thumb, true);
                 $source = imageCreateFromGif($filename);
            break;
        }
        if ($thumbnail !="false") {
            $filename = $thumbnail;
        }
        imagecopyresampled($thumb, $source, 0, 0, 0, 0, $newwidth, $newheight, $width, $height);
        switch ($extension) {
            case 'jpg':
                $im=  imagejpeg($thumb,$filename);
                 imagedestroy($thumb);
            break;
            case 'jpeg':
                 $im=  imagejpeg($thumb,$filename);
                 imagedestroy($thumb);
            break;
            case 'png':
                 $im=  imagepng($thumb,$filename);
                 imagedestroy($thumb);
            break;
            case 'gif':
                $im= imagegif($thumb,$filename);
                imagedestroy($thumb);
            break;
        }
        return $im;
    }

    public function random_text() {
        $letters = 'abcefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890';
        return str_shuffle($letters);
    }


}//end fungsi