<?php
/**
 * Created by PhpStorm.
 * User: OrinJay
 * Date: 2015/8/29 0029
 * Time: 20:17
 */

namespace Home\Controller;


class SignInController extends BaseController{
    public function doSignIn() {
        if(!IS_POST) {
            $this->ajaxReturn($this->getReturnData(204));
        }

        $jsonString = $_POST['json'];
        $json = json_decode($jsonString, true);
        $username = $json['username'];
        $password = $json['password'];
        $ip = $json['ip'];
        $datetime = $json['datetime'];
        if ($username == null || $password == null || $datetime == null) {
            $this->ajaxReturn($this->getReturnData(312));
        }
        $userController = $this->getUserController();
        if (!$userController->isUserExistedWithUsername($username)) {
            $this->ajaxReturn($this->getReturnData(302));
        }
        $salt = $userController->getDecodedUserSaltWithUsername($username);
        $oldPassword = $userController->getPasswordWithUsername($username);
        $encodedPassword = $this->getEncryptEvent()->encrypt($password, $salt);
        if($encodedPassword == $oldPassword) {
            if($ip != null){$updateData['last_ip'] = $ip;}
            $updateData['last_date'] = $datetime;
            $updateData['id'] = $userController->getUserIDWithUsername($username);
            $updateResult = $this->getUserModel()->save($updateData);
            if($updateResult) {
                $this->ajaxReturn($this->getReturnData(200));
            } else {
                $this->ajaxReturn($this->getReturnData(201));
            }
        } else {
            $this->ajaxReturn($this->getReturnData(301));
        }
        $this->ajaxReturn($this->getReturnData(202));
    }
}