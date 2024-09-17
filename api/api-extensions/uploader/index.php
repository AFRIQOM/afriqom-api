<?php
  function uploadBlob($token, $getParams, $fileParams){
    $sessionInfo = APIEngine::validateSession('session', 'validate', $getParams);
    $getParams["user_id"] = $sessionInfo['info'][0]['id'];
    $fileParams = (isset($fileParams['file'])) ? $fileParams['file'] : $fileParams;
    if(empty($getParams["user_id"]) || empty($token) || empty($fileParams)){
      throw new Exception("Missing Blob Upload Parameters", 404);
    }else{
      $fileParams = (isset($getParams["key"])) ? $fileParams[$getParams["key"]] : $fileParams;
      $uploadFilename = time() . "_" .$fileParams['name'];
      $uploadFile = rtrim(UPLOADS_DIRECTORY, '/') . "/" . $uploadFilename; 

      if(!file_exists($uploadFile)) {
        try{
          @rename($fileParams['tmp_name'], $uploadFile); // security concern. use move_uploaded_file() instead but be cautious of base64 uploads
          chmod($uploadFile, 0644);
          if(ENABLE_API_FIELD_ENCRYPTION === TRUE){
            $response = APIEngine::saveData('blobs', 'save', array('n3963' => $fileParams['name'], 'm9797' => $fileParams['type'], 'u9765' => $uploadFilename, 'u9094' => $getParams["user_id"], 's3024' => $fileParams['size'], 's3524' => ACTIVE_STATUS, 'token' => $token));
            $response["i7084"] = $response["id"];
            $response["u9765"] = CDN_BASE_URL.$uploadFilename;
            unset($response["id"]);
          } else {
            $response = APIEngine::saveData('blobs', 'save', array('name' => $fileParams['name'], 'mime_type' => $fileParams['type'], 'url' => $uploadFilename, 'user_id' => $getParams["user_id"], 'size' => $fileParams['size'], 'status' => ACTIVE_STATUS, 'token' => $token));
            $response["url"] = $uploadFilename;
          }
          return $response;
        }
        catch(Exception $e){
          throw $e;
        }
      }else{
        throw new Exception("Duplicate upload", 409);
      }

    }
  }

  function base64ToImage($base64_string) {
    $output_file = '/tmp/'.md5(microtime().rand(100000,999999));
    $file = fopen($output_file, "wb");
    $data = $base64_string; 
    fwrite($file, base64_decode($data));
    fclose($file);
    return $output_file;
  }
?>