<?php if (!defined('THINK_PATH')) exit();?><!DOCTYPE html>
<html>
<head lang="en">
    <meta charset="UTF-8">
    <title>EditGroup - <?php echo ($title); ?></title>
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
                        <li><?php echo ($actionName); ?></li>
                    </ol>
                </h3>
            </div>
        </div>
    </header>
    <div class="form-horizontal">
        <div id="body-wrap" class="breadcrumb">
            <div class="form-group row has-feedback">
                <label class="col-sm-2 control-label">群组名：</label>
                <div class="col-sm-4">
                    <label class="control-label"><?php echo ($group["name"]); ?></label>
                </div>
            </div>

            <div class="form-group row has-feedback">
                <label class="col-sm-2 control-label">群组容量：</label>
                <div class="col-sm-4">
                    <label class="control-label"><?php echo ($group["capacity"]); ?></label>
                </div>
            </div>

            <div class="form-group row has-feedback">
                <label class="col-sm-2 control-label">添加日期：</label>
                <div class="col-sm-4">
                    <label class="control-label"><?php echo ($group["datetime_added"]); ?></label>
                </div>
            </div>

            <div class="form-group row has-feedback">
                <label class="col-sm-2 control-label">添加人：</label>
                <div class="col-sm-4">
                    <label class="control-label"><?php echo ($group["username_added"]); ?></label>
                </div>
            </div>

            <div class="form-group row has-feedback">
                <label class="col-sm-2 control-label">群组类型：</label>
                <div class="col-sm-2">
                    <?php if($group["type"] == 0): ?><span class="label label-default">全局通用</span>
                        <?php elseif($group["type"] == 1): ?>
                        <span class="label label-danger">仅限前台</span>
                        <?php elseif($group["type"] == 2): ?>
                        <span class="label label-info">仅限后台</span><?php endif; ?>
                </div>
            </div>

            <div class="form-group row has-feedback">
                <label class="col-sm-2 control-label">是否可用：</label>
                <div class="col-sm-2">
                    <?php if($group["isenabled"] == 0): ?><span class="label label-default control-label">不可用</span>
                        <?php else: ?>
                        <span class="label label-success control-label">启用中</span><?php endif; ?>
                </div>
            </div>

            <div class="form-group row has-feedback">
                <label class="col-sm-2 control-label">群组描述：</label>
                <div class="col-sm-4">
                    <label class="control-label"><?php echo ($group["introduction"]); ?></label>
                </div>
            </div>

        </div>
    </div>

    <div class="breadcrumb">
        <form class="form-horizontal" enctype="multipart/form-data" method="post" action="<?php echo U('Permission/editThePermission');?>" style="margin-top: 20px;">
            <input type="hidden" name="edit_group[id]" value="<?php echo ($group["id"]); ?>">
            <div class="form-group row has-feedback">
                <label class="col-sm-2 control-label">更改群组名：</label>
                <div class="col-sm-4">
                    <input type="text" class="form-control" name="edit_permission[name]" placeholder="名称" style="display:inline-block;width: 60%;" value="<?php echo ($group["name"]); ?>">
                </div>
            </div>

            <div class="form-group row has-feedback">
                <label class="col-sm-2 control-label">群组容量：</label>
                <div class="col-sm-4">
                    <input type="number" class="form-control" style="display:inline-block;" value="<?php echo ($group["capacity"]); ?>">
                </div>
                <p class="help-block">*群组的可容纳人数</p>
            </div>

            <div class="form-group row has-feedback">
                <label class="col-sm-2 control-label">更改描述：</label>
                <div class="col-sm-4">
                    <input type="text" class="form-control" name="edit_permission[introduction]" placeholder="权限的描述" style="display:inline-block;" value="<?php echo ($permission["introduction"]); ?>">
                </div>
            </div>

            <div class="form-group row has-feedback">
                <label class="col-sm-2 control-label">更改群组类型：</label>
                <div class="col-sm-4">
                    <select name="edit_permission[type]" class="form-control" disabled>
                        <?php if($group["type"] == 0): ?><option value="0" selected>全局通用</option>
                            <option value="1">仅限前台</option>
                            <option value="2">仅限后台</option>
                            <?php elseif($permission["type"] == 1): ?>
                            <option value="1" selected>仅限前台</option>
                            <option value="0">全局通用</option>
                            <option value="2">仅限后台</option>
                            <?php elseif($permission["type"] == 2): ?>
                            <option value="2" selected>仅限后台</option>
                            <option value="0">全局通用</option>
                            <option value="1">仅限前台</option><?php endif; ?>
                    </select>
                </div>
            </div>

            <div class="form-group row has-feedback">
                <label class="col-sm-2 control-label">更改是否启用：</label>

                <div class="col-sm-2">
                    <select name="edit_permission[isenabled]" class="form-control">
                        <?php if($group["isenabled"] == 0): ?><option value="0" selected>不可用</option>
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