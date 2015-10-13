<?php
namespace Admin\Controller;
use Think\Controller;
class MenuController extends BaseController {
    protected function _initialize(){
        parent::_initialize();
    }
    public function menu_list(){
        $pageSize = $_GET['pageSize'];
        $type = $_GET['level'];
        $visible = $_GET['visible'];
        $enable = $_GET['enable'];
        $menuList = $this->getBaseEvent()->getMenuEvent()->getMenuListWithPage($pageSize, $type, $visible, $enable);
        $this->assign('list', $menuList['list']);
        $this->assign('page', $menuList['page']);
        $this->assign('parentMenus', $this->getBaseEvent()->getMenuEvent()->getMenuList());
        $this->display();
    }
    public function menu_edit(){

    }

    public function postNewMenu(){
        $menuData = I('post.new_menu');
        if($menuData[MENU_PARENT_ID] == 0){
            $menuData[MENU_LEVEL] = MENU_LEVEL_CONTROLLER;
        }
        if($menuData[MENU_LEVEL] == MENU_LEVEL_CONTROLLER){
            $menuData[MENU_PARENT_ID] = 0;
        } else if ($menuData[MENU_LEVEL] == MENU_LEVEL_ACTION){
            $menuData[MENU_VISIBLE] = 0;
        }
        $menuData[MENU_DATE] = $this->getBaseEvent()->getCurrentDateTime();
        $menuData[MENU_OPERATOR_ID] = $this->getBaseEvent()->getCurrentSignedInUserID();
        if($this->getBaseEvent()->getDBEvent()->insertMenuRecord($menuData)){
            $accessData[ACCESS_LEVEL] = $menuData[MENU_LEVEL];
            $accessData[ACCESS_MENU_ID] = $this->getBaseEvent()->getMenuModel()->where(array(MENU_PARENT_ID => $menuData[MENU_PARENT_ID], MENU_URL => $menuData[MENU_URL]))->find()[MENU_ID];
            $accessData[ACCESS_DATE] = $this->getBaseEvent()->getCurrentDateTime();
            $accessData[ACCESS_OPERATOR_ID] = $this->getBaseEvent()->getCurrentSignedInUserID();
            $accessData[ACCESS_DESCRIPTION] = 'Description of access:'.$menuData[MENU_NAME];
            $accessData[ACCESS_NAME] = 'Access:'.$menuData[MENU_NAME];
            $this->getBaseEvent()->getDBEvent()->insertAccessRecord($accessData);
            $this->success('New menu has been successfully added to database.', U('Menu/menu_list'), 1);
        } else {
            $this->error('New menu inserted failed.');
        }
    }
}