<?php

require_once('dbHandler.class.php');
require_once('email.class.php');

/**
 * Updated - Oct 13, 2013
 * The invoice Class handles the CRUD functions for invoices
 */
class invoice
{

    /**
     * Function allows you to get all invoices from the database
     * @return array
     */

    public function getInvoices($waktu='')
    {
        $dbConn = new DBConnection();
        $i = new dbHandler($dbConn, 'inv_details');
        
        $sql = "select invDetails.id as invId, invDetails.number, invDetails.clientName, invDetails.date, 
        round(sum(inv.itemPrice * ii.qty ) - (inv.itemPrice * ii.qty * ii.itemDisc * 0.01),2) as subTotal, 
        round((inv.itemPrice * ii.qty * ii.itemDisc * 0.01 * invDetails.tax * 0.01), 2) as salesTaxTotal 
        from inv_items as ii join items as inv on inv.id = ii.itemId join inv_details as invDetails on invDetails.id = ii.invId ". $waktu ." group by invDetails.id ORDER BY invDetails.clientName ASC, lpad(invDetails.number, 20, 0) ";

        $invoices = $i->getBySQL($sql);
        return $invoices;
  
    }

    /**
     * Get invoice details from the database based on invoice Id passed
     * @param $id
     * @return array
     */

    public function getInvDetails($id)
    {
        $dbConn = new DBConnection();
        $i = new dbHandler($dbConn, 'inv_details');

        $sql = "select invDetails.id, invDetails.number, invDetails.tax, invDetails.date, invDetails.clientName, invDetails.clientAddress, invDetails.clientPostal, invDetails.clientCompany, invDetails.clientPhone, ii.poNumber, 
round(sum((inv.itemPrice * ii.qty) - (inv.itemPrice * ii.qty * ii.itemDisc * 0.01)), 2) as subTotal, 
round(sum((inv.itemPrice * ii.qty  * ii.itemDisc * 0.01) * (invDetails.tax * 0.01)), 2) as salesTaxTotal from inv_items as ii join items as inv on inv.id = ii.itemId join inv_details as invDetails on invDetails.id = ii.invId where ii.invId = " . $id . " group by invDetails.id";

        $details = $i->getBySQL($sql);
        return $details;
    }

/* get invoice group by Client name 
*
*
*/
public function rekapInvDetails($bulan)
    {
        $dbConn = new DBConnection();
        $i = new dbHandler($dbConn, 'inv_details');

        $sql = "select invDetails.id as invId, invDetails.number, count(invDetails.clientName) as jmlItem,  invDetails.tax, invDetails.date, invDetails.clientName, invDetails.clientAddress, invDetails.clientPostal, invDetails.clientCompany,invDetails.clientPhone, ii.poNumber, ii.itemDisc, ii.itemUkuran,  inv.itemName, inv.itemPrice, inv.satuan, inv.itemSize,ii.qty, 
        round(sum((inv.itemPrice * ii.qty)  - (inv.itemPrice * ii.qty  * ii.itemDisc * 0.01)) , 2) as subTotal, 
round(sum((inv.itemPrice * ii.qty * ii.itemDisc * 0.01) * (invDetails.tax * 0.01)), 2) as salesTaxTotal,
(round(sum((inv.itemPrice * ii.qty) - (inv.itemPrice * ii.qty  * ii.itemDisc * 0.01)) , 2) + round(sum((inv.itemPrice * ii.qty) -( (inv.itemPrice * ii.qty * ii.itemDisc * 0.01) * (invDetails.tax * 0.01))), 2)) as totalInvoice from inv_items as ii join items as inv on inv.id = ii.itemId join inv_details as invDetails on invDetails.id = ii.invId WHERE  " . $bulan . " ";
        $rekapdetails = $i->getBySQLrekap($sql);
        return $rekapdetails;
 
}

public function viewInvDetails($bulan)
    {
        $dbConn = new DBConnection();
        $i = new dbHandler($dbConn, 'rekinv');

        $sql = "select invId,number,tax,date,clientName,clientAddress,clientPostal,clientCompany,clientPhone, poNumber,itemDisc,itemUkuran,itemsid, itemName, itemPrice, satuan,itemUkuran, itemSize, qty, lineTotal, lineTotal as subTotal from  rekinv " . $bulan ." " ;
        $rekapdetails = $i->getBySQLrekap($sql);
        return $rekapdetails;
 
}
public function viewInvtotal($bulan)
    {
        $dbConn = new DBConnection();
        $i = new dbHandler($dbConn, 'rekinv');

        //$sql =  $bulan ;
        $rekapdetails = $i->getBySQLrekap($bulan);
        return $rekapdetails;
 
}
public function yearInvDetails()
    {
        $dbConn = new DBConnection();
        $i = new dbHandler($dbConn, 'inv_details');
        $sql = "SELECT YEAR(date) as Year  FROM `inv_details` group by YEAR(date)";
        $yeardetails = $i->getBySQLrekap($sql);
        return $yeardetails;
     }   

/*Tampilkan  nama client
*/
   public function getClient($tabelclient)
    {
        $dbConn = new DBConnection();
        $i = new dbHandler($dbConn, $tabelclient);
        
        $sql = "select id , clientName, clientAddress, clientPostal, clientCompany, clientPhone, clientEmail from " .$tabelclient. "  group by clientName ASC";
        $cl = $i->getBySQL($sql);
        return $cl;
    }
/* Seting Toko

*/
public function toko()
    {
        $dbConn = new DBConnection();
        $i = new dbHandler($dbConn, 'perusahaan');
        $sql = "select * from perusahaan ";
        $toko = $i->getBySQL($sql);
        return $toko;
}
/* Get query data from sql
*/
public function getData($tabel,$coloum,$kondisi)
    {
        $dbConn = new DBConnection();
        if (!isset($coloum)) {$coloum= "*";}
        if (!isset($kondisi)) {$kondisi= " ";} 
        $i = new dbHandler($dbConn, $tabel);
        $sql = "select ".$coloum." from ".$tabel . $kondisi;
        $data = $i->getBySQL($sql);
        return $data;
}
//quick update data
public function updateData($tabel,$set,$kondisi)
    {
        $dbConn = new DBConnection();
        $i = new dbHandler($dbConn, $tabel);
        $sql = "UPDATE ". $tabel ." set ". $set ." ". $kondisi;
        $data = $i->updateDbQuick($sql);
       // $this->mysqli->query($sql);
        //return $data;
}

/* save or update data 
*
*/
   public function saveData($tabel, array $post)
    {
        $dbConn = new DBConnection();
        $details = new dbHandler($dbConn, $tabel);

        // Set post date whether we are updating or inserting
        //$post['date'] = date('Y-m-d');

        if ($_POST['update'] == 'true') {
            //trim space
            function trim_value(&$value) 
            { 
                $value = trim($value); 
            }
            array_walk($post, 'trim_value');
            
            $details->updateDatabaseWhere($post, 'where id=' . $post['userId']);


        } else {
            //trim space
            function trim_value(&$value) 
            { 
                $value = trim($value); 
            }
            array_walk($post, 'trim_value');

            $userId = $details->insertIntoDatabase($post);
        }

    }

/* Delete data
*/
    public function deleteData($tabel,$id)
    {

        $dbConn = new DBConnection();
        $i = new dbHandler($dbConn, $tabel);  
        $i->deleteWhere('where id = ' . $id);
     
    }

    /**
     * Get invoice items from database based on invoice Id passed
     * @param $id
     * @param $rawData - Should we use the html markup or just pass back the raw data
     * @return string 
     */

    public function getInvItems($id)
    {

        $dbConn = new DBConnection();
        $i = new dbHandler($dbConn, 'inv_items');

        $sql = "select ii.itemId, ii.qty, ii.poNumber, ii.itemDisc, ii.itemUkuran, inv.itemCode, inv.itemName, inv.itemDesc, inv.itemPrice, inv.satuan, inv.itemSize, round(sum((inv.itemPrice * ii.qty ) - (inv.itemPrice * ii.qty  * ii.itemDisc * 0.01) ), 2) as lineTotal  from inv_items as ii join items as inv on inv.id = ii.itemId where ii.invId = " . $id . " group by ii.id";

        $items = $i->getBySQL($sql);

        return $items;

    }

    /**
     * Save or Update invoice this is based on setting the $_POST var update to TRUE or FALSE.
     * @param array $_POST - Form data being submitted
     * @return mixed
     */

    public function saveInv(array $post)
    {
        $dbConn = new DBConnection();
        $details = new dbHandler($dbConn, 'inv_details');

       
        

        if ($_POST['update'] == 'true') {
            // Set post date whether we are  inserting or updaeting
            //$post['date'] = date('Y-m-d');
            // If we are updating we have to delete the quote items
           $items = new dbHandler($dbConn, 'inv_items');
            $items->deleteWhere('where invId=' . $post['invId']);
                       //trim space
            function trim_value(&$value) 
            { 
                $value = trim($value); 
            }
            array_walk($post, 'trim_value');
            
            // Update invoice details
            $details->updateDatabaseWhere($post, 'where id=' . $post['invId']);
            // This is used for the inserting of the items we have on the invoice
            $invId = $post['invId'];

        } else {
             // Set post date whether we are  inserting
            $post['date'] = date('Y-m-d');
                        //trim space
            function trim_value(&$value) 
            { 
                $value = trim($value); 
            }
            array_walk($post, 'trim_value');

            //save invoice detail
            $invId = $details->insertIntoDatabase($post);
        }

        // Iterate over the items on the invoice and insert them into the database
        foreach ($_POST['itemId'] as $row => $item) {

            // Build a new array so we can insert them into the database
            $postArray = array(
                'invId' => $invId,
                'itemId' => $_POST['itemId'][$row],
                'qty' => $_POST['itemQty'][$row],
                'poNumber' => $_POST['noPo'][$row],
                'itemDisc' => $_POST['itemDisc'][$row],
                'itemUkuran' => $_POST['itemUkuran'][$row]
            );

            $items = new dbHandler($dbConn, 'inv_items');
            $items->insertIntoDatabase($postArray);

        }

        return $invId;

    }

    /**
     * Delete invoice details and items
     * @param $id
     */
    public function deleteInvoice($id)
    {

        $dbConn = new DBConnection();
        $i = new dbHandler($dbConn, 'inv_details');
        $ii = new dbHandler($dbConn, 'inv_items');

        $i->deleteWhere('where id = ' . $id);
        $ii->deleteWhere('where invId = ' . $id);

    }

    /**
     * Generates a sequential number for our invoices by getting the most recent invoice number in the database and adding 1 to it
     * @return string
     */

    public function generateInvNumber()
    {

        $dbConn = new DBConnection();
        $i = new dbHandler($dbConn, 'inv_details');

        $iNumber = $i->getResultsWhere('order by number DESC LIMIT 0, 1 ');
        $pecahInv = explode("/",$iNumber[0]->number);
        $thsekarang = date('Y');
        $thInv = $pecahInv[3];
        // Get current invoice number so we can add one to it.
        // Do we have an invoice number to add 1 to?  If not we are going to start at 0001
        if ((isset($iNumber[0]->number) != null) OR ($thsekarang != $thInv) )  {
            // Add one to the invoice number if exists
            $newNumber = $pecahInv[0] + 1;
        } else {
            
            $newNumber = '1';
        }

        return $newNumber;

    }

    // decimal to word function
    //USAGE :
    //echo convert_number_to_words(123456789);
    // one hundred and twenty-three million, four hundred and fifty-six thousand, seven hundred and eighty-nine

    function convert_number_to_words($number) {
    
    $hyphen      = '-';
    $conjunction = ' and ';
    $separator   = ', ';
    $negative    = 'negative ';
    $decimal     = ' point ';
    $dictionary  = array(
        0                   => 'zero',
        1                   => 'satu',
        2                   => 'dua',
        3                   => 'tiga',
        4                   => 'empat',
        5                   => 'lima',
        6                   => 'enam',
        7                   => 'tujuh',
        8                   => 'delapan',
        9                   => 'sembilan',
        10                  => 'sepuluh',
        11                  => 'sebelas',
        12                  => 'dua belas',
        13                  => 'tiga belas',
        14                  => 'empat belas',
        15                  => 'lima belas',
        16                  => 'enam belas',
        17                  => 'tujuh belas',
        18                  => 'delapan belas',
        19                  => 'sembilan belas',
        20                  => 'dua puluh',
        30                  => 'tiga puluh',
        40                  => 'empat puluh',
        50                  => 'lima puluh',
        60                  => 'enam puluh',
        70                  => 'tujuh puluh',
        80                  => 'delapan puluh',
        90                  => 'sembilan puluh',
        100                 => 'seratus',
        1000                => 'seribu',
        1000000             => 'satu juta',
        1000000000          => 'milyar',
        1000000000000       => 'trilyun',
        1000000000000000    => 'quadrillion',
        1000000000000000000 => 'quintillion'
    );
    
    if (!is_numeric($number)) {
        return false;
    }
    
    if (($number >= 0 && (int) $number < 0) || (int) $number < 0 - PHP_INT_MAX) {
        // overflow
        trigger_error(
            'convert_number_to_words only accepts numbers between -' . PHP_INT_MAX . ' and ' . PHP_INT_MAX,
            E_USER_WARNING
        );
        return false;
    }

    if ($number < 0) {
        return $negative . convert_number_to_words(abs($number));
    }
    
    $string = $fraction = null;
    
    if (strpos($number, '.') !== false) {
        list($number, $fraction) = explode('.', $number);
    }
    
    switch (true) {
        case $number < 21:
            $string = $dictionary[$number];
            break;
        case $number < 100:
            $tens   = ((int) ($number / 10)) * 10;
            $units  = $number % 10;
            $string = $dictionary[$tens];
            if ($units) {
                $string .= $hyphen . $dictionary[$units];
            }
            break;
        case $number < 1000:
            $hundreds  = $number / 100;
            $remainder = $number % 100;
            $string = $dictionary[$hundreds] . ' ' . $dictionary[100];
            if ($remainder) {
                $string .= $conjunction . convert_number_to_words($remainder);
            }
            break;
        default:
            $baseUnit = pow(1000, floor(log($number, 1000)));
            $numBaseUnits = (int) ($number / $baseUnit);
            $remainder = $number % $baseUnit;
            $string = convert_number_to_words($numBaseUnits) . ' ' . $dictionary[$baseUnit];
            if ($remainder) {
                $string .= $remainder < 100 ? $conjunction : $separator;
                $string .= convert_number_to_words($remainder);
            }
            break;
    }
    
    if (null !== $fraction && is_numeric($fraction)) {
        $string .= $decimal;
        $words = array();
        foreach (str_split((string) $fraction) as $number) {
            $words[] = $dictionary[$number];
        }
        $string .= implode(' ', $words);
    }
    
    return $string;
    }

}