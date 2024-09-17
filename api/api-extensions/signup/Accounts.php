<?php
class Accounts extends Extensions{

	public static function process($getParams, $postParams)
	{
		$params = array(
			'dbres' => $getParams['dbres'],
			'phone_number' => $postParams['user']["phone_number"],
			'status:in' => 'active,pending'
		);
		$userWithPhoneNumber = APIEngine::getData("users", "list", $params); 
		if(sizeof($userWithPhoneNumber) > 0) throw new Exception("User exists with phone number", 409);

		$params = array(
			'dbres' => $getParams['dbres'],
			'email' => $postParams['user']["email"],
			'status:in' => 'active,pending'
		);
		$userWithEmail =  APIEngine::getData("users", "list", $params); 
		if(sizeof($userWithEmail) > 0) throw new Exception("User exists with email address", 409);

		$params = array(
			'dbres' => $getParams['dbres'],
			'name' => $postParams['organisation']["name"],
			'status:in' => 'active,pending'
		);
		$organisationWithName = APIEngine::getData("organisations", "list", $params); 
		if(sizeof($organisationWithName)) throw new Exception("Organization exists with the same name", 409);

		$params = array(
			'dbres' => $getParams['dbres'],
			'email' => $postParams['organisation']["email"],
			'status:in' => 'active,pending'
		);
		$organisationWithEmail = APIEngine::getData("organisations", "list", $params); 
		if(sizeof($organisationWithEmail) > 0) throw new Exception("Organization exists with the same name", 409);

		if(!isset($postParams["user"])) throw new Exception("User data is required for signup", 400);
		if(!isset($postParams["user"]["email"])) throw new Exception("User email is required for signup", 400);
		if(isset($postParams["user"]["id"])) throw new Exception("ID not required on user data", 400);
		if(!isset($postParams["organisation"])) throw new Exception("Organisation data is required for signup", 400);
		if(!isset($postParams["organisation"]["email"])) throw new Exception("Organisation email is required for signup", 400);
		if(isset($postParams["organisation"]["id"])) throw new Exception("ID not required on organisation data", 400);
		if(strlen($postParams["user"]["password"]) != 32) throw new Exception("Password must be md5 hashed", 400);

		// setting user defaults
		$postParams["user"]["username"] = $postParams["user"]["email"]; // the user's email is their default username for signin
		$postParams["user"]["access_country_restriction"] = "Ghana";
        $postParams["user"]["account_type"] = "Administrator";
        $postParams["user"]["main_contact"] = "Yes";
        $postParams["user"]["light_preference"] = "Yes";

		$postParams["organisation"]['status'] = "pending";

		$result = APIEngine::saveData("organisations", "save", $postParams["organisation"]);

		$postParams["user"]["organisation_id"] = $result["id"];
		$result = APIEngine::saveData("users", "save", $postParams["user"]);

		return array("message" => "Account created successfully");
	}

}
?>