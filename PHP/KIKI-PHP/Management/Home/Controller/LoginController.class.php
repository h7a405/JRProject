<?php
namespace Home\Controller;
use Think\Controller;
class LoginController extends BaseController {
    public function _initialize(){
        parent::_initialize();

    }
    public function login(){
//        dump(APP_PATH);
//        dump(MODULE_NAME);
//        dump(CONTROLLER_NAME);
//        dump(ACTION_NAME);die;
        if($this->isLogin()){
            $this->error('请勿重复登录!', U('Index/index'), 1);
        }

        $this->display();
    }

    public function doLogin(){
        $loginUserInfo = $_POST['admin_login'];
        if($loginUserInfo['username'] == null){
            $this->error('用户名不能为空。');
        }
        if($loginUserInfo['password'] == null){
            $this->error('密码不能为空。');
        }
        $adminUserSelectResult = $this->getUserModel()->where(array(USER_ADMIN_USERNAME => $loginUserInfo['username']))->find();
        if($adminUserSelectResult){
            $encodePassword = $this->encrypt($loginUserInfo['password'], $adminUserSelectResult[USER_ADMIN_SALT], true);

            if($adminUserSelectResult[USER_ADMIN_PASSWORD] == $encodePassword){
                $userInfo = $adminUserSelectResult;
                $this->doLoginSuccess($userInfo);
            } else {
                $this->doWriteAdminOperationLog(CONTROLLER_NAME, ACTION_NAME, $loginUserInfo['username'].'||因密码错误而登录失败');
                $this->error('帐号或密码不正确。');
            }
        } else {
            $this->error('该管理员帐号不存在。');
        }
    }

    public function doLoginSuccess($userInfo){
        $userInfo[USER_ADMIN_DATE_LOGIN_LAST] = $this->getCurrentDateTime();
        $userInfo[USER_ADMIN_IP_LOGIN_LAST] = $this->getClientIP();
//        $userInfo[USER_ADMIN_LOGINED] = 1;

        $userUpdateResult = $this->getUserModel()->save($userInfo);
        if($userUpdateResult){
            $this->setSession($userInfo);
            $this->doWriteAdminOperationLog(CONTROLLER_NAME, ACTION_NAME, $userInfo['username'].'||成功登录到后台');
            $this->success('登录成功！', U('Index/index'), 3);
        }else{
            $this->doWriteAdminOperationLog(CONTROLLER_NAME, ACTION_NAME, $userInfo['username'].'||因保存数据到数据库错误而登录失败');
            $this->error('登录失败，请稍候再试……');
        }
    }

    public function doLogout(){
        if($this->isLogin()){
            $this->doWriteAdminOperationLog(CONTROLLER_NAME, ACTION_NAME, session(SESSION_ADMIN_USERNAME).'||从后台退出登录');
            $this->setSessionClear();
            $this->success('您已退出后台管理系统...', U('Login/login'), 1);
        }else{
            $this->error('您还未登录...', U('Login/login'), 1);
        }
    }
}