<?php if (!defined('THINK_PATH')) exit();?><!DOCTYPE html>
<html>
<head lang="en">
    <meta charset="UTF-8">
    <title>Menus List - <?php echo ($title); ?></title>
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
            <a class="navbar-brand" href="<?php echo U('Index/index');?>"><?php echo ($title); ?> <?php echo (L("lang_backstage")); ?></a>
        </div>
        <div id="navbar" class="navbar-collapse collapse">
            <ul class="nav navbar-nav navbar-right">
                <li><div class="navbar-text"><?php echo (L("lang_change")); ?><a href="?l=zh-cn">简体中文</a> | <a href="?l=zh-tw">繁體中文</a> | <a href="?l=en-us">English</a></div></li>
                <li><p class="navbar-text"><?php echo (L("welcome")); ?>, </p></li>
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
                            <li><a href=""><?php echo (L("lang_logout")); ?></a></li>
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
                <li><a href="<?php echo U('Login/doLogout');?>"><i class="glyphicon glyphicon-off"> <?php echo (L("lang_logout")); ?></i></a></li>
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
                <li class="" style="background-color: #1b6d85;"><a href="<?php echo U('Index/index');?>" style="color: #ffffff;"><?php echo (L("lang_backstage")); ?></a></li>
            <?php if(is_array($menus)): $i = 0; $__LIST__ = $menus;if( count($__LIST__)==0 ) : echo "" ;else: foreach($__LIST__ as $key=>$vo): $mod = ($i % 2 );++$i;?><li>
                    <a href="#systemSetting<?php echo ($vo["id"]); ?>" class="nav-header collapsed" data-toggle="collapse">
                        <i class="glyphicon glyphicon-plus"></i>
                        <?php echo ($vo["name"]); ?>
                        <!--<span class="pull-right glyphicon glyphicon-chevron-toggle"></span>-->
                    </a>
                    <ul id="systemSetting<?php echo ($vo["id"]); ?>" class="nav nav-list collapse" style="height: 0px;">
                        <?php if(is_array($vo["childMenus"])): $i = 0; $__LIST__ = $vo["childMenus"];if( count($__LIST__)==0 ) : echo "" ;else: foreach($__LIST__ as $key=>$vo1): $mod = ($i % 2 );++$i; if($vo1["isActivated"] != 0): ?><li class="active">
                            <?php else: ?>
                                <li><?php endif; ?>
                            <?php if($vo1["enable"] == 0): ?><a>
                            <?php else: ?>
                                <a href="/kiki/admin.php/<?php echo ($vo["url"]); ?>/<?php echo ($vo1["url"]); ?>"><?php endif; ?>
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
    <div class="table-responsive breadcrumb">
        <caption>
            <form class="bs-example bs-example-form form-inline" role="form" method="get" action="<?php echo ($currentURL); ?>">
                <div class="row">
                    <div class="form-inline pull-right">
                        <div class="btn-toolbar" role="toolbar">
                            <div class="btn-group">
                                <button type="submit" class="btn btn-default" value="-1" name="pageSize">ALL</button>
                                <button type="submit" class="btn btn-default" value="20" name="pageSize">Default</button>
                                <button type="submit" class="btn btn-default" value="5" name="pageSize">5</button>
                                <button type="submit" class="btn btn-default" value="15" name="pageSize">15</button>
                                <button type="submit" class="btn btn-default" value="30" name="pageSize">30</button>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-offset-0 row">
                        <div class="form-inline">
                            <div class="btn-toolbar" role="toolbar">
                                <div class="btn-group">
                                    <button type="submit" class="btn btn-default" value="-1" name="level">All</button>
                                    <button type="submit" class="btn btn-inverse" value="0" name="level">Undefined</button>
                                    <button type="submit" class="btn btn-danger" value="1" name="level">Module</button>
                                    <button type="submit" class="btn btn-info" value="2" name="level">Page</button>
                                    <button type="submit" class="btn btn-warning" value="3" name="level">Action</button>
                                </div>
                                <div class="btn-group" style="margin-left: 50px;">
                                    <button type="submit" class="btn btn-default" value="-1" name="visible">All</button>
                                    <button type="submit" class="btn btn-inverse" value="0" name="visible">Invisible</button>
                                    <button type="submit" class="btn btn-success" value="1" name="visible">Visible</button>
                                </div>
                                <div class="btn-group" style="margin-left: 50px;">
                                    <button type="submit" class="btn btn-default" value="-1" name="enable">All</button>
                                    <button type="submit" class="btn btn-inverse" value="0" name="enable">Disable</button>
                                    <button type="submit" class="btn btn-success" value="1" name="enable">Enable</button>
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
                <th>Operation</th>
                <th>Menu Name</th>
                <th>Menu URL</th>
                <th>Added Time</th>
                <th>Added By</th>
                <th>Father Menu</th>
                <th>Menu Type</th>
                <th>Description</th>
                <th>Show on Navigation</th>
                <th>Enabled</th>
            </tr>
            </thead>
            <tbody id="menu-list-content">
            <?php if(is_array($list)): $i = 0; $__LIST__ = $list;if( count($__LIST__)==0 ) : echo "" ;else: foreach($__LIST__ as $key=>$vo): $mod = ($i % 2 );++$i;?><tr>
                    <td><a class="btn btn-sm btn-warning" href="<?php echo ($vo["edit_url"]); ?>">编辑</a></td>
                    <td><?php echo ($vo["name"]); ?></td>
                    <td><?php echo ($vo["url"]); ?></td>
                    <td><?php echo ($vo["added_date"]); ?></td>
                    <td><?php echo ($vo["username_added"]); ?></td>
                    <td>
                        <?php if($vo["parent_id"] == 0): ?><span class="label label-danger">Top Menu</span>
                        <?php else: ?>
                            <span class="label label-info"><?php echo ($vo["name_father"]); ?></span><?php endif; ?>
                    </td>
                    <td>
                        <?php if($vo["level"] == 0): ?><span class="label label-default">Undefined</span>
                        <?php elseif($vo["level"] == 1): ?>
                            <span class="label label-danger">Module</span>
                        <?php elseif($vo["level"] == 2): ?>
                            <span class="label label-info">Page</span>
                        <?php else: ?>
                            <span class="label label-warning">Action</span><?php endif; ?>
                    </td>
                    <td><?php echo ($vo["description"]); ?></td>
                    <td>
                        <?php if($vo["visible"] == 0): ?><span class="label label-default">Invisible</span>
                        <?php else: ?>
                            <span class="label label-success">Visible</span><?php endif; ?>
                    </td>
                    <td>
                        <?php if($vo["enable"] == 0): ?><span class="label label-default">Disable</span>
                            <?php else: ?>
                            <span class="label label-success">Enable</span><?php endif; ?>
                    </td>
                </tr><?php endforeach; endif; else: echo "" ;endif; ?>
            </tbody>
        </table>
    </div>
    <!--翻页-->
    <div align="center">
        <?php echo ($page); ?>
    </div>
    <div style="margin-top:20px;margin-bottom:10px;border-bottom: 1px solid #999999;color: #999999">
        Add new menu：
    </div>
    <div class="adder">
        <form class="form-horizontal" enctype="multipart/form-data" accept-charset="utf-8" action="<?php echo U('Menu/postNewMenu');?>" method="post">
            <input type="hidden" name="" value="2">
            <div id="body-wrap" width="60%" class="breadcrumb">
                <div class="form-group row has-feedback" style="margin-top: 20px;">
                    <label class="col-sm-2 control-label">Name：</label>
                    <div class="col-sm-4">
                        <input type="text" class="form-control" name="new_menu[name]" placeholder=""
                               style="display:inline-block;width: 90%;" required>
                    </div>
                </div>

                <div class="form-group row has-feedback" style="margin-top: 20px;">
                    <label class="col-sm-2 control-label">URL：</label>

                    <div class="col-sm-4">
                        <input type="text" class="form-control" name="new_menu[url]" placeholder=""
                               style="display:inline-block;width: 90%;" required>
                        </select>
                    </div>
                    <p class="help-block">URL of the menu.</p>
                </div>

                <div class="form-group row has-feedback">
                    <label class="col-sm-2 control-label">Description：</label>

                    <div class="col-sm-4">
                        <input type="text" class="form-control" name="new_menu[description]" placeholder=""
                               style="display:inline-block;width: 90%;">
                    </div>
                </div>

                <div class="form-group row has-feedback" style="margin-top: 20px;">
                    <label class="col-sm-2 control-label">Type：</label>
                    <div class="col-sm-4">
                        <select class="form-control" name="new_menu[level]">
                            <option value="0">Undefined</option>
                            <option value="1">Module/Controller</option>
                            <option value="2">Page</option>
                            <option value="3">Action</option>
                        </select>
                    </div>
                    <p class="help-block">Action will always invisible. Module will not have any parent menu</p>
                </div>

                <div class="form-group row has-feedback" style="margin-top: 20px;">
                    <label class="col-sm-2 control-label">Parent：</label>
                    <div class="col-sm-4">
                        <select class="form-control" name="new_menu[parent_id]" id="menu">
                            <option value="0" selected>No Parent</option>
                            <?php if(is_array($parentMenus)): $i = 0; $__LIST__ = $parentMenus;if( count($__LIST__)==0 ) : echo "" ;else: foreach($__LIST__ as $key=>$vo): $mod = ($i % 2 );++$i;?><option value="<?php echo ($vo["id"]); ?>"><?php echo ($vo["name"]); ?>[<?php echo ($vo["url"]); ?>]</option><?php endforeach; endif; else: echo "" ;endif; ?>
                        </select>
                    </div>
                    <p class="help-block">If this menu is able to browse.</p>
                </div>

                <div class="form-group row has-feedback" style="margin-top: 20px;">
                    <label class="col-sm-2 control-label">Visible：</label>
                    <div class="col-sm-4">
                        <select class="form-control" name="new_menu[visible]">
                            <option value="1">Visible</option>
                            <option value="0">Invisible</option>
                        </select>
                    </div>
                    <p class="help-block">If this menu is able to be see on the navigation list.</p>
                </div>

                <div class="form-group row has-feedback" style="margin-top: 20px;">
                    <label class="col-sm-2 control-label">Enable：</label>
                    <div class="col-sm-4">
                        <select class="form-control" name="new_menu[enable]">
                            <option value="1">Enable</option>
                            <option value="0">Disable</option>
                        </select>
                    </div>
                    <p class="help-block">If this menu is able to browse.</p>
                </div>

                <div class="form-group row" style="margin-top: 20px;">
                    <div class="col-md-2">
                        <button type="submit" class="btn btn-primary" style="margin-left: 100px;;">Submit</button>
                    </div>
                </div>
            </div>
        </form>
    </div>
</div>

</div>
</body>
</html>