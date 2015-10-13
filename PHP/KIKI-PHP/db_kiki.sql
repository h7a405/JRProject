-- phpMyAdmin SQL Dump
-- version 4.3.11
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: 2015-07-27 01:54:30
-- 服务器版本： 5.6.24
-- PHP Version: 5.6.8

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `db_kiki`
--

-- --------------------------------------------------------

--
-- 表的结构 `kiki_log_admin`
--

CREATE TABLE IF NOT EXISTS `kiki_log_admin` (
  `id` int(8) NOT NULL,
  `datetime_added` datetime DEFAULT NULL,
  `id_user_added` int(8) DEFAULT NULL,
  `module_operated` int(11) DEFAULT NULL,
  `function_operated` int(11) DEFAULT NULL,
  `information` text CHARACTER SET utf8,
  `details` text CHARACTER SET utf8
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=latin1;

--
-- 转存表中的数据 `kiki_log_admin`
--

INSERT INTO `kiki_log_admin` (`id`, `datetime_added`, `id_user_added`, `module_operated`, `function_operated`, `information`, `details`) VALUES
(1, '2015-07-25 22:36:07', 1, 6, NULL, 'superadmin||成功登录到后台', '未知功能:doLogin '),
(2, '2015-07-26 12:04:48', 1, 1, NULL, '添加新菜单:[1]登录处理方法(doLogin)成功', '未知功能:addNewMenu '),
(3, '2015-07-26 12:08:19', 1, 1, NULL, '添加新菜单:[1]登录处理方法(doLogin)成功', '未知功能:addNewMenu '),
(4, '2015-07-26 12:09:30', 1, 1, NULL, '添加新菜单:[1]退出登录处理方法(doLogout)成功', '未知功能:addNewMenu '),
(5, '2015-07-26 12:09:45', 1, 6, 12, 'superadmin||从后台退出登录', NULL),
(6, '2015-07-26 12:09:48', 1, 6, 11, 'superadmin||成功登录到后台', NULL),
(7, '2015-07-26 12:10:41', 1, 1, 13, '添加新菜单:[1]添加菜单处理方法(addNewMenu)成功', NULL),
(8, '2015-07-26 16:06:06', 1, 6, 11, 'superadmin||成功登录到后台', NULL),
(9, '2015-07-26 16:37:58', 1, 1, 13, '添加新菜单:[1]用户管理(User)成功', NULL),
(10, '2015-07-26 16:40:42', 1, 1, 13, '添加新菜单:[1]后台用户列表(adminUser)成功', NULL),
(11, '2015-07-26 16:42:09', 1, 1, 13, '添加新菜单:[1]前台用户列表(index)成功', NULL),
(12, '2015-07-26 17:07:56', 1, 1, 13, '添加新菜单:[1]菜单编辑页面(editMenu)成功', NULL),
(13, '2015-07-26 17:31:26', 1, 6, 11, 'superadmin||成功登录到后台', NULL),
(14, '2015-07-26 17:31:44', 1, 6, 11, 'superadmin||成功登录到后台', NULL),
(15, '2015-07-26 18:17:41', 1, 1, NULL, '修改菜单成功, 原数据:[(1)菜单名:菜单管理[Menu], 上级菜单ID:0], 修改为:((1)菜单名:菜单管理[Menu], 上级菜单ID:0)', '未知功能:editTheMenu '),
(16, '2015-07-26 18:19:38', 1, 1, NULL, '修改菜单成功, 原数据:[(1)菜单名:菜单管理[Menu], 上级菜单ID:0], 修改为:((1)菜单名:菜单管理[Menu], 上级菜单ID:0)', '未知功能:editTheMenu '),
(17, '2015-07-26 18:19:57', 1, 1, NULL, '修改菜单成功, 原数据:[(1)菜单名:菜单管理[Menu], 上级菜单ID:0], 修改为:((1)菜单名:菜单管理[Menu], 上级菜单ID:0)', '未知功能:editTheMenu '),
(18, '2015-07-26 18:21:11', 1, 1, NULL, '修改菜单成功, 原数据:[(1)菜单名:菜单管理[Menu], 上级菜单ID:0], 修改为:((1)菜单名:菜单管理[Menu], 上级菜单ID:0)', '未知功能:editTheMenu '),
(19, '2015-07-26 18:33:46', 1, 1, NULL, '修改菜单成功, 原数据:[(3)菜单名:查看菜单[index], 上级菜单ID:1], 修改为:((3)菜单名:所有菜单[index], 上级菜单ID:1)', '未知功能:editTheMenu '),
(20, '2015-07-26 18:34:31', 1, 1, NULL, '修改菜单成功, 原数据:[(3)菜单名:所有菜单[index], 上级菜单ID:1], 修改为:((3)菜单名:查看菜单列表[index], 上级菜单ID:1)', '未知功能:editTheMenu '),
(21, '2015-07-26 18:34:47', 1, 1, NULL, '修改菜单成功, 原数据:[(2)菜单名:添加菜单[addMenu], 上级菜单ID:1], 修改为:((2)菜单名:添加新菜单[addMenu], 上级菜单ID:1)', '未知功能:editTheMenu '),
(22, '2015-07-26 18:49:30', 1, 1, 13, '添加新菜单:[1]测试菜单模块(Test)成功', NULL),
(23, '2015-07-26 18:52:35', 1, 1, 13, '添加新菜单:[1]测试菜单模块1(Test1)成功', NULL),
(24, '2015-07-26 18:59:36', 1, 1, NULL, '修改菜单成功, 原数据:[(1)菜单名:菜单管理[Menu], 上级菜单ID:0], 修改为:((1)菜单名:菜单管理[Menu], 上级菜单ID:0)', '未知功能:editTheMenu '),
(25, '2015-07-26 19:00:12', 1, 1, NULL, '修改菜单成功, 原数据:[(1)菜单名:菜单管理[Menu], 上级菜单ID:0], 修改为:((1)菜单名:菜单管理[Menu], 上级菜单ID:0)', '未知功能:editTheMenu '),
(26, '2015-07-26 19:00:20', 1, 1, NULL, '修改菜单成功, 原数据:[(1)菜单名:菜单管理[Menu], 上级菜单ID:0], 修改为:((1)菜单名:菜单管理[Menu], 上级菜单ID:0)', '未知功能:editTheMenu '),
(27, '2015-07-26 19:00:49', 1, 1, NULL, '修改菜单成功, 原数据:[(4)菜单名:主页模块[Index], 上级菜单ID:0], 修改为:((4)菜单名:主页模块[Index], 上级菜单ID:0)', '未知功能:editTheMenu '),
(28, '2015-07-26 19:01:08', 1, 1, NULL, '修改菜单成功, 原数据:[(6)菜单名:登录模块[Login], 上级菜单ID:0], 修改为:((6)菜单名:登录模块[Login], 上级菜单ID:0)', '未知功能:editTheMenu '),
(29, '2015-07-26 19:01:34', 1, 1, NULL, '修改菜单成功, 原数据:[(8)菜单名:日志管理[Log], 上级菜单ID:0], 修改为:((8)菜单名:日志管理[Log], 上级菜单ID:0)', '未知功能:editTheMenu '),
(30, '2015-07-26 19:01:47', 1, 1, NULL, '修改菜单成功, 原数据:[(1)菜单名:菜单管理[Menu], 上级菜单ID:0], 修改为:((1)菜单名:菜单管理[Menu], 上级菜单ID:0)', '未知功能:editTheMenu '),
(31, '2015-07-26 20:51:47', 1, 1, 13, '添加新菜单:[2]编辑菜单处理方法(editTheMenu)成功', NULL),
(32, '2015-07-26 21:06:21', 1, 1, 20, '修改菜单成功, 原数据:[(1)菜单名:菜单管理[Menu], 上级菜单ID:0], 修改为:((1)菜单名:菜单管理[Menu], 上级菜单ID:0)', NULL),
(33, '2015-07-26 21:06:57', 1, 1, 20, '修改菜单成功, 原数据:[(1)菜单名:菜单管理[Menu], 上级菜单ID:0], 修改为:((1)菜单名:菜单管理[Menu], 上级菜单ID:0)', NULL),
(34, '2015-07-26 21:07:22', 1, 1, 20, '修改菜单成功, 原数据:[(1)菜单名:菜单管理[Menu], 上级菜单ID:0], 修改为:((1)菜单名:菜单管理[Menu], 上级菜单ID:0)', NULL),
(35, '2015-07-26 21:09:39', 1, 1, 20, '修改菜单成功, 原数据:[(1)菜单名:菜单管理[Menu], 上级菜单ID:0], 修改为:((1)菜单名:菜单管理[Menu], 上级菜单ID:0)', NULL);

-- --------------------------------------------------------

--
-- 表的结构 `kiki_menu_admin`
--

CREATE TABLE IF NOT EXISTS `kiki_menu_admin` (
  `id` int(8) NOT NULL,
  `id_father` int(8) NOT NULL DEFAULT '0' COMMENT '0-superClass',
  `name` varchar(32) CHARACTER SET utf8 NOT NULL,
  `url` varchar(255) DEFAULT NULL,
  `level` tinyint(4) NOT NULL COMMENT '0-superClass, 1-childClass',
  `datetime_added` datetime DEFAULT NULL,
  `id_user_added` int(8) DEFAULT NULL,
  `type` tinyint(4) DEFAULT '0' COMMENT '0-未定义, 1-控制器(默认父级菜单), 2-页面, 3-方法',
  `isvisible` tinyint(4) NOT NULL DEFAULT '1' COMMENT '0-unVisible, 1-visible',
  `isavailable` tinyint(4) DEFAULT '1' COMMENT '0-不可用, 1-可用',
  `introduction` varchar(255) CHARACTER SET utf8 DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=latin1;

--
-- 转存表中的数据 `kiki_menu_admin`
--

INSERT INTO `kiki_menu_admin` (`id`, `id_father`, `name`, `url`, `level`, `datetime_added`, `id_user_added`, `type`, `isvisible`, `isavailable`, `introduction`) VALUES
(1, 0, '菜单管理', 'Menu', 0, '2015-07-24 22:07:55', 1, 1, 1, 1, '菜单管理模块'),
(2, 1, '添加新菜单', 'addMenu', 1, '2015-07-24 22:41:49', 1, 2, 1, 1, '添加新菜单的页面'),
(3, 1, '查看菜单列表', 'index', 1, '2015-07-24 22:42:56', 1, 2, 1, 1, '显示所有菜单列表的页面'),
(4, 0, '主页模块', 'Index', 0, '2015-07-24 23:52:15', 1, 1, 0, 1, '后台管理主页模块(不显示)'),
(5, 4, '主页面', 'index', 1, '2015-07-24 23:54:43', 1, 2, 0, 1, '后台主页面'),
(6, 0, '登录模块', 'Login', 0, '2015-07-24 23:56:36', 1, 1, 0, 1, '后台登录模块(不显示)'),
(7, 6, '登录页面', 'login', 1, '2015-07-24 23:56:57', 1, 2, 0, 1, '后台登录页面'),
(8, 0, '日志管理', 'Log', 0, '2015-07-25 00:55:31', 1, 1, 1, 1, '后台日志管理(只能查看列表)'),
(9, 8, '查看日志', 'index', 1, '2015-07-25 00:55:53', 1, 2, 1, 1, '查看日志列表'),
(11, 6, '登录处理方法', 'doLogin', 1, '2015-07-26 12:08:19', 1, 3, 0, 1, '登陆时的处理方法'),
(12, 6, '退出登录处理方法', 'doLogout', 1, '2015-07-26 12:09:30', 1, 3, 0, 1, '退出登录时的处理方法'),
(13, 1, '添加菜单处理方法', 'addNewMenu', 1, '2015-07-26 12:10:41', 1, 3, 0, 1, '添加菜单的处理方法'),
(14, 0, '用户管理', 'User', 0, '2015-07-26 16:37:58', 1, 1, 1, 1, '后台的用户管理模块'),
(15, 14, '后台用户列表', 'adminUser', 1, '2015-07-26 16:40:42', 1, 2, 1, 0, '查看后台用户列表页面'),
(16, 14, '前台用户列表', 'index', 1, '2015-07-26 16:42:09', 1, 2, 1, 0, '查看前台用户列表的页面'),
(17, 1, '菜单编辑页面', 'editMenu', 1, '2015-07-26 17:07:56', 1, 2, 0, 1, '菜单编辑跳转页面'),
(18, 0, '测试菜单模块', 'Test', 0, '2015-07-26 18:49:30', 1, 1, 0, 0, '测试用的模块'),
(19, 0, '测试菜单模块1', 'Test1', 0, '2015-07-26 18:52:35', 1, 1, 0, 0, '测试用的模块'),
(20, 1, '编辑菜单处理方法', 'editTheMenu', 1, '2015-07-26 20:51:47', 1, 3, 0, 1, '编辑菜单的处理方法');

-- --------------------------------------------------------

--
-- 表的结构 `kiki_system_info`
--

CREATE TABLE IF NOT EXISTS `kiki_system_info` (
  `id` int(8) NOT NULL,
  `name` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `issystemopened` tinyint(1) NOT NULL DEFAULT '1',
  `domain` varchar(32) DEFAULT NULL,
  `ip` varchar(32) DEFAULT NULL,
  `iskikiopened` tinyint(1) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- 转存表中的数据 `kiki_system_info`
--

INSERT INTO `kiki_system_info` (`id`, `name`, `issystemopened`, `domain`, `ip`, `iskikiopened`) VALUES
(1, 'KIKI', 1, NULL, NULL, 1);

-- --------------------------------------------------------

--
-- 表的结构 `kiki_user_admin`
--

CREATE TABLE IF NOT EXISTS `kiki_user_admin` (
  `id` int(8) NOT NULL,
  `username` varchar(32) NOT NULL,
  `password` varchar(32) NOT NULL,
  `nickname` varchar(32) CHARACTER SET utf8 NOT NULL,
  `datetime_added` datetime NOT NULL DEFAULT '1970-01-01 00:00:00',
  `gender` tinyint(4) DEFAULT '0' COMMENT '0-unknown, 1-male, 2-female',
  `salt` varchar(32) NOT NULL,
  `birthday` date DEFAULT NULL,
  `lasttime_login` datetime NOT NULL DEFAULT '1970-01-01 00:00:00',
  `isonline` tinyint(1) NOT NULL DEFAULT '0',
  `id_user_added` int(8) DEFAULT NULL,
  `lastip_login` varchar(8) DEFAULT NULL,
  `lastmac_login` varchar(16) DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

--
-- 转存表中的数据 `kiki_user_admin`
--

INSERT INTO `kiki_user_admin` (`id`, `username`, `password`, `nickname`, `datetime_added`, `gender`, `salt`, `birthday`, `lasttime_login`, `isonline`, `id_user_added`, `lastip_login`, `lastmac_login`) VALUES
(1, 'superadmin', 'd9bnPMpGxNKlsSUlXQ+sYA==', 'SuperAdmin', '2015-07-24 22:29:46', 1, 'kikiadmin', NULL, '2015-07-26 17:31:44', 0, NULL, '127.0.0.', NULL);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `kiki_log_admin`
--
ALTER TABLE `kiki_log_admin`
  ADD PRIMARY KEY (`id`), ADD KEY `IndexOperatorID` (`id_user_added`);

--
-- Indexes for table `kiki_menu_admin`
--
ALTER TABLE `kiki_menu_admin`
  ADD PRIMARY KEY (`id`), ADD KEY `IndexAddedBy` (`id_user_added`);

--
-- Indexes for table `kiki_system_info`
--
ALTER TABLE `kiki_system_info`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `kiki_user_admin`
--
ALTER TABLE `kiki_user_admin`
  ADD PRIMARY KEY (`id`), ADD KEY `addedBy` (`id_user_added`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `kiki_log_admin`
--
ALTER TABLE `kiki_log_admin`
  MODIFY `id` int(8) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=36;
--
-- AUTO_INCREMENT for table `kiki_menu_admin`
--
ALTER TABLE `kiki_menu_admin`
  MODIFY `id` int(8) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=21;
--
-- AUTO_INCREMENT for table `kiki_user_admin`
--
ALTER TABLE `kiki_user_admin`
  MODIFY `id` int(8) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=2;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
