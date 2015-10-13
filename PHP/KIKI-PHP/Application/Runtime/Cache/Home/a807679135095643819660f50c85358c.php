<?php if (!defined('THINK_PATH')) exit();?><!DOCTYPE html>
<html>
<head lang="en">
    <meta charset="UTF-8">
    <title>Sign up - <?php echo ($websiteBaseInfo["title"]); ?></title>
    <link rel="stylesheet" href="/kiki/Public/css/signup.css">
</head>
<body>
<!DOCTYPE html>
<html lang="ZH-CN">
    <head>
        <title>KIKI Response Header</title>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <meta name="description" content="">
        <meta name="author" content="">
        <!--<link rel="stylesheet" href="http://apps.bdimg.com/libs/bootstrap/3.3.0/css/bootstrap.min.css">-->
        <!--<script src="http://apps.bdimg.com/libs/jquery/2.1.1/jquery.min.js"></script>-->
        <!--<script src="http://apps.bdimg.com/libs/bootstrap/3.3.0/js/bootstrap.min.js"></script>-->

        <link rel="stylesheet" href="/kiki/Public/css/bootstrap.min.css">
        <link rel="stylesheet" href="/kiki/Public/css/bootstrap.css">
        <link rel="stylesheet" href="/kiki/Public/css/carousel.css">
        <script src="/kiki/Public/js/jquery-2.1.4.min.js"></script>
        <!--<script src="/kiki/Public/js/bootstrap.min.js"></script>-->

    </head>
    <body>
    <!--[if lt IE 7]>
        <p class="chromeframe">You are using an outdated browser. <a href="http://browsehappy.com/">Upgrade your browser
            today</a> or <a href="#/chromeframe/?redirect=true">install Google Chrome Frame</a> to better experience this site.
        </p>
    <![endif]-->

        <header>
            <nav class="navbar navbar-default" role="navigation">
                <div class="navbar-header">
                    <button type="button" class="navbar-toggle" data-toggle="collapse"
                            data-target="#example-navbar-collapse">
                        <span class="sr-only">切换导航</span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                    </button>
                    <a class="navbar-brand" href="<?php echo U('Index/index');?>">KIKI</a>
                </div>
                <div class="collapse navbar-collapse" id="example-navbar-collapse">
                    <ul class="nav navbar-nav">
                        <li><a href="#">Discover</a></li>
                        <li><a href="#">Start</a></li>
                        <!--<li class="dropdown">-->
                            <!--<a href="#" class="dropdown-toggle" data-toggle="dropdown">-->
                                <!--Java <b class="caret"></b>-->
                            <!--</a>-->
                            <!--<ul class="dropdown-menu">-->
                                <!--<li><a href="#">jmeter</a></li>-->
                                <!--<li><a href="#">EJB</a></li>-->
                                <!--<li><a href="#">Jasper Report</a></li>-->
                                <!--<li class="divider"></li>-->
                                <!--<li><a href="#">分离的链接</a></li>-->
                                <!--<li class="divider"></li>-->
                                <!--<li><a href="#">另一个分离的链接</a></li>-->
                            <!--</ul>-->
                        <!--</li>-->
                    </ul>
                    <div>
                        <form class="navbar-form navbar-left" role="search">
                            <div class="form-group">
                                <input type="text" class="form-control" placeholder="Search">
                            </div>
                            <button type="submit" class="btn btn-default">提交</button>
                        </form>
                    </div>
                    <div class="navbar-right">
                        <p class="navbar-text"><a href="<?php echo U('User/signup');?>">sign up</a></p>
                        <p class="navbar-text"><a href="<?php echo U('User/login');?>">log in</a></p>
                    </div>
                </div>

            </nav>
        </header>
    </body>
</html>
    <div class="container">
        <div class="panel panel-default panel-signup">
            <form class="form-signup">
                <h2 class="form-signup-heading">Sign up</h2>
                <label for="inputName" class="sr-only">Name</label>
                <input id="inputName" class="form-control" placeholder="Name" required="" type="text">
                <label for="inputEmail" class="sr-only">Email</label>
                <input id="inputEmail" class="form-control" placeholder="Email" required="" autofocus="" type="email">
                <label for="inputPassword" class="sr-only">Password</label>
                <input id="inputPassword" class="form-control" placeholder="Password" required="" type="password">
                <label for="inputPasswordAgain" class="sr-only">Re-enter Password</label>
                <input id="inputPasswordAgain" class="form-control" placeholder="Re-enter Password" required="" type="password">
                <div class="checkbox">
                    <label>
                        <input value="remember-me" type="checkbox"> Receive occasional updates with our favorite projects and the latest news
                    </label>
                </div>
                <button class="btn btn-lg btn-success btn-block" type="submit">Sign up now!</button>
            </form>
            <p class="help-block">By signing up, you agree to our terms of use, privacy policy, and cookie policy. </p>
            <div class="panel-footer">Have an account? <a href="<?php echo U('User/Login');?>">Log in</a></div>
        </div>
        <!DOCTYPE html>
<html lang="zh-CN">
<head>
</head>
<body>
<footer>
    <hr class="featurette-divider">
    <div class="container">
        <div class="main-footer">
            <div class="row">
                <div class="col-md-3">
                    <div class="about">
                        <h4 class="footer-title">关于我们</h4>

                        <p>尚无内容……</p>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="shop-list">
                        <h4 class="footer-title">待添加</h4>
                        <ul>
                            <li><a href="#"><i class="fa fa-angle-right"></i>New Grill Menu</a></li>
                            <li><a href="#"><i class="fa fa-angle-right"></i>Healthy Fresh Juices</a></li>
                            <li><a href="#"><i class="fa fa-angle-right"></i>Spicy Delicious Meals</a></li>
                            <li><a href="#"><i class="fa fa-angle-right"></i>Simple Italian Pizzas</a></li>
                            <li><a href="#"><i class="fa fa-angle-right"></i>Pure Good Yogurts</a></li>
                            <li><a href="#"><i class="fa fa-angle-right"></i>Ice-cream for kids</a></li>
                        </ul>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="recent-posts">
                        <h4 class="footer-title">待添加</h4>

                        <div class="recent-post">
                            <div class="recent-post-thumb">
                                <img src="/kiki/Uploads/images/recent-post1.jpg" alt="">
                            </div>
                            <div class="recent-post-info">
                                <h6><a href="#">Delicious and Healthy Menus</a></h6>
                                <span>24/12/2084</span>
                            </div>
                        </div>
                        <div class="recent-post">
                            <div class="recent-post-thumb">
                                <img src="/kiki/Uploads/images/recent-post2.jpg" alt="">
                            </div>
                            <div class="recent-post-info">
                                <h6><a href="#">Simple and effective meals</a></h6>
                                <span>18/12/2084</span>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="more-info">
                        <h4 class="footer-title">更多信息</h4>

                        <p>欢迎联系我们！</p>
                        <ul>
                            <li><i class="fa fa-phone"></i>010-020-0340</li>
                            <li><i class="fa fa-globe"></i>123 Dagon Studio, Yakin Street, Digital Estate</li>
                            <li><i class="fa fa-envelope"></i><a href="#">联系管理员</a></li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
        <hr class="featurette-divider">
        <div class="bottom-footer">

            <p><div class="pull-right"> <?php if($account == 'admin'): ?><span class="glyphicon glyphicon-cog"></span><a class="navbar-link" href="/kiki/admin.php"> 后台管理</a><?php endif; ?></div>Copyright © 2015 <a href="#">JasonLee</a>

            </p>
        </div>

    </div>
</footer>



<!-- jQuery文件。务必在bootstrap.min.js 之前引入 -->
<!--<script src="http://cdn.bootcss.com/jquery/1.11.1/jquery.min.js"></script>-->
<!-- 最新的 Bootstrap 核心 JavaScript 文件 -->
<!--<script src="http://cdn.bootcss.com/bootstrap/3.3.0/js/bootstrap.min.js"></script>-->
<script src="/kiki/Public/js/bootstrap.js"></script>

</body>
</html>
    </div>

</body>
</html>