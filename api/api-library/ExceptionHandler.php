<?php
class ExceptionHandler{
    
	public function __construct() {
		@set_exception_handler(array($this, 'exception_handler'));
	}

	public function exception_handler($e) {
        $httpStatusCodes = array(
            100 => '100 Continue',
            101 => '101 Switching Protocols',
            200 => '200 OK',
            201 => '201 Created',
            202 => '202 Accepted',
            204 => '204 No Content',
            301 => '301 Moved Permanently',
            302 => '302 Found',
            304 => '304 Not Modified',
            400 => '400 Bad Request',
            401 => '401 Unauthorized',
            403 => '403 Forbidden',
            404 => '404 Not Found',
            405 => '405 Method Not Allowed',
            409 => '409 Conflict',
            429 => '429 Too Many Requests',
            500 => '500 Internal Server Error',
            502 => '502 Bad Gateway',
            503 => '503 Service Unavailable',
            504 => '504 Gateway Timeout'
        );

		$error = array("ERR" => $e->getMessage(), "CODE" => $e->getCode());
        header($_SERVER["SERVER_PROTOCOL"] . " " . ($httpStatusCodes[$e->getCode()]));
		echo json_encode($error);

		$message = json_encode(array_merge($error, array("FILE" => $e->getFile(), "LINE" => $e->getLine())));
		$ip = $_SERVER['REMOTE_ADDR'];
        if ($ip == ''){
            $ip = 'localhost';
        }
        $message = gmdate("Y-M-d H:i:s")." ".$ip." ".$_SERVER["SCRIPT_NAME"]." ".$message."\n";
        error_log ($message, 3, LOGS_DIRECTORY.'errors.'.gmdate('Ym').'.log');
        if (strpos($message, "MYSQL"))
        {

            $message = str_replace ('\n', '' , $message);
            error_log ($message, 3, LOGS_DIRECTORY.'sql.'.gmdate('Ym').'.log');
        }
	}
}

new ExceptionHandler();
?>