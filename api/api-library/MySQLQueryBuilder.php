<?php
include_once(API_LIBRARY_DIRECTORY."_denyDirectAccess.php");

class MySQLQueryBuilder{
	// api url param/keyworkds reserved for system use only
	private static $apiParamReservedDefault = array("f","fields","orderby","token","filter","limit", "offset","dbres","intelli-cache","fmt","sysaudit");
	private static $apiParamReserved = array();
	private static $fieldMaps = array();

	static function prepare($action, $xmlObject, $param, $filter = null){
		self::$fieldMaps = array();
		self::$apiParamReserved = array();
		$tableName = $xmlObject->table->attributes()->name;
		$userFields = $userFieldMaps = $execMaps = array();
		$ctr = 0;
		if(isset($param["fields"])){
			$userFields = explode(",", $param["fields"]);
		}
		// create fields and intersect with user defined fields
		foreach($xmlObject->table->field as $value){
			$dbField = (string)$value;
			if(isset($value->attributes()->api_field)){
				$apiField = (string)$value->attributes()->api_field;

				// TODO: Implement sprintf() and replace encrypt with exec
				if($value->attributes()->encrypt){
					$param[(string)$value] = (string)$value->attributes()->encrypt."(\"".$param[(string)$value]."\")";
					$execMaps[(string)$value] = true;
				}
				else{
					$execMaps[(string)$value] = false;
				}
			}
			else{
				$apiField = $dbField;
			}

			self::$fieldMaps[$apiField] = $dbField;

			if(isset($param["fields"]) && array_search($apiField,$userFields) !== FALSE){
				$userFieldMaps[$apiField] = $dbField;
			}
		}

		// Error management is critical
		if(isset($param["fields"]) && sizeof($userFieldMaps) == 0){
			throw new Exception("Unknown Fields", 400);
		}

		if(!isset($param["fields"])){
			$userFieldMaps = self::$fieldMaps;
		}

		switch($action){
			case "sum":
			case "count":
			case "list":
				MySQLQueryBuilder::$apiParamReserved = MySQLQueryBuilder::$apiParamReservedDefault;
				return MySQLQueryBuilder::prepareSelect($tableName, $param, $userFieldMaps, $execMaps, $filter, $action);
			case "delete": // proceed to save
			case "save":
				MySQLQueryBuilder::$apiParamReserved = array_merge(MySQLQueryBuilder::$apiParamReservedDefault,array("id"));
				return MySQLQueryBuilder::prepareSave($tableName, $param, $userFieldMaps);
			case "replace":
				MySQLQueryBuilder::$apiParamReserved = MySQLQueryBuilder::$apiParamReservedDefault;
				return MySQLQueryBuilder::prepareReplace($tableName, $param, $userFieldMaps);
		}
	}

	private static function prepareSave($tableName, $param, $userFieldMaps){
		global $databaseResource;
		// Do not edit lines below unless you are a geek
		$sql = $whereClause = "";
		if(count(MySQLQueryBuilder::getOtherParams($param))){
			if(ENABLE_API_FIELD_ENCRYPTION === TRUE){
                if(isset($param["i7084"])){
					$sql = "UPDATE ".$tableName." SET ";
					$whereClause = " WHERE `".$userFieldMaps["i7084"]."` in (\"".$param["i7084"]."\")";
				}
				else{
					$sql = "INSERT INTO ".$tableName." SET id=\"".Utils::generateUuidV4()."\", ";
				}
            }
            else{
            	if(isset($param["id"])){
					$sql = "UPDATE ".$tableName." SET ";
					$whereClause = " WHERE `".$userFieldMaps["id"]."` in (\"".$param["id"]."\")";
				}
				else{
					$sql = "INSERT INTO ".$tableName." SET  id=\"".Utils::generateUuidV4()."\", ";
				}
            }
		}
		// build where clause if conditions exists
		foreach(MySQLQueryBuilder::getOtherParams($param) as $key => $value){
			if(array_key_exists($key,$userFieldMaps)){
				$sql.="`".$userFieldMaps[$key]."` = \"".mysqli_escape_string(Utils::getMySQLResource($databaseResource), $value)."\", ";
			}
			else{
				throw new Exception("Unknown column '{$key}' in 'where clause'", 400);
			}
		}
		$sql = rtrim($sql,", ").$whereClause;
		return $sql;
	}

	private static function prepareReplace($tableName, $param, $userFieldMaps){
		// Do not edit lines below unless you are a geek
		$sql = $whereClause = "";
		if(count(MySQLQueryBuilder::getOtherParams($param))){
			$sql = "REPLACE INTO ".$tableName." SET ";
		}
		// build where clause if conditions exists
		foreach(MySQLQueryBuilder::getOtherParams($param) as $key => $value){
			if(array_key_exists($key,$userFieldMaps)){
				$sql.="`".$userFieldMaps[$key]."` = \"".$value."\", ";
			}
			else{
				throw new Exception("Unknown column '{$key}' in 'REPLACE INTO STATEMENT'", 400);
			}
		}
		$sql = rtrim($sql,", ").$whereClause;
		return $sql;
	}

	private static function prepareSelect($tableName, $param, $userFieldMaps, $execMaps, $filter = null, $action = 'list'){
		// Do not edit lines below unless you are a geek
		$sql = "SELECT ";

		// if($filter[0] == 'distinct'){
		// 	$sql.="DISTINCT(`".$filter[1]."`) as \"".$filter[1]."\", ";
		// 	unset($userFieldMaps[$filter[1]]);
		// }

		foreach($userFieldMaps as $key => $value){
			if($action == 'count'){
				$sql.="count(*) as count";
				break;
			}

			if($action == 'sum'){
				$sql.="sum(".$value.") as sum from (select ".$value;
			}			

			if($filter == null && $action != 'sum'){
				$sql.="`".$value."` as \"".$key."\", ";
			}
			else{
				switch ($filter[0]) {									
					case 'summary':
						$needle = "";
						switch ($filter[2]) {
							case 'paragraph':
							$needle = "\n";
							break;
							case 'sentence':
							$needle = ". ";
							break;
							case 'word':
							$needle = " ";
							break;
						}
						if($filter[2] == ""){
							$needle = "\n";
						}
						elseif($filter[2] == "sentence"){
							$needle = ".";
						}					

						$sql.="SUBSTRING_INDEX(".$value.", '".$needle."', ".(is_numeric($filter[3])?$filter[3]:1).") as \"".$key."\", ";
					break;
					case 'distinct':

					break;
					default:
					if($action != 'sum'){
						$sql.="`".$value."` as \"".$key."\", ";
					}
					break;
				}
			}
		}
		$sql = rtrim($sql,", ");
		$sql.=" FROM ".$tableName;

		// build where clause if conditions exists
		if(count(MySQLQueryBuilder::getOtherParams($param))){ $sql.=" WHERE 1=1"; }
		foreach(MySQLQueryBuilder::getOtherParams($param) as $key => $value){
			$hasNotLike = strpos($key, ":notlike");
			$key = str_replace(":notlike", "", $key);

			$hasNotIn = strpos($key, ":notin");
			$key = str_replace(":notin", "", $key);

			$hasNot = strpos($key, ":not");
			$key = str_replace(":not", "", $key);

			$hasLike = strpos($key, ":like");
			$key = str_replace(":like", "", $key);

			$hasIn = strpos($key, ":in");
			$key = str_replace(":in", "", $key);

			$hasBetween = strpos($key, ":between");
			$key = str_replace(":between", "", $key);

			$hasGT = strpos($key, ":gt");
			$key = str_replace(":gt", "", $key);

			$hasLT = strpos($key, ":lt");
			$key = str_replace(":lt", "", $key);

			$hasLE = strpos($key, ":le");
			$key = str_replace(":le", "", $key);

			$hasGE = strpos($key, ":ge");
			$key = str_replace(":ge", "", $key);

			$valueTmp = $value;

			$operator = "=";

			if($execMaps[$key])
				$value = $valueTmp;
			else
				$value = "\"".$valueTmp."\"";

			if($hasGT){
				$operator = ">";
				$value = "\"".$valueTmp."\"";
			}

			if($hasLT){
				$operator = "<";
				$value = "\"".$valueTmp."\"";
			}

			if($hasGE){
				$operator = ">=";
				$value = "\"".$valueTmp."\"";
			}

			if($hasLE){
				$operator = "<=";
				$value = "\"".$valueTmp."\"";
			}

			if($hasLike){
				$operator = "LIKE";
				$value = "\"%".$valueTmp."%\"";
			}

			if($hasNotLike){
				$operator = "NOT LIKE";
				$value = "\"%".$valueTmp."%\"";
			}

			if($hasNotIn){
				$operator = "NOT IN";
				$value = "(\"".implode('","', explode(",", $valueTmp))."\")";
			}

			if($hasIn){
				$operator = "IN";
				$value = "(\"".implode('","', explode(",", $valueTmp))."\")";
			}

			if($hasBetween){
				$operator = "BETWEEN";
				$value = "\"".implode('" AND "', explode(",", $valueTmp))."\"";
			}

			if(array_key_exists($key,self::$fieldMaps)){
				if($hasLike || $hasNotLike){
					$sql.=" AND ".(($hasNot)?"NOT":"")." COALESCE(`".self::$fieldMaps[$key]."`,'') ".$operator." ".$value;
				}else{
					$sql.=" AND ".(($hasNot)?"NOT":"")." `".self::$fieldMaps[$key]."` ".$operator." ".$value;
				}
			}
			else{
				throw new Exception("Unknown column '{$key}' in 'where clause'", 400);
			}
		}

		// define db preserved filters
		if(isset($param["orderby"])){
			$orderBy = explode(",", $param["orderby"]);
			foreach($orderBy as $orderByCondition){
				$orderByMap = explode(":", $orderByCondition);
				if(sizeof($orderByMap) > 2){
					throw new Exception("Invalid ORDER BY conditions; ".$orderByCondition, 400);
				}

				if(isset($orderByMap[1]) && $orderByMap[1] != "asc" && $orderByMap[1] != "desc"){
					throw new Exception("Invalid ORDER BY conditions; ".$orderByCondition, 400);
				}
				// array_key_exists($param["orderby"],$userFieldMaps)
			}
			$sql.= " ORDER BY ". str_replace(":"," ",$param["orderby"]);
		}

		if(isset($param["limit"]) && is_numeric($param["limit"])){
			$sql.= " LIMIT ".round($param["limit"]);
		}
		else{
			//$sql.= " LIMIT 10";
		}

		if(isset($param["offset"]) && is_numeric($param["offset"])){
			$sql.= " OFFSET ".$param["offset"];
		}

		if($action == 'sum'){
			$sql.=") as t1";
		}			

		return $sql;
	}

	static function query($sql, $params = null){
		global $databaseResource;

		if(is_array($sql)){ return $sql; }
		if(empty($sql)){ return ""; }

		//handle_error($sql);
		$rows = array();
		$rst = mysqli_query(Utils::getMySQLResource($databaseResource), $sql);// or handle_error($sql." ".mysqli_error());
		
		if($rst === false){ throw new Exception("Invalid MySQL Resource: ".$sql, 400); }

		if(substr($sql,0,6) == "SELECT"){
			while($rows[] = mysqli_fetch_assoc($rst));
			/**
				* this pops the false assignment at the last
				* element of the array resulting from the
				* loop above
				**/
				array_pop($rows);
				return $rows;
			}
			elseif(substr($sql,0,6) == "UPDATE"){
			// note: gabbage in, gabbage out theory applies here
				if(ENABLE_API_FIELD_ENCRYPTION === TRUE){
	                if(isset($params["i7084"])){
						return array("id"=>$params["i7084"]);
					}					
	            }
	            else{
	            	if(isset($params["id"])){
						return array("id"=>$params["id"]);
					}
	            }
				
			}
			elseif(substr($sql,0,6) == "INSERT" || substr($sql,0,7) == "REPLACE"){
				// Regular expression pattern to match UUID
				$pattern = '/[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}/i';

				// Find all matches in the string
				preg_match_all($pattern, $sql, $matches);

				return array("id"=>$matches[0][0]);
			}
		}

		private static function getOtherParams($param){
			return array_diff_key($param, array_flip(MySQLQueryBuilder::$apiParamReserved));
		}
	}
?>
