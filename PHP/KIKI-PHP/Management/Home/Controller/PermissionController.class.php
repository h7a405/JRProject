<?php
namespace Home\Controller;
use Think\Controller;
class PermissionController extends BaseController {
    public function _initialize(){
        parent::_initialize();
        if(!$this->isLogin()){
            $this->redirect('Login/login');
        }
    }

    public function index(){
        $pageSize = $_GET['pageSize'];
        $type = $_GET['type'];
        $visible = $_GET['isenabled'];
        $permissionListResult = $this->getPermissionList($pageSize, $type, $visible);
        $this->assign('list', $permissionListResult['list']);
        $this->assign('page', $permissionListResult['page']);
        $this->display();
    }

    public function addPermission(){
        $this->assign('menu_list', $this->getChildMenus());
        $this->display();
    }

    public function authority(){
        $this->display();
    }

    public function editPermission(){
        $permissionID = $_GET[PERMISSION_ID];
        if($permissionID == null){
            $this->error('错误的调用.');
        }
        $this->assign('permission', $this->getSinglePermission($permissionID));
        $this->display();
    }

    public function addNewPermission($permissionData){
//        $newPermissionData = $_POST['new_permission'];
        $newPermissionData = $permissionData;
        if($newPermissionData[PERMISSION_ID_MENU] == 0){
            $this->error('请选择对应URL');
        }
        if($this->isPermissionExist($newPermissionData[PERMISSION_ID_MENU])){
            $this->error('该权限已经存在。');
        }
        $newPermissionData[PERMISSION_ADDED_DATE] = $this->getCurrentDateTime();
        $newPermissionData[PERMISSION_ADDED_BY] = $this->getCurrentUserID();
        $newPermissionInsertResult = $this->getPermissionModel()->data($newPermissionData)->add();
        if($newPermissionInsertResult){
            $this->doWriteAdminOperationLog(CONTROLLER_NAME, ACTION_NAME, '添加新权限:'.$this->toStringWithPermissionID($newPermissionInsertResult[PERMISSION_ID]));

            $this->displayDefaultSuccess();
        } else {
            $this->displayDefaultError();
        }
    }

    public function addAuthority($authorityData){
        $authorityInsertData = $this->getAuthorityModel()->data($authorityData)->add();
        $this->doWriteAdminOperationLog(CONTROLLER_NAME, ACTION_NAME, '添加新授权:'.$this->toStringWithPermissionID($authorityInsertData[GROUP_PERMISSION_ID]));
    }

    public function addAuthorityForPermission($permissionID){
        $groupResult = $this->getGroupModel()->select();
        for($i = 0; $i < count($groupResult); $i++){
            $authorityData[AUTHORITY_ID_GROUP] = $groupResult[GROUP_ID];
            $authorityData[AUTHORITY_ID_PERMISSION] = $permissionID;
            $authorityData[AUTHORITY_ADDED_DATE] = $this->getCurrentDateTime();
            $authorityData[AUTHORITY_ADDED_BY] = $this->getCurrentUserID();
            $authorityData[AUTHORITY_ENABLED] = 1;
            $this->addAuthority($authorityData);
        }
    }

    public function editThePermission(){
        $editPermissionData = $_POST['edit_permission'];
//        dump($editPermissionData);die;
        $permissionBeforeUpdatedData = $this->toStringWithPermissionID($editPermissionData[PERMISSION_ID]);
        $editPermissionUpdateResult = $this->getPermissionModel()->save($editPermissionData);
//        dump($editMenuUpdateResult);
        if($editPermissionUpdateResult){
            $this->doWriteAdminOperationLog(CONTROLLER_NAME, ACTION_NAME, '修改权限成功, 原数据:['.$permissionBeforeUpdatedData.'], 修改为:('.$this->toStringWithPermissionID($editPermissionUpdateResult[PERMISSION_ID]).')');
            $this->success('修改权限成功', U('Permission/index'), 3);
        }else{
            $this->error('修改失败, 请稍候重试.');
        }
    }

    private function isPermissionExist($menuID){
        $permissionSelectResult = $this->getPermissionModel()->where(array(PERMISSION_ID_MENU => $menuID))->select();
        if($permissionSelectResult)
            return true;
        else
            return false;
    }

    private function getSinglePermission($permissionID){
        $singlePermissionFindResult = $this->getPermissionModel()->where(array(PERMISSION_ID => $permissionID))->find();
        if($singlePermissionFindResult[MENU_ADMIN_ADDED_BY] != null){
            $singlePermissionFindResult['username_added'] = $this->getUserNameWithID($singlePermissionFindResult[PERMISSION_ADDED_BY]);
        }else{
            $singlePermissionFindResult['username_added'] = '未知用户('.$singlePermissionFindResult[PERMISSION_ADDED_BY].')';
        }
        if($singlePermissionFindResult[PERMISSION_ID_MENU] != 0){
            $singlePermissionFindResult['name_father'] = $this->getMenuNameWithID($singlePermissionFindResult[PERMISSION_ID_MENU]);
        }else{
            $singlePermissionFindResult['name_father'] = '不存在的父级菜单';
        }
//        dump($singleMenuFindResult);die;
        return $singlePermissionFindResult;
    }

    private function getPermissionList($pageSize, $type, $visible){
        if($type != -1 && $type != null) {
            $map['type'] = $type;
        }
        if($visible != -1 && $visible != null){
            $map['isenabled'] = $visible;
        }
//        dump($map);
        $page = $this->getPage($this->getPermissionModel(), $map, $pageSize);
//        dump($page);
//        $condition[$map['keyword_type']] = array('like',"%".$map['keyword']."%");

        $list = $this->getPermissionModel()->where($map)->order(PERMISSION_ADDED_DATE.' DESC')->limit($page->firstRow.','.$page->listRows)->select();
//        dump($list);die;
        for($i = 0; $i < count($list); $i++){
            $list[$i]['edit_url'] = U('Permission/editPermission', array(PERMISSION_ID => $list[$i][PERMISSION_ID]));
            if($list[$i][PERMISSION_ADDED_BY] != null){
                $list[$i]['username_added'] = $this->getUserNameWithID($list[$i][PERMISSION_ADDED_BY]);
            }else{
                $list[$i]['username_added'] = '未知用户('.$list[$i][PERMISSION_ADDED_BY].')';
            }
            if($list[$i][PERMISSION_ID_MENU] != null){
                $list[$i]['url'] = $this->getMenuNameWithID($list[$i][PERMISSION_ID_MENU]);
            } else {
                $list[$i]['url'] = '未添加的对应菜单('.$list[$i][PERMISSION_ID_MENU].')';
            }
        }
        $result['list'] = $list;
//        dump($page->show());
        $result['page'] = $page->show();
        return $result;
    }

    private function getChildMenus(){
        $childMenuSelectResult = $this->getMenuModel()->where(array(MENU_ADMIN_LEVEL => 1))->select();
        return $childMenuSelectResult;
    }

}