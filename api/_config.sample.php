<?php
	/**
	 * This is the configuration file that drives the API
	 * Make a copy of this into the api root directorty (WEBSITE_BASE_DIRECTORY."api/")
	 * with the name _config.php; and update the values appropriately
	 **/
	$devMode = true;

	// Security levels
	define("FLEXIBLE_SECURITY", 1); 	// FLEXIBLE_SECURITY = TOKEN ONLY
	define("MORDERATE_SECURITY", 2); 	// MORDERATE_SECURITY = TOKEN + IP
	define("STRICT_SECURITY", 3); 		// STRICT_SECURITY = TOKEN + IP + USER_AGENT

	// Define Cache Engine
	define('CE_MEMCACHE', 1);
	define('CE_SESSION', 2);
	define('CE_FILESYSTEM', 3);
	define('CE_NONE', 4);

	// Define Database Engine
	define('MYSQL', 1);
	define('POSTGRESQL', 2);

	// Enable permission management
	define("ENABLE_PERMISSIONS", TRUE);

	// Enable audit
	define("ENABLE_AUDIT", FALSE);

	// Enable REST output encryption. Note: Javascript client must implement https://github.com/mdp/gibberish-aes
	define("REST_DATA_ENCRYPTION", FALSE);

	// Toggle debug mode
	define("API_DEBUG_MODE", FALSE);

	// Local mode API calls are REST requests, this setting will setup the environment as in PHP implementation 
	define("API_LOCAL_MODE", FALSE);

	// Force use of Advanced Email extension
	define("FORCE_ADVANCED_EMAIL", FALSE);

	// Login status
	define("ACTIVE_STATUS", 'active');
	define("DELETED_STATUS", 'deleted');

	// Required constants
	define("DEFAULT_DATABASE_CONNECTION_INDEX", "primary"); // This should contact the key to your default database config array
	define("WEBSITE_BASE_DIRECTORY", "/home/path/to/base/directorty/"); // Note the trailing slash is required
	define("API_BASE_DIRECTORY", WEBSITE_BASE_DIRECTORY."api/"); // Note the trailing slash is required
	define("XML_DEFINITIONS_DIRECTORY", API_BASE_DIRECTORY."api-xml-definitions/");
	define("API_LIBRARY_DIRECTORY", API_BASE_DIRECTORY."api-library/");
	define("INTELLI_CACHE_DIRECTORY", API_BASE_DIRECTORY."intelli-cache/");
	define("LOGS_DIRECTORY", WEBSITE_BASE_DIRECTORY."logs/");
	define("DEFAULT_SECURITY_LEVEL", FLEXIBLE_SECURITY);
	define("CACHE_ENGINE", CE_NONE);	
	define("API_EXTENSIONS_DIRECTORY", API_BASE_DIRECTORY."api-extensions/");
	define("PROJECT_EXTENSIONS_DIRECTORY", WEBSITE_BASE_DIRECTORY."portal/extensions/");
	define("API_BASE_URL", "http://api.domain.com/");
	define("DATABASE_ENGINE", MYSQL);

	define("WSITE_MEMCACHE_KEY_SEED", 'live_'.md5(API_BASE_URL));
	
	// Project specific constants
	define("FSCACHE_DIRECTORY", WEBSITE_BASE_DIRECTORY."fscache/");
	define("CDN_BASE_URL", "http://cdn.domain.com/");
	define("WEBSITE_DOMAIN", "http://domain.com/");
	define("BCC_EMAILS", "email1@domain.com, email2@domain.com");
	define("UPLOADS_DIRECTORY", WEBSITE_BASE_DIRECTORY."cdn/");

	// Encryption toggle
	define("ENABLE_API_FIELD_ENCRYPTION", FALSE);

	// Sendgrid config
	define('SENDGRID_API_KEY', 'SENDGRID_API_KEY');
	define('SMTP_HOST', 'smtp.sendgrid.net');
	define('SMTP_USERNAME', 'SMTP_USERNAME');
	define('SMTP_PASSWORD', SENDGRID_API_KEY);
	define('SMTP_SECURE', 'tls');
	define('SMTP_PORT', 587);

	// Project specific constants
	define('ADMIN_ROLE_ID',1);
	define('USER_ROLE_ID',2);
	define('PUBLIC_TOKEN','AfRiQoM444cd254a1d84b58872aef96d0fbb967');
	define('LIST_LIMIT',200);

	/***Database Resources***/
	define('PRIMARY_DBRES','primary');
	define('USERS_DBRES','users');


	// Project specific views
	$uiModels = array();

	require_once(WEBSITE_BASE_DIRECTORY.'db.config.php');

	// define api filename (nb: include file extension) .
	$apiFilename = "index.php";
?>

