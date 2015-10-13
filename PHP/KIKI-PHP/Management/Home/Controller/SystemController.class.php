<?php
namespace Home\Controller;
use Think\Controller;
class SystemController extends BaseController {

    public function _initialize(){
        parent::_initialize();
        if(!$this->isLogin()){
            $this->redirect('Login/login');
        }
    }

    public function index(){
        $data = $this->getSystemInfo();
        $this->assign('system', $data);
        $this->display();
    }

    public function editSystemInfo(){
        $result = $this->getSystemInfo();
        $data = $_POST['system'];
        $model = $this->getSystemInfoModel();
        $updateResult = null;
        $systemDataBeforeUpdate = $this->toStringWithSystemInfo();
        //dump($data);dump($result);die;
        if($result != null){
            $data['id'] = $result[SYSTEM_INFO_ID];
            $updateResult = $model->save($data);
        }else{
            $updateResult = $model->add($data);
            //dump($updateResult);die;
        }
        if($updateResult){
            $this->doWriteAdminOperationLog(CONTROLLER_NAME, ACTION_NAME, '修改了系统信息, 原信息:'.$systemDataBeforeUpdate.' || 修改后:'.$this->toStringWithSystemInfo());
            $this->success("系统信息修改成功！");
        }else{
            $this->error("系统信息修改失败！");
        }
    }

}