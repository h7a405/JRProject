<?php //固定开头
/**
 * class.php文件内代码结构
 * 注：$开头适用于PHPStorm自定义模板。$后首字母大写的，自定义命名也需大写
 */
 
//文档注释
/**
 * Created by PhpStorm.
 * User: OrinJay
 * Date: 2015/8/8 0008
 * Time: 23:09
 */
/*
 *ApplicationModuleName：应用模块名，在Admin模块下就是Admin，Home模块下是Home
 *ModuleName：类所在模块名，在Service模块下就是Service，在Controller模块下就是Controller
 */
 namespace Admin\Event;
/*
 * ModuleName：同上。
 */

class MenuEvent  extends BaseEvent {
//继承方法

//页面方法（用于显示页面）

//请求方法，request（用于页面请求数据）

//提交方法，post（用于页面提交数据）

//处理方法，do

//自定义方法（其他自定义方法）

//判断方法，is
    public function isModuleEnabled($controllerName){
        if($this->isControllerExist($controllerName)){
            return $this->getMenuModel()->where(array(MENU_URL => $controllerName))->find()[MENU_ENABLED] == 1;
        }else{
            return false;
        }
    }
     public function isActionEnabled($controllerName, $actionName){
         if($this->isActionExist($controllerName, $actionName)){
             return $this->getMenuModel()->where(array(MENU_URL => $actionName, MENU_PARENT_ID => $this->getControllerID($controllerName)))->find()[MENU_ENABLED] == 1;
         } else {
             return false;
         }
     }
     public function isModuleVisible($controllerName){

     }
     public function isActionVisible($controllerName, $actionName){

     }
     public function isControllerExist($controllerName){
         if(!$this->getControllerID($controllerName)){
             $menuData[MENU_NAME] = $controllerName;
             $menuData[MENU_URL] = $controllerName;
             $menuData[MENU_DATE] = $this->getCurrentDateTime();
             $menuData[MENU_OPERATOR_ID] = $this->getCurrentSignedInUserID();
             $menuData[MENU_DESCRIPTION] = $controllerName;
             $menuData[MENU_LEVEL] = MENU_LEVEL_CONTROLLER;
             $menuData[MENU_PARENT_ID] = 0;
             $menuInsertResult = $this->getDBEvent()->insertMenuRecord($menuData);
             if($menuInsertResult){
                 $this->getAccessEvent()->isAccessExistWithMenuID($this->getMenuIDWithMenuURL($controllerName, null));
                 return true;
             } else {
                 return false;
             }
         }
         return true;
     }
     public function isPageExist($controllerName, $actionName){
         if(!$this->getActionID($controllerName, $actionName)){
             $menuData[MENU_NAME] = $actionName;
             $menuData[MENU_URL] = $actionName;
             $menuData[MENU_DATE] = $this->getCurrentDateTime();
             $menuData[MENU_OPERATOR_ID] = $this->getCurrentSignedInUserID();
             $menuData[MENU_DESCRIPTION] = $actionName;
             $menuData[MENU_LEVEL] = MENU_LEVEL_PAGE;
             $menuData[MENU_PARENT_ID] = $this->getControllerID($controllerName);
             $menuInsertResult = $this->getDBEvent()->insertMenuRecord($menuData);
             if($menuInsertResult){
                 $this->getAccessEvent()->isAccessExistWithMenuID($this->getMenuIDWithMenuURL($controllerName, $actionName));
                 return true;
             } else {
                 return false;
             }
         }
         return true;
     }
     public function isActionExist($controllerName, $actionName){
         if(!$this->getActionID($controllerName, $actionName)){
             $menuData[MENU_NAME] = $actionName;
             $menuData[MENU_URL] = $actionName;
             $menuData[MENU_DATE] = $this->getCurrentDateTime();
             $menuData[MENU_OPERATOR_ID] = $this->getCurrentSignedInUserID();
             $menuData[MENU_DESCRIPTION] = $actionName;
             $menuData[MENU_LEVEL] = MENU_LEVEL_UNKNOWN;
             $menuData[MENU_VISIBLE] = 0;
             $menuData[MENU_PARENT_ID] = $this->getControllerID($controllerName);
             $menuInsertResult = $this->getDBEvent()->insertMenuRecord($menuData);
             if($menuInsertResult){
                 $this->getAccessEvent()->isAccessExistWithMenuID($this->getMenuIDWithMenuURL($controllerName, $actionName));
                 return true;
             } else {
                 return false;
             }
         }
         return true;
     }

//设值方法，setter

//获取方法，getter
    public function getControllerID($controllerName){
        return $this->getMenuModel()->where(array(MENU_URL => $controllerName, MENU_PARENT_ID => 0))->find()[MENU_ID];
    }
     public function getActionID($controllerName, $actionName){
        return $this->getMenuModel()->where(array(MENU_URL => $actionName, MENU_PARENT_ID => $this->getControllerID($controllerName)))->find()[MENU_ID];
     }
     public function getMenuToStringWithMenuID($menuID){
         $menuResult = $this->getMenuWithMenuID($menuID);
         if($menuResult[MENU_LEVEL] == 1){
             $level = 'Level Controller';
         } else if($menuResult[MENU_LEVEL] == 2){
             $level = 'Level Page';
         } else {
             $level = 'Level Action';
         }
         return 'Name of Menu:'.$menuResult[MENU_NAME].' | URL of Menu:'.$menuResult[MENU_URL].' | '.$level;
     }

     public function getMenuWithMenuID($menuID){
        return $this->getMenuModel()->where(array(MENU_ID => $menuID))->find();
     }
     public function getMenuIDWithMenuURL($controllerName, $actionName){
         if($actionName == null){
             return $this->getMenuModel()->where(array(MENU_URL => $controllerName, MENU_LEVEL => MENU_LEVEL_CONTROLLER))->find()[MENU_ID];
         } else {
             return $this->getMenuModel()->where(array(MENU_URL => $actionName, MENU_PARENT_ID => $this->getMenuIDWithMenuURL($controllerName, null)))->find()[MENU_ID];
         }
     }
     public function getMenuNameWithMenuID($menuID){
         return $this->getMenuModel()->where(array(MENU_ID => $menuID))->find()[MENU_NAME];
     }
     public function getMenuURLWithMenuID($menuID){
         return $this->getMenuModel()->where(array(MENU_ID => $menuID))->find()[MENU_URL];
     }

     public function getFrameworkMenus(){
         $Level0MenuSelectResult = $this->getMenuModel()->where(array(MENU_LEVEL => 1, MENU_VISIBLE => 1))->select();
//        dump($Level0MenuSelectResult);
         for($i = 0; $i < count($Level0MenuSelectResult); $i++){
             $Level0MenuSelectResult[$i]['childMenus'] = $this->getMenuModel()->where(array(MENU_PARENT_ID => $Level0MenuSelectResult[$i][MENU_ID], MENU_VISIBLE => 1, MENU_LEVEL => 2))->select();
//            dump($Level0MenuSelectResult[$i]['childMenus']);
//            dump(CONTROLLER_NAME);
             if(CONTROLLER_NAME == $Level0MenuSelectResult[$i][MENU_URL]){
//                dump($Level0MenuSelectResult[$i]);
                 for($j = 0; $j < count($Level0MenuSelectResult[$i]['childMenus']); $j++){
//                    dump(ACTION_NAME);
                     if(ACTION_NAME == $Level0MenuSelectResult[$i]['childMenus'][$j][MENU_URL]){
                         $isActivated = 1;
                     }else{
                         $isActivated = 0;
                     }
                     $Level0MenuSelectResult[$i]['childMenus'][$j]['isActivated'] = $isActivated;
                 }
             }

         }
         $menus = $Level0MenuSelectResult;
//        dump($menus);die;
         return $menus;
     }

     public function getMenuList(){
         $menuResult = $this->getMenuModel()->where(array(MENU_PARENT_ID => 0))->select();
         return $menuResult;
     }

     public function getMenuListWithPage($pageSize, $type, $visible, $enable){
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
         $map = null;
         if($type != -1 && $type != null) {
             $map['level'] = $type;
         }
         if($visible != -1 && $visible != null){
             $map['visible'] = $visible;
         }
         if($enable != -1 && $enable != null){
             $map['enable'] = $enable;
         }
         if($pageSize == null){
             $pageSize = 20;
         } else if($pageSize == -1){
             $pageSize = null;
         }
//        dump($map);
         $page = $this->getPage($this->getMenuModel(), $map, $pageSize);
//        dump($page);
//        $condition[$map['keyword_type']] = array('like',"%".$map['keyword']."%");

         $list = $this->getMenuModel()->where($map)->order(MENU_PARENT_ID.' ASC')->limit($page->firstRow.','.$page->listRows)->select();
//        dump($list);die;
         for($i = 0; $i < count($list); $i++){
             $list[$i]['edit_url'] = U('Menu/menu_edit', array(MENU_ID => $list[$i][MENU_ID]));
             if($list[$i][MENU_OPERATOR_ID] != null){
                 $list[$i]['username_added'] = $this->getUserEvent()->getUserNameWithUserID($list[$i][MENU_OPERATOR_ID], USER_TYPE_ADMIN);
             }else{
                 $list[$i]['username_added'] = 'Unknown userID:('.$list[$i][MENU_OPERATOR_ID].')';
             }
             if($list[$i][MENU_PARENT_ID] == 0){
                 $list[$i]['name_father'] = 'Undefined';
             }else{
                 $list[$i]['name_father'] = $this->getMenuNameWithMenuID($list[$i][MENU_PARENT_ID]);
             }
         }
         $result['list'] = $list;
//        dump($page->show());
         $result['page'] = $page->show();
         return $result;
     }
}
