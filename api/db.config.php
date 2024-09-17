<?php

    $databaseServer = $databaseName = $databaseUser = $databasePassword = $databasePort = array();

    $databaseServer["primary"] = getenv("DATABASE_SERVER", true) ?: "server_host_or_ip";
    $databaseName["primary"] = getenv("DATABASE_NAME", true) ?: "database_name";
    $databaseUser["primary"] = getenv("DATABASE_USER", true) ?: "database_user";
    $databasePassword["primary"] = getenv("DATABASE_PASSWORD", true) ?: "database_password";
    $databasePort["primary"] = getenv("DATABASE_PORT", true) ?: "3306";

    $databaseServer["users"] = getenv("ROLES_DATABASE_SERVER", true) ?: $databaseServer["primary"];
    $databaseName["users"] = getenv("ROLES_DATABASE_NAME", true) ?: "roles_database_name";
    $databaseUser["users"] = getenv("ROLES_DATABASE_USER", true) ?: $databaseUser["primary"];
    $databasePassword["users"] = getenv("ROLES_DATABASE_PASSWORD", true) ?: $databasePassword["primary"];
    $databasePort["users"] = getenv("ROLES_DATABASE_PORT", true) ?: $databasePort["primary"];
?>