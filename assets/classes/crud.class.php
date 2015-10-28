<?php

require_once('dbHandler.class.php');
//require_once('email.class.php');

/**
 * Apr 2015
 * The crud Class handles the CRUD functions 
 */
class laksanakan
{

    /**
     * fungsi untuk ambil data dari database
     * @return array hasil query
     */

    public function ambil($tdbase,$ndbase,$detailquery="")
    {
        $dbConn = new DBConnection();
        $i = new dbHandler($dbConn, $ndbase);

        $sql = "SELECT ".$tdbase." FROM ".$ndbase." ".$detailquery;
        $hasil = $i->getBySQL($sql);
        return $hasil;
    }

    /**
     * ambil data dari database berdasarkan where
     * @param $ndbase,$tdbase,$wheres
     * @return array
     */

    public function ambilDetail($tdbase,$ndbase,$wheres)
    {
        $dbConn = new DBConnection();
        $i = new dbHandler($dbConn, $ndbase);

        $sql = "SELECT ".$tdbase." FROM ".$ndbase."  WHERE " . $wheres ." " ;

        $details = $i->getBySQL($sql);
        return $details;
    }

    /**
     * Update database berdasarkan id
     * @param $ndbase=namadb,$tdbase=namatable,$wheres=berdasarkan id
     * @return array
     */
    public function updateDB($tdbase,$ndbase,$wheres)
    {
        $dbConn = new DBConnection();
        $i = new dbHandler($dbConn, $ndbase);
        $sql = "UPDATE ".$ndbase ." SET ".$tdbase . " WHERE " .$wheres;
        $details = $i->updateDbQuick($sql);
        $this->logging($ndbase,$sql,"UPDATE");
        return $details;
    }
    /**
     * Simpan atau Update berdasarkan  setting pada variabel $_POST  update to TRUE or FALSE.
     * @param array $_POST - Form data yang dimasukan
     * @return mixed
     */

    public function simpan(array $post,$ndbase)
    {
        $dbConn = new DBConnection();
        $details = new dbHandler($dbConn, $ndbase);

        //Set post date whether we are updating or inserting
        //$post['date'] = date('Y-m-d');

        if ($_POST['update'] == 'true') {

            // If we are updating we have to delete the quote items
            $simpan = new dbHandler($dbConn, $ndbase);
           // $items->deleteWhere('where id=' . $post['Id']);

            // Update invoice details
            $details->updateDatabaseWhere($post, 'WHERE id=' . $post['editid']);
            // This is used for the inserting of the items we have on the invoice
           // $Id = $post['Id'];
            //simpan log update
            $gabungarayval = implode("', '", $post);
            $gabungaraykey = implode("', '", array_keys($post));
            $sql = "key(".$gabungaraykey.") val(".$gabungarayval.") WHERE id = ".$post['editid'];
            $this->logging($ndbase,$sql,"UPDATE");

        } else {

            $items = new dbHandler($dbConn,  $ndbase);
            $items->insertIntoDatabase($post);

        }

        //return $Id;

    }

    /**
     * Delete invoice details and items
     * @param $id
     */
    
    public function delete($ndbase,$id)
    {

        $dbConn = new DBConnection();
        //$i = new dbHandler($dbConn, 'inv_details');
        $i = new dbHandler($dbConn, $ndbase);

       // $i->deleteWhere('where id = ' . $id);
        $i->deleteWhere('WHERE ' . $id);
        $sql = "DELETE  FROM ".$ndbase. " WHERE ". $id;
        $this->logging($ndbase,$sql,"DELETE");

    }

    public function logging($ndbase,$idtable,$statuss) {
        $dbConn = new DBConnection();
        $logging = new dbHandler($dbConn, "loging");
        if (!isset($_SESSION['ID'])){
            $session = "none";
        } else {
            $session = $_SESSION['ID'];
        }

        $inputdata = array (
                    'namatabel' => $ndbase,
                    'iduser' => $session,
                    'tanggal' => date("Y-m-d H:i:s"),
                    'logtabel' => $idtable,
                    'statuss' => $statuss
                );
            //set update=false
            //$_POST['update'] = 'false';
            //simpan data user ke db
            $logging->insertIntoDatabase($inputdata);
    }


}