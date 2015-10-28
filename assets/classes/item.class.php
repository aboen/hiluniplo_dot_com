<?php

require_once('dbHandler.class.php');


/**
 * Updated - Oct 13, 2013
 * The invoice Class handles the CRUD functions for invoices
 */
class item
{

    /**
     * Function allows you to get all invoices from the database
     * @return array
     */

    public function getItems()
    {
        $dbConn = new DBConnection();
        $i = new dbHandler($dbConn, 'items');

        $sql = "select id as itemId, itemCode, itemName,  itemDesc, itemPrice, satuan, itemSize from items order by id desc Limit 100  ";
        $items = $i->getBySQL($sql);
        return $items;
    }
    public function searchItems($search)
    {
        $dbConn = new DBConnection();
        $i = new dbHandler($dbConn, 'items');

        $sql = "select id as itemId, itemCode, itemName,  itemDesc, itemPrice, satuan, itemSize from items WHERE itemName like '%".$search."%' ";
        $items = $i->getBySQL($sql);
        return $items;
    }

    /**
     * Get invoice details from the database based on invoice Id passed
     * @param $id
     * @return array
     */

    public function getItemDetails($id)
    {
        $dbConn = new DBConnection();
        $i = new dbHandler($dbConn, 'items');

        $sql = "select id as itemId, itemCode, itemName,  itemDesc, itemPrice, satuan, itemSize from items  where id = " . $id . " limit 1;";

        $details = $i->getBySQL($sql);
        return $details;
    }

    /**
     * Get invoice items from database based on invoice Id passed
     * @param $id
     * @param $rawData - Should we use the html markup or just pass back the raw data
     * @return string
     */
/**
    public function getInvItems($id)
    {

        $dbConn = new DBConnection();
        $i = new dbHandler($dbConn, 'inv_items');

        $sql = "select ii.itemId, ii.qty, inv.itemCode, inv.itemDesc, inv.itemPrice, round(sum((inv.itemPrice * ii.qty)), 2) as lineTotal from inv_items as ii join inventory as inv on inv.id = ii.itemId where ii.invId = " . $id . " group by ii.id";

        $items = $i->getBySQL($sql);

        return $items;

    }
*/
    /**
     * Save or Update invoice this is based on setting the $_POST var update to TRUE or FALSE.
     * @param array $_POST - Form data being submitted
     * @return mixed
     */

    public function saveItem(array $post)
    {
        $dbConn = new DBConnection();
        $details = new dbHandler($dbConn, 'items');

        // Set post date whether we are updating or inserting
       // $post['date'] = date('Y-m-d');

        if ($_POST['update'] == 'true') {

            // If we are updating we have to delete the quote items
            $items = new dbHandler($dbConn, 'items');
            //$items->deleteWhere('where id=' . $post['itemId']);
            //trim space
            function trim_value(&$value) 
            { 
                $value = trim($value); 
            }

            array_walk($post, 'trim_value');
            // Update invoice details
            $details->updateDatabaseWhere($post, 'where id=' . $post['itemId']);
            // This is used for the inserting of the items we have on the invoice
            $itemId = $post['itemId'];

        } else {
 //           var_export ($post);
// komentar
        //    $itemId = $details->insertIntoDatabase($post);
                       
            
        

        // Iterate over the items on the invoice and insert them into the database
  //      foreach ($_POST['itemId'] as $row => $item) {

            // Build a new array so we can insert them into the database
        //"KodeBarang", "NamaBarang", "DiskripsiBarang", "HargaBarang", "DiscBarang"
            $postArray = array(
                'itemCode' => trim($_POST['itemCode']),
                'itemName' => trim($_POST['itemName']),
                'itemDesc' => trim($_POST['itemDesc']),
                'itemPrice' => trim($_POST['itemPrice']),
                'itemSize' => trim($_POST['itemSize']),
                'satuan' => trim($_POST['satuan'])
            );

            $items = new dbHandler($dbConn, 'items');
            
            // Update invoice details
            $items->insertIntoDatabase($postArray);

  //      }
        }
        return $itemId;

    }

    /**
     * Delete invoice details and items
     * @param $id
     */
    
    public function deleteItem($id)
    {

        $dbConn = new DBConnection();
        //$i = new dbHandler($dbConn, 'inv_details');
        $ii = new dbHandler($dbConn, 'items');

       // $i->deleteWhere('where id = ' . $id);
        $ii->deleteWhere('where Id = ' . $id);

    }

//Perusahaan
        public function perusahaan()
    {
        $dbConn = new DBConnection();
        $i = new dbHandler($dbConn, 'perusahaan');

        $sql = "select id, Nama, Alamat, Kota, Telp, Email, Note from perusahaan ";
        $perusahaan = $i->getBySQL($sql);
        return $perusahaan;
    }
//Save Perusahaan    
   public function updatePerusahaan(array $post)
    {
        $dbConn = new DBConnection();
        $perusahaan = new dbHandler($dbConn, 'perusahaan');
        $perusahaan->updateDatabaseWhere($post, 'where id=' . $post['id']);

    }
    /**
     * Generates a sequential number for our invoices by getting the most recent invoice number in the database and adding 1 to it
     * @return string
     */



}