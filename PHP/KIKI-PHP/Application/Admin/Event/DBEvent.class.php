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
 * Time: 0:25
 */
/*
 *ApplicationModuleName：应用模块名，在Admin模块下就是Admin，Home模块下是Home
 *ModuleName：类所在模块名，在Service模块下就是Service，在Controller模块下就是Controller
 */
 namespace Admin\Event;
/*
 * ModuleName：同上。
 */
class DBEvent  extends BaseEvent  {
//继承方法

//页面方法（用于显示页面）

//请求方法，request（用于页面请求数据）

//提交方法，post（用于页面提交数据）

//处理方法，do
    public function doWriteLog($information){
        $this->getLogEvent()->doWriteAdminOperationLog(CONTROLLER_NAME, ACTION_NAME, $information);
    }

//自定义方法（其他自定义方法）
 //Insert
     public function insertSystemRecord($data){
         $insertResult = $this->getSystemModel()->add($data);
         if($insertResult){
             $this->doWriteLog(L(LANG_SYSTEM_RECORD_INSERT));
             return true;
         } else {
             return false;
         }
     }

     public function insertLogRecord($data){
         $insertResult = $this->getLogModel()->add($data);
         if($insertResult) {
             return true;
         } else {
             return false;
         }
     }

     public function insertMenuRecord($data){
         $insertResult = $this->getMenuModel()->add($data);
         if($insertResult) {
             $this->doWriteLog(L(LANG_MENU_RECORD_INSERT).''.$this->getMenuEvent()->getMenuToStringWithMenuID($insertResult[MENU_ID]));
             return true;
         } else {
             return false;
         }
     }

     public function insertAccessRecord($data){
         $insertResult = $this->getAccessModel()->add($data);
         if($insertResult) {
             $this->doWriteLog(L(LANG_ACCESS_RECORD_INSERT).''.$this->getAccessEvent()->getAccessToStringWithAccessID($insertResult[ACCESS_ID]));
             return true;
         } else {
             return false;
         }
     }

     //update
     public function updateUser($data){
         $updateResult = $this->getUserModel()->save($data);
         if($updateResult){
             return true;
         } else {
             return false;
         }
     }
     public function updateAdmin($data){
         $updateResult = $this->getAdminModel()->save($data);
         if($updateResult){
             return true;
         } else {
             return false;
         }
     }

//判断方法，is

//设值方法，setter

//获取方法，getter
}
