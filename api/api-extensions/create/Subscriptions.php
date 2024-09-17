<?php
class Subscriptions extends Extensions{

	public static function process($getParams, $postParams)
	{
		// Validate payload keys
		if(!isset($postParams['package'])){
			throw new Exception("Package parameter is required");
		}

		if($postParams['package'] == "Full Access"){
			if(!isset($postParams['region_id']) || !isset($postParams['rate_paid']) || !isset($postParams['license']) || isset($postParams['databoards'])){
				throw new Exception("Full Access requires organisation_id, package, rate_paid, license and region_id only");
			}
		}

		if($postParams['package'] == "Individual Access"){
			if(!isset($postParams['databoards']) || isset($postParams['region_id'])){
				throw new Exception("Individual Access requires organisation_id, package and databoards only");
			}
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

		// Check if the logged in user belongs to the organization they are subscribing for (ie. for Administrators)
		if($userData['account_type'] == "Administrator" && $userData['organisation_id'] != $postParams['organisation_id']){
			throw new Exception("User organisation forbidden", 403);
		}

		// Prevent subscription to databoards that have already been subscribed to
		if($postParams['package'] == "Individual Access"){
			$databoardIds = '';
			if(isset($postParams['databoards'])){
				foreach($postParams['databoards'] as $databoard){
					$databoardIds .= $databoard['databoard_id'].',';
				}

				$databoardIds = substr($databoardIds, 0, -1);
			}
			$params = array(
				'dbres' => $getParams['dbres'],
				'databoard_id:in' => $databoardIds,
				'organisation_id' => $userData['organisation_id'],
				'status:in' => 'active,pending'
			);
			$subscriptionsData = APIEngine::getData("subscriptions", "list", $params);

			if(sizeof($subscriptionsData) > 0){
				throw new Exception("Some databoards already subscribed to. Consider updating subscriptions instead", 403);
			}

			// Check for invalid databoard ids
			$params = array(
				'dbres' => $getParams['dbres'],
				'id:in' => $databoardIds,
				'status:in' => 'active,pending'
			);
			$databoardsData = APIEngine::getData("databoards", "list", $params);

			if(sizeof($databoardsData) != sizeof($postParams['databoards'])){
				throw new Exception("Invalid databoard id provided", 403);
			}

			// save individual databoards
			foreach($postParams['databoards'] as $databoard){
				$params = array(
					'dbres' => $getParams['dbres'],
					'organisation_id' => $postParams['organisation_id'],
					'package' => 'Individual Access',
					'databoard_id' => $databoard['databoard_id'],
					'license' => $databoard['license'],
					'rate_paid' => $databoard['rate_paid'],
					'status' => 'pending'
				);
				if(isset($databoard['start_date'])){
					$params['start_date'] = $databoard['start_date'];
				}
	
				if(isset($databoard['expiry_date'])){
					$params['expiry_date'] = $databoard['expiry_date'];
				}
				$saveResponse = APIEngine::saveData("subscriptions", "save", $params);
			}

			// Soft delete Full Access subscriptions when new package is Individual Access
			$params = array(
				'dbres' => $getParams['dbres'],
				'organisation_id' => $postParams['organisation_id'],
				'fields' => 'id',
				'package' => 'Full Access'
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

			// Update organisation subscription package
			$params = array(
				'dbres' => $getParams['dbres'],
				'id' => $postParams['organisation_id'],
				'subscription' => 'Individual Access'
			);
			$saveResponse = APIEngine::saveData("organisations", "save", $params);

			// Hard delete deleted sebecriptions
			MySQLQueryBuilder::query("DELETE from subscriptions WHERE status = 'deleted'");
		}
		

		// Prevent subscriptions if there is an already existing full access subscription
		if($postParams['package'] == "Full Access"){
			$params = array(
				'dbres' => $getParams['dbres'],
				'organisation_id' => $userData['organisation_id'],
				'package' => 'Full Access',
				'status:in' => 'active,pending'
			);
			$subscriptionsData = APIEngine::getData("subscriptions", "list", $params);
		}

		if(sizeof($subscriptionsData) > 0){
			throw new Exception("Full Access already subscribed to. Consider updating subscriptions instead", 403);
		}

		// Create subscriptions with status defaulted to pending
		if($postParams['package'] == "Full Access"){
			$params = array(
				'dbres' => $getParams['dbres'],
				'organisation_id' => $postParams['organisation_id'],
				'package' => 'Full Access',
				'region_id' => $postParams['region_id'],
				'license' => $postParams['license'],
				'rate_paid' => $postParams['rate_paid'],
				'status' => 'pending'
			);
			if(isset($postParams['start_date'])){
				$params['start_date'] = $postParams['start_date'];
			}

			if(isset($postParams['expiry_date'])){
				$params['expiry_date'] = $postParams['expiry_date'];
			}
			$saveResponse = APIEngine::saveData("subscriptions", "save", $params);

			// Soft delete Individual Access subscriptions when new package is Full Access
			$params = array(
				'dbres' => $getParams['dbres'],
				'organisation_id' => $postParams['organisation_id'],
				'fields' => 'id',
				'package' => 'Individual Access'
			);
			$individualAccessSubscriptions = APIEngine::getData("subscriptions", "list", $params);
			
			foreach($individualAccessSubscriptions as $key => $subscription){
				$params = array(
					"id" => $subscription["id"], 
					"status" => "deleted"
				);
				$deleteResponse = APIEngine::saveData("subscriptions", "save", $params);
			}

			// Update organisation subscription package
			$params = array(
				'dbres' => $getParams['dbres'],
				'id' => $postParams['organisation_id'],
				'subscription' => 'Full Access'
			);
			$saveResponse = APIEngine::saveData("organisations", "save", $params);

			// Hard delete deleted sebecriptions
			MySQLQueryBuilder::query("DELETE from subscriptions WHERE status = 'deleted'");
		}
		
		return array("message" => "Subscription created successfully");
	}
}
?>