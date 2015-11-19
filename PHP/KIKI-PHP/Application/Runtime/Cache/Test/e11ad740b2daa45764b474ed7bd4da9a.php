<?php if (!defined('THINK_PATH')) exit();?><!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/html">
<head lang="en">
    <meta charset="UTF-8">
    <title></title>
    <link rel="stylesheet" href="/project-kiki/kiki-php/Public/css/bootstrap.min.css">
    <link rel="stylesheet" href="/project-kiki/kiki-php/Public/css/bootstrap.css">
    <script src="/project-kiki/kiki-php/Public/js/jquery-2.1.4.min.js"></script>
    <script>
        function didInterfaceChoosingButtonClicked() {
            document.getElementById('status').innerText = '';
            document.getElementById("result").innerText = '';
            var value = "";
            var text = "";
            var index = "";
            var obj = document.getElementById("interface");
            for (var i = 0; i < obj.length; i++) {
                if (true == obj[i].selected) {
                    text = obj[i].innerText;
                    value = obj[i].value;
                    index = i;
                }
            }
            var radioValue = "";
            var radio = document.getElementsByName("method");
            for (var j = 0; j < radio.length; j++) {
                if (true == radio[j].checked) {
                    radioValue = radio[j].value;
                }
            }
            document.getElementById("selected_method").value = radioValue;
            document.getElementById("selected_interface").value = value;
            document.getElementById("selected_index").value = index;
        }
        function doGetTimeStamp() {
            var timestamp = Date.parse(new Date());
            document.getElementById("timestamp").innerText = timestamp;
        }
    </script>
</head>
<body class="col-xs-12 col-sm-12 col-md-12">
    <table width="1400" border="0" class="table table-responsive">
        <tr>
            <td colspan="3" style="background-color: #31708f;">
                <h3 style="color: #ffffff; text-align: center;">接口测试</h3>
            </td>
        </tr>
        <tr>
            <td style="background-color: #f0c040; width: 200px;">
                <div class="form-group well">选择提交方式：<br/>
                    <input type="radio" name="method" value="post" checked/>POST <br />
                    <input type="radio" name="method" value="get" />GET <br /><br/>
                    选择测试接口：<br/>
                    <select class="form-control" id="interface">
                        <?php if(is_array($InterfaceList)): $i = 0; $__LIST__ = $InterfaceList;if( count($__LIST__)==0 ) : echo "" ;else: foreach($__LIST__ as $key=>$vo): $mod = ($i % 2 );++$i;?><option value="<?php echo ($vo["id"]); ?>"><?php echo ($vo["name"]); ?></option><?php endforeach; endif; else: echo "" ;endif; ?>
                    </select>
                    <br />
                    <br/>
                    <button class="btn btn-danger" id="btn_request_parameters" type="button" onclick="didInterfaceChoosingButtonClicked()">选择</button>
                </div>
                <br/>
                <br />
                <div class="form-group well">
                    获取当前时间时间戳：<div id="timestamp"></div>
                    <button class="btn btn-info" type="button" onclick="doGetTimeStamp()">获取</button>
                </div>
            </td>
            <td style="background-color: #EEEEEE; height: 500px; width: 800px;">
                <table width="100%" class="table table-striped table-responsive">
                    <tr>
                        <td>需要参数:<div id="including_parameters"></div></td>
                    </tr>
                    <tr>
                        <td>返回参数:<div id="return_parameters"></div></td>
                    </tr>
                    <tr>
                        <td>备注：<div id="remarks"></div></td>
                    </tr>
                    <tr>
                        <td>
                            <div>填写模拟请求JSON：</div><br/>
                            <form id="content" method="" action="">
                                <input type="hidden" id="selected_index" />
                                <div>提交方式：<input class="form-control" type="text" id="selected_method" disabled placeholder="请先在左侧选择"/></div><br/>
                                <div>接口地址：<input class="form-control" type="text" disabled id="selected_interface" required="" placeholder="请先在左侧选择"/></div><br/>
                                <textarea class="form-control" rows="8" placeholder="请使用JSON格式" required="" id="json"></textarea><br/><br/>
                                <button class="btn btn-default" type="button" id="btn_submit">测试</button>
                            </form>
                        </td>
                    </tr>
                </table>
                <br/>
                <div>JSON在线编辑器<a href="http://www.bejson.com/jsoneditoronline/" target="_blank">点击此处</a></div>
            </td>
            <td style="background-color: #dca7a7; width: 200px; color: #ffffff;">
                <p>接口示例：</p>
                <p>请求接口：SignIn/doSignIn</p>
                <p>请求方式：POST</p>
                <p>请求JSON：<div class="well" style="color: #000000">{"username": "admin", "password": "admin", "ip": "127.0.0.1", "datetime": "1440846045000"}</div></p>
                <p>返回结果：<div class="well" style="color: #000000">{"status":200,"result":"操作成功","id":"1","token":"abcdefghijklmn"}</div></p>
                <br/>
                <div>
                    base64：
                    <div class="well">
                        <textarea class="form-control" rows="3" id="encode_base64"></textarea>
                        <button class="btn btn-default" type="button" id="btn_encode">加密</button>
                        <br/>
                        <textarea class="form-control" rows="3" id="decode_base64"></textarea>
                        <button class="btn btn-default" type="button" id="btn_decode">解密</button>
                    </div>
                </div>
            </td>
        </tr>
        <tr>
            <td colspan="3" style="background-color: #67b168;color: #ffffff;">
                <h4>返回结果：</h4>
                <div id="status"></div>
                <div id="result"></div>
            </td>
        </tr>
    </table>
    <script src="/project-kiki/kiki-php/Public/js/bootstrap.js"></script>
    <script>
        $(document).ready(function (){
           $("#btn_submit").click(function (e) {
               e.preventDefault();
               $.ajax({
                   type: $('#selected_method').val(),
                   url: 'index.php/Home/' + $('#selected_interface').val(),
                   data: 'json=' + $('#json').val(),
                   dataType: 'json',
                   success: function (data) {
                       $('#status').text('代号:' + data.status);
                        $('#result').text('内容：' + data.content);
                   },
                   error: function (data) {
                       $('#status').text(data.status);
                       $('#result').text(data);
                   }
               });
           });

            $("#btn_request_parameters").click(function (e) {
                e.preventDefault();
                $.ajax({
                    type: 'post',
                    url: "<?php echo U('Index/requestParameters');?>",
                    data: 'index=' + $('#selected_index').val(),
                    dataType: 'json',
                    success: function (data) {
                        $('#including_parameters').text(data.request);
                        $('#return_parameters').text(data.return);
                        $('#remarks').text(data.remarks);
                    },
                    error: function (data) {

                    }
                });
            });

            $("#btn_encode").click(function(e) {
                e.preventDefault();
                $.ajax({
                   type: 'post',
                    url: "<?php echo U('Index/encodeWithBase64');?>",
                    data: 'string=' + $('#encode_base64').val(),
                    dataType: 'json',
                    success: function (data) {
                        if (0 == data.status) {
                            $('#decode_base64').text(data.content);
                        }
                    },
                    error: function (data) {

                    }
                });
            });

            $('#btn_decode').click(function (e) {
                e.preventDefault();
                $.ajax({
                   type: 'post',
                    url: "<?php echo U('Index/decodeWithBase64');?>",
                    data: 'string=' + $('#decode_base64').val(),
                    dataType: 'json',
                    success: function (data) {
                        if (0 == data.status) {
                            $('#encode_base64').text(data.content);
                        }
                    }
                });
            });
        });
    </script>

</body>
</html>