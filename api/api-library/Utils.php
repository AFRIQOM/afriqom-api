<?php
	$memcache = null;
	$GLOBALS['cacheEngineEnabled'] = false;
	if(defined('CACHE_ENGINE')){
		$GLOBALS['cacheEngineEnabled'] = true;
		switch (CACHE_ENGINE) {
			case CE_MEMCACHE:
				$memcache = new Memcache;
				$memcache->connect('127.0.0.1');
				$memcache->addServer('127.0.0.1');
			break;
			case CE_NONE:
				$GLOBALS['cacheEngineEnabled'] = false;
			break;
		}
	}

	class Utils{
		private static $MYSQL_RESOURCE;

		public static function createMySQLResource($key){
			global $databaseServer, $databaseUser, $databasePassword, $databaseName, $dbName, $databasePort;

			if(!isset($databaseServer[$key])){
				throw new Exception("Unknown database resource", 400);
			}

			$dbServer = $databaseServer[$key];
			$dbUser = $databaseUser[$key];
			$dbPassword = $databasePassword[$key];
			$dbName = $databaseName[$key];
			$dbPort = $databasePort[$key];

			switch (DATABASE_ENGINE) {
				case POSTGRESQL:
					$dbPort= (isset($databasePort[$key]))?$databasePort[$key]:5432; // check if to use default port
					$resource = pg_connect("host=".$dbServer." port=".$dbPort." dbname=".$dbName." user=".$dbUser." password=".$dbPassword);
					$error = pg_last_error();
					break;
				
				default:
					$resource = mysqli_connect($dbServer, $dbUser, $dbPassword, $dbName);
					$error = mysqli_error($resource);
					break;
			}

			if($resource){
				self::$MYSQL_RESOURCE = array($key => $resource);
			}
			else{
				throw new Exception("Could not connect to database: ".$error, 400);
			}

			return $resource;
		}

		public static function getMySQLResource($key){
			return self::$MYSQL_RESOURCE[$key];
		}

		public static function array_to_xml($data, &$xml_data ) {
		    foreach( $data as $key => $value ) {
		        if( is_array($value) ) {
		            if( is_numeric($key) ){
		                $key = 'item'.$key; //dealing with <0/>..<n/> issues
		            }
		            $subnode = $xml_data->addChild($key);
		            self::array_to_xml($value, $subnode);
		        }
		        else {
		            $xml_data->addChild("$key",htmlspecialchars("$value"));
		        }
		    }
		}

		public static function array_to_html($data)
		{
			$html = "<table border='1'><tr>";	
			// printing table headers
			if (is_array($data) || is_object($data))
			{
				foreach($data[0] as $key=>$value)
				{
		    		$html .= strtoupper("<th>".$key."</th>");
				}
				$html .= "</tr>\n";
			}

			// printing table rows
			if (is_array($data) || is_object($data))
			{
				foreach ($data as $key => $value) {
					$html .= "<tr>";
					foreach ($value as $key2 => $value2) {
						$html .= "<td>".htmlspecialchars("$value2")."</td>";
					}
					$html .="</tr>";
				}
			}

			$html .= "</table>";   
			return $html;
		}

		public static function export2($format, $response, $token, $restful=false){
			switch($format){
				case 'csv': // export to csv
					if ($fp = fopen('php://output', 'w')){
					    header('Content-Type: text/csv');
					    header('Content-Disposition: attachment; filename="export.csv"');
					    header('Pragma: no-cache');
					    header('Expires: 0');
					    //fputcsv($fp, $headers);
					    foreach($response as $record){
					    	fputcsv($fp, $record);
					    }
					}
				break;
				case 'xml': // export to XML
					header('Content-Type: text/xml');
					// creating object of SimpleXMLElement
					$xml_data = new SimpleXMLElement('<?xml version="1.0"?><data></data>');

					// function call to convert array to xml
					Utils::array_to_xml($response,$xml_data);

					//saving generated xml file; 
					$result = $xml_data->asXML();
					echo $result;
				break;
				case 'html': // export to XML
					header('Content-Type: text/html; charset=utf-8');
					echo '<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />';
					// function call to convert array to xml
					echo Utils::array_to_html($response);
				break;
				default: // export to JSON
					header('Content-Type: application/json');
					$json_response = str_replace(array('\", \"','"[\"','\"]"'),array('", "','["','"]'),json_encode($response));
					if(REST_DATA_ENCRYPTION === TRUE && $restful === TRUE){
						$ecryptionPassword = $token;
						$secretString = $json_response;
						GibberishAES::size(256);    // Also 192, 128
						$encryptedSecretString = GibberishAES::enc($secretString, $ecryptionPassword);
						if(defined('API_DEBUG_MODE') && API_DEBUG_MODE === TRUE){
							echo json_encode(array('data'=>$encryptedSecretString, 'debug_data'=>$json_response));
						}else{
							echo json_encode(array('data'=>$encryptedSecretString));
						}
					}
					else{
						echo $json_response;
					}
			}
		}

		public static function setMemcache($key,$value,$expire=0,$limit=0)
		{
			global $memcache;
			//var_dump($GLOBALS['cacheEngineEnabled']);
			if($GLOBALS['cacheEngineEnabled'] === false){
				return true;
			}
			switch (CACHE_ENGINE) {
				case CE_MEMCACHE:
					return $memcache->set(WSITE_MEMCACHE_KEY_SEED.'_'.$key,array($limit => $value),false,$expire);
				case CE_SESSION:
					return $_SESSION[WSITE_MEMCACHE_KEY_SEED.'_'.$key] = array($limit => $value);
				case CE_FILESYSTEM:
					touch(FSCACHE_DIRECTORY.'snippets_'.WSITE_MEMCACHE_KEY_SEED.'_'.$key);
					@include_once(FSCACHE_DIRECTORY.'snippets_'.WSITE_MEMCACHE_KEY_SEED.'_'.$key);
					// if(is_array(${WSITE_MEMCACHE_KEY_SEED}.'_'.$key)){
						${WSITE_MEMCACHE_KEY_SEED.'_'.$key} = array_replace((array)${WSITE_MEMCACHE_KEY_SEED.'_'.$key}, array($limit => $value));
						$exportVariable = '$'.WSITE_MEMCACHE_KEY_SEED.'_'.$key;
						file_put_contents(FSCACHE_DIRECTORY.'snippets_'.WSITE_MEMCACHE_KEY_SEED.'_'.$key, '<?php '.$exportVariable.'='.var_export(${WSITE_MEMCACHE_KEY_SEED.'_'.$key}, true).' ?>');
					// }
					//var_dump(${WSITE_MEMCACHE_KEY_SEED.'_'.$key});
				break;
			}
		}
		
		public static function getMemcache($key, $limit=0)
		{
			global $memcache;
			if($GLOBALS['cacheEngineEnabled'] === false){
				return false;
			}

			switch (CACHE_ENGINE) {
				case CE_MEMCACHE:
					$data = $memcache->get(WSITE_MEMCACHE_KEY_SEED.'_'.$key);
		    		return isset($data[$limit]) ? $data[$limit] : false;
				case CE_SESSION:
					$data = $_SESSION[WSITE_MEMCACHE_KEY_SEED.'_'.$key];
		    		return isset($data[$limit]) ? $data[$limit] : false;
				case CE_FILESYSTEM:
					@include(FSCACHE_DIRECTORY.'snippets_'.WSITE_MEMCACHE_KEY_SEED.'_'.$key);
					if(is_array(${WSITE_MEMCACHE_KEY_SEED.'_'.$key})){
						//print_r(${WSITE_MEMCACHE_KEY_SEED.'_'.$key}[$limit]);
						if(isset(${WSITE_MEMCACHE_KEY_SEED.'_'.$key}[$limit])){
							//print_r(${WSITE_MEMCACHE_KEY_SEED.'_'.$key}[$limit]);
							return ${WSITE_MEMCACHE_KEY_SEED.'_'.$key}[$limit];
						}
						else{
							return false;
						}
					}
				break;
			}
		}

		public static function memcacheKeyExists($key, $limit=0)
		{
			return is_array(self::getMemcache($key, $limit));
		}

		public static function deleteMemcache($key)
		{
			global $memcache;
			if($GLOBALS['cacheEngineEnabled'] === false){
				return true;
			}

			switch (CACHE_ENGINE) {
				case CE_MEMCACHE:
					return $memcache->delete(WSITE_MEMCACHE_KEY_SEED.'_'.$key);
				case CE_SESSION:
					unset($_SESSION[$key]);
		    		return true;
				case CE_FILESYSTEM:
					return unlink(FSCACHE_DIRECTORY.'snippets_'.WSITE_MEMCACHE_KEY_SEED.'_'.$key);
			}
		}

		public static function dateDifference($date_1, $date_2, $format = 'd' )
		{
		    $interval = strtotime(explode(' ', $date_2)[0]) - strtotime(explode(' ', $date_1)[0]);
		    $differenceFormat = 0;

		    switch ($format) {
		    	case 'w':
		    		$difference = ceil($interval / (60 * 60 * 24 * 7));
		    	break;

		    	case 'm':
		    		$difference = ceil($interval / (60 * 60 * 24 * 30));
		    	break;

		    	case 'y':
		    		$difference = ceil($interval / (60 * 60 * 24 * 365));
		    	break;
		    	
		    	default: // difference in days
		    		$difference = ceil($interval / (60 * 60 * 24));
		    	break;
		    }
		    
		    return $difference;
		    
		}

		public static function makeGetRequest($url) {
			// Initialize a cURL session
			$ch = curl_init();
		
			// Set the cURL options
			curl_setopt($ch, CURLOPT_URL, $url);
			curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
			curl_setopt($ch, CURLOPT_FOLLOWLOCATION, true);  // Follow redirects
			curl_setopt($ch, CURLOPT_TIMEOUT, 30);  // Set a timeout in seconds
		
			// Execute the cURL session and capture the response
			$response = curl_exec($ch);
		
			// Check for cURL errors
			if (curl_errno($ch)) {
				$error_msg = curl_error($ch);
				curl_close($ch);
				return false;
			}
		
			// Close the cURL session
			curl_close($ch);
		
			// Convert the response to a JSON array
			$jsonArray = json_decode($response, true);

			// Check if json_decode() failed
			if (json_last_error() !== JSON_ERROR_NONE) {
				return false;
			}
		
			// Return the JSON array
			return $jsonArray;
		}

		public static function generateUuidV4() {
			// Generate 16 random bytes
			$data = random_bytes(16);
		
			// Set version to 0100 (UUIDv4)
			$data[6] = chr(ord($data[6]) & 0x0f | 0x40);
		
			// Set variant to 10xxxxxx
			$data[8] = chr(ord($data[8]) & 0x3f | 0x80);
		
			// Output the 36 character UUID
			return vsprintf('%s%s-%s-%s-%s-%s%s%s', str_split(bin2hex($data), 4));
		}
	}
?>
