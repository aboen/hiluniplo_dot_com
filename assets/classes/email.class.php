<?php

class sendEmail{

    var $to;
    var $bcc;
    var $fromName;
    var $from;
    var $subject;
    var $body;
    var $headers;

    /**
     * Set To email address
     * @param $toEmail
     * @return mixed
     */
    public function setToEmail($toEmail) {
        return $this->to = $toEmail;
    }

    /**
     * Set Bcc email address
     * @param $toBcc
     * @return mixed
     */
    public function setBcc($toBcc) {
        return $this->bcc = $toBcc;
    }

    /**
     * Set From Name
     * @param $thisName
     * @return mixed
     */
    public function setFromName($thisName) {
        return $this->fromName = $thisName;
    }

    /**
     * Set From Email address
     * @param $fromEmail
     * @return mixed
     */
    public function setFromEmail($fromEmail) {
        return $this->from = $fromEmail;
    }

    /**
     * Set email subject
     * @param $emailSubject
     * @return mixed
     */
    public function setEmailSubject($emailSubject) {
        return $this->subject = $emailSubject;
    }

    /**
     * Set email body (HTML or Text)
     * @param $emailBody
     * @return mixed
     */
    public function setEmailBody($emailBody) {
        return $this->body = $emailBody;
    }

    /**
     * Send email based on set values
     */
    public function send(){
        $this->headers .= 'From: '.$this->from.' <'.$this->fromName.'> ' . "\r\n";
		$this->headers .= 'Reply-To: '.$this->from.' ' . "\r\n";
        // $this->headers .= 'BCC: '.$this->bcc.' ' . "\r\n";
        $this->headers  = 'MIME-Version: 1.0 ' . "\r\n";
        $this->headers .= 'Content-type: text/html; charset=iso-8859-1 ' . "\r\n";
        mail( $this->to, $this->subject, $this->body, $this->headers );
    }



}