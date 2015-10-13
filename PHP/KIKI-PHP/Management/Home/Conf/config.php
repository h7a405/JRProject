<?php
return array(
	//'配置项'=>'配置值'

    /**
     * management
     */
    //settings
    define('YES', true),
    define('NO', false),
    define('FORMAT_DATE', 'Y-m-d H:i:s'),

    //pages
    define('PAGE_ERROR', 'Error/index'),

    //session
    define('SESSION_ADMIN_ID', 'KIKI_ADMIN_ID'),
    define('SESSION_ADMIN_USERNAME', 'KIKI_ADMIN_USERNAME'),

    //database:db_kiki
    define('DB_USER', 'user_admin'),
    define('DB_LOG', 'log_admin'),
    define('DB_MENU', 'menu_admin'),
    define('DB_SYSTEM', 'system_info'),
    define('DB_PERMISSION', 'permission'),
    define('DB_GROUP', 'group'),
    define('DB_AUTHORITY', 'authority'),

    //database:system_info
    define('SYSTEM_INFO_OPENED', 'issystemopened'),
    define('SYSTEM_INFO_NAME', 'name'),
    define('SYSTEM_INFO_DOMAIN', 'domain'),
    define('SYSTEM_INFO_IP', 'ip'),
    define('SYSTEM_INFO_VISIBLE', 'iskikiopened'),
    define('SYSTEM_INFO_ID', 'id'),

    //database:user_admin
    define('USER_ADMIN_USERNAME', 'username'),
    define('USER_ADMIN_PASSWORD', 'password'),
    define('USER_ADMIN_ID', 'id'),
    define('USER_ADMIN_NICKNAME', 'nickname'),
    define('USER_ADMIN_ADDED_DATE', 'datetime_added'),
    define('USER_ADMIN_ADDED_BY', 'id_user_added'),
    define('USER_ADMIN_GENDER', 'gender'),
    define('USER_ADMIN_SALT', 'salt'),
    define('USER_ADMIN_BIRTHDAY', 'birthday'),
    define('USER_ADMIN_DATE_LOGIN_LAST', 'lasttime_login'),
    define('USER_ADMIN_IP_LOGIN_LAST', 'lastip_login'),
    define('USER_ADMIN_MAC_LOGIN_LAST', 'lastmac_login'),
    define('USER_ADMIN_LOGINED', 'isonline'),

    //database:log_admin
    define('LOG_ADMIN_ID', 'id'),
    define('LOG_ADMIN_DATE', 'datetime_added'),
    define('LOG_ADMIN_OPERATOR', 'id_user_added'),
    define('LOG_ADMIN_MODULE', 'module_operated'),
    define('LOG_ADMIN_FUNCTION', 'function_operated'),
    define('LOG_ADMIN_INFORMATION', 'information'),
    define('LOG_ADMIN_DETAILS', 'details'),

    //database:menu_admin
    define('MENU_ADMIN_ID', 'id'),
    define('MENU_ADMIN_NAME', 'name'),
    define('MENU_ADMIN_LEVEL', 'level'),
    define('MENU_ADMIN_FATHER', 'id_father'),
    define('MENU_ADMIN_ADDED_DATE', 'datetime_added'),
    define('MENU_ADMIN_ADDED_BY', 'id_user_added'),
    define('MENU_ADMIN_INTRODUCTION', 'introduction'),
    define('MENU_ADMIN_URL', 'url'),
    define('MENU_ADMIN_VISIBLE', 'isvisible'),
    define('MENU_ADMIN_TYPE', 'type'),
    define('MENU_ADMIN_AVAILABLE', 'isavailable'),

    //database:group
    define('GROUP_ID', 'id'),
    define('GROUP_NAME', 'name'),
    define('GROUP_INTRODUCTION', 'introduction'),
    define('GROUP_ADDED_DATE', 'datetime_added'),
    define('GROUP_ADDED_BY', 'id_user_added'),
    define('GROUP_TYPE', 'type'),
    define('GROUP_CAPACITY', 'capacity'),
    define('GROUP_ENABLED', 'isenabled'),

    //database:permission
    define('PERMISSION_ID_MENU', 'id_menu'),
    define('PERMISSION_ID', 'id'),
    define('PERMISSION_NAME', 'name'),
    define('PERMISSION_INTRODUCTION', 'introduction'),
    define('PERMISSION_ADDED_DATE' ,'datetime_added'),
    define('PERMISSION_ADDED_BY', 'id_user_added'),
    define('PERMISSION_ENABLED', 'isenabled'),
    define('PERMISSION_TYPE', 'type'),


    //database:group_permission
    define('AUTHORITY_ID', 'id'),
    define('AUTHORITY_ID_PERMISSION', 'id_permission'),
    define('AUTHORITY_ID_GROUP', 'id_group'),
    define('AUTHORITY_ADDED_DATE', 'datetime_added'),
    define('AUTHORITY_ADDED_BY', 'id_user_added'),
    define('AUTHORITY_ENABLED', 'isenabled'),
);