<?php
namespace Admin\Controller;
use Think\Controller;
class IndexController extends BaseController {
    protected function _initialize(){
        parent::_initialize();
    }
    public function index(){
        $this->display();
    }
}