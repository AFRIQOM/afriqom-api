<?php
session_start(); // WARNING: Place nothing above this line and do not delete
error_reporting(E_ERROR | E_PARSE);

include_once("_config.php");

switch (DATABASE_ENGINE) {
	case POSTGRESQL:
		header("Location: pg.xmlgen.php");
		exit;
}

/**
 * @todo make this executable from console
 */

// including classes
include_once(API_LIBRARY_DIRECTORY . "Permissions.php");
include_once(API_LIBRARY_DIRECTORY . "Utils.php");
include_once(API_LIBRARY_DIRECTORY . "MySQLQueryBuilder.php");
include_once(API_LIBRARY_DIRECTORY . "IExtensions.php");
include_once(API_LIBRARY_DIRECTORY . "Extensions.php");

$runFromConsole = false;

$end_of_line = ($runFromConsole) ? "\n" : "<br/>";

if (!file_exists(XML_DEFINITIONS_DIRECTORY . "primary.sessions.xml")) {
	echo "-------------------------------------------------" . $end_of_line;
	echo "primary.session.xml not found in xml definitions" . $end_of_line;
	echo "-------------------------------------------------" . $end_of_line;
}

foreach ($databaseServer as $databaseResource => $settings) {
	if (isset($_GET['dbres']) && $_GET['dbres'] != $databaseResource) {
		continue;
	}
	Utils::createMySQLResource($databaseResource);
	$rst = mysqli_query(Utils::getMySQLResource($databaseResource), "show tables");

	echo "--- Generating XML: dbres=" . $databaseResource . " ---" . $end_of_line;
	while ($row = mysqli_fetch_assoc($rst)) {
		$rst2 = mysqli_query(Utils::getMySQLResource($databaseResource), "describe " . $row["Tables_in_" . $dbName]);

		$xml = "<?xml version=\"1.0\" encoding=\"utf-8\"?>\n";
		$xml .= "<" . $row["Tables_in_" . $dbName] . ">\n";
		$xml .= "<table name=\"" . $row["Tables_in_" . $dbName] . "\">\n";

		while ($row2 = mysqli_fetch_assoc($rst2)) {
			if (ENABLE_API_FIELD_ENCRYPTION === TRUE) {
				$char = substr($row2["Field"], 0, 1);
				$data = base64_encode(gzdeflate($row2["Field"]));
				$xml .= "<field api_field=\"" . $char . substr(crc32($data), 0, 4) . "\">" . $row2["Field"] . "</field>\n";
			} else {
				$xml .= "<field api_field=\"" . $row2["Field"] . "\">" . $row2["Field"] . "</field>\n";
			}
		}
		$xml .= "</table>\n";
		$xml .= "<access mode=\"rw\" />\n";
		$xml .= "</" . $row["Tables_in_" . $dbName] . ">\n";
		file_put_contents(XML_DEFINITIONS_DIRECTORY . "/" . $databaseResource . '.' . $row["Tables_in_" . $dbName] . ".xml", $xml);
		echo $databaseResource . '.' . $row["Tables_in_" . $dbName] . ".xml" . $end_of_line;
	}
}

if (ENABLE_PERMISSIONS === TRUE) {
	// Create Administrator Role
	echo "--- Creating Administrator Role ---" . $end_of_line;
	$currentResource = $databaseResource;
	$databaseResource = 'users';
	Utils::createMySQLResource($databaseResource);

	if (ENABLE_API_FIELD_ENCRYPTION === TRUE) {
		$param = array('fields' => 'i7084,n3963', 'n3963' => 'Administrator');
	} else {
		$param = array('fields' => 'id,name', 'name' => 'Administrator');
	}
	$xml = simplexml_load_file(XML_DEFINITIONS_DIRECTORY . $databaseResource . '.roles.xml');
	$adminRole = MySQLQueryBuilder::query(MySQLQueryBuilder::prepare('list', $xml, $param, null));

	if (ENABLE_API_FIELD_ENCRYPTION === TRUE) {
		$roleID = @$adminRole[0]['i7084'];
	} else {
		$roleID = @$adminRole[0]['id'];
	}
	if (!$roleID) {
		if (ENABLE_API_FIELD_ENCRYPTION === TRUE) {
			$param = array('n3963' => 'Administrator', 'd9984' => 'This is the Administrator role');
		} else {
			$param = array('name' => 'Administrator', 'description' => 'This is the Administrator role');
		}
		$result = MySQLQueryBuilder::query(MySQLQueryBuilder::prepare('save', $xml, $param, null));
		echo "--- Administrator role created ---" . $end_of_line;
		$roleID = (isset($result['i7084'])) ? $result['i7084'] : $result['id'];
	} else {
		echo "--- Administrator role already created ---" . $end_of_line;
	}
	echo "--- Assigning/Updating Administrator Permissions ---" . $end_of_line;
	populateAdminRolePermissions($roleID, $databaseResource);

	populateAdminRoleExtentionPermissions($roleID, $databaseResource);
	populateAdminUIModelPermissions($roleID, $databaseResource);
	Utils::createMySQLResource($currentResource);
}

function populateAdminRolePermissions($roleID, $databaseResource)
{
	global $end_of_line;
	foreach (scandir(XML_DEFINITIONS_DIRECTORY) as $key => $value) {
		if ($value == '.' || $value == '..') {
			continue;
		}
		$parts = explode('.', $value);
		if (sizeof($parts) == 3 && $parts[1]) {
			$model = 'api.' . $parts[0] . '.' . $parts[1];
			$permissions = implode('', Permissions::getConstants());

			if (ENABLE_API_FIELD_ENCRYPTION === TRUE) {
				$param = array('fields' => 'i7084,r1184,m2184', 'm2184' => $model, 'r1184' => $roleID);
			} else {
				$param = array('fields' => 'id,role_id,model', 'model' => $model, 'role_id' => $roleID);
			}
			$xml = simplexml_load_file(XML_DEFINITIONS_DIRECTORY . $databaseResource . '.permissions.xml');
			$role = MySQLQueryBuilder::query(MySQLQueryBuilder::prepare('list', $xml, $param, null));

			if (ENABLE_API_FIELD_ENCRYPTION === TRUE) {
				$role = @$role[0]['i7084'];
			} else {
				$role = @$role[0]['id'];
			}
			if ($role) {
				if (ENABLE_API_FIELD_ENCRYPTION === TRUE) {
					$param = array('r1184' => $roleID, 'm2184' => $model, 'p5574' => $permissions, 'i7084' => $role);
				} else {
					$param = array('role_id' => $roleID, 'model' => $model, 'permissions' => $permissions, 'id' => $role);
				}
			} else {
				if (ENABLE_API_FIELD_ENCRYPTION === TRUE) {
					$param = array('r1184' => $roleID, 'm2184' => $model, 'p5574' => $permissions);
				} else {
					$param = array('role_id' => $roleID, 'model' => $model, 'permissions' => $permissions);
				}
			}
			$xml = simplexml_load_file(XML_DEFINITIONS_DIRECTORY . $databaseResource . '.permissions.xml');
			MySQLQueryBuilder::query(MySQLQueryBuilder::prepare('save', $xml, $param, null));
			echo $model . $end_of_line;
		}
	}
	return true;
}

function populateAdminRoleExtentionPermissions($roleID, $databaseResource)
{
	global $end_of_line;
	echo "--- Assigning/Updating Administrator extension Permissions ---" . $end_of_line;
	foreach (getDirContents(API_EXTENSIONS_DIRECTORY) as $key => $filePath) {
		echo $filePath . "<br/>";
		processExtensions($filePath, $databaseResource, $roleID);
	}
	foreach (getDirContents(PROJECT_EXTENSIONS_DIRECTORY) as $key => $filePath) {
		processExtensions($filePath, $databaseResource, $roleID);
	}
}

function processExtensions($filePath, $databaseResource, $roleID)
{
	global $end_of_line;
	$filePath = str_replace("\\", "/", $filePath); // windows
	$extensionPath = $filePath;
	$pathParts = explode('/', $filePath);
	$filename = @end($pathParts);
	$function = @current(explode('.', $filename));
	$action = @prev($pathParts);
	if (file_exists($extensionPath)) {
		$extention = file_get_contents($extensionPath);
		if (strpos($extention, 'extends') !== false && strpos($extention, 'Extensions') !== false) {
			$model = 'api.ext.' . $action . '.' . $function;
			$permissions = implode('', array_values(Permissions::getConstants()));

			if (ENABLE_API_FIELD_ENCRYPTION === TRUE) {
				$param = array('fields' => 'i7084,r1184,m2184', 'm2184' => $model, 'r1184' => $roleID);
			} else {
				$param = array('fields' => 'id,role_id,model', 'model' => $model, 'role_id' => $roleID);
			}
			$xml = simplexml_load_file(XML_DEFINITIONS_DIRECTORY . $databaseResource . '.permissions.xml');
			$role = MySQLQueryBuilder::query(MySQLQueryBuilder::prepare('list', $xml, $param, null));

			if (ENABLE_API_FIELD_ENCRYPTION === TRUE) {
				$role = @$role[0]['i7084'];
			} else {
				$role = @$role[0]['id'];
			}
			if ($role) {
				if (ENABLE_API_FIELD_ENCRYPTION === TRUE) {
					$param = array('r1184' => $roleID, 'm2184' => $model, 'p5574' => $permissions, 'i7084' => $role);
				} else {
					$param = array('role_id' => $roleID, 'model' => $model, 'permissions' => $permissions, 'id' => $role);
				}
			} else {
				if (ENABLE_API_FIELD_ENCRYPTION === TRUE) {
					$param = array('r1184' => $roleID, 'm2184' => $model, 'p5574' => $permissions);
				} else {
					$param = array('role_id' => $roleID, 'model' => $model, 'permissions' => $permissions);
				}
			}

			MySQLQueryBuilder::query(MySQLQueryBuilder::prepare('save', $xml, $param, null));
			echo $model . $end_of_line;
		}
	}
}

function populateAdminUIModelPermissions($roleID, $databaseResource)
{
	global $uiModels, $end_of_line;
	echo "--- Assigning/Updating Administrator UI Model Permissions ---" . $end_of_line;
	if ($uiModels) {
		foreach ($uiModels as $key => $view) {
			$model = 'ui.' . $view;
			$permissions = implode('', array_values(Permissions::getConstants()));

			if (ENABLE_API_FIELD_ENCRYPTION === TRUE) {
				$param = array('fields' => 'i7084,r1184,m2184', 'm2184' => $model, 'r1184' => $roleID);
			} else {
				$param = array('fields' => 'id,role_id,model', 'model' => $model, 'role_id' => $roleID);
			}
			$xml = simplexml_load_file(XML_DEFINITIONS_DIRECTORY . $databaseResource . '.permissions.xml');
			$role = MySQLQueryBuilder::query(MySQLQueryBuilder::prepare('list', $xml, $param, null));

			if (ENABLE_API_FIELD_ENCRYPTION === TRUE) {
				$role = @$role[0]['i7084'];
			} else {
				$role = @$role[0]['id'];
			}
			if ($role) {
				if (ENABLE_API_FIELD_ENCRYPTION === TRUE) {
					$param = array('r1184' => $roleID, 'm2184' => $model, 'p5574' => $permissions, 'i7084' => $role);
				} else {
					$param = array('role_id' => $roleID, 'model' => $model, 'permissions' => $permissions, 'id' => $role);
				}
			} else {
				if (ENABLE_API_FIELD_ENCRYPTION === TRUE) {
					$param = array('r1184' => $roleID, 'm2184' => $model, 'p5574' => $permissions);
				} else {
					$param = array('role_id' => $roleID, 'model' => $model, 'permissions' => $permissions);
				}
			}
			MySQLQueryBuilder::query(MySQLQueryBuilder::prepare('save', $xml, $param, null));
			echo $model . $end_of_line;
		}
	}
}

function getDirContents($dir, &$results = array())
{
	global $end_of_line;
	$files = @scandir($dir);
	if (!$files) {
		echo strtoupper("--- Extensions Directory does not exist ---") . $end_of_line;
		$result = array();
	} else {
		foreach ($files as $key => $value) {
			$path = realpath($dir . DIRECTORY_SEPARATOR . $value);
			$filename = @end(explode('/', $path));
			if (!is_dir($path)) {
				if (is_file($path) && $filename[0] != ".")
					$results[] = $path;
			} else if ($value != "." && $value != "..") {
				getDirContents($path, $results);
				if (is_file($path) && $filename[0] != ".")
					$results[] = $path;
			}
		}
	}
	return $results;
}

echo "--- Completed ---" . $end_of_line;
