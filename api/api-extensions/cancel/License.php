<?php
class License extends Extensions{

	public static function process($getParams, $postParams)
	{
		if(!isset($postParams['organisation_id'])){
			throw new Exception("\"organisation_id\" is required", 400);
		}

		// check if logged in user is an Administrator, Sales Administrator or Super Administrator
		$sessionInfo = APIEngine::validateSession("sessions", "validate", $getParams);
		$params = array(
			'dbres' => $getParams['dbres'],
			'id' => $sessionInfo['info'][0]['id'],
			'status' => 'active'
		);
		$userData = APIEngine::getData("users", "list", $params)[0];

		if(!isset($userData['account_type'])){
			throw new Exception("User role forbidden", 403);
		}

		if($userData['account_type'] != "Super Administrator" && $userData['account_type'] != "Sales Administrator" && $userData['account_type'] != "Administrator"){
			throw new Exception("User role forbidden", 403);
		}


		// Soft delete subscription to be cancelled
		$params = array(
			'dbres' => $getParams['dbres'],
			'organisation_id' => $postParams['organisation_id'],
			'fields' => 'id'
		);

		$individualAccessSubscriptions = APIEngine::getData("subscriptions", "list", $params);
		
		foreach($individualAccessSubscriptions as $key => $subscription){
			$params = array(
				'dbres' => $getParams['dbres'],
				"id" => $subscription["id"], 
				"status" => "deleted"
			);
			$deleteResponse = APIEngine::saveData("subscriptions", "save", $params);
		}

		// Soft delete User subscriptions
		$params = array(
			'dbres' => $getParams['dbres'],
			'organisation_id' => $postParams['organisation_id'],
			'fields' => 'id'
		);

		$users = APIEngine::getData("users", "list", $params);
		
		foreach($users as $key => $user){
			$params = array(
				'dbres' => $getParams['dbres'],
				"user_id" => $user["id"], 
				"fields" => "id"
			);
			$user_databoards = APIEngine::getData("user_databoards", "list", $params);

			foreach($user_databoards as $key => $user_databoard){
				$params = array(
					'dbres' => $getParams['dbres'],
					"id" => $user_databoard["id"], 
					"status" => "deleted"
				);
				$deleteResponse = APIEngine::saveData("user_databoards", "save", $params);
			}
		}

		// Update organisation subscription package
		$params = array(
			'dbres' => $getParams['dbres'],
			'id' => $postParams['organisation_id'],
			'subscription' => 'Individual Access'
		);
		$saveResponse = APIEngine::saveData("organisations", "save", $params);

		// Hard delete deleted subscriptions
		MySQLQueryBuilder::query("DELETE from subscriptions WHERE status = 'deleted'");

		// Hard delete deleted user_databoards
		MySQLQueryBuilder::query("DELETE from user_databoards WHERE status = 'deleted'");

		return array("message" => "License cancelled successfully");
	}
}
?>