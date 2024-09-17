<?php
include_once(API_LIBRARY_DIRECTORY."_denyDirectAccess.php");

class PGQueryBuilder{
	// api url param/keyworkds reserved for system use only
	private static $apiParamReservedDefault = array("f","fields","orderby","token","filter","limit", "offset","dbres","intelli-cache","fmt","sysaudit");
	private static $apiParamReserved = array();
	private static $fieldMaps = array();

	static function prepare($action, $xmlObject, $param, $filter = null){
		global $databaseResource;
		self::$fieldMaps = array();
		self::$apiParamReserved = array();
		$tableName = $xmlObject->table->attributes()->name;
		$userFields = $userFieldMaps = $execMaps = array();
		$ctr = 0;
		if(isset($param["fields"])){
			$userFields = explode(",", $param["fields"]);
		}else{
			$rst = pg_query(Utils::getMySQLResource($databaseResource), "SELECT distinct(jsonb_object_keys(data)) as field FROM ".$tableName);
			$userFields["id"] = "id";
			while($row = pg_fetch_assoc($rst)){
				if(!empty($row["field"])){
					$userFields[$row["field"]] = $row["field"];
				}
			}
			if(sizeof($userFields)==1 && isset($userFields["id"])){
				foreach ($param as $key => $value) {
					if(in_array($key, self::$apiParamReservedDefault)) continue;
					$userFields = array_merge($userFields, array($key => $key));
				}
			}
		}
		foreach ($userFields as $key => $value) {
			$userFieldMaps[$value] = $value;
		}
		
		switch($action){
			case "sum":
			case "count":
			case "list":
				self::$apiParamReserved = self::$apiParamReservedDefault;
				return self::prepareSelect($tableName, $param, $userFieldMaps, $execMaps, $filter, $action);
			case "delete": // proceed to save
			case "save":
				self::$apiParamReserved = array_merge(self::$apiParamReservedDefault,array("id"));
				return self::prepareSave($tableName, $param, $userFieldMaps, $execMaps);
			case "replace":
				self::$apiParamReserved = self::$apiParamReservedDefault;
				return self::prepareReplace($tableName, $param, $userFieldMaps, $execMaps);
		}
	}

	private static function prepareSave($tableName, $param, $userFieldMaps){
		global $databaseResource;
		// Do not edit lines below unless you are a geek
		$sql = $whereClause = "";
		if(count(self::getOtherParams($param))){
			if(ENABLE_API_FIELD_ENCRYPTION === TRUE){
                if(isset($param["i7084"])){
                	$type = "update";
					$sql = "UPDATE ".$tableName." SET data = data ";
					$whereClause = " WHERE ".$userFieldMaps["i7084"]." in (".$param["i7084"].")";
				}
				else{
					$type = "insert";
					$sql = "INSERT INTO ".$tableName." (data) VALUES ('{";
				}
            }
            else{
            	if(isset($param["id"])){
            		$type = "update";
					$sql = "UPDATE ".$tableName." SET data = data ";
					$whereClause = " WHERE ".$userFieldMaps["id"]." in (".$param["id"].")";
				}
				else{
					$type = "insert";
					$sql = "INSERT INTO ".$tableName." (data) VALUES ('{";
				}
            }
		}
		// build where clause if conditions exists
		foreach(self::getOtherParams($param) as $key => $value){
			if(array_key_exists($key,$userFieldMaps)){
				if($type == "update")
					$sql.="|| '{\"".$userFieldMaps[$key]."\":\"".pg_escape_string(Utils::getMySQLResource($databaseResource), $value)."\"}' ";
				else
					$sql.="\"".$userFieldMaps[$key]."\":\"".pg_escape_string(Utils::getMySQLResource($databaseResource), $value)."\",";
			}
			else{
				throw new Exception("Unknown column '{$key}' in 'where clause'", 400);
			}
		}
		$sql = rtrim($sql,", ").(($type=="insert") ? "}')" : "").$whereClause;
		return $sql;
	}

	private static function prepareReplace($tableName, $param, $userFieldMaps){
		// Do not edit lines below unless you are a geek
		$sql = $whereClause = "";
		if(count(self::getOtherParams($param))){
			$sql = "REPLACE INTO ".$tableName." SET ";
		}
		// build where clause if conditions exists
		foreach(self::getOtherParams($param) as $key => $value){
			if(array_key_exists($key,$userFieldMaps)){
				$sql.="".$userFieldMaps[$key]." = \"".$value."\", ";
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

		/*if($filter[0] == 'distinct'){
			$sql.="DISTINCT(".$filter[1].") as \"".$filter[1]."\", ";
			unset($userFieldMaps[$filter[1]]);
		}*/

		foreach($userFieldMaps as $key => $value){
			if($action == 'count'){
				$sql.="count(*) as count";
				break;
			}

			if($action == 'sum'){
				$sql.="sum(".$value.") as sum from (select ".$value;
			}			

			if($filter == null && $action != 'sum'){
				if($value == "id"){
					$sql.="".$value." as ".$key.", ";
				}else{
					$sql.="data->>'".$value."' as ".$key.", ";
				}
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

					if($value == "id"){
						$sql.="".$value." as ".$key.", ";
					}else{
						if($filter[1] == $value){
							$sql.="split_part(data->>'".$value."', '".$needle."', ".(is_numeric($filter[3])?$filter[3]:1).") as ".$key.", ";
						}else{
							$sql.="data->>'".$value."' as ".$key.", ";
						}
					}

					break;					

					default:
					if($action != 'sum'){
						$sql.="".$value." as ".$key.", ";
					}
					break;
				}
			}
		}
		$sql = rtrim($sql,", ");
		$sql.=" FROM ".$tableName;

		// build where clause if conditions exists
		if(count(self::getOtherParams($param))){ $sql.=" WHERE 1=1"; }
		foreach(self::getOtherParams($param) as $key => $value){
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

			$value = "'".$valueTmp."'";

			if($hasGT){
				$operator = ">";
				$value = $valueTmp;
			}

			if($hasLT){
				$operator = "<";
				$value = $valueTmp;
			}

			if($hasGE){
				$operator = ">=";
				$value = $valueTmp;
			}

			if($hasLE){
				$operator = "<=";
				$value = $valueTmp;
			}

			if($hasLike){
				$operator = "LIKE";
				$value = "%".$valueTmp."%";
			}

			if($hasNotLike){
				$operator = "NOT LIKE";
				$value = "%".$valueTmp."%";
			}

			if($hasNotIn){
				$operator = "NOT IN";
				$value = "('".implode("','", explode(",", $valueTmp))."')";
			}

			if($hasIn){
				$operator = "IN";
				$value = "('".implode("','", explode(",", $valueTmp))."')";
			}

			if($hasBetween){
				$operator = "BETWEEN";
				$value = "'".implode("' AND '", explode(",", $valueTmp))."'";
			}
			if($hasLike || $hasNotLike){
				if($userFieldMaps[$key] == "id"){
					$sql.=" AND ".(($hasNot)?"NOT":"")." COALESCE('".$userFieldMaps[$key]."',0) ".$operator." ".$value."";
				}else{
					$sql.=" AND ".(($hasNot)?"NOT":"")." COALESCE(data->>'".$userFieldMaps[$key]."','') ".$operator." ".$value."";
				}
			}else{
				if($userFieldMaps[$key] == "id"){
					$sql.=" AND ".(($hasNot)?"NOT":"")." ".$userFieldMaps[$key]." ".$operator." ".$value."";
				}else{
					$sql.=" AND ".(($hasNot)?"NOT":"")." data->>'".$userFieldMaps[$key]."' ".$operator." ".$value."";
				}
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
		$rst = pg_query(Utils::getMySQLResource($databaseResource), $sql);// or handle_error($sql." ".mysqli_error());
		
		if($rst === false){ throw new Exception("Invalid MySQL Resource: ".$sql, 400); }

		if(substr($sql,0,6) == "SELECT"){
			while($rows[] = pg_fetch_assoc($rst));
			/**
				* this pops the fasle assignment as the last
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
			elseif(substr($sql,0,6) == "INSERT"){
				$rst = pg_query(Utils::getMySQLResource($databaseResource), "SELECT LASTVAL() as last_id;");
				$row = pg_fetch_assoc($rst);
				return array("id"=>$row["last_id"]);
			}
			elseif(substr($sql,0,7) == "REPLACE"){
				$rst = pg_query(Utils::getMySQLResource($databaseResource), "SELECT LASTVAL() as last_id;");
				$row = pg_fetch_assoc($rst);
				return array("id"=>$row["last_id"]);
			}
		}

		private static function getOtherParams($param){
			return array_diff_key($param, array_flip(self::$apiParamReserved));
		}
	}
?>
