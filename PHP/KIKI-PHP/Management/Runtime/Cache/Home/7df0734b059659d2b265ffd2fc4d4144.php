<?php if (!defined('THINK_PATH')) exit();?><!DOCTYPE html>
<html>
<head lang="en">
    <meta charset="UTF-8">
    <title>Menu edit - <?php echo ($title); ?></title>
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
                        <?php if(is_array($vo["childMenus"])): $i = 0; $__LIST__ = $vo["childMenus"];if( count($__LIST__)==0 ) : echo "" ;else: foreach($__LIST__ as $key=>$vo1): $mod = ($i % 2 );++$i; if($vo1["isActivated"] != 0): ?><li class="active" style="background-color: #e3e3e3;">
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
    <div class="form-horizontal">
        <div id="body-wrap" class="breadcrumb">
            <div class="form-group row has-feedback">
                <label for="menu-name" class="col-sm-2 control-label">菜单名：</label>
                <div class="col-sm-4">
                    <label class="control-label" name="menu[name]" id="menu-name" value="<?php echo ($menu["name"]); ?>"><?php echo ($menu["name"]); ?></label>
                </div>
            </div>

            <div class="form-group row has-feedback">
                <label for="menu-url" class="col-sm-2 control-label">菜单URL：</label>
                <div class="col-sm-4">
                    <label class="control-label" name="menu[password]" id="menu-url" value="<?php echo ($menu["url"]); ?>"><?php echo ($menu["url"]); ?></label>
                </div>
            </div>

            <div class="form-group row has-feedback">
                <label for="menu-addedDate" class="col-sm-2 control-label">创建日期：</label>
                <div class="col-sm-4">
                    <label class="control-label" name="menu[addedDate]" id="menu-addedDate" value="<?php echo ($menu["datetime_added"]); ?>"><?php echo ($menu["datetime_added"]); ?></label>
                </div>
            </div>

            <div class="form-group row has-feedback">
                <label for="menu-addedBy" class="col-sm-2 control-label">创建人：</label>
                <div class="col-sm-4">
                    <label class="control-label" name="menu[addedBy]" id="menu-addedBy" value="<?php echo ($menu["username_added"]); ?>"><?php echo ($menu["username_added"]); ?></label>
                </div>
            </div>

            <div class="form-group row has-feedback">
                <label for="menu-type" class="col-sm-2 control-label">菜单类型</label>
                <div class="col-sm-2" id="menu-type">
                    <?php if($menu["type"] == 0): ?><span class="label label-default">未定义</span>
                        <?php elseif($menu["type"] == 1): ?>
                        <span class="label label-danger">控制器(模块)</span>
                        <?php elseif($menu["type"] == 2): ?>
                        <span class="label label-info">页面</span>
                        <?php else: ?>
                        <span class="label label-warning">动作(功能,方法)</span><?php endif; ?>
                </div>
            </div>

            <div class="form-group row has-feedback">
                <label for="menu-father" class="col-sm-2 control-label">父级菜单：</label>
                <div class="col-sm-2" id="menu-father">
                    <?php if($menu["level"] == 0): ?><span class="label label-danger control-label">父级菜单</span>
                    <?php else: ?>
                        <span class="label label-info control-label"><?php echo ($menu["name_father"]); ?></span><?php endif; ?>
                </div>
            </div>

            <div class="form-group row has-feedback">
                <label for="menu-visible" class="col-sm-2 control-label">是否可见：</label>
                <div class="col-sm-2" id="menu-visible">
                    <?php if($menu["isvisible"] == 0): ?><span class="label label-default control-label">不可见</span>
                        <?php else: ?>
                        <span class="label label-success control-label">可见</span><?php endif; ?>
                </div>
            </div>

            <div class="form-group row has-feedback">
                <label for="menu-introduction" class="col-sm-2 control-label">菜单描述：</label>
                <div class="col-sm-4">
                    <label class="control-label" name="menu[introduction]" id="menu-introduction" value="<?php echo ($menu["introduction"]); ?>"><?php echo ($menu["introduction"]); ?></label>
                </div>
            </div>

        </div>
    </div>

    <div class="breadcrumb">
        <form class="form-horizontal" enctype="multipart/form-data" method="post" action="<?php echo U('Menu/editTheMenu');?>" style="margin-top: 20px;">
            <input type="hidden" name="edit_menu[id]" id="menu-id" value="<?php echo ($menu["id"]); ?>">
            <div class="form-group row has-feedback">
                <label for="edit_menu-name" class="col-sm-2 control-label">更改菜单名：</label>
                <div class="col-sm-4">
                    <input type="text" id="edit_menu-name" class="form-control" name="edit_menu[name]" placeholder="菜单的名称" style="display:inline-block;width: 60%;" value="<?php echo ($menu["name"]); ?>">
                </div>
            </div>

            <div class="form-group row has-feedback">
                <label for="edit_menu-url" class="col-sm-2 control-label">更改菜单URL：</label>
                <div class="col-sm-4">
                    <input type="text" id="edit_menu-url" class="form-control" name="edit_menu[url]" placeholder="菜单的url" style="display:inline-block;width: 60%;" value="<?php echo ($menu["url"]); ?>">
                </div>
            </div>

            <div class="form-group row has-feedback">
                <label for="edit_menu-introduction" class="col-sm-2 control-label">更改菜单描述：</label>
                <div class="col-sm-4">
                    <input type="text" id="edit_menu-introduction" class="form-control" name="edit_menu[introduction]" placeholder="菜单的描述" style="display:inline-block;width: 60%;" value="<?php echo ($menu["introduction"]); ?>">
                </div>
            </div>

            <div class="form-group row has-feedback">
                <label class="col-sm-2 control-label">更改菜单类型</label>
                <div class="col-sm-4">
                    <select id="edit_menu-type" name="edit_menu[type]" class="form-control">
                        <?php if($menu["type"] == 0): ?><option value="0" selected>当前:未定义</option>
                            <?php elseif($menu["type"] == 1): ?>
                            <option value="1" selected>控制器(模块)</option>
                            <?php elseif($menu["type"] == 2): ?>
                            <option value="2" selected>页面</option>
                            <?php else: ?>
                            <option value="3" selected>动作(功能,方法)</option><?php endif; ?>
                        <option value="0">不定义</option>
                        <option value="1">控制器(模块)[默认父级]</option>
                        <option value="2">页面</option>
                        <option value="3">动作(功能, 方法)[默认不可见]</option>
                    </select>
                </div>
            </div>

            <div class="form-group row has-feedback">
                <label class="col-sm-2 control-label">更改上级菜单：</label>

                <div class="col-sm-4">
                    <select id="tag" name="edit_menu[id_father]" class="form-control">
                        <?php if($menu["level"] == 0): ?><option value="0" selected>无</option>
                        <?php else: ?>
                            <option value="<?php echo ($menu["id_father"]); ?>" selected><?php echo ($menu["name_father"]); ?></option>
                            <option value="0">无</option><?php endif; ?>
                        <?php if(is_array($menuList)): $i = 0; $__LIST__ = $menuList;if( count($__LIST__)==0 ) : echo "" ;else: foreach($__LIST__ as $key=>$menu_father): $mod = ($i % 2 );++$i;?><option value="<?php echo ($menu_father["id"]); ?>"><?php echo ($menu_father["name"]); ?>[<?php echo ($menu_father["url"]); ?>]<?php echo ($menu_father["visible"]); ?></option><?php endforeach; endif; else: echo "" ;endif; ?>
                    </select>
                </div>
                <p class="help-block">如选择无则代表是模块。</p>
            </div>

            <div class="form-group row has-feedback">
                <label for="isEnabled" class="col-sm-2 control-label">更改是否可见：</label>

                <div class="col-sm-2">
                    <select id="isEnabled" name="edit_menu[isvisible]" class="form-control">
                        <?php if($menu["isvisible"] == 0): ?><option value="0" selected>隐藏中</option>
                            <option value="1">可见</option>
                        <?php else: ?>
                            <option value="1" selected>可见</option>
                            <option value="0">隐藏</option><?php endif; ?>

                    </select>
                </div>
            </div>

            <div class="form-group row has-feedback">
                <label for="isAvailable" class="col-sm-2 control-label">更改是否启用：</label>

                <div class="col-sm-2">
                    <select id="isAvailable" name="edit_menu[isavailable]" class="form-control">
                        <?php if($menu["isavailable"] == 0): ?><option value="0" selected>不可用</option>
                            <option value="1">启用</option>
                            <?php else: ?>
                            <option value="1" selected>启用</option>
                            <option value="0">不可用</option><?php endif; ?>

                    </select>
                </div>
            </div>
            <div class="form-group row" style="margin-top: 20px;">
                <div class="col-md-2">
                    <button type="submit" class="btn btn-primary" style="margin-left: 100px;">保存</button>
                </div>
                <div class="col-sm-4">
                    <a href="javascript:history.go(-1);">
                        <span class="btn btn-default">返回</span>
                    </a>
                </div>
            </div>
        </form>
    </div>
</div>
</body>
</html>