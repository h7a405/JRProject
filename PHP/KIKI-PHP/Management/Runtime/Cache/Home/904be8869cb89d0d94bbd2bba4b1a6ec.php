<?php if (!defined('THINK_PATH')) exit();?><!DOCTYPE html>
<html>
<head lang="en">
    <meta charset="UTF-8">
    <title>index - <?php echo ($title); ?></title>
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
    <div class="table-responsive breadcrumb">
        <caption>
            <form class="bs-example bs-example-form form-inline" role="form" method="get" action="<?php echo U('Permission/index');?>">
                <div class="row">
                    <div class="form-inline pull-right">
                        <div class="btn-toolbar" role="toolbar">
                            <div class="btn-group">
                                <button type="submit" class="btn btn-default" value="20" name="pageSize">默认</button>
                                <button type="submit" class="btn btn-default" value="5" name="pageSize">5条</button>
                                <button type="submit" class="btn btn-default" value="15" name="pageSize">15条</button>
                                <button type="submit" class="btn btn-default" value="30" name="pageSize">30条</button>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-offset-0 row">
                        <div class="form-inline">
                            <div class="btn-toolbar" role="toolbar">
                                <div class="btn-group">
                                    <button type="submit" class="btn btn-default" value="-1" name="type">全部</button>
                                    <button type="submit" class="btn btn-inverse" value="0" name="type">全局通用</button>
                                    <button type="submit" class="btn btn-danger" value="1" name="type">仅限前台</button>
                                    <button type="submit" class="btn btn-info" value="2" name="type">仅限后台</button>
                                </div>
                                <div class="btn-group" style="margin-left: 50px;">
                                    <button type="submit" class="btn btn-default" value="-1" name="isenabled">全部</button>
                                    <button type="submit" class="btn btn-inverse" value="0" name="isenabled">不可用</button>
                                    <button type="submit" class="btn btn-success" value="1" name="isenabled">启用中</button>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!--<div class="col-lg-8 form-inline">-->
                    <!--<div class="form-group">-->
                    <!--<p class="help-block">(搜索的为括号内内容)</p></div>-->
                    <!--<div class="control-label form-group">-->
                    <!--<select name="keywordType" class="form-control">-->
                    <!--<option value="" selected>选择搜索字段</option>-->
                    <!--<?php if(is_array($fields)): $i = 0; $__LIST__ = $fields;if( count($__LIST__)==0 ) : echo "" ;else: foreach($__LIST__ as $key=>$vo): $mod = ($i % 2 );++$i;?>-->
                    <!--<option value="<?php echo ($vo["value"]); ?>"><?php echo ($vo["name"]); ?></option>-->
                    <!--<?php endforeach; endif; else: echo "" ;endif; ?>-->
                    <!--</select>-->
                    <!--</div>-->
                    <!--<div class="form-group input-group">-->
                    <!--<input type="text" class="form-control" name="keyword">-->

                    <!--<span class="input-group-btn">-->
                    <!--<button class="btn btn-default" type="submit">-->
                    <!--<i class="glyphicon glyphicon-search"></i>-->
                    <!--</button>-->
                    <!--</span>-->
                    <!--</div>-->
                    <!--&lt;!&ndash; /input-group &ndash;&gt;-->
                    <!--</div>-->
                    <!-- /.col-lg-6 -->
                </div>
                <!-- /.row -->
            </form>

        </caption>

        <table class="table table-hover table-condensed" style="background-color: white; margin-top: 20px;">
            <thead>
            <tr>
                <th>操作</th>
                <th>权限名</th>
                <th>对应URL</th>
                <th>添加时间</th>
                <th>添加人</th>
                <th>权限类别</th>
                <th>权限描述</th>
                <th>是否启用</th>
            </tr>
            </thead>
            <tbody id="menu-list-content">
            <?php if(is_array($list)): $i = 0; $__LIST__ = $list;if( count($__LIST__)==0 ) : echo "" ;else: foreach($__LIST__ as $key=>$vo): $mod = ($i % 2 );++$i;?><tr>
                    <td><a class="btn btn-sm btn-warning" href="<?php echo ($vo["edit_url"]); ?>">编辑</a></td>
                    <td><?php echo ($vo["name"]); ?></td>
                    <td><?php echo ($vo["url"]); ?></td>
                    <td><?php echo ($vo["datetime_added"]); ?></td>
                    <td><?php echo ($vo["username_added"]); ?></td>
                    <td>
                        <?php if($vo["type"] == 0): ?><span class="label label-default">全局通用</span>
                            <?php elseif($vo["type"] == 1): ?>
                            <span class="label label-danger">仅限前台</span>
                            <?php elseif($vo["type"] == 2): ?>
                            <span class="label label-info">仅限后台</span><?php endif; ?>
                    </td>
                    <td><?php echo ($vo["introduction"]); ?></td>
                    <td>
                        <?php if($vo["isenabled"] == 0): ?><span class="label label-default">不可用</span>
                            <?php else: ?>
                            <span class="label label-success">启用中</span><?php endif; ?>
                    </td>
                </tr><?php endforeach; endif; else: echo "" ;endif; ?>
            </tbody>
        </table>
    </div>
</div>
<!--翻页-->
<div align="center">
    <?php echo ($page); ?>
</div>
</div>
</body>
</html>