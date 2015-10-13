<?php if (!defined('THINK_PATH')) exit();?><!DOCTYPE html>
<html>
<head lang="en">
    <meta charset="UTF-8">
    <title>Menu - <?php echo ($title); ?></title>
</head>
<body>
<!DOCTYPE html>
<html>
<head lang="en">
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- 上述3个meta标签*必须*放在最前面，任何其他内容都*必须*跟随其后！ -->
    <meta name="description" content="">
    <meta name="author" content="">
    <link rel="icon" href="">

    <title>KIKI Response Header</title>

    <link rel="stylesheet" href="/kiki/Public/css/bootstrap.min.css">
    <link rel="stylesheet" href="/kiki/Public/css/bootstrap.css">
    <link href="/kiki/Public/css/dashboard.css" rel="stylesheet">
    <script src="/kiki/Public/js/jquery-2.1.4.min.js"></script>
</head>
<body>
<nav class="navbar navbar-inverse navbar-fixed-top">
    <div class="container-fluid">
        <div class="navbar-header">
            <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar">
                <span class="sr-only">Toggle navigation</span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
            <a class="navbar-brand" href="<?php echo U('Index/index');?>"><?php echo ($title); ?> 后台管理系统</a>
        </div>
        <div id="navbar" class="navbar-collapse collapse">
            <ul class="nav navbar-nav navbar-right">
                <li><p class="navbar-text">欢迎, </p></li>
                <li>
                    <div class="dropdown">
                        <button class="navbar-btn btn btn-inverse dropdown-toggle" type="button" id="dropdownMenuUser" data-toggle="dropdown" aria-haspopup="true" aria-expanded="true">
                            <i class="glyphicon glyphicon-user"> <?php echo ($username); ?></i>
                            <span class="caret"></span>
                        </button>
                        <ul class="dropdown-menu" aria-labelledby="dropdownMenuUser">
                            <li><a href="">个人资料</a></li>
                            <li><a href="">修改密码</a></li>
                            <li role="separator" class="divider"></li>
                            <li><a href="">退出登录</a></li>
                        </ul>
                    </div>
                    <!--<a href="#userInfo" class="collapsed" data-toggle="collapse">-->
                        <!--<i class="glyphicon glyphicon-user"> <?php echo ($username); ?></i>-->
                    <!--</a>-->
                    <!--<ul id="userInfo" class="nav nav-list collapse" style="height: 0px;">-->
                        <!--<li><a href="">个人资料</a></li>-->
                        <!--<li><a href="">修改密码</a></li>-->
                        <!--<li role="separator" class="divider"></li>-->
                        <!--<li><a href="">退出登录</a></li>-->
                    <!--</ul>-->
                </li>
                <li><a href="<?php echo U('Login/doLogout');?>"><i class="glyphicon glyphicon-off"> 退出登录</i></a></li>
            </ul>
            <!--<form class="navbar-form navbar-right">-->
                <!--<input type="text" class="form-control" placeholder="Search...">-->
            <!--</form>-->
        </div>
    </div>
</nav>

<div class="container-fluid">
    <div class="row">
        <div class="col-sm-3 col-md-2 sidebar">
            <ul class="nav nav-sidebar">
                <li class="active"><a href="<?php echo U('Index/index');?>">后台管理</a></li>
            <?php if(is_array($menus)): $i = 0; $__LIST__ = $menus;if( count($__LIST__)==0 ) : echo "" ;else: foreach($__LIST__ as $key=>$vo): $mod = ($i % 2 );++$i;?><li>
                    <a href="#systemSetting<?php echo ($vo["id"]); ?>" class="nav-header collapsed" data-toggle="collapse">
                        <i class="glyphicon glyphicon-plus"></i>
                        <?php echo ($vo["name"]); ?>
                        <!--<span class="pull-right glyphicon glyphicon-chevron-toggle"></span>-->
                    </a>
                    <ul id="systemSetting<?php echo ($vo["id"]); ?>" class="nav nav-list collapse" style="height: 0px;">
                        <?php if(is_array($vo["childMenus"])): $i = 0; $__LIST__ = $vo["childMenus"];if( count($__LIST__)==0 ) : echo "" ;else: foreach($__LIST__ as $key=>$vo1): $mod = ($i % 2 );++$i; if($vo1["isactivated"] != 0): ?><li class="active" style="background-color: #e3e3e3;">
                            <?php else: ?>
                                <li><?php endif; ?>
                            <?php if($vo1["isavailable"] == 0): ?><a>
                            <?php else: ?>
                                <a href="/kiki/admin.php/Home/<?php echo ($vo["url"]); ?>/<?php echo ($vo1["url"]); ?>"><?php endif; ?>
                            <?php if($vo1["isactivated"] != 0): ?><i class="glyphicon glyphicon-chevron-right">
                            <?php else: ?>
                                <i class="glyphicon glyphicon-minus"><?php endif; ?> <?php echo ($vo1["name"]); ?></i></a></li><?php endforeach; endif; else: echo "" ;endif; ?>
                    </ul>
                </li><?php endforeach; endif; else: echo "" ;endif; ?>
            </ul>
        </div>
    </div>
</div>
<script src="/kiki/Public/js/bootstrap.js"></script>
</body>
</html>
<div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
    <header>
        <div class="row title">
            <div class="col-md-12">
                <h3>
                    <ol class="breadcrumb">
                        <li><i class="glyphicon glyphicon-chevron-right"></i>
                            <a href="<?php echo ($currentURL); ?>"><?php echo ($controllerName); ?></a>
                        </li>
                        <li> <?php echo ($actionName); ?></li>
                    </ol>
                </h3>
            </div>
        </div>
    </header>
    <div class="adder">
        <form class="form-horizontal" enctype="multipart/form-data" id="new_menu" method="post"
              action="<?php echo U('Menu/addNewMenu');?>">
            <div id="body-wrap" width="60%" class="breadcrumb">
                <div class="form-group row has-feedback" style="margin-top: 20px;">
                    <label for="menu-name" class="col-sm-2 control-label">*菜单名称：</label>
                    <div class="col-sm-4">
                        <input id="menu-name" type="text" class="form-control" name="new_menu[name]" placeholder="请输入菜单名称"
                               style="display:inline-block;width: 90%;" required>
                    </div>
                </div>

                <div class="form-group row has-feedback" style="margin-top: 20px;">
                    <label for="menu-url" class="col-sm-2 control-label">*菜单URL：</label>

                    <div class="col-sm-4">
                        <input id="menu-url" type="text" class="form-control" name="new_menu[url]" placeholder="请输入菜单的URL"
                               style="display:inline-block;width: 90%;" required>
                    </div>
                    <p class="help-block">如登录模块(Login) 或 登录页面(login)。</p>
                </div>

                <div class="form-group row has-feedback">
                    <label for="menu-type" class="col-sm-2 control-label">定义菜单类别</label>
                    <div class="col-sm-4">
                        <select id="menu-type" name="new_menu[type]" class="form-control">
                            <option value="0" selected>不定义</option>
                            <option value="1">控制器(模块)[默认父级]</option>
                            <option value="2">页面</option>
                            <option value="3">动作(功能, 方法)[默认不可见]</option>
                        </select>
                    </div>
                </div>

                <div class="form-group row has-feedback">
                    <label for="menu-father" class="col-sm-2 control-label">*上级菜单：</label>

                    <div class="col-sm-4">
                        <select id="menu-father" name="new_menu[id_father]" class="form-control">
                            <option value="0" selected>无</option>
                            <?php if(is_array($menu_father)): $i = 0; $__LIST__ = $menu_father;if( count($__LIST__)==0 ) : echo "" ;else: foreach($__LIST__ as $key=>$menu_father): $mod = ($i % 2 );++$i;?><option value="<?php echo ($menu_father["id"]); ?>"><?php echo ($menu_father["name"]); ?>[<?php echo ($menu_father["url"]); ?>]<?php echo ($menu_father["visible"]); ?></option><?php endforeach; endif; else: echo "" ;endif; ?>
                        </select>
                    </div>
                    <p class="help-block">如选择无则代表是模块。</p>
                </div>

                <div class="form-group row has-feedback">
                    <label for="menu-introduction" class="col-sm-2 control-label">菜单描述：</label>

                    <div class="col-sm-4">
                        <input id="menu-introduction" type="text" class="form-control" name="new_menu[introduction]" placeholder="菜单的详细描述"
                               style="display:inline-block;width: 90%;">
                    </div>
                </div>

                <div class="form-group row has-feedback" style="margin-top: 20px;">
                    <label for="menu-visible" class="col-sm-2 control-label">菜单是否可见：</label>
                    <div class="col-sm-4">
                        <select id="menu-visible" class="form-control" name="new_menu[isvisible]">
                            <option value="1">可见</option>
                            <option value="0">不可见</option>
                        </select>
                    </div>
                    <p class="help-block">该菜单是否在左侧导航栏显示。</p>
                </div>

                <div class="form-group row has-feedback" style="margin-top: 20px;">
                    <label for="menu-available" class="col-sm-2 control-label">菜单是否可用：</label>
                    <div class="col-sm-4">
                        <select id="menu-available" class="form-control" name="new_menu[isavailable]">
                            <option value="1">启用</option>
                            <option value="0">不可用</option>
                        </select>
                    </div>
                    <p class="help-block">该菜单是否在左侧导航栏可用。</p>
                </div>

                <div class="form-group row" style="margin-top: 20px;">
                    <div class="col-md-2">
                        <button type="submit" class="btn btn-primary" style="margin-left: 100px;;">保存</button>
                    </div>
                </div>
            </div>
        </form>
    </div>
</div>
</body>
</html>