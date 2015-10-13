<?php if (!defined('THINK_PATH')) exit();?><!DOCTYPE HTML>
<html>
    <head>
        <meta charset="utf-8">
        <title><?php echo ($websiteBaseInfo["title"]); ?></title>
        <meta name="description" content="">
        <meta name="viewport" content="width=device-width">
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
        <div class="col-sm-12 col-sm-offset-3 col-md-12 col-md-offset-0 main">

            <div id="myCarousel" class="carousel slide" data-ride="carousel">
                <!-- Indicators -->
                <ol class="carousel-indicators">
                    <li data-target="#myCarousel" data-slide-to="0" class=""></li>
                    <li class="" data-target="#myCarousel" data-slide-to="1"></li>
                    <li class="active" data-target="#myCarousel" data-slide-to="2"></li>
                </ol>
                <div class="carousel-inner" role="listbox">
                    <div class="item">
                        <img class="first-slide" src="data:image/gif;base64,R0lGODlhAQABAIAAAHd3dwAAACH5BAAAAAAALAAAAAABAAEAAAICRAEAOw==" alt="First slide">
                        <div class="container">
                            <div class="carousel-caption">
                                <h1>Example headline.</h1>
                                <p>Note: If you're viewing this page via a <code>file://</code> URL, the "next" and "previous" Glyphicon buttons on the left and right might not load/display properly due to web browser security rules.</p>
                                <p><a class="btn btn-lg btn-primary" href="#" role="button">Sign up today</a></p>
                            </div>
                        </div>
                    </div>
                    <div class="item">
                        <img class="second-slide" src="data:image/gif;base64,R0lGODlhAQABAIAAAHd3dwAAACH5BAAAAAAALAAAAAABAAEAAAICRAEAOw==" alt="Second slide">
                        <div class="container">
                            <div class="carousel-caption">
                                <h1>Another example headline.</h1>
                                <p>Cras justo odio, dapibus ac facilisis in, egestas eget quam. Donec id elit non mi porta gravida at eget metus. Nullam id dolor id nibh ultricies vehicula ut id elit.</p>
                                <p><a class="btn btn-lg btn-primary" href="#" role="button">Learn more</a></p>
                            </div>
                        </div>
                    </div>
                    <div class="item active">
                        <img class="third-slide" src="data:image/gif;base64,R0lGODlhAQABAIAAAHd3dwAAACH5BAAAAAAALAAAAAABAAEAAAICRAEAOw==" alt="Third slide">
                        <div class="container">
                            <div class="carousel-caption">
                                <h1>One more for good measure.</h1>
                                <p>Cras justo odio, dapibus ac facilisis in, egestas eget quam. Donec id elit non mi porta gravida at eget metus. Nullam id dolor id nibh ultricies vehicula ut id elit.</p>
                                <p><a class="btn btn-lg btn-primary" href="#" role="button">Browse gallery</a></p>
                            </div>
                        </div>
                    </div>
                </div>
                <a class="left carousel-control" href="#myCarousel" role="button" data-slide="prev">
                    <span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
                    <span class="sr-only">Previous</span>
                </a>
                <a class="right carousel-control" href="#myCarousel" role="button" data-slide="next">
                    <span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
                    <span class="sr-only">Next</span>
                </a>
            </div>


            <div class="container">
                <div class="row featurette">
                    <div class="col-md-7">
                        <h2 class="featurette-heading">First featurette heading. <span class="text-muted">It'll blow your mind.</span></h2>
                        <p class="lead">Donec ullamcorper nulla non metus auctor fringilla. Vestibulum id ligula porta felis euismod semper. Praesent commodo cursus magna, vel scelerisque nisl consectetur. Fusce dapibus, tellus ac cursus commodo.</p>
                    </div>
                    <!--<div class="col-md-5">-->
                        <!--<img class="featurette-image img-responsive center-block" data-src="holder.js/500x500/auto" alt="Generic placeholder image">-->
                    <!--</div>-->
                    <div class="col-md-2 col-md-offset-1">
                        <ul class="nav nav-pills nav-stacked">
                            <li class="active"><a href="">Home</a></li>
                            <li><a href="">SVN</a></li>
                            <li><a href="">iOS</a></li>
                            <li><a href="">VB.Net</a></li>
                            <li><a href="">Java</a></li>
                            <li><a href="">PHP</a></li>
                            <li><a href="">test1</a></li>
                            <li><a href="">test2</a></li>
                        </ul>
                    </div>
                </div>
            </div>
            <hr class="featurette-divider">


            <div class="container">
                <div class="row">
                    <div class="col-lg-4">
                        <img class="img-circle" src="data:image/gif;base64,R0lGODlhAQABAIAAAHd3dwAAACH5BAAAAAAALAAAAAABAAEAAAICRAEAOw==" alt="Generic placeholder image" height="140" width="140">
                        <h2>Heading</h2>
                        <p>Donec sed odio dui. Etiam porta sem malesuada magna mollis euismod. Nullam id dolor id nibh ultricies vehicula ut id elit. Morbi leo risus, porta ac consectetur ac, vestibulum at eros. Praesent commodo cursus magna.</p>
                        <p><a class="btn btn-default" href="#" role="button">View details »</a></p>
                    </div><!-- /.col-lg-4 -->
                    <div class="col-lg-4">
                        <img class="img-circle" src="data:image/gif;base64,R0lGODlhAQABAIAAAHd3dwAAACH5BAAAAAAALAAAAAABAAEAAAICRAEAOw==" alt="Generic placeholder image" height="140" width="140">
                        <h2>Heading</h2>
                        <p>Duis mollis, est non commodo luctus, nisi erat porttitor ligula, eget lacinia odio sem nec elit. Cras mattis consectetur purus sit amet fermentum. Fusce dapibus, tellus ac cursus commodo, tortor mauris condimentum nibh.</p>
                        <p><a class="btn btn-default" href="#" role="button">View details »</a></p>
                    </div><!-- /.col-lg-4 -->
                    <div class="col-lg-4">
                        <img class="img-circle" src="data:image/gif;base64,R0lGODlhAQABAIAAAHd3dwAAACH5BAAAAAAALAAAAAABAAEAAAICRAEAOw==" alt="Generic placeholder image" height="140" width="140">
                        <h2>Heading</h2>
                        <p>Donec sed odio dui. Cras justo odio, dapibus ac facilisis in, egestas eget quam. Vestibulum id ligula porta felis euismod semper. Fusce dapibus, tellus ac cursus commodo, tortor mauris condimentum nibh, ut fermentum massa justo sit amet risus.</p>
                        <p><a class="btn btn-default" href="#" role="button">View details »</a></p>
                    </div><!-- /.col-lg-4 -->
                </div>
            </div>

            <hr class="featurette-divider">
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