<?php
/**
 * Created by PhpStorm.
 * User: OrinJay
 * Date: 2015/8/4 0004
 * Time: 21:35
 */
return array(

    /* 数据库设置 */
    'DB_TYPE'               =>  'MySQL',     // 数据库类型
    'DB_HOST'               =>  'localhost', // 服务器地址
    'DB_NAME'               =>  'kiki_database',          // 数据库名
    'DB_USER'               =>  'root',      // 用户名
    'DB_PWD'                =>  '',          // 密码
    'DB_PORT'               =>  '3306',        // 端口
    'DB_PREFIX'             =>  'tb_',    // 数据库表前缀
    'DB_PARAMS'          	=>  array(), // 数据库连接参数
    'DB_DEBUG'  			=>  TRUE, // 数据库调试模式 开启后可以记录SQL日志
    'DB_FIELDS_CACHE'       =>  true,        // 启用字段缓存
    'DB_CHARSET'            =>  'utf8',      // 数据库编码默认采用utf8
    'DB_DEPLOY_TYPE'        =>  0, // 数据库部署方式:0 集中式(单一服务器),1 分布式(主从服务器)
    'DB_RW_SEPARATE'        =>  false,       // 数据库读写是否分离 主从式有效
    'DB_MASTER_NUM'         =>  1, // 读写分离后 主服务器数量
    'DB_SLAVE_NO'           =>  '', // 指定从服务器序号

    'LANG_SWITCH_ON'    => true,   // 开启语言包功能
    'LANG_AUTO_DETECT'  => true, // 自动侦测语言 开启多语言功能后有效
    'DEFAULT_LANG'      => 'en-us', // 默认语言
    'LANG_LIST'         => 'zh-cn, en-us, zh-tw', // 允许切换的语言列表 用逗号分隔
    'VAR_LANGUAGE'      => 'l', // 默认语言切换变量

    define('YES', true),
    define('NO', false),
    define('FORMAT_DATE', 'Y-m-d H:i:s'),

    //pages
    define('PAGE_ERROR', 'Error/index'),

    //session
    define('SESSION_ID', 'admin_id'),
    define('SESSION_USERNAME', 'admin_username'),

    //table name
    define('TB_SYSTEM', 'system'),
    define('TB_ADMIN', 'admin'),
    define('TB_MENU', 'menu'),
    define('TB_USER', 'user'),
    define('TB_LOG', 'log'),
    define('TB_GROUP', 'group'),
    define('TB_ACCESS', 'access'),
    define('TB_PROJECT', 'project'),
    define('TB_FEEDBACK', 'feedback'),
    define('TB_MESSAGE', 'message'),
    define('TB_BACKING_RECORD', 'backer_record'),
    define('TB_FOLLOW', 'follow'),
    define('TB_IDENTIFY_RECORD', 'identify_record'),
    define('TB_BLOCK_RECORD', 'block_record'),
    define('TB_BACKING_TYPE', 'backer_type'),
    define('TB_COMMENT', 'comment'),
    define('TB_GROUP_ACCESS', 'group_access'),

    //common
    define('ID', 'id'),
    define('USERNAME', 'username'),
    define('PASSWORD', 'password'),
    define('DATE', 'added_date'),
    define('OPERATOR_ID', 'added_by'),
    define('OPERATOR_NAME', 'added_name'),
    define('IS_SIGNED_IN_SUCCESS', 'isPassed'),
    define('SUCCESS', 'success'),
    define('ERROR', 'error'),
    define('FAILED', 'failed'),
    define('DIRECT_TO', 'goto'),
    define('SECONDS_AFTER_SUCCESS_DEFAULT', 1),
    define('SECONDS_AFTER_FAILED_DEFAULT', 3),
    define('USER_TYPE_ADMIN', 1),
    define('USER_TYPE_USER', 2),

    //tb_system
    define('SYSTEM_ID', 'id'),
    define('SYSTEM_NAME', 'name'),
    define('SYSTEM_IP', 'ip'),
    define('SYSTEM_DOMAIN', 'domain'),
    define('SYSTEM_KEYWORD', 'keyword'),
    define('SYSTEM_INTRODUCTION', 'introduction'),
    define('SYSTEM_WEBSITE_ENABLED', 'website_enable'),
    define('SYSTEM_SYSTEM_ENABLED', 'system_enable'),
    define('SYSTEM_WEBSITE_VERSION', 'website_version'),
    define('SYSTEM_SYSTEM_VERSION', 'system_version'),
    define('SYSTEM_OWNER', 'owner'),
    define('SYSTEM_MAIL', 'mail'),

    //tb_group
    define('GROUP_ID', 'id'),
    define('GROUP_NAME', 'name'),
    define('GROUP_LEVEL', 'level'),
    define('GROUP_DATE', 'added_date'),
    define('GROUP_OPERATOR_ID', 'added_by'),
    define('GROUP_DESCRIPTION', 'description'),
    define('GROUP_LEVEL_SUPER', 1),
    define('GROUP_LEVEL_SYSTEM', 2),
    define('GROUP_LEVEL_DEVELOPER', 3),
    define('GROUP_LEVEL_MAINTAIN', 4),
    define('GROUP_LEVEL_OPERATION', 5),
    define('GROUP_LEVEL_NORMAL', 6),

    //tb_access
    define('ACCESS_ID', 'id'),
    define('ACCESS_NAME', 'name'),
    define('ACCESS_MENU_ID', 'url'),
    define('ACCESS_LEVEL', 'level'),
    define('ACCESS_PARENT_ID', 'parent_id'),
    define('ACCESS_DATE', 'added_date'),
    define('ACCESS_OPERATOR_ID', 'added_by'),
    define('ACCESS_DESCRIPTION', 'description'),
    define('ACCESS_LEVEL_UNKNOWN', 0),
    define('ACCESS_LEVEL_CONTROLLER', 1),
    define('ACCESS_LEVEL_PAGE', 2),
    define('ACCESS_LEVEL_ACTION', 3),

    //tb_group_access
    define('GROUP_ACCESS_ID', 'id'),
    define('GROUP_ACCESS_DATE', 'added_date'),
    define('GROUP_ACCESS_OPERATOR_ID', 'added_by'),
    define('GROUP_ACCESS_LEVEL', 'level'),
    define('GROUP_ACCESS_ACCESS_ID', 'access_id'),
    define('GROUP_ACCESS_DESCRIPTION', 'description'),
    define('GROUP_ACCESS_ENABLED', 'enable'),

    //tb_admin
    define('ADMIN_ID', 'id'),
    define('ADMIN_USERNAME', 'username'),
    define('ADMIN_PASSWORD', 'password'),
    define('ADMIN_SALT', 'salt'),
    define('ADMIN_DATE', 'added_date'),
    define('ADMIN_OPERATOR_ID', 'added_by'),
    define('ADMIN_LAST_DATE', 'last_login_date'),
    define('ADMIN_LAST_IP', 'last_login_ip'),
    define('ADMIN_ONLINE', 'online'),
    define('ADMIN_ENABLED', 'enable'),
    define('ADMIN_SALT_TEST', 'test'),
    define('ADMIN_GROUP_ID', 'group_id'),

    //tb_menu
    define('MENU_ID', 'id'),
    define('MENU_NAME', 'name'),
    define('MENU_URL', 'url'),
    define('MENU_DATE', 'added_date'),
    define('MENU_OPERATOR_ID', 'added_by'),
    define('MENU_ENABLED', 'enable'),
    define('MENU_VISIBLE', 'visible'),
    define('MENU_LEVEL', 'level'),
    define('MENU_PARENT_ID', 'parent_id'),
    define('MENU_DESCRIPTION', 'description'),
    define('MENU_TYPE', 'type'),
    define('MENU_LEVEL_UNKNOWN', 0),
    define('MENU_LEVEL_CONTROLLER', 1),
    define('MENU_LEVEL_PAGE', 2),
    define('MENU_LEVEL_ACTION', 3),

    //tb_log
    define('LOG_ID', 'id'),
    define('LOG_DATE', 'added_date'),
    define('LOG_OPERATOR_ID', 'added_by'),
    define('LOG_CONTROLLER_ID', 'controller_id'),
    define('LOG_ACTION_ID', 'action_id'),
    define('LOG_REMARK', 'remark'),
    define('LOG_INFORMATION', 'information'),

    //tb_user
    define('USER_ID', 'id'),
    define('USER_USERNAME', 'username'),
    define('USER_PASSWORD', 'password'),
    define('USER_SALT', 'salt'),
);