<?php
class Subscription extends Extensions{

	public static function process($getParams, $postParams)
	{
		if(!isset($postParams['id'])){
			throw new Exception("The \"id\" of the subscription to be cancelled is required", 400);
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

		// Soft delete User subscriptions
		$params = array(
			'dbres' => $getParams['dbres'],
			'id' => $postParams['id'],
			'fields' => 'databoard_id'
		);
		$subscriptions = APIEngine::getData("subscriptions", "list", $params);


		if(!$subscriptions){
			throw new Exception("Subscription not found", 404);
		}


		// Soft delete the description to be deleted
		$params = array(
			'dbres' => $getParams['dbres'],
			"id" => $postParams['id'], 
			"status" => "deleted"
		);
		$deleteResponse = APIEngine::saveData("subscriptions", "save", $params);
		
		foreach($subscriptions as $key => $subscription){
			$params = array(
				'dbres' => $getParams['dbres'],
				"databoard_id" => $subscription["databoard_id"]
			);
			$userDataboards = APIEngine::saveData("user_databoards", "list", $params);

			foreach($userDataboards as $key => $userDataboard){
				$params = array(
					'dbres' => $getParams['dbres'],
					"id" => $userDataboard["id"], 
					"status" => "deleted"
				);
				$deleteResponse = APIEngine::saveData("user_databoards", "save", $params);
			}
		}

		// Hard delete deleted subscriptions
		MySQLQueryBuilder::query("DELETE from subscriptions WHERE status = 'deleted'");

		// Hard delete deleted user_databoards
		MySQLQueryBuilder::query("DELETE from user_databoards WHERE status = 'deleted'");

		return array("message" => "Subscription cancelled successfully");
	}
}
?>