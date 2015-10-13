<?php
/**
 * Created by PhpStorm.
 * User: OrinJay
 * Date: 2015/8/4 0004
 * Time: 21:29
 */

namespace Admin\Event;
use Think\Controller;

class BaseEvent extends Controller{

    public function isEnabledToBrowse($controllerName, $actionName)
    {
        $systemEvent = $this->getSystemEvent();
        $menuEvent = $this->getMenuEvent();
        $loginEvent = $this->getLoginEvent();
        $accessEvent = $this->getAccessEvent();

        $result['isEnabled'] = true;

        if (!$systemEvent->isSystemEnabled()) {
            $result['isEnabled'] = false;
            $result['error'] = L(LANG_SYSTEM_CLOSED);
            $result['goto'] = U('Error/error');
            return $result;
        }
        if (!$menuEvent->isModuleEnabled($controllerName)) {
            $result['isEnabled'] = false;
            $result['error'] = L(LANG_MODULE_DISABLED);
            return $result;
        }
        if (!$menuEvent->isActionEnabled($controllerName, $actionName)) {
            $result['isEnabled'] = false;
            $result['error'] = L(LANG_ACTION_DISABLED);
            return $result;
        }
        if (CONTROLLER_NAME != 'Login') {
            if (!$loginEvent->isSignedIn()) {
                $result['isEnabled'] = false;
                $result['error'] = L(LANG_UNSIGNED_IN);
                $result['goto'] = U('Login/login', array('l' => 'en-us'));
                return $result;
            }
            if($this->getGroupEvent()->getGroupLevelWithGroupID($this->getCurrentSignedInUserID()) != 1) {
                if (!$accessEvent->isAccessibleWithMenuID($menuEvent->getMenuIDWithMenuURL($controllerName, null))) {
                    $result['isEnabled'] = false;
                    $result['ERROR'] = L(LANG_NO_ACCESS);
                    return $result;
                } else {
                    if (!$accessEvent->isAccessibleWithMenuID($menuEvent->getMenuIDWithMenuURL($controllerName, $actionName))) {
                        $result['isEnabled'] = false;
                        $result['ERROR'] = L(LANG_NO_ACCESS);
                        return $result;
                    }
                }
            }
        }

        return $result;
    }
    public function getPage($targetModel, $map, $pageSize = 10){
        $model = $targetModel;

        if($map['keyword_type']){
            $condition[$map['keyword_type']] = array('like',"%".$map['keyword']."%");
        }

        $count = $model->where($condition)->count();

        $Page = new \Think\Page($count, $pageSize);


        //分页跳转的时候保证查询条件
        foreach($map as $key=>$val) {
            $Page->parameter[$key]   =   urlencode($val);
        }
//        $Page->setConfig('theme', '<li><a>%totalRow% %header%</a></li> %upPage% %downPage% %first% %prePage% %linkPage% %nextPage% %end% ');
        return $Page;
    }

    public function getCurrentDateTime(){
        return date(FORMAT_DATE, NOW_TIME);
    }
    public function getCurrentSignedInUserID(){
        if(session('?'.SESSION_ADMIN_ID)){
            return session(SESSION_ADMIN_ID);
        } else {
            return 1;
        }
    }
    public function getIP(){
        $ip = get_client_ip();
        return $ip;
    }

    public function getLoginEvent(){
        return new LoginEvent();
    }
    public function getLogEvent(){
        return new LogEvent();
    }
    public function getMenuEvent(){
        return new MenuEvent();
    }
    public function getSystemEvent(){
        return new SystemEvent();
    }
    public function getDBEvent(){
        return new DBEvent();
    }
    public function getAccessEvent(){
        return new AccessEvent();
    }
    public function getUserEvent(){
        return new UserEvent();
    }
    public function getEncryptEvent(){
        return new EncryptEvent();
    }
    public function getGroupEvent(){
        return new GroupEvent();
    }

    public function getMenuModel(){
        return M(TB_MENU);
    }
    public function getSystemModel(){
        return M(TB_SYSTEM);
    }
    public function getLogModel(){
        return M(TB_LOG);
    }
    public function getAccessModel(){
        return M(TB_ACCESS);
    }
    public function getAdminModel(){
        return M(TB_ADMIN);
    }
    public function getUserModel(){
        return M(TB_USER);
    }
    public function getGroupModel(){
        return M(TB_GROUP);
    }
    public function getGroupAccessModel(){
        return M(TB_GROUP_ACCESS);
    }
}