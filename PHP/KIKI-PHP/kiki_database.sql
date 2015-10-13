-- phpMyAdmin SQL Dump
-- version 4.3.11
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: 2015-08-09 16:49:45
-- 服务器版本： 5.6.24
-- PHP Version: 5.6.8

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `kiki_database`
--

-- --------------------------------------------------------

--
-- 表的结构 `tb_access`
--

CREATE TABLE IF NOT EXISTS `tb_access` (
  `id` int(8) NOT NULL,
  `name` varchar(32) CHARACTER SET utf8 DEFAULT NULL,
  `url` int(8) DEFAULT NULL,
  `level` tinyint(4) NOT NULL,
  `parent_id` int(8) DEFAULT NULL,
  `added_date` datetime NOT NULL,
  `added_by` int(8) DEFAULT NULL,
  `description` text CHARACTER SET utf8
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=latin1;

--
-- 转存表中的数据 `tb_access`
--

INSERT INTO `tb_access` (`id`, `name`, `url`, `level`, `parent_id`, `added_date`, `added_by`, `description`) VALUES
(1, 'Access:Index', 1, 1, 0, '2015-08-09 09:47:45', 1, 'Description of access:Index'),
(2, 'Access:index', 2, 0, 0, '2015-08-09 09:47:45', 1, 'Description of access:index'),
(3, 'Access:Login', 3, 1, 0, '2015-08-09 11:58:51', 1, 'Description of access:Login'),
(4, 'Access:login', 4, 0, 0, '2015-08-09 11:58:51', 1, 'Description of access:login'),
(5, 'Access:doLogin', 5, 0, 0, '2015-08-09 11:59:28', 1, 'Description of access:doLogin'),
(6, 'Access:menu_edit', 8, 0, 0, '2015-08-09 17:35:32', 1, 'Description of access:menu_edit'),
(7, 'Access:postNewMenu', 9, 0, 0, '2015-08-09 17:37:23', 1, 'Description of access:postNewMenu'),
(8, 'Access:Menu', 6, 1, 0, '2015-08-09 21:53:38', 1, 'Description of access:'),
(9, 'Access:Menu List', 7, 2, 8, '2015-08-09 21:55:14', 1, 'Description of access:'),
(10, 'Access:System', 10, 1, NULL, '2015-08-09 22:17:54', 1, 'Description of access:System'),
(11, 'Access:System Information', 11, 2, NULL, '2015-08-09 22:21:59', 1, 'Description of access:System Information'),
(12, 'Access:Database Management', 12, 2, NULL, '2015-08-09 22:25:03', 1, 'Description of access:Database Management'),
(13, 'Access:Log', 13, 1, NULL, '2015-08-09 22:28:05', 1, 'Description of access:Log'),
(14, 'Access:Log List', 14, 2, NULL, '2015-08-09 22:28:27', 1, 'Description of access:Log List'),
(15, 'Access:doLogout', 15, 0, 0, '2015-08-09 22:30:00', 1, 'Description of access:doLogout'),
(16, 'Access:Group', 16, 1, NULL, '2015-08-09 22:31:53', 1, 'Description of access:Group'),
(17, 'Access:Group List', 17, 2, NULL, '2015-08-09 22:32:06', 1, 'Description of access:Group List'),
(18, 'Access:Group Access', 18, 2, NULL, '2015-08-09 22:32:46', 1, 'Description of access:Group Access'),
(19, 'Access:User', 19, 1, NULL, '2015-08-09 22:32:59', 1, 'Description of access:User'),
(20, 'Access:User List', 20, 2, NULL, '2015-08-09 22:33:15', 1, 'Description of access:User List'),
(21, 'Access:Admin List', 21, 2, NULL, '2015-08-09 22:33:26', 1, 'Description of access:Admin List'),
(22, 'Access:index', 22, 0, 0, '2015-08-09 22:33:35', 1, 'Description of access:index'),
(23, 'Access:Message', 23, 1, NULL, '2015-08-09 22:35:01', 1, 'Description of access:Message'),
(24, 'Access:Message Feedback', 24, 2, NULL, '2015-08-09 22:35:19', 1, 'Description of access:Message Feedback'),
(25, 'Access:Message Report', 25, 2, NULL, '2015-08-09 22:35:48', 1, 'Description of access:Message Report'),
(26, 'Access:Block', 26, 1, NULL, '2015-08-09 22:36:17', 1, 'Description of access:Block'),
(27, 'Access:Block User List', 27, 2, NULL, '2015-08-09 22:36:38', 1, 'Description of access:Block User List'),
(28, 'Access:Project', 28, 1, NULL, '2015-08-09 22:43:26', 1, 'Description of access:Project'),
(29, 'Access:Review List', 29, 2, NULL, '2015-08-09 22:44:47', 1, 'Description of access:Review List'),
(30, 'Access:Project List', 30, 2, NULL, '2015-08-09 22:45:00', 1, 'Description of access:Project List'),
(31, 'Access:Identify List', 31, 2, NULL, '2015-08-09 22:46:22', 1, 'Description of access:Identify List');

-- --------------------------------------------------------

--
-- 表的结构 `tb_admin`
--

CREATE TABLE IF NOT EXISTS `tb_admin` (
  `id` int(8) NOT NULL,
  `username` varchar(18) CHARACTER SET utf8 NOT NULL,
  `password` text NOT NULL,
  `salt` text NOT NULL,
  `added_date` datetime NOT NULL,
  `added_by` int(8) DEFAULT NULL,
  `last_login_date` datetime DEFAULT NULL,
  `last_login_ip` varchar(16) DEFAULT NULL,
  `online` tinyint(1) NOT NULL DEFAULT '0',
  `enable` tinyint(1) NOT NULL DEFAULT '1',
  `group_id` int(8) DEFAULT '0'
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

--
-- 转存表中的数据 `tb_admin`
--

INSERT INTO `tb_admin` (`id`, `username`, `password`, `salt`, `added_date`, `added_by`, `last_login_date`, `last_login_ip`, `online`, `enable`, `group_id`) VALUES
(1, 'superadmin', 'jN4wIg/0KwPq1HpR//gNDw==', 'a2lraXN1cGVyYWRtaW4=', '2015-08-09 11:01:31', 0, '2015-08-09 22:47:46', '127.0.0.1', 0, 1, 1);

-- --------------------------------------------------------

--
-- 表的结构 `tb_group`
--

CREATE TABLE IF NOT EXISTS `tb_group` (
  `id` int(8) NOT NULL,
  `name` varchar(32) CHARACTER SET utf8 NOT NULL,
  `added_date` datetime NOT NULL,
  `added_by` int(8) DEFAULT NULL,
  `level` tinyint(4) NOT NULL DEFAULT '6',
  `description` text CHARACTER SET utf8
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;

--
-- 转存表中的数据 `tb_group`
--

INSERT INTO `tb_group` (`id`, `name`, `added_date`, `added_by`, `level`, `description`) VALUES
(1, 'SuperAdmin', '2015-08-09 17:42:49', 1, 1, NULL),
(2, 'SystemAdmin', '2015-08-09 17:43:00', 1, 2, NULL),
(3, 'Developer', '2015-08-09 17:43:42', 1, 3, NULL),
(4, 'MaintainAdmin', '2015-08-09 17:43:56', 1, 4, NULL),
(5, 'OperationAdmin', '2015-08-09 17:44:21', 1, 5, NULL),
(6, 'Admin', '2015-08-09 17:44:34', 1, 6, NULL);

-- --------------------------------------------------------

--
-- 表的结构 `tb_group_access`
--

CREATE TABLE IF NOT EXISTS `tb_group_access` (
  `id` int(11) NOT NULL,
  `added_date` datetime NOT NULL,
  `added_by` int(8) DEFAULT NULL,
  `level` tinyint(4) NOT NULL,
  `acces_id` int(8) NOT NULL,
  `enable` tinyint(1) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- 表的结构 `tb_log`
--

CREATE TABLE IF NOT EXISTS `tb_log` (
  `id` int(8) NOT NULL,
  `added_date` datetime NOT NULL,
  `added_by` int(8) DEFAULT NULL,
  `controller_id` int(8) DEFAULT NULL,
  `action_id` int(8) DEFAULT NULL,
  `information` text CHARACTER SET utf8,
  `remark` text CHARACTER SET utf8
) ENGINE=InnoDB AUTO_INCREMENT=67 DEFAULT CHARSET=latin1;

--
-- 转存表中的数据 `tb_log`
--

INSERT INTO `tb_log` (`id`, `added_date`, `added_by`, `controller_id`, `action_id`, `information`, `remark`) VALUES
(1, '2015-08-09 09:47:45', 0, 1, NULL, 'LANG_MENU_RECORD_INSERTName of Menu:Index | URL of Menu:Index | Level Controller', 'Unknown user or done by system. Unknown Action:index. '),
(2, '2015-08-09 09:47:45', 0, 1, NULL, 'LANG_ACCESS_RECORD_INSERTName of access:Access:Index | URL of access:Index | Level Controller', 'Unknown user or done by system. Unknown Action:index. '),
(3, '2015-08-09 09:47:45', 0, 1, 2, 'LANG_MENU_RECORD_INSERTName of Menu:index | URL of Menu:index | Level Action', 'Unknown user or done by system. '),
(4, '2015-08-09 09:47:45', 0, 1, 2, 'LANG_ACCESS_RECORD_INSERTName of access:Access:index | URL of access:index | Level Action', 'Unknown user or done by system. '),
(5, '2015-08-09 11:55:00', 0, NULL, NULL, 'Wrong password attempt with username:superadmin', 'Unknown user or done by system. Unknown Module:Login. Unknown Action:login. '),
(6, '2015-08-09 11:58:51', 0, 3, NULL, 'LANG_MENU_RECORD_INSERTName of Menu:Login | URL of Menu:Login | Level Controller', 'Unknown user or done by system. Unknown Action:login. '),
(7, '2015-08-09 11:58:51', 0, 3, NULL, 'LANG_ACCESS_RECORD_INSERTName of access:Access:Login | URL of access:Login | Level Controller', 'Unknown user or done by system. Unknown Action:login. '),
(8, '2015-08-09 11:58:51', 0, 3, 4, 'LANG_MENU_RECORD_INSERTName of Menu:login | URL of Menu:login | Level Action', 'Unknown user or done by system. '),
(9, '2015-08-09 11:58:51', 0, 3, 4, 'LANG_ACCESS_RECORD_INSERTName of access:Access:login | URL of access:login | Level Action', 'Unknown user or done by system. '),
(10, '2015-08-09 11:59:28', 0, 3, 5, 'LANG_MENU_RECORD_INSERTName of Menu:doLogin | URL of Menu:doLogin | Level Action', 'Unknown user or done by system. '),
(11, '2015-08-09 11:59:28', 0, 3, 5, 'LANG_ACCESS_RECORD_INSERTName of access:Access:doLogin | URL of access:doLogin | Level Action', 'Unknown user or done by system. '),
(12, '2015-08-09 12:12:12', 1, 3, 4, 'Success login on 2015-08-09 12:12:12 and ip:127.0.0.1 with username:superadmin', NULL),
(13, '2015-08-09 16:57:34', 1, 3, 4, 'Success login on 2015-08-09 16:57:34 and ip:127.0.0.1 with username:superadmin', NULL),
(14, '2015-08-09 17:35:32', 1, 6, 8, 'A menu record has been inserted to the database.Name of Menu:menu_edit | URL of Menu:menu_edit | Level Action', NULL),
(15, '2015-08-09 17:35:32', 1, 6, 8, 'A access record has been inserted to the databaseName of access:Access:menu_edit | URL of access:menu_edit | Level Action', NULL),
(16, '2015-08-09 17:37:23', 1, 6, 9, 'A menu record has been inserted to the database.Name of Menu:postNewMenu | URL of Menu:postNewMenu | Level Action', NULL),
(17, '2015-08-09 17:37:23', 1, 6, 9, 'A access record has been inserted to the databaseName of access:Access:postNewMenu | URL of access:postNewMenu | Level Action', NULL),
(18, '2015-08-09 21:46:00', 1, 3, 4, 'Success login on 2015-08-09 21:46:00 and ip:127.0.0.1 with username:superadmin', NULL),
(19, '2015-08-09 21:53:38', 1, 6, 7, 'A access record has been inserted to the databaseName of access:Access:Menu | URL of access:Menu | Level Controller', NULL),
(20, '2015-08-09 21:55:14', 1, 6, 7, 'A access record has been inserted to the databaseName of access:Access:Menu List | URL of access:menu_list | Level Page', NULL),
(21, '2015-08-09 22:17:54', 1, 6, 9, 'A menu record has been inserted to the database.Name of Menu:Index | URL of Menu:Index | Level Controller', NULL),
(22, '2015-08-09 22:17:54', 1, 6, 9, 'A access record has been inserted to the databaseName of access:Access:Index | URL of access:Index | Level Controller', NULL),
(23, '2015-08-09 22:21:59', 1, 6, 9, 'A menu record has been inserted to the database.Name of Menu:Index | URL of Menu:Index | Level Controller', NULL),
(24, '2015-08-09 22:21:59', 1, 6, 9, 'A access record has been inserted to the databaseName of access:Access:Index | URL of access:Index | Level Controller', NULL),
(25, '2015-08-09 22:25:03', 1, 6, 9, 'A menu record has been inserted to the database.Name of Menu:Index | URL of Menu:Index | Level Controller', NULL),
(26, '2015-08-09 22:25:03', 1, 6, 9, 'A access record has been inserted to the databaseName of access:Access:Index | URL of access:Index | Level Controller', NULL),
(27, '2015-08-09 22:28:05', 1, 6, 9, 'A menu record has been inserted to the database.Name of Menu:Index | URL of Menu:Index | Level Controller', NULL),
(28, '2015-08-09 22:28:05', 1, 6, 9, 'A access record has been inserted to the databaseName of access:Access:Index | URL of access:Index | Level Controller', NULL),
(29, '2015-08-09 22:28:27', 1, 6, 9, 'A menu record has been inserted to the database.Name of Menu:Index | URL of Menu:Index | Level Controller', NULL),
(30, '2015-08-09 22:28:27', 1, 6, 9, 'A access record has been inserted to the databaseName of access:Access:Index | URL of access:Index | Level Controller', NULL),
(31, '2015-08-09 22:30:00', 1, 3, 15, 'A menu record has been inserted to the database.Name of Menu:Index | URL of Menu:Index | Level Controller', NULL),
(32, '2015-08-09 22:30:00', 1, 3, 15, 'A access record has been inserted to the databaseName of access:Access:Index | URL of access:Index | Level Controller', NULL),
(33, '2015-08-09 22:31:30', 1, 3, 4, 'Success login on 2015-08-09 22:31:30 and ip:127.0.0.1 with username:superadmin', NULL),
(34, '2015-08-09 22:31:53', 1, 6, 9, 'A menu record has been inserted to the database.Name of Menu:Index | URL of Menu:Index | Level Controller', NULL),
(35, '2015-08-09 22:31:53', 1, 6, 9, 'A access record has been inserted to the databaseName of access:Access:Index | URL of access:Index | Level Controller', NULL),
(36, '2015-08-09 22:32:06', 1, 6, 9, 'A menu record has been inserted to the database.Name of Menu:Index | URL of Menu:Index | Level Controller', NULL),
(37, '2015-08-09 22:32:06', 1, 6, 9, 'A access record has been inserted to the databaseName of access:Access:Index | URL of access:Index | Level Controller', NULL),
(38, '2015-08-09 22:32:46', 1, 6, 9, 'A menu record has been inserted to the database.Name of Menu:Index | URL of Menu:Index | Level Controller', NULL),
(39, '2015-08-09 22:32:46', 1, 6, 9, 'A access record has been inserted to the databaseName of access:Access:Index | URL of access:Index | Level Controller', NULL),
(40, '2015-08-09 22:32:59', 1, 6, 9, 'A menu record has been inserted to the database.Name of Menu:Index | URL of Menu:Index | Level Controller', NULL),
(41, '2015-08-09 22:32:59', 1, 6, 9, 'A access record has been inserted to the databaseName of access:Access:Index | URL of access:Index | Level Controller', NULL),
(42, '2015-08-09 22:33:15', 1, 6, 9, 'A menu record has been inserted to the database.Name of Menu:index | URL of Menu:index | Level Action', NULL),
(43, '2015-08-09 22:33:15', 1, 6, 9, 'A access record has been inserted to the databaseName of access:Access:index | URL of access:index | Level Action', NULL),
(44, '2015-08-09 22:33:26', 1, 6, 9, 'A menu record has been inserted to the database.Name of Menu:index | URL of Menu:index | Level Action', NULL),
(45, '2015-08-09 22:33:26', 1, 6, 9, 'A access record has been inserted to the databaseName of access:Access:index | URL of access:index | Level Action', NULL),
(46, '2015-08-09 22:33:35', 1, 6, 22, 'A menu record has been inserted to the database.Name of Menu:index | URL of Menu:index | Level Action', NULL),
(47, '2015-08-09 22:33:35', 1, 6, 22, 'A access record has been inserted to the databaseName of access:Access:index | URL of access:index | Level Action', NULL),
(48, '2015-08-09 22:35:01', 1, 6, 9, 'A menu record has been inserted to the database.Name of Menu:index | URL of Menu:index | Level Action', NULL),
(49, '2015-08-09 22:35:01', 1, 6, 9, 'A access record has been inserted to the databaseName of access:Access:index | URL of access:index | Level Action', NULL),
(50, '2015-08-09 22:35:19', 1, 6, 9, 'A menu record has been inserted to the database.Name of Menu:index | URL of Menu:index | Level Action', NULL),
(51, '2015-08-09 22:35:19', 1, 6, 9, 'A access record has been inserted to the databaseName of access:Access:index | URL of access:index | Level Action', NULL),
(52, '2015-08-09 22:35:48', 1, 6, 9, 'A menu record has been inserted to the database.Name of Menu:index | URL of Menu:index | Level Action', NULL),
(53, '2015-08-09 22:35:48', 1, 6, 9, 'A access record has been inserted to the databaseName of access:Access:index | URL of access:index | Level Action', NULL),
(54, '2015-08-09 22:36:17', 1, 6, 9, 'A menu record has been inserted to the database.Name of Menu:index | URL of Menu:index | Level Action', NULL),
(55, '2015-08-09 22:36:17', 1, 6, 9, 'A access record has been inserted to the databaseName of access:Access:index | URL of access:index | Level Action', NULL),
(56, '2015-08-09 22:36:38', 1, 6, 9, 'A menu record has been inserted to the database.Name of Menu:index | URL of Menu:index | Level Action', NULL),
(57, '2015-08-09 22:36:38', 1, 6, 9, 'A access record has been inserted to the databaseName of access:Access:index | URL of access:index | Level Action', NULL),
(58, '2015-08-09 22:43:26', 1, 6, 9, 'A menu record has been inserted to the database.Name of Menu:index | URL of Menu:index | Level Action', NULL),
(59, '2015-08-09 22:43:26', 1, 6, 9, 'A access record has been inserted to the databaseName of access:Access:index | URL of access:index | Level Action', NULL),
(60, '2015-08-09 22:44:47', 1, 6, 9, 'A menu record has been inserted to the database.Name of Menu:index | URL of Menu:index | Level Action', NULL),
(61, '2015-08-09 22:44:47', 1, 6, 9, 'A access record has been inserted to the databaseName of access:Access:index | URL of access:index | Level Action', NULL),
(62, '2015-08-09 22:45:00', 1, 6, 9, 'A menu record has been inserted to the database.Name of Menu:Login | URL of Menu:Login | Level Controller', NULL),
(63, '2015-08-09 22:45:00', 1, 6, 9, 'A access record has been inserted to the databaseName of access:Access:Login | URL of access:Login | Level Controller', NULL),
(64, '2015-08-09 22:46:22', 1, 6, 9, 'A menu record has been inserted to the database.Name of Menu:Login | URL of Menu:Login | Level Controller', NULL),
(65, '2015-08-09 22:46:22', 1, 6, 9, 'A access record has been inserted to the databaseName of access:Access:Login | URL of access:Login | Level Controller', NULL),
(66, '2015-08-09 22:47:46', 1, 3, 4, 'Success login on 2015-08-09 22:47:46 and ip:127.0.0.1 with username:superadmin', NULL);

-- --------------------------------------------------------

--
-- 表的结构 `tb_menu`
--

CREATE TABLE IF NOT EXISTS `tb_menu` (
  `id` int(8) NOT NULL,
  `name` varchar(32) CHARACTER SET utf8 NOT NULL,
  `url` varchar(32) CHARACTER SET utf8 NOT NULL,
  `added_date` datetime NOT NULL,
  `added_by` int(8) DEFAULT NULL,
  `enable` tinyint(1) NOT NULL DEFAULT '1',
  `visible` tinyint(1) NOT NULL DEFAULT '1',
  `level` tinyint(4) NOT NULL DEFAULT '0',
  `parent_id` int(8) DEFAULT '0',
  `description` text CHARACTER SET utf8,
  `type` tinyint(4) NOT NULL DEFAULT '0'
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=latin1;

--
-- 转存表中的数据 `tb_menu`
--

INSERT INTO `tb_menu` (`id`, `name`, `url`, `added_date`, `added_by`, `enable`, `visible`, `level`, `parent_id`, `description`, `type`) VALUES
(1, 'Index', 'Index', '2015-08-09 09:47:45', 1, 1, 0, 1, 0, 'Index', 0),
(2, 'index', 'index', '2015-08-09 09:47:45', 1, 1, 0, 0, 1, 'index', 0),
(3, 'Login', 'Login', '2015-08-09 11:58:51', 1, 1, 0, 1, 0, 'Login', 0),
(4, 'login', 'login', '2015-08-09 11:58:51', 1, 1, 0, 0, 3, 'login', 0),
(5, 'doLogin', 'doLogin', '2015-08-09 11:59:28', 1, 1, 0, 0, 3, 'doLogin', 0),
(6, 'Menu', 'Menu', '2015-08-09 12:36:33', 1, 1, 1, 1, 0, NULL, 0),
(7, 'Menu List', 'menu_list', '2015-08-09 12:37:40', 1, 1, 1, 2, 6, NULL, 2),
(8, 'menu_edit', 'menu_edit', '2015-08-09 17:35:32', 1, 1, 0, 0, 6, 'menu_edit', 0),
(9, 'postNewMenu', 'postNewMenu', '2015-08-09 17:37:23', 1, 1, 0, 0, 6, 'postNewMenu', 0),
(10, 'System', 'System', '2015-08-09 22:21:27', 1, 1, 1, 1, 0, '', 0),
(11, 'System Information', 'information', '2015-08-09 22:21:59', 1, 1, 1, 2, 10, '', 0),
(12, 'Database Management', 'database', '2015-08-09 22:25:03', 1, 1, 1, 2, 10, '', 0),
(13, 'Log', 'Log', '2015-08-09 22:28:05', 1, 1, 1, 1, 0, '', 0),
(14, 'Log List', 'log_list', '2015-08-09 22:28:27', 1, 1, 1, 2, 13, '', 0),
(15, 'doLogout', 'doLogout', '2015-08-09 22:30:00', 1, 1, 0, 0, 3, 'doLogout', 0),
(16, 'Group', 'Group', '2015-08-09 22:31:53', 1, 1, 1, 1, 0, '', 0),
(17, 'Group List', 'group_list', '2015-08-09 22:32:06', 1, 1, 1, 2, 16, '', 0),
(18, 'Group Access', 'access', '2015-08-09 22:32:46', 1, 1, 1, 2, 16, '', 0),
(19, 'User', 'User', '2015-08-09 22:32:59', 1, 1, 1, 1, 0, '', 0),
(20, 'User List', 'user_list', '2015-08-09 22:33:15', 1, 1, 1, 2, 19, '', 0),
(21, 'Admin List', 'admin_list', '2015-08-09 22:33:26', 1, 1, 1, 2, 19, '', 0),
(22, 'index', 'index', '2015-08-09 22:33:35', 1, 1, 0, 0, 6, 'index', 0),
(23, 'Message', 'Message', '2015-08-09 22:35:01', 1, 1, 1, 1, 0, '', 0),
(24, 'Message Feedback', 'feedback', '2015-08-09 22:35:19', 1, 1, 1, 2, 23, '', 0),
(25, 'Message Report', 'report_list', '2015-08-09 22:35:48', 1, 1, 1, 2, 23, '', 0),
(26, 'Block', 'Block', '2015-08-09 22:36:17', 1, 1, 1, 1, 0, '', 0),
(27, 'Block User List', 'block_user_list', '2015-08-09 22:36:38', 1, 1, 1, 2, 26, '', 0),
(28, 'Project', 'Project', '2015-08-09 22:43:26', 1, 1, 1, 1, 0, '', 0),
(29, 'Review List', 'review_list', '2015-08-09 22:44:47', 1, 1, 1, 2, 28, '', 0),
(30, 'Project List', 'project_list', '2015-08-09 22:45:00', 1, 1, 1, 2, 28, '', 0),
(31, 'Identify List', 'identify_list', '2015-08-09 22:46:22', 1, 1, 1, 2, 19, '', 0);

-- --------------------------------------------------------

--
-- 表的结构 `tb_system`
--

CREATE TABLE IF NOT EXISTS `tb_system` (
  `id` tinyint(4) NOT NULL DEFAULT '1',
  `name` varchar(32) CHARACTER SET utf8 NOT NULL,
  `ip` varchar(16) NOT NULL,
  `domain` varchar(32) CHARACTER SET utf8 NOT NULL,
  `keyword` text CHARACTER SET utf8 NOT NULL,
  `introduction` text CHARACTER SET utf8 NOT NULL,
  `website_enable` tinyint(1) NOT NULL DEFAULT '1',
  `system_enable` tinyint(1) NOT NULL DEFAULT '1',
  `website_version` varchar(8) NOT NULL,
  `system_version` varchar(8) NOT NULL,
  `owner` varchar(16) CHARACTER SET utf8 NOT NULL,
  `mail` varchar(16) CHARACTER SET utf8 NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- 转存表中的数据 `tb_system`
--

INSERT INTO `tb_system` (`id`, `name`, `ip`, `domain`, `keyword`, `introduction`, `website_enable`, `system_enable`, `website_version`, `system_version`, `owner`, `mail`) VALUES
(1, 'KIKI', '', '', '', '', 1, 1, '0.1', '0.1', '', '');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `tb_access`
--
ALTER TABLE `tb_access`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tb_admin`
--
ALTER TABLE `tb_admin`
  ADD PRIMARY KEY (`id`), ADD KEY `group_id` (`group_id`);

--
-- Indexes for table `tb_group`
--
ALTER TABLE `tb_group`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tb_group_access`
--
ALTER TABLE `tb_group_access`
  ADD PRIMARY KEY (`id`), ADD KEY `group_id` (`level`), ADD KEY `acces_id` (`acces_id`);

--
-- Indexes for table `tb_log`
--
ALTER TABLE `tb_log`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tb_menu`
--
ALTER TABLE `tb_menu`
  ADD PRIMARY KEY (`id`), ADD KEY `parent_id` (`parent_id`), ADD KEY `added_by` (`added_by`);

--
-- Indexes for table `tb_system`
--
ALTER TABLE `tb_system`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `tb_access`
--
ALTER TABLE `tb_access`
  MODIFY `id` int(8) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=32;
--
-- AUTO_INCREMENT for table `tb_admin`
--
ALTER TABLE `tb_admin`
  MODIFY `id` int(8) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT for table `tb_group`
--
ALTER TABLE `tb_group`
  MODIFY `id` int(8) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=7;
--
-- AUTO_INCREMENT for table `tb_group_access`
--
ALTER TABLE `tb_group_access`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `tb_log`
--
ALTER TABLE `tb_log`
  MODIFY `id` int(8) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=67;
--
-- AUTO_INCREMENT for table `tb_menu`
--
ALTER TABLE `tb_menu`
  MODIFY `id` int(8) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=32;
--
-- 限制导出的表
--

--
-- 限制表 `tb_group_access`
--
ALTER TABLE `tb_group_access`
ADD CONSTRAINT `tb_group_access_ibfk_2` FOREIGN KEY (`acces_id`) REFERENCES `tb_access` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
