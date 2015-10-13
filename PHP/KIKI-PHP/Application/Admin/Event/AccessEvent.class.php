<?php //固定开头
/**
 * class.php文件内代码结构
 * 注：$开头适用于PHPStorm自定义模板。$后首字母大写的，自定义命名也需大写
 */
 
//文档注释
/**
 * Created by PhpStorm.
 * User: OrinJay
 * Date: 2015/8/9 0009
 * Time: 7:59
 */
/*
 *ApplicationModuleName：应用模块名，在Admin模块下就是Admin，Home模块下是Home
 *ModuleName：类所在模块名，在Service模块下就是Service，在Controller模块下就是Controller
 */
 namespace Admin\Event;
/*
 * ModuleName：同上。
 */

class AccessEvent  extends BaseEvent  {
//继承方法

//页面方法（用于显示页面）

//请求方法，request（用于页面请求数据）

//提交方法，post（用于页面提交数据）

//处理方法，do

//自定义方法（其他自定义方法）
 public function postNewAccess($data){

 }

//判断方法，is
 public function isAccessExistWithMenuID($menuID){
    if(!$this->getAccessWithMenuID($menuID)){
        $menuData = $this->getMenuEvent()->getMenuWithMenuID($menuID);
//        dump($menuData[MENU_NAME]);
        $accessData[ACCESS_NAME] = 'Access:'.$menuData[MENU_NAME];
//        dump($accessData[ACCESS_NAME]);
        $accessData[ACCESS_MENU_ID] = $menuData[MENU_ID];
        $accessData[ACCESS_DATE] = $this->getCurrentDateTime();
        $accessData[ACCESS_OPERATOR_ID] = $this->getCurrentSignedInUserID();
        $accessData[ACCESS_LEVEL] = $menuData[MENU_LEVEL];
        $accessData[ACCESS_DESCRIPTION] = 'Description of access:'.$menuData[MENU_DESCRIPTION];
        if($accessData[ACCESS_LEVEL] > 1){
            $accessData[ACCESS_PARENT_ID] = $this->getAccessIDWithMenuID($menuData[MENU_PARENT_ID]);
        } else {
            $accessData[ACCESS_PARENT_ID] = 0;
        }
        if($this->getDBEvent()->insertAccessRecord($accessData))
            return true;
        else return false;
    } else {
        return true;
    }
 }
     public function isAccessibleWithMenuID($menuID){
         $accessible = false;
         if($this->isAccessExistWithMenuID($menuID)){
             $accessID = $this->getAccessIDWithMenuID($menuID);
            $groupID = $this->getUserEvent()->getUserGroupWithUserID($this->getCurrentSignedInUserID(), USER_TYPE_ADMIN);
            $groupLevel = $this->getGroupEvent()->getGroupLevelWithGroupID($groupID);
             $groupAccessResult = $this->getGroupAccessModel()->where(array(GROUP_ACCESS_LEVEL => $groupLevel, GROUP_ACCESS_ACCESS_ID => $accessID))->find();

             if($groupAccessResult[GROUP_ACCESS_ENABLED] == 1){
                 $accessible = true;
             }
         }
         return $accessible;
     }

//设值方法，setter

//获取方法，getter
 public function getAccessWithMenuID($menuID){
     return $this->getAccessModel()->where(array(ACCESS_MENU_ID => $menuID))->find();
 }
     public function getAccessIDWithMenuID($menuID){
         return $this->getAccessWithMenuID($menuID)[ACCESS_ID];
     }
     public function getAccessWithAccessID($accessID){
         return $this->getAccessModel()->where(array(ACCESS_ID => $accessID))->find();
     }
     public function getAccessToStringWithAccessID($accessID){
         $accessResult = $this->getAccessWithAccessID($accessID);
         $accessURL = $this->getMenuEvent()->getMenuURLWithMenuID($accessResult[ACCESS_MENU_ID]);
         if($accessResult[ACCESS_LEVEL] == 1){
             $level = 'Level Controller';
         } else if($accessResult[ACCESS_LEVEL] == 2){
             $level = 'Level Page';
         } else {
             $level = 'Level Action';
         }
         return 'Name of access:'.$accessResult[ACCESS_NAME].' | URL of access:'.$accessURL.' | '.$level;
     }
}
