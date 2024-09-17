<?php
class Users extends Extensions{

	public static function process($getParams, $postParams)
	{
		$databoards = "";
		if(isset($postParams['databoards'])){
			$databoards = $postParams['databoards'];
			unset($postParams['databoards']);
		}
		$postParams['dbres'] = $getParams['dbres'];
		$savedResponse = APIEngine::saveData("users", "save", $postParams);
		$postParams['id'] ??= $savedResponse['id'];

		if($databoards != ""){
			// delete any active databoard the user has
			$params = array(
				'dbres' => $getParams['dbres'],
				'user_id' => $postParams['id']
			);
			$userDataboards = APIEngine::getData("user_databoards", "list", $params);

			foreach($userDataboards as $key => $userDataboard){
				MySQLQueryBuilder::query("DELETE from user_databoards WHERE id = \"".$userDataboard['id']."\"");
			}

			$databoards2array = explode(",", $databoards);
			foreach($databoards2array as $databoard){
				$params = array(
					'dbres' => $getParams['dbres'],
					'user_id' => $postParams['id'],
					'databoard_id' => $databoard

				);
				$savedResponse = APIEngine::saveData("user_databoards", "save", $params);
			}
		}

		return array("message" => "User saved successfully", "id" => $postParams['id']);
	}
}
?>