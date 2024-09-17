<?php
	class Permissions{
		const VIEW 		= 'V';
		const SAVE 		= 'S';
		const DELETE 	= 'D';
		const EDIT 		= 'E';

		static function hasPermission($model, $permission, $token){
			try{
				$sessionInfo = APIEngine::validateSession(null, null, array('token' => $token));

				if(ENABLE_PERMISSIONS !== TRUE){ return $sessionInfo; }

				if(
					// Implement strict permissions when accessing the API via REST
					(strpos($sessionInfo["role"][$model], $permission) === false && defined('REST_MODE') && REST_MODE === TRUE) ||

					// When utilizing API class via PHP, limit permissions to UI models
					(substr($model, 0, 3) == "ui." && !defined('REST_MODE') && strpos($sessionInfo["role"][$model], $permission) === false)

				){
					
					return false;
				}else{
					return true;
				}
			}
			catch(Exception $e){
				return false;
			}
		}

		static function getConstants() {
      $reflection = new ReflectionClass(__CLASS__);
      return array_values($reflection->getConstants());
    }
	}
?>