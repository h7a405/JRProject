<?php
namespace Home\Controller;
use Think\Controller;
class FrameworkController extends BaseController {
    public function _initialize(){
        parent::_initialize();
        if(!$this->isLogin()){
            $this->redirect('Login/login');
        }
    }
    public function index(){
        $this->display();
    }
}