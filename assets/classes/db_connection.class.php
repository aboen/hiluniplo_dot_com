<?php

/**
 * Class DBConnection handles connection to database and querying
 */

class DBConnection
{
    protected $mysqli;

    /*
     * Set to your db connection info
     */
    private $db_host = DB_HOST; 
    private $db_name = DB_NAME;
    private $db_username = DB_USER;
    private $db_password = DB_PASSWORD;

    public function __construct()
    {
        $this->mysqli = new mysqli($this->db_host, $this->db_username,
            $this->db_password, $this->db_name) or die($this->mysqli->error);

        return $this->mysqli;
    }

    /**
     * Get local query
     * @param $query
     * @return bool|mysqli_result
     */
    public function query($query)
    {
        return $this->mysqli->query($query);
    }

    /**
     * @return mysqli
     */
    public function getLink()
    {
        return $this->mysqli;
    }

    /**
     * Clear db connection
     */
    function __destruct()
    {
        //Close the Connection
        $this->mysqli->close();
    }
}