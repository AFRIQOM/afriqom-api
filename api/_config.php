<?php
    /**
     * This is the configuration file that drives the API
     * Make a copy of this into the api root directorty (WEBSITE_BASE_DIRECTORY."api/")
     * with the name _config.php; and update the values appropriately
     **/
    $devMode = false;

    // Security levels
    define("FLEXIBLE_SECURITY", 1);     // FLEXIBLE_SECURITY = TOKEN ONLY
    define("MORDERATE_SECURITY", 2);    // MORDERATE_SECURITY = TOKEN + IP
    define("STRICT_SECURITY", 3);       // STRICT_SECURITY = TOKEN + IP + USER_AGENT

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
    define("API_LOCAL_MODE", TRUE);

    // Force use of Advanced Email extension
    define("FORCE_ADVANCED_EMAIL", FALSE);

    // Enable login country restriction, via the comma separated list to 2 alpha country codes in users.access_country_restriction
    define("ENABLE_LOGIN_COUNTRY_RESTRICTION", TRUE);

    // Login status
    define("ACTIVE_STATUS", 'active');
    define("DELETED_STATUS", 'deleted');

    // Required constants
    define("DEFAULT_DATABASE_CONNECTION_INDEX", "primary"); // This should contact the key to your default database config array
    define("WEBSITE_BASE_DIRECTORY", "/app/"); // Note the trailing slash is required
    define("API_BASE_DIRECTORY", WEBSITE_BASE_DIRECTORY."api/"); // Note the trailing slash is required
    define("XML_DEFINITIONS_DIRECTORY", API_BASE_DIRECTORY."api-xml-definitions/");
    define("API_LIBRARY_DIRECTORY", API_BASE_DIRECTORY."api-library/");
    define("INTELLI_CACHE_DIRECTORY", API_BASE_DIRECTORY."intelli-cache/");
    define("LOGS_DIRECTORY", "/logs/"); // Note the trailing slash is required
    define("DEFAULT_SECURITY_LEVEL", FLEXIBLE_SECURITY);
    define("CACHE_ENGINE", CE_NONE);    
    define("API_EXTENSIONS_DIRECTORY", API_BASE_DIRECTORY."api-extensions/");
    define("PROJECT_EXTENSIONS_DIRECTORY", WEBSITE_BASE_DIRECTORY."app/extensions/");
    define("API_BASE_URL", "http://nginx/api/");
    define("DATABASE_ENGINE", MYSQL);
    define("AZURE_MYSQL_SSL_CA", API_BASE_DIRECTORY."ssl/DigiCertGlobalRootCA.crt.pem");

    define("WSITE_MEMCACHE_KEY_SEED", 'live_'.md5(API_BASE_URL));
    
    // Project specific constants
    define("FSCACHE_DIRECTORY", WEBSITE_BASE_DIRECTORY."fscache/");
    define("CDN_BASE_URL", "http://nginx/cdn/");
    define("WEBSITE_DOMAIN", "http://nginx/");
    define("BCC_EMAILS", "");
    define("UPLOADS_DIRECTORY", API_BASE_DIRECTORY."cdn/");

    // Encryption toggle
    define("ENABLE_API_FIELD_ENCRYPTION", FALSE);

    // Sendgrid config
    define('SENDGRID_API_KEY', 'SENDGRID_API_KEY');
    define('SMTP_HOST', 'SMTP_HOST');
    define('SMTP_USERNAME', 'SMTP_USERNAME');
    define('SMTP_PASSWORD', 'SMTP_PASSWORD');
    define('SMTP_SECURE', 'tls');
    define('SMTP_PORT', 587);

    // Project specific views
    $uiModels = array();

    require_once(API_BASE_DIRECTORY.'db.config.php');

    // define api filename (nb: include file extension) .
    $apiFilename = "index.php";

?>