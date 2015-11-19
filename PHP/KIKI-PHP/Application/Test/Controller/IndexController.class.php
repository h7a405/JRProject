<?php
/**
 * Created by PhpStorm.
 * User: OrinJay
 * Date: 2015/8/29 0029
 * Time: 17:04
 */

namespace Test\Controller;


use Think\Controller;

class IndexController extends Controller{
    public function index(){
        $interfaceList = $this->packDATAs();
        $this->assign('InterfaceList', $interfaceList);
        $this->display();
    }

    public function packDATAs() {
        $arrayNAME = $this->getNAMEs();
        $arrayURL = $this->getURLs();
        $returnArray = null;
        for ($i = 0; $i < count($arrayNAME); $i++) {
            $returnArray[$i]['id'] = $arrayURL[$i];
            $returnArray[$i]['name'] = $arrayNAME[$i];
        }
        return $returnArray;
    }

    public function getNAMEs() {
        return array(
            "注册",
            "登录",
            "新建项目",
        );
    }
    public function getURLs() {
        return array(
            "SignUp/doSignUp",
            "SignIn/doSignIn",
            "Project/doCreateProject",
        );
    }

    public function requestParameters() {
        $index = $_POST['index'];
        $returnData = null;
        switch($index){
            case 0:
                $returnData['request'] = '{"username": "admin", "password": "admin", "ip": "127.0.0.1", "datetime": "1440846045000", "nickname" : "AdminUser"}';
                $returnData['return'] = '{"status" : " ", "content" : " "}';
                $returnData['remarks'] = '帐号必须为邮箱，密码长度为6-20位';
                break;
            case 1:
                $returnData['request'] = '{"username" : " ", "password" : " ", "ip" : " ", "datetime" : " "}';
                $returnData['return'] = '{"status" : " ", "content" : " ", "id" : " "}';
                $returnData['remarks'] = '帐号必须为邮箱，密码长度为6-20位，ip可以没有，时间戳必须有。返回的token和id后面所有用户登陆后的操作都需要。';
                break;
            case 2:
                $returnData['request'] = '错误的接口';
                $returnData['return'] = '错误的接口';
                $returnData['remarks'] = '没有备注';
            default:
                $returnData['request'] = '错误的接口';
                $returnData['return'] = '错误的接口';
                $returnData['remarks'] = '没有备注';
                break;
        }
        $this->ajaxReturn($returnData);
    }

    public function encodeWithBase64() {
        $string = $_POST['string'];
        $returnString = base64_encode($string);
        if($returnString) {
            $returnData['status'] = 0;
            $returnData['content'] = $returnString;
            $this->ajaxReturn($returnData);
        }
    }
    public function decodeWithBase64() {
        $string = $_POST['string'];
        $returnString = base64_decode($string);
        if($returnString) {
            $returnData['status'] = 0;
            $returnData['content'] = $returnString;
            $this->ajaxReturn($returnData);
        }
    }
}