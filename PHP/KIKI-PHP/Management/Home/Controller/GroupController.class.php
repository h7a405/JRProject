<?php
namespace Home\Controller;
use Think\Controller;
class GroupController extends BaseController {
    public function _initialize(){
        parent::_initialize();
        if(!$this->isLogin()){
            $this->redirect('Login/login');
        }
    }

    public function index(){

    }

    public function userGroup(){
        $UserListResult = $this->getGroupList(1);
        $this->assign('list', $UserListResult['list']);
        $this->assign('page', $UserListResult['page']);
        $this->display();
    }

    public function administratorGroup(){
        $UserListResult = $this->getGroupList(2);
        $this->assign('list', $UserListResult['list']);
        $this->assign('page', $UserListResult['page']);
        $this->display();
    }

    public function addNewGroup(){
        $newGroupData = $_POST['new_group'];
//        dump($newGroupData);die;
        $newGroupData[GROUP_ADDED_DATE] = $this->getCurrentDateTime();
        $newGroupData[GROUP_ADDED_BY] = $this->getCurrentUserID();
        if($this->isGroupExist($newGroupData[GROUP_NAME])){
            $this->error('该群组已经存在。');
        }
        $newGroupInsertResult = $this->getGroupModel()->data($newGroupData)->add();
        if($newGroupInsertResult){
            $this->doWriteAdminOperationLog(CONTROLLER_NAME, ACTION_NAME, '添加新群组:'.$this->toStringWithGroupID($newGroupInsertResult[GROUP_ID]));
            $this->addPermissionRecordForGroup($newGroupInsertResult[GROUP_ID]);
            $this->displayDefaultSuccess();
        } else {
            $this->displayDefaultError();
        }
    }

    private function addPermissionRecordForGroup($groupID){
        $permissionController = new PermissionController();
        $permissionSelectResult = $this->getPermissionModel()->select();
//        dump($permissionSelectResult);dump($groupID);die;
        for($i = 0; $i < count($permissionSelectResult); $i++){
            $authorityData[AUTHORITY_ID_GROUP] = $groupID;
            $authorityData[AUTHORITY_ID_PERMISSION] = $permissionSelectResult[$i][PERMISSION_ID];
            $authorityData[AUTHORITY_ADDED_DATE] = $this->getCurrentDateTime();
            $authorityData[AUTHORITY_ADDED_BY] = $this->getCurrentUserID();
            $authorityData[AUTHORITY_ENABLED] = 1;
            $permissionController->addAuthority($authorityData);
        }
    }

    public function editGroup(){
        $groupID = $_GET[GROUP_ID];
        if($groupID == null){
            $this->error('错误的调用.');
        }
        if($groupID == 1){
            $this->error('超级管理员群组无法操作');
        }
        $this->assign('group', $this->getSingleGroup($groupID));
        $this->display();
    }

    private function isGroupExist($name){
        $groupSelectResult = $this->getGroupModel()->where(array(GROUP_NAME => $name))->select();
        if($groupSelectResult)
            return true;
        else
            return false;
    }

    private function getGroupList($type){
        $map['type'] = $type;
        $page = $this->getPage($this->getGroupModel(), $map, 10);
//        dump($page);
//        $condition[$map['keyword_type']] = array('like',"%".$map['keyword']."%");

        $list = $this->getGroupModel()->where($map)->order(GROUP_ID.' ASC')->limit($page->firstRow.','.$page->listRows)->select();
//        dump($list);die;
        for($i = 0; $i < count($list); $i++){
            if(!($type == 2 && $list[$i][GROUP_ID] == 1)){
                $list[$i]['edit_url'] = U('Group/editGroup', array(GROUP_ID => $list[$i][GROUP_ID]));
            }
            if($list[$i][GROUP_ADDED_BY] != null){
                $list[$i]['username_added'] = $this->getUserNameWithID($list[$i][GROUP_ADDED_BY]);
            }else{
                $list[$i]['username_added'] = '未知用户('.$list[$i][GROUP_ADDED_BY].')';
            }
        }
        $result['list'] = $list;
//        dump($page->show());
        $result['page'] = $page->show();
        return $result;
    }

    private function getSingleGroup($groupID){
        $singleGroupFindResult = $this->getGroupModel()->where(array(GROUP_ID => $groupID))->find();
        if($singleGroupFindResult[GROUP_ADDED_BY] != null){
            $singleGroupFindResult['username_added'] = $this->getUserNameWithID($singleGroupFindResult[GROUP_ADDED_BY]);
        }else{
            $singleGroupFindResult['username_added'] = '未知用户('.$singleGroupFindResult[GROUP_ADDED_BY].')';
        }
//        dump($singleMenuFindResult);die;
        return $singleGroupFindResult;
    }
}