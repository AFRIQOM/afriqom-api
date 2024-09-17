<?php
	/**
	 * @author Xose Ahlijah
	 * @version 2.0
	 **/

	include("api-library/GibberishAES.php");
	include("API.php");

	error_reporting(E_ERROR | E_PARSE);
	
	$SET_REST_MODE = (API_LOCAL_MODE === TRUE) ? FALSE : TRUE;
	define('REST_MODE', $SET_REST_MODE);

	// Allow from any origin
	if (isset($_SERVER['HTTP_ORIGIN'])) {
	    header("Access-Control-Allow-Origin: {$_SERVER['HTTP_ORIGIN']}");
	    header('Access-Control-Allow-Credentials: true');
	    header('Access-Control-Max-Age: 86400');    // cache for 1 day
	}

	// Access-Control headers are received during OPTIONS requests
	if ($_SERVER['REQUEST_METHOD'] == 'OPTIONS') {

	    if (isset($_SERVER['HTTP_ACCESS_CONTROL_REQUEST_METHOD']))
	        header("Access-Control-Allow-Methods: GET, POST, OPTIONS");

	    if (isset($_SERVER['HTTP_ACCESS_CONTROL_REQUEST_HEADERS']))
	        header("Access-Control-Allow-Headers: {$_SERVER['HTTP_ACCESS_CONTROL_REQUEST_HEADERS']}");

	    exit(0);
	}

	if (isset($HTTP_RAW_POST_DATA)) {
		if(REST_DATA_ENCRYPTION === TRUE){
			parse_str($HTTP_RAW_POST_DATA, $postData);
			$_POST = $postData;
		}else{
    	$_POST = json_decode($HTTP_RAW_POST_DATA, true);
		}
	}

	if(sizeof($_POST) == 0){
		$input = file_get_contents("php://input");
		if($input){    
	    $_POST = json_decode($input, true);    
		}
	}

	$ecryptionPassword = "";
	if(REST_DATA_ENCRYPTION === TRUE){
		
		GibberishAES::size(256);    // Also 192, 128
		$ecryptionPassword = GibberishAES::dec($_GET['token'], $_GET['data']);
		$_GET['token'] = $ecryptionPassword;
		
		if(isset($_GET['data'])){
			$decryptedSecretString = GibberishAES::dec($_GET['data'], $ecryptionPassword);
			if($decryptedSecretString !== false){
				parse_str($decryptedSecretString, $queryParams);
				$decryptedSecretString = $queryParams;
				$_GET = array_merge($queryParams, $_GET);
				unset($_GET['data']);
			}
			else{
				throw new Exception('Invalid encryption key for POST. API terminated.', 500);
			}
		}

		if(isset($_POST['data'])){
			$decryptedSecretString = GibberishAES::dec($_POST['data'], $ecryptionPassword);
			if($decryptedSecretString !== false){
				$_POST = array_merge(json_decode($decryptedSecretString, true), $_POST);
				unset($_POST['data']);
			}
			else{
				throw new Exception('Invalid encryption key for POST. API terminated.', 500);
			}
		}
	}

	// file_put_contents(LOGS_DIRECTORY."_debug.log", json_encode($_GET)."|".json_encode($_POST)."\n", FILE_APPEND);
	
	if(isset($_FILES)){
		$response = API::processRequest($_GET, $_POST, $_FILES);
	}
	else{
		$response = API::processRequest($_GET, $_POST);
	}

	
	header($_SERVER["SERVER_PROTOCOL"] . " 200 Success");
	$_GET['fmt'] = (isset($_GET['fmt'])?$_GET['fmt']:'json');
	$response = is_array($response) ? $response : array();
	Utils::export2($_GET['fmt'], $response, $ecryptionPassword, REST_DATA_ENCRYPTION);
?>
