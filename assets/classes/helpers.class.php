<?php

class helpers
{

    /**
     * Redirect to the path passed.
     * @param null $location - The location of the
     */
    public function redirect_to($location = NULL)
    {
        if ($location != NULL) {
            header("Location: {$location}");
            exit;
        }
    }

    /**
     * Set message in session
     * @param $type
     * @param $message
     */
    public function setAlert($type, $message)
    {
        $_SESSION['alertMessage'] = '<div class="alertMessage"><span><div class="alert ' . $type . '">' . $message . '</div></span></div>';
    }

    /**
     * Print alert in session
     * @return mixed
     */
    public function printAlert()
    {
        return $_SESSION['alertMessage'];
    }

    /**
     * Unset alert in session
     */
    public function unsetAlert()
    {
        unset($_SESSION['alertMessage']);
    }

    /**
     * Clean way to view array data
     * @param array $arr
     */
    public function printArray($arr)
    {
        echo '<pre>', print_r($arr, 1), '</pre>';
    }

    public function validateInput($postValues, $os)
    {
        foreach ($postValues as $k => $v) {
            if (in_array($k, $os)) {
                foreach ( (array) $v as $x) {
                    if ($x == null) {
                        return true;
                    } else {
                        return false;
                    }
                }
            }
        }
    }

    public function trim_value(&$value) 
    { 
        $value = trim($value); 
        return $value;
    }

}
