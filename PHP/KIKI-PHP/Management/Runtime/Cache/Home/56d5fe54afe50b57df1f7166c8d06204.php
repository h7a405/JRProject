<?php if (!defined('THINK_PATH')) exit();?><!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>System - <?php echo ($title); ?></title>
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
                            <?php if($vo1["isActivated"] != 0): ?><i class="glyphicon glyphicon-chevron-right">
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
    <div class="breadcrumb">
        <table class="table table-bordered" style="width:55%; background-color: white; margin-top:10px;">
            <tr>
                <td width="25%"><label class="control-label">系统名称：</label></td>
                <td><label id="system-name" value="<?php echo ($system["name"]); ?>"><?php echo ($system["name"]); ?></label></td>
            </tr>
            <tr>
                <td><label class="control-label">IP地址：</label></td>
                <td><label id="system-ipAddress" value="<?php echo ($system["ip"]); ?>"><?php echo ($system["ip"]); ?></label></td>
            </tr>
            <tr>
                <td><label class="control-label">网站域名：</label></td>
                <td><label id="system-domain" value="<?php echo ($system["domain"]); ?>"><?php echo ($system["domain"]); ?></label></td>
            </tr>
            <tr>
                <td><label class="control-label">关键词：</label></td>
                <td><label id="system-intro" value="<?php echo ($system["introduction"]); ?>"><?php echo ($system["introduction"]); ?></label></td>
            </tr>
            <tr>
                <td><label class="control-label">前台状态：</label></td>
                <td>
                    <?php if($system["iskikiopened"] == 0): ?><span class="label label-warning">已关闭</span><?php endif; ?>
                    <?php if($system["iskikiopened"] == 1): ?><span class="label label-success">开启中</span><?php endif; ?>
                    <!--<label name="system[status]" id="system-status" value="<?php echo ($system["status"]); ?>"><?php echo ($system["status"]); ?></label>-->
                </td>
            </tr>
            <tr>
                <td><label class="control-label">系统状态：</label></td>
                <td>
                    <?php if($system["issystemopened"] == 0): ?><span class="label label-warning">已关闭</span><?php endif; ?>
                    <?php if($system["issystemopened"] == 1): ?><span class="label label-success">开启中</span><?php endif; ?>
                    <!--<label name="system[status]" id="system-status" value="<?php echo ($system["status"]); ?>"><?php echo ($system["status"]); ?></label>-->
                </td>
            </tr>
        </table>
    </div>
    <div style="margin-top:20px;margin-bottom:10px;border-bottom: 1px solid #999999;color: #999999">
        修改信息：
    </div>
    <form class="form-horizontal" enctype="multipart/form-data" id="edit_system" method="post"
          action="<?php echo U('System/editSystemInfo');?>">
        <div id="body-wrap" width="60%" class="breadcrumb">
            <div class="form-group row has-feedback" style="margin-top: 20px;">
                <label for="name" class="col-sm-2 control-label">系统名称：</label>

                <div class="col-sm-4">
                    <input id="name" type="text" class="form-control" name="system[name]" placeholder="请输入系统名称"
                           style="display:inline-block;width: 90%;" value="<?php echo ($system["name"]); ?>">
                </div>
            </div>

            <div class="form-group row has-feedback">
                <label class="col-sm-2 control-label">IP地址：</label>

                <div class="col-sm-4">
                    <input type="text" class="form-control" name="system[ip]" placeholder="如无，请留空"
                           style="display:inline-block;width: 90%;" value="<?php echo ($system["ip"]); ?>">
                </div>
            </div>

            <div class="form-group row has-feedback">
                <label class="col-sm-2 control-label">网站域名：</label>

                <div class="col-sm-4">
                    <input type="text" class="form-control" name="system[domain]" placeholder="如无，请留空"
                           style="display:inline-block;width: 90%;" value="<?php echo ($system["domain"]); ?>">
                </div>
            </div>

            <div class="form-group row has-feedback">
                <label class="col-sm-2 control-label">关键词：</label>

                <div class="col-sm-4">
                    <input type="text" class="form-control" name="system[introduction]" placeholder="多个用,隔开"
                           style="display:inline-block;width: 90%;" value="<?php echo ($system["introduction"]); ?>">
                </div>
            </div>

            <div class="form-group row has-feedback">
                <label for="iskikiopened" class="col-sm-2 control-label">前台状态：</label>

                <div class="col-sm-2">
                    <select id="iskikiopened" name="system[iskikiopened]" class="form-control">
                        <?php if($system["iskikiopened"] == 0): ?><option value="1" >开启</option>
                            <option value="0" selected>关闭</option>
                            <?php else: ?>
                            <option value="1" selected>开启</option>
                            <option value="0">关闭</option><?php endif; ?>

                    </select>
                </div>
            </div>

            <div class="form-group row has-feedback">
                <label for="issystemopened" class="col-sm-2 control-label">系统状态：</label>

                <div class="col-sm-2">
                    <select id="issystemopened" name="system[issystemopened]" class="form-control">
                        <?php if($system["issystemopened"] == 0): ?><option value="1" >开启</option>
                            <option value="0" selected>关闭</option>
                            <?php else: ?>
                            <option value="1" selected>开启</option>
                            <option value="0">关闭</option><?php endif; ?>

                    </select>
                </div>
                <p class="help-block">*请勿随意关闭系统</p>
            </div>

            <div class="form-group row" style="margin-top: 20px;">
                <div class="col-md-2">
                    <button type="submit" class="btn btn-primary" style="margin-left: 100px;;">保存</button>
                </div>
            </div>
        </div>
    </form>
</div>

</body>
</html>