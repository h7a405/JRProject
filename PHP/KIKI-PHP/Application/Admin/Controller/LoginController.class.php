<?php
namespace Admin\Controller;
use Think\Controller;
class LoginController extends BaseController {
    protected function _initialize(){
        parent::_initialize();
    }

    public function login(){
        $this->display();
    }

    public function doLogin(){
        $userData = I('post.admin_login');
        if($userData['username'] == null){
            $this->error();
        }
        if($userData['password'] == null){
            $this->error();
        }
        $signInResult = $this->getBaseEvent()->getLoginEvent()->doSignIn($userData);
        if(!$signInResult[IS_SIGNED_IN_SUCCESS]){
            $this->error($signInResult[ERROR]);
        } else {
            $this->success($signInResult[SUCCESS], $signInResult[DIRECT_TO], SECONDS_AFTER_SUCCESS_DEFAULT);
        }
    }

    public function doLogout(){
        $this->getBaseEvent()->getLoginEvent()->getSessionEvent()->setSessionCleaned();
        $this->success('You have logged out.', U('Login/login', array('l' => 'en-us')), 1);
    }
}