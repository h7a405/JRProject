<?php
/**
 * Created by PhpStorm.
 * User: OrinJay
 * Date: 2015/8/28 0028
 * Time: 20:50
 */

namespace Home\Controller;
use Home\Controller\BaseController;

class SignUpController extends BaseController{
    public function _initialize() {

    }

    public function doSignUp(){
        if(!IS_POST) {
            $this->ajaxReturn($this->getReturnData(204));
        }
        $jsonString = $_POST['json'];
        $json = json_decode($jsonString, true);
        $username = $json['username'];
        $password = $json['password'];
        $ip = $json['ip'];
        $datetime = $json['datetime'];
        $nickname = $json['nickname'];

        if ($username == null || $password == null || $datetime == null || $nickname == null) {
            $this->ajaxReturn($this->getReturnData(312));
        }

        if($this->getUserController()->isUserExistedWithUsername($username)) {
            $this->ajaxReturn($this->getReturnData(311));
        }

        if($this->getUserController()->isNicknameExisted($nickname)) {
            $this->ajaxReturn($this->getReturnData(313));
        }

        $salt = md5(time().mt_rand(0, 1000));
        if($salt == null) {
            $this->ajaxReturn($this->getReturnData(201));
        }
        $encodedPassword = $this->getEncryptEvent()->encrypt($password, $salt);
        if($encodedPassword == null) {
            $this->ajaxReturn($this->getReturnData(201));
        }
        $userData['password'] = $encodedPassword;
        $userData['salt'] = base64_encode($salt);
        $userData['added_date'] = $datetime;
        if($ip != null) {
            $userData['last_ip'] = $ip;
        }
        $userData['nickname'] = $nickname;
        $userData['email'] = $username;
        $updateResult = $this->getUserModel()->add($userData);
        if($updateResult) {
            $this->ajaxReturn($this->getReturnData(200));
        } else {
            $this->ajaxReturn($this->getReturnData(201));
        }

        $this->ajaxReturn($this->getReturnData(202));
    }
}