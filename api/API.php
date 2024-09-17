<?php
/**
 * @author Xose & Edem Ahlijah
 * @version 3.0
 **/
session_start(); // WARNING: Place nothing above this line and do not delete

include_once("_config.php");

// including classes
include_once(API_LIBRARY_DIRECTORY . "Permissions.php");
include_once(API_LIBRARY_DIRECTORY . "Utils.php");
include_once(API_LIBRARY_DIRECTORY . "ExceptionHandler.php");
include_once(API_LIBRARY_DIRECTORY . "APIEngine.php");
include_once(API_LIBRARY_DIRECTORY . "IExtensions.php");
include_once(API_LIBRARY_DIRECTORY . "Extensions.php");

class API{
    private static function prepareDatabaseResource($dbres){
        global $databaseResource;
        $databaseResource = $dbres;

        if(isset($databaseResource)){
            Utils::createMySQLResource($databaseResource);
        }
        else{
            $databaseResource = DEFAULT_DATABASE_CONNECTION_INDEX;
            Utils::createMySQLResource($databaseResource);
        }
    }

    public static function processRequest($getParams, $postParams=array(), $fileParams=array()){        
        global $databaseResource;
        $databaseResource = (isset($getParams['dbres'])?$getParams['dbres']:null);
        API::prepareDatabaseResource($databaseResource);
        
        // TODO: Debug what happens when API is called with no parameters
        if (isset($getParams["f"])) {
            //self::handle_error("GET: ".json_encode($getParams)."   POST: ".json_encode($postParams));

            $f = explode(":", $getParams["f"]); // split function request on colon (:)
            /**
             * Ensure that the function name and the action are a valid API
             * For now use size of function request split
             * More securely lookup supported functions from an API funtions array
             * */
            if (sizeof($f) == 2) {
                switch (DATABASE_ENGINE) {
                    case POSTGRESQL:
                        $function = pg_escape_string(Utils::getMySQLResource($databaseResource)); // get the function name
                        $action = strtolower(pg_escape_string(Utils::getMySQLResource($databaseResource))); // get the action
                        break;
                    default:
                        $function = mysqli_real_escape_string(Utils::getMySQLResource($databaseResource), $f[0]); // get the function name
                        $action = strtolower(mysqli_real_escape_string(Utils::getMySQLResource($databaseResource), $f[1])); // get the action
                        break;
                }
                $model = 'api.'.$databaseResource.'.'.$function; // api core models associated with permission management
                $accessCountryCode = "";
                if ($function == "sessions" || $function == "sessions_pin") {
                    switch ($action) {
                        case "validate":
                            return APIEngine::validateSession($function, $action, $getParams);
                        case "login":
                            // force in active users only
                            $postParams['status'] = ACTIVE_STATUS;

                            if(ENABLE_LOGIN_COUNTRY_RESTRICTION === TRUE && $_SERVER["REMOTE_ADDR"] != '172.18.0.1'){
                                $countryResponse = Utils::makeGetRequest("https://api.country.is/".$_SERVER["REMOTE_ADDR"]);

                                if($countryResponse == false || !isset($countryResponse["country"])){
                                    throw new Exception("Access Location Unauthorized", 401);
                                }

                                $accessCountryCode = $countryResponse["country"];
                            }
                            if($function == "sessions" && (!isset($postParams['username']) || !isset($postParams['password']))) {
                                throw new Exception("Credentials Required", 400);
                            }
                            elseif($function == "sessions_pin" && (!isset($postParams['phone_number']) || !isset($postParams['pin']))) {
                                throw new Exception("Credentials Required", 400);
                            }
                            else{
                                return APIEngine::createSession($function, $action, $postParams, $accessCountryCode); // authenticate and create active session
                            }
                        case "logout":
                            return APIEngine::killSession($getParams); // kill active session
                        default:
                            throw new Exception("Endpoint not found", 404);
                    }
                } else {
                    switch ($action) {
                        case "count":
                        case "list":
                        case "sum":

                            if(!Permissions::hasPermission($model, Permissions::VIEW, $getParams["token"])){
                                throw new Exception("You do not have permission to perform action '".$function.":".$action."'", 403);
                            }

                            $filter = null;

                            if (isset($getParams["filter"])) {
                                /*                         * *
                                  Currently supported summaries
                                  1. summary:db_field:paragraph:1
                                  2. summary:db_field:sentence:3
                                  3. summary:db_field:word:2
                                 * * */
                                $filter = explode(":", $getParams["filter"]);
                            }

                            return APIEngine::getData($function, $action, $getParams, $filter); // get requested data
                        case "save":
                        case "replace":
                            if(!Permissions::hasPermission($model, Permissions::SAVE, $getParams["token"])){
                                throw new Exception("You do not have permission to perform action '".$function.":".$action."'", 403);
                            }

                            include_once "api-extensions/uploader/index.php";
                            switch ($function) {
                                case 'blobs':
                                    if(isset($getParams['type']) && $getParams['type'] == 'base64'){
                                        $tmpFile = base64ToImage($postParams['base64']);
                                        $fileParams = array(
                                                        'name' => (isset($getParams['name'])) ? $getParams['name'] : 'b64conv.jpg',
                                                        'type' => (isset($getParams['mime_type'])) ? $getParams['mime_type'] : 'image/jpeg',
                                                        'tmp_name' => $tmpFile,
                                                        'error' => 0,
                                                        'size' => filesize($tmpFile)
                                                      );
                                        unset($getParams['type']);
                                    }
                                    return uploadBlob($getParams["token"], $getParams, $fileParams);
                                default:
                                    $sessionData = APIEngine::validateSession('session', 'validate', $getParams);
                                    $auditGet = array();
                                    $response = array();
                                    
                                    if(ENABLE_AUDIT === TRUE){ // deciding to make audit core to the API by default
                                        $auditGet['fields'] = implode(",", array_keys($postParams));
                                        $auditGet["id"] = $postParams['id'];
                                        $auditGet["token"] = $getParams['token'];
                                        $auditGet["dbres"] = $getParams['dbres'];
                                        $response = APIEngine::getData($function, 'list', $auditGet, $filter);
                                    }

                                    $savedData = APIEngine::saveData($function, $action, $postParams); // save data

                                	// if condition used to be:
                                	// /*isset($getParams['sysaudit']) && $getParams['sysaudit'] == 1*/
                                    if(ENABLE_AUDIT === TRUE){ // deciding to make audit core to the API by default 
                                        $changeset = array();
                                        if(isset($response[0])){
                                            foreach ($response[0] as $key => $value) {
                                                if($response[0][$key] !== $postParams[$key]){
                                                    $changeset[$key] = array('old_value'=>$response[0][$key], 'new_value'=>$postParams[$key]);
                                                }
                                            }
                                        }
                                        else{
                                            foreach ($postParams as $key => $value) {
                                                $changeset[$key] = array('old_value'=>'', 'new_value'=>$postParams[$key]);
                                            }
                                        }

                                        if(sizeof($changeset) > 0 && $function != 'sysaudit'){
                                            $auditPost = array('changeset'=>json_encode($changeset),
                                                               'session_user_id'=>$sessionData['info'][0]['id'],
                                                               'session_fullname'=>$sessionData['info'][0]['first_name'].' '.$sessionData['info'][0]['last_name'],
                                                               'entity'=>$function,
                                                               'record_id'=>$savedData['id'],
                                                               'ip'=>$_SERVER['REMOTE_ADDR'],
                                                               'user_agent'=>$_SERVER['HTTP_USER_AGENT']);
                                            $auditGet["dbres"] = 'audit';
                                            API::prepareDatabaseResource('audit');
                                            $auditId = APIEngine::saveData('sysaudit', 'save', $auditPost, $auditGet);
                                            API::prepareDatabaseResource($getParams['dbres']); // reset database resource
                                        }
                                    }
                                    return $savedData;
                            }
                        case "delete":
                            if(!Permissions::hasPermission($model, Permissions::DELETE, $getParams["token"])){
                                throw new Exception("You do not have permission to perform action '".$function.":".$action."'", 403);
                            }
                            if(ENABLE_API_FIELD_ENCRYPTION === TRUE){
                                return APIEngine::saveData($function, $action, array("i7084" => $getParams["i7084"], "s3524" => "deleted")); // get requested data
                            }
                            return APIEngine::saveData($function, $action, array("id" => $getParams["id"], "status" => "deleted")); // get requested data
                        case "retrieve":
                            if(!Permissions::hasPermission($model, Permissions::VIEW, $getParams["token"])){
                                throw new Exception("You do not have permission to perform action '".$function.":".$action."'", 403);
                            }
                            return APIEngine::getBlob($function, $action, $getParams); // get requested data
                        default:
                            $model = 'api.ext.'.$action.'.'.$function; // api extensions associated with permission management
                            $extensionPath = PROJECT_EXTENSIONS_DIRECTORY.$action."/".$function.".php";
                            if(!file_exists($extensionPath)){
                                $extensionPath = API_EXTENSIONS_DIRECTORY.$action."/".$function.".php";
                            }

                            if(file_exists($extensionPath)){
                                if(!Permissions::hasPermission($model, Permissions::VIEW, $getParams["token"]) && $action != "signup"){
                                    throw new Exception("You do not have permission to perform action '".$function.":".$action."'", 403);
                                }
                                include_once($extensionPath);
                                if(in_array('IExtensions', class_implements($function))){
                                    $response = $function::process($getParams, $postParams);
                                    if(is_array($response)){
                                        return $response;
                                    }
                                    else{
                                        throw new Exception("Extension did not return a valid response", 500);
                                    }
                                }
                                else{
                                    throw new Exception("Extension must [ implement IExtensions ]", 500);
                                }
                            }
                            else{
                                throw new Exception("Unknown extension $function:$action", 400);
                            }
                    }
                }
            } else {
                throw new Exception("Unknown API", 400);
            }
        }
    }
}
?>
