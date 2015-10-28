<?php

/**
 * Class dbHandler handles most database CRUD functions.
 * Simplifying the insert and updating by matching field inputs with the column names in the
 * table you are working with.
 */

require_once('db_connection.class.php');

class dbHandler
{

    var $sqlString;
    var $table;
    var $setTerm;
    var $set;
    var $columns;

    public function __construct(DBConnection $db, $table)
    {
        $this->mysqli = $db->getLink();
        $this->table = $table;
        $this->initColumns($table);
    }

    public function setQuery($sql)
    {
        return $this->sqlString = $sql;
    }


    /**
     * initColumns
     * Gathers and sets the array of columns for the class
     * @param  string $tablename Tablename passed into the call
     * @return void
     */

    /** */

    function initColumns()
    {
        unset($this->columns);

        $result = $this->mysqli->query("DESCRIBE $this->table");
        while ($row = $result->fetch_object()) {
              $this->columns[$row->Field] = $row->Type;
        }
    }

    /**
     * @param $term - Value to search for
     * @param $where - Column to search on
     * @param $limit - Limit the number of returned data
     * @return array
     */

    public function getResultsByTerm($term, $where, $limit)
    {

        $term = $this->mysqli->real_escape_string($term);
        $where = $this->mysqli->real_escape_string($where);

        $query = "SELECT * FROM $this->table WHERE " . $where . " LIKE '%" . $term . "%' LIMIT " . $limit;

        $result = $this->mysqli->query($query) or die("SQL Error: " . $this->mysqli->error . __LINE__);

        $function_result = array();
        $i = 0;
        while ($row = $result->fetch_object()) {
            $function_result[$i] = $row;
            $i++;
        }

        $return_results = $this->stripslashesFull($function_result);

        return $return_results;

    }

    /**
     * @param $where - Syntax ('where column = value')
     * @return array
     */

    public function getResultsWhere($where)
    {

        $where = $this->mysqli->real_escape_string($where);

        $query = "SELECT * FROM $this->table " . $where . " ";

        $result = $this->mysqli->query($query) or die("SQL Error: " . $this->mysqli->error . __LINE__);

        $function_result = array();
        $i = 0;

        while ($row = $result->fetch_object()) {

            $function_result[$i] = $row;
            $i++;

        }

        $return_results = $this->stripslashesFull($function_result);

        return $return_results;

    }

    /**
     * Get all data from table
     * @return array
     */

    public function getAllResults()
    {

        $query = "SELECT * FROM $this->table ";

        $result = $this->mysqli->query($query) or die("SQL Error: " . $this->mysqli->error . __LINE__);

        $function_result = array();
        $i = 0;
        while ($row = $result->fetch_object()) {
            $function_result[$i] = $row;
            $i++;
        }

        $return_results = $this->stripslashesFull($function_result);

        return $return_results;

    }

    /**
     * Get by passed SQL statement and return values
     * @param $sql - Standard SQL pattern
     * @return array
     */
    public function getBySQL($sql)
    {

        //$thisSql = $this->mysqli->real_escape_string($sql);
        $thisSql = $sql;
        $result = $this->mysqli->query($thisSql) or die("SQL Error: " . $this->mysqli->error . __LINE__);

        $function_result = array();
        $i = 0;
        while ($row = $result->fetch_object()) {
            $function_result[$i] = $row;
            $i++;
        }

        $return_results = $this->stripslashesFull($function_result);

        return $return_results;

    }
//rekap invoice
  public function getBySQLrekap($sql)
    {

        //$thisSql = $this->mysqli->real_escape_string($sql);
        $thisSql =$sql;
        $result = $this->mysqli->query($thisSql) or die("SQL Error: " . $this->mysqli->error . __LINE__);

        $function_result = array();
        $i = 0;
        while ($row = $result->fetch_object()) {
            $function_result[$i] = $row;
            $i++;
        }

        $return_results = $this->stripslashesFull($function_result);

        return $return_results;

    }

    /**
     * Insert data into table by passed SQL statement
     * @param $sql - Standard SQL pattern
     * @return bool|mysqli_result
     */

    public function insertBySQL($sql)
    {
        $thisSql = $this->mysqli->real_escape_string($sql);
        $result = $this->mysqli->query($thisSql) or die("SQL Error: " . $this->mysqli->error . __LINE__);

        return $result;
    }

    /**
     * @param $post
     * @return mixed
     */
    public function replaceIntoDatabase(array $post)
    {
        $query = "REPLACE INTO " . $this->table;
        $fis = array();
        $vas = array();

        foreach ($post as $field => $val) {
            $fis[] = $field; //you must verify keys of array outside of function;
            $vas[] = "'" . $this->mysqli->real_escape_string($val) . "'";
        }

        $query .= " (" . implode(", ", $fis) . ") VALUES (" . implode(", ", $vas) . ")";
        $result = $this->mysqli->query($query) or die("SQL Error: " . $this->mysqli->error . __LINE__);
        $lastInsertId = $this->mysqli->insert_id;

        return $lastInsertId;

    }

    /**
     * Insert data into table using passed $_POST form data.
     * @param array $post
     * @return mixed
     */
    public function insertIntoDatabase(array $post)
    {
        $query = "INSERT INTO $this->table ";

        $columnkeys = array_keys($this->columns);

        // look for key matches from args to table column and build set
        foreach ($post as $key => $val) {
            if (in_array($key, $columnkeys)) {
                $updateset[$key] = $val;
            }
        }
 //if (is_array($updateset)) {
 //   $updateset = '';
        foreach ((array) $updateset as $field => $val) {

            $this->set .= $field . " = '" . $this->mysqli->real_escape_string($val) . "',";
        }
//}

        // remove extra trailing comma
        $this->set = 'SET ' . substr($this->set, 0, -1) . ' ';

        $result = $this->mysqli->query($query . $this->set) or die("SQL Error: " . $this->mysqli->error . __LINE__);
        $insertId = $this->mysqli->insert_id;
        return $insertId;
    }


    /**
     * Update $_POST form data where passed where clause
     * @param $post
     * @param $where
     * @return bool|mysqli_result
     */
    public function updateDatabaseWhere($post, $where)
    {

        $thisWhere = $this->mysqli->real_escape_string($where);

        $query = "UPDATE $this->table ";

        $columnkeys = array_keys($this->columns);

        // look for key matches from args to table column and build set
        foreach ($post as $key => $val) {
            if (in_array($key, $columnkeys)) {
                $updateset[$key] = $val;
            }
        }

        foreach ($updateset as $field => $val) {
            $this->set .= $field . " = '" . $this->mysqli->real_escape_string($val) . "',";
        }


        // remove extra trailing comma
        $this->set = 'SET ' . substr($this->set, 0, -1) . ' ';

        $result = $this->mysqli->query($query . " " . $this->set . " " . $thisWhere) or die("SQL Error: " . $this->mysqli->error . __LINE__);

        return $result;
    }
//update quick
     public function updateDbQuick($sql)
    {

       // $sql = "UPDATE ".$tabel ." set ".$coloum . " WHERE " .$kondisi;

        $result = $this->mysqli->query($sql) or die("SQL Error: " . $this->mysqli->error . __LINE__);

        return $result;
    }
    /**
     * Delete where passed where clause
     * @param $where
     * @return bool|mysqli_result
     */
    public function deleteWhere($where)
    {

        $thisWhere = $this->mysqli->real_escape_string($where);
        $query = "DELETE FROM $this->table";
        $result = $this->mysqli->query($query . " " . $thisWhere) or die("SQL Error: " . $this->mysqli->error . __LINE__);

        return $result;

    }

    /**
     * Clean up data passed to this function.  Can be array or string
     * @param $input
     * @return array|object|string
     */
    private function stripslashesFull($input)
    {
        if (is_array($input)) {
            $input = array_map(array($this, 'stripslashesFull'), $input);
        } elseif (is_object($input)) {
            $vars = get_object_vars($input);
            foreach ($vars as $k => $v) {
                $input->{$k} = $this->stripslashesFull($v);
            }
        } else {
            $input = stripslashes($input);
        }
        return $input;
    }

    /**
    * mysql escape string
    */
   public function mysqlescape($escape)
    {
        $s = $this->mysqli->real_escape_string($escape);
        return "'$s'";
    }
}

