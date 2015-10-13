<?php
namespace Admin\Controller;
use Admin\Event\BaseEvent;
use Think\Controller;
class BaseController extends Controller {
    protected function _initialize(){
        $result = $this->isEnabledToBrowse();
        if(!$result['isEnabled']){
            $this->error($result['error'], $result['goto'], 3);
        }
        $this->assign('controllerName', $this->getBaseEvent()->getMenuEvent()->getMenuNameWithMenuID($this->getBaseEvent()->getMenuEvent()->getControllerID(CONTROLLER_NAME)));
        $this->assign('actionName', $this->getBaseEvent()->getMenuEvent()->getMenuNameWithMenuID($this->getBaseEvent()->getMenuEvent()->getActionID(CONTROLLER_NAME, ACTION_NAME)));
        $this->assign('currentURL', U(CONTROLLER_NAME.'/'.ACTION_NAME));
        $this->assign('menus', $this->getBaseEvent()->getMenuEvent()->getFrameworkMenus());
        $this->assign('username', session(SESSION_ADMIN_USERNAME));
    }

    private function isEnabledToBrowse(){
        return $this->getBaseEvent()->isEnabledToBrowse(CONTROLLER_NAME, ACTION_NAME);
    }



    public function getBaseEvent(){
        return new BaseEvent();
    }

}