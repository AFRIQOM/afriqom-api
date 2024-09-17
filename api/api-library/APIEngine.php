<?php
	include_once(API_LIBRARY_DIRECTORY."_denyDirectAccess.php");

	switch (DATABASE_ENGINE) {
        case POSTGRESQL:
            include_once("PgQueryBuilder.php");
            $queryBuilderClassName = "PgQueryBuilder";
            break;
        default:
			include_once("MySQLQueryBuilder.php");
            $queryBuilderClassName = "MySQLQueryBuilder";
            break;
    }

	include_once(API_LIBRARY_DIRECTORY."TimThumb.php");

	class APIEngine{
		static function getData($function, $action, $param, $filter = null){		
			return self::processData($function, $action, $param, $filter);
		}

		static function saveData($function, $action, $param){
			return self::processData($function, $action, $param);
		}

		static function createSession($function, $action, $param, $accessCountryCode){
			global $databaseResource, $queryBuilderClassName;
			if($param == null){
				throw new Exception("Fields Not Defined For Authentication", 400);
			}

			$remember = (isset($param["remember"])) ? true : false;
			unset($param["remember"]);

			if(isset($param["token"])){
				self::killSession($param);
			}
			$xml=simplexml_load_file(XML_DEFINITIONS_DIRECTORY.$databaseResource.'.'.$function.".xml");
			// hardening against sql injection
			foreach ($param as $key => $value) {
				switch (DATABASE_ENGINE) {
		        	case POSTGRESQL:
						$param[$key] = pg_escape_string(Utils::getMySQLResource($databaseResource), $value);
			            break;
			        default:
						$param[$key] = mysqli_real_escape_string(Utils::getMySQLResource($databaseResource), $value);
			            break;
			    }
			}

			$sessionInfo=$queryBuilderClassName::query($queryBuilderClassName::prepare("list", $xml, $param));

			if($sessionInfo[0]["access_country_restriction"] != "All Countries"){
				if($accessCountryCode != "" && $sessionInfo[0]["access_country_restriction"] != ""){
					if(strpos($sessionInfo[0]["access_country_restriction"], $accessCountryCode) === false){
						throw new Exception("Access Location Unauthorized", 401);
					}
				}
			}

			if(sizeof($sessionInfo) == 1){
				$_SESSION = array();
				$_SESSION["info"] = $sessionInfo;
				unset($_SESSION["info"][0]["password"]);
				$_SESSION["token"] = self::getToken();
				$_SESSION["ip"] = $_SERVER['REMOTE_ADDR'];
				$_SESSION["user_agent"] = (isset($_SERVER['HTTP_USER_AGENT'])) ? $_SERVER['HTTP_USER_AGENT'] : "Unspecified";
				$_SESSION["role"] = self::getUserPermissions($_SESSION["info"][0]["id"]);
				$_SESSION["login_timestamp"] = date("Y-m-d H:i:s");
				// echo '<pre>';
				// print_r($_SESSION);

				if($remember){
					$_SESSION["remember"] = true;
				}
				if(defined('DEFAULT_SECURITY_LEVEL')){
					$_SESSION["type"] = DEFAULT_SECURITY_LEVEL;
				}

				$tableName = $xml->table->attributes()->name;

				$encodedSession = json_encode($_SESSION, JSON_NUMERIC_CHECK);

				// TODO: Clean _sessions dir of duplicate old sessions
				$v = file_put_contents(API_BASE_DIRECTORY."_sessions/".$_SESSION["token"], $encodedSession);

				if(ENABLE_API_FIELD_ENCRYPTION === TRUE){
					$data = array("i7084"=>$_SESSION["info"][0]["id"], 'i1603'=>$_SERVER['REMOTE_ADDR'], 'u2978'=>$_SERVER['HTTP_USER_AGENT'], 'l2905' => gmdate('Y-m-d H:i:s'));
				}else{
					$data = array("id"=>$_SESSION["info"][0]["id"], 'ip_address'=>$_SERVER['REMOTE_ADDR'], 'user_agent'=>$_SERVER['HTTP_USER_AGENT'], 'last_login_date' => gmdate('Y-m-d H:i:s'));
				}

				API::processRequest(array("f"=>"users:save", "token"=>$_SESSION["token"], "dbres"=>$databaseResource), $data);
								
				return $_SESSION;
			}
			else{
				throw new Exception("Invalid Credentials", 400);
			}
		}

		static function validateSession($function, $action, $param){
			if(self::hasValidSession($param["token"])){
				return json_decode(file_get_contents(API_BASE_DIRECTORY."_sessions/".$param["token"]), true); // @todo potential i/o issue for high traffic sites
			}
			else{
				throw new Exception("Invalid Session", 401);
			}
		}

		static function killSession($param){
			// TODO: Standardize ERROR & WARNING messages
			return (@unlink(API_BASE_DIRECTORY."_sessions/".$param["token"]))?array("msg"=>"logout successful for token=".$param["token"]):array("warning"=>"sessions does not exist");
		}

		private static function getToken(){
			return sha1(md5(print_r($_SESSION,true).microtime()));
		}

		private static function getUserPermissions($userID){					
			global $databaseResource, $queryBuilderClassName;
			$currentResource = $databaseResource;
			$databaseResource = 'users';
			Utils::createMySQLResource($databaseResource);

			if(ENABLE_API_FIELD_ENCRYPTION === TRUE){
				$param = array('fields' => 'u9094,r1184', 'u9094' => $userID);
			}else{
				$param = array('fields' => 'user_id,role_id', 'user_id' => $userID);
			}
			$xml = simplexml_load_file(XML_DEFINITIONS_DIRECTORY.$databaseResource.'.user_roles_lookup.xml');
			$userRole = $queryBuilderClassName::query($queryBuilderClassName::prepare('list', $xml, $param, null));
			
			if(ENABLE_API_FIELD_ENCRYPTION === TRUE){
				$roleID = $userRole[0]['r1184'];
				$param = array('fields' => 'r1184,m2184,p5574', 'r1184' => $roleID);
			}else{
				$roleID = $userRole[0]['role_id'];
				$param = array('fields' => 'role_id,model,permissions', 'role_id' => $roleID);
			}

			$_SESSION["role_id"] = $roleID;

			$xml = simplexml_load_file(XML_DEFINITIONS_DIRECTORY.$databaseResource.'.permissions.xml');
			$permissions = $queryBuilderClassName::query($queryBuilderClassName::prepare('list', $xml, $param, null));
			foreach ($permissions as $index => $value) {
				if(ENABLE_API_FIELD_ENCRYPTION === TRUE){
					$permissionsFormatted[$value['m2184']] = $value['p5574'];	
				}else{
					$permissionsFormatted[$value['model']] = $value['permissions'];	
				}	
			}
			Utils::createMySQLResource($currentResource);
			$databaseResource = $currentResource;
			return ($permissionsFormatted) ? $permissionsFormatted : array();
		}

		static function hasValidSession($token){
			$tokenFile = API_BASE_DIRECTORY."_sessions/".$token;
			$isValid = ($token == null || !file_exists($tokenFile))?false:true;
			if($isValid){
				$sessionData = json_decode(file_get_contents(API_BASE_DIRECTORY."_sessions/".$token), true); // @todo potential i/o issue for high traffic sites
        
        $isValid = ($sessionData['ip'] == $_SERVER['REMOTE_ADDR'] && $sessionData['user_agent'] == $_SERVER['HTTP_USER_AGENT']);
        
        if(isset($sessionData['type'])){
          switch ($sessionData['type']) {
            case FLEXIBLE_SECURITY:
              $isValid = true; // token file exists
            break;

            case MORDERATE_SECURITY:
              $isValid = ($sessionData['ip'] == $_SERVER['REMOTE_ADDR']);
            break;
          }
        }

				touch($tokenFile);
				//handle_error("Log file touched\n");
			}
			return $isValid;
		}

		static function getBlob($function, $action, $param){
			global $databaseResource, $queryBuilderClassName;

			$file = (isset($param['type']) && $param['type'] == 'file') ? true : false;
			$image = (isset($param['type']) && $param['type'] == 'image') ? true : false;
			$thumbOptions = array(
					'width' => @$param['w'], 
					'height' => @$param['h'], 
					'zoom' => @$param['z'], 
					'quality' => @$param['q']
				);
			unset($param['w']); unset($param['h']); unset($param['z']); unset($param['q']); unset($param['type']);

			if(ENABLE_API_FIELD_ENCRYPTION === TRUE){
				if(!isset($param["i7084"])) throw new Exception("Blob ID is required", 400);	

				$param = array_merge($param, array("fields"=>"i7084,u9765,m9797"));
				$xml=simplexml_load_file(XML_DEFINITIONS_DIRECTORY.$databaseResource.'.'.$function.".xml");

				$blob=$queryBuilderClassName::query($queryBuilderClassName::prepare("list", $xml, $param));
				if(file_exists($blob[0]["u9765"])){
					return self::resizeBlob($thumbOptions, $blob[0]["u9765"]);
				}
				else{
					return self::resizeBlob($thumbOptions, CDN_BASE_URL.$blob[0]["u9765"]);
				}
			}
			else{
				if(!isset($param["id"])) throw new Exception("Blob ID is required", 400);
				$param = array_merge($param, array("fields"=>"id,url,mime_type"));
				$xml=simplexml_load_file(XML_DEFINITIONS_DIRECTORY.$databaseResource.'.'.$function.".xml");
				$blob=$queryBuilderClassName::query($queryBuilderClassName::prepare("list", $xml, $param));

				if($file === true){
					return self::getResource($blob[0]);
				}if($image === true){
					return self::getCachedResource($thumbOptions, CDN_BASE_URL.$blob[0]["url"]);
				}else{
					return self::resizeBlob($thumbOptions, CDN_BASE_URL.$blob[0]["url"]);
				}
			}
		}

		private static function resizeBlob($param, $src){
			$_GET["w"] = ($param["width"]) ? $param["width"] : 'auto';
			$_GET["h"] = ($param["height"]) ? $param["height"] : 'auto';
			$_GET["q"] = ($param["quality"]) ? $param["quality"] : 100;
			$_GET["zc"] = ($param["zoom"]) ? $param["zoom"] : 1;
			$_GET["src"] = $src;
			TimThumb::start();
		}

		private static function getCachedResource($param, $src){
			$urlParams = "?src=".$src;
			$urlParams .= ($param["width"]) ? "&w=".$param["width"] : '';
			$urlParams .= ($param["height"]) ? "&h=".$param["height"] : '';
			$urlParams .= ($param["quality"]) ? "&q=".$param["quality"] : '';
			$urlParams .= ($param["zoom"]) ? "&zc=".$param["zoom"] : '';
			return CDN_BASE_URL."images/".$urlParams;
		}

		private static function getResource($blob){
			return array("url" => CDN_BASE_URL.$blob["url"], "type" => self::fileType($blob["mime_type"]));
		}

		private static function fileType($mime){
	    switch ($mime) {
        case 'image/png':
        case 'image/jpeg':
        case 'image/pipeg':
        case 'image/pjpeg':
        case 'image/gif':
        case 'image/ief':
        case 'image/bmp':
        case 'image/tiff':
        case 'image/svg+xml':
        case 'image/vnd.dwg':
        case 'image/x-dwg':
        case 'image/vnd.fpx':
        case 'image/vnd.net-fpx':
        case 'image/g3fax':
        case 'image/x-icon':
        case 'image/x-windows-bmp':
        case 'image/vnd.microsoft.icon':
        case 'image/x-cmu-raster':
        case 'image/x-cmx':
        case 'image/x-portable-anymap':
        case 'image/x-portable-bitmap':
        case 'image/x-portable-graymap':
        case 'image/x-portable-pixmap':
        case 'image/x-rgb':
        case 'image/x-xbitmap':
        case 'image/x-xpixmap':
        case 'image/x-xwindowdump':
            return 'image';
        case 'application/msword':
        case 'application/rtf':
        case 'application/vnd.oasis.opendocument.text':
        case 'application/vnd.openxmlformats-officedocument.wordprocessingml.document':
            return 'word';
        case 'application/vnd.ms-excel':
        case 'application/vnd.oasis.opendocument.spreadsheet':
        case 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet':
        case 'application/vnd.openxmlformats-officedocument.spreadsheetml.template':
        case 'application/vnd.ms-excel.sheet.binary.macroEnabled.12':
        case 'application/vnd.ms-excel.addin.macroEnabled.12':
            return 'excel';
        case 'application/vnd.ms-powerpoint':
        case 'application/vnd.openxmlformats-officedocument.presentationml.presentation':
        case 'application/vnd.openxmlformats-officedocument.presentationml.template':
        case 'application/vnd.openxmlformats-officedocument.presentationml.slideshow':
        case 'application/vnd.ms-powerpoint.addin.macroEnabled.12':
        case 'application/vnd.ms-powerpoint.presentation.macroEnabled.12':
        case 'application/vnd.ms-powerpoint.slideshow.macroEnabled.12':
            return 'powerpoint';
        case 'application/pdf':
            return 'pdf';
        case 'application/zip':
        case 'application/x-rar-compressed':
        case 'application/x-msdownload':
        case 'application/vnd.ms-cab-compressed':
            return 'archive';
        default:
            return 'file';
	    }
		}

		private static function processData($function, $action, $param, $filter = null){
			global $databaseResource, $queryBuilderClassName;
			if(!file_exists(XML_DEFINITIONS_DIRECTORY.$databaseResource.'.'.$function.".xml")){
				throw new Exception("The definition $databaseResource.$function.xml does not exist. Run xmlgen to fix.", 404);
			}
			$xml=simplexml_load_file(XML_DEFINITIONS_DIRECTORY.$databaseResource.'.'.$function.".xml");
			$response = $queryBuilderClassName::prepare($action, $xml, $param, $filter);
			return $queryBuilderClassName::query($response, $param);
		}
	}
?>
