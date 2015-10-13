<?php
namespace Home\Controller;
use Think\Controller;
class MenuController extends BaseController {
    public function _initialize(){
        parent::_initialize();
        if(!$this->isLogin()){
            $this->redirect('Login/login');
        }

//        $this->assign('controllerName', $this->getCurrentControllerName(CONTROLLER_NAME));
//        $this->assign('actionName', $this->getCurrentActionName(ACTION_NAME, CONTROLLER_NAME));
    }

    public function index(){
        $pageSize = $_GET['pageSize'];
        $type = $_GET['type'];
        $visible = $_GET['isvisible'];
        $menuList = $this->getMenuListWithPage($pageSize, $type, $visible);
        $this->assign('list', $menuList['list']);
        $this->assign('page', $menuList['page']);
        $this->display();
    }

    public function addMenu(){
        $this->assign('menu_father', $this->getFatherMenu());
        $this->display();
    }

    public function editMenu(){
        $menuID = $_GET[MENU_ADMIN_ID];
        if($menuID == null){
            $this->error('错误的调用.');
        }
        $this->assign('menuList', $this->getFatherMenu());
        $this->assign('menu', $this->getSingleMenu($menuID));
        $this->display();
    }


    /*
     *
     */
    public function addNewMenu(){
        $newMenuData = $_POST['new_menu'];
//        dump($newMenuData);
        if($newMenuData['name'] == null){
            $this->error('菜单名不能为空.');
        }
        if($newMenuData['url'] == null){
            $this->error('菜单URL不能为空.');
        }
        if($this->isMenuNameExist($newMenuData['name'])){
            $this->error('该菜单名已经存在.');
        }
        if($this->isMenuURLExist($newMenuData['url'], $newMenuData['id_father'])){
            $this->error('该URL已经存在');
        }
//        if($newMenuData['isvisible'] == null){
//            $newMenuData['isvisible'] = false;
//        }else{
//            $newMenuData['isvisible'] = true;
//        }
        if($newMenuData['id_father'] == 0){
            $newMenuData['level'] = 0;
        }else{
            $newMenuData['level'] = 1;

            if(!$this->isMenuVisible($newMenuData['id_father'])){
                $newMenuData['isvisible'] = false;
            }
        }
        if($newMenuData['type'] == 1){
            $newMenuData['level'] = 0;
            $newMenuData['id_father'] = 0;
        } else if($newMenuData['type'] == 3){
            $newMenuData['isvisible'] = false;
        }
        $newMenuData[MENU_ADMIN_ADDED_DATE] = $this->getCurrentDateTime();
        $newMenuData[MENU_ADMIN_ADDED_BY] = $this->getCurrentUserID();
//        dump($newMenuData);die;
        $newMenuInsertResult = $this->getMenuModel()->data($newMenuData)->add();
        if($newMenuInsertResult){
            $this->doWriteAdminOperationLog(CONTROLLER_NAME, ACTION_NAME, '添加新菜单:['.$newMenuInsertResult[MENU_ADMIN_ID].']'.$newMenuData[MENU_ADMIN_NAME].'('.$newMenuData[MENU_ADMIN_URL].')成功');
            $newPermissionData[PERMISSION_ADDED_DATE] = $this->getCurrentDateTime();
            $newPermissionData[PERMISSION_ADDED_BY] = $this->getCurrentUserID();
            $newPermissionData[PERMISSION_TYPE] = 2;
            $newPermissionData[PERMISSION_NAME] = $newMenuInsertResult[MENU_ADMIN_NAME].'的权限';
            $newPermissionData[PERMISSION_INTRODUCTION] = $newMenuInsertResult[MENU_ADMIN_NAME].'的权限描述（自动生成）';
            $newPermissionData[PERMISSION_ENABLED] = 1;
            $newPermissionData[PERMISSION_ID_MENU] = $newMenuInsertResult[MENU_ADMIN_ID];
            $permissionController = new PermissionController();
            $permissionController->addNewPermission($newPermissionData);
            $this->success('添加新菜单:['.$newMenuInsertResult['id'].']'.$newMenuData['name'].'('.$newMenuData['url'].')成功', U('Menu/index'), 3);
        }else{
            $this->error('添加失败, 请稍候重试.');
        }
    }

    public function editTheMenu(){
        $editMenuData = $_POST['edit_menu'];
        if($editMenuData[MENU_ADMIN_FATHER] == 0){
            $editMenuData[MENU_ADMIN_LEVEL] = 0;
        }else{
            $editMenuData[MENU_ADMIN_LEVEL] = 1;
        }

        if($editMenuData['type'] == 1){
            $editMenuData['level'] = 0;
            $editMenuData['id_father'] = 0;
        } else if($editMenuData['type'] == 3){
            $editMenuData['isvisible'] = false;
        }
//        dump($editMenuData);die;
        $menuBeforeUpdatedData = $this->toStringWithMenuID($editMenuData[MENU_ADMIN_ID]);
        $editMenuUpdateResult = $this->getMenuModel()->save($editMenuData);
//        dump($editMenuUpdateResult);
        if($editMenuUpdateResult){
            $this->doWriteAdminOperationLog(CONTROLLER_NAME, ACTION_NAME, '修改菜单成功, 原数据:['.$menuBeforeUpdatedData.'], 修改为:('.$this->toStringWithMenuID($editMenuData[MENU_ADMIN_ID]).')');
            $this->success('修改菜单成功', U('Menu/index'), 3);
        }else{
            $this->error('修改失败, 请稍候重试.');
        }
    }

    private function isMenuNameExist($targetMenuName){
        $menuFindResult = $this->getMenuModel()->where(array(MENU_ADMIN_NAME => $targetMenuName))->find();
        if($menuFindResult){
            return true;
        } else {
            return false;
        }
    }
    private function isMenuURLExist($targetMenuURL, $fatherID){
        $menuFindResult = $this->getMenuModel()->where(array(MENU_ADMIN_URL => $targetMenuURL, MENU_ADMIN_FATHER => $fatherID))->find();
        if($menuFindResult){
            return true;
        }else{
            return false;
        }
    }

    private function isMenuVisible($targetMenuID){
        $menuFindResult = $this->getMenuModel()->where(array(MENU_ADMIN_ID => $targetMenuID))->find();
        return $menuFindResult['isvisible'];
    }

    private function getSingleMenu($targetID){
        $singleMenuFindResult = $this->getMenuModel()->where(array(MENU_ADMIN_ID => $targetID))->find();
        if($singleMenuFindResult[MENU_ADMIN_ADDED_BY] != null){
            $singleMenuFindResult['username_added'] = $this->getUserNameWithID($singleMenuFindResult[MENU_ADMIN_ADDED_BY]);
        }else{
            $singleMenuFindResult['username_added'] = '未知用户('.$singleMenuFindResult[MENU_ADMIN_ADDED_BY].')';
        }
        if($singleMenuFindResult[MENU_ADMIN_LEVEL] != 0){
            $singleMenuFindResult['name_father'] = $this->getMenuNameWithID($singleMenuFindResult[MENU_ADMIN_FATHER]);
        }else{
            $singleMenuFindResult['name_father'] = '不存在的父级菜单';
        }
//        dump($singleMenuFindResult);die;
        return $singleMenuFindResult;
    }

    private function getMenuListWithPage($pageSize, $type, $visible){
//        if($keywordType != ''){
//            if($keyword) {
//                if($keywordType == LOG_ADMIN_OPERATOR){
//                    $target = $this->getUserModel()->where(array(USER_ADMIN_USERNAME => $keyword))->find();
//                    $map['keyword'] = $target[USER_ADMIN_ID];
//                } else if($keywordType == LOG_ADMIN_MODULE){
//                    $target = $this->getMenuModel()->where(array(MENU_ADMIN_URL => $keyword, MENU_ADMIN_LEVEL => 0))->find();
//                    $map['keyword'] = $target[MENU_ADMIN_ID];
//                } else if($keywordType == LOG_ADMIN_FUNCTION){
//                    $target = $this->getMenuModel()->where(array(MENU_ADMIN_URL => $keyword, MENU_ADMIN_LEVEL => 1))->find();
//                    $map['keyword'] = $target[MENU_ADMIN_ID];
//                }
////                $map['keyword'] = $keyword;
//
//                $map['keyword_type'] = $keywordType;
//            }
//        }
        if($type != -1 && $type != null) {
            $map['type'] = $type;
        }
        if($visible != -1 && $visible != null){
            $map['isvisible'] = $visible;
        }
//        dump($map);
        $page = $this->getPage($this->getMenuModel(), $map, $pageSize);
//        dump($page);
//        $condition[$map['keyword_type']] = array('like',"%".$map['keyword']."%");

        $list = $this->getMenuModel()->where($map)->order(MENU_ADMIN_TYPE.' ASC')->limit($page->firstRow.','.$page->listRows)->select();
//        dump($list);die;
        for($i = 0; $i < count($list); $i++){
            $list[$i]['edit_url'] = U('Menu/editMenu', array(MENU_ADMIN_ID => $list[$i][MENU_ADMIN_ID]));
            if($list[$i][MENU_ADMIN_ADDED_BY] != null){
                $list[$i]['username_added'] = $this->getUserNameWithID($list[$i][MENU_ADMIN_ADDED_BY]);
            }else{
                $list[$i]['username_added'] = '未知用户('.$list[$i][MENU_ADMIN_ADDED_BY].')';
            }
            if($list[$i][MENU_ADMIN_LEVEL] != 0){
                $list[$i]['name_father'] = $this->getMenuNameWithID($list[$i][MENU_ADMIN_FATHER]);
            }else{
                $list[$i]['name_father'] = '不存在的父级菜单';
            }
        }
        $result['list'] = $list;
//        dump($page->show());
        $result['page'] = $page->show();
        return $result;
    }

    private function getFatherMenu(){
        $menuSelectResult = $this->getMenuModel()->where(array(MENU_ADMIN_LEVEL => 0))->select();
        for($i = 0; $i <count($menuSelectResult); $i++){
            if($menuSelectResult[$i]['isvisible'] = false){
                $menuSelectResult[$i]['visible'] = '(不可见)';
            }
        }
        return $menuSelectResult;
    }
}