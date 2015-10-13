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
 * Time: 11:52
 */
/*
 *ApplicationModuleName：应用模块名，在Admin模块下就是Admin，Home模块下是Home
 *ModuleName：类所在模块名，在Service模块下就是Service，在Controller模块下就是Controller
 */
 namespace Admin\Event;
/*
 * ModuleName：同上。
 */

class SystemEvent  extends BaseEvent{
//继承方法

//页面方法（用于显示页面）

//请求方法，request（用于页面请求数据）

//提交方法，post（用于页面提交数据）

//处理方法，do

//自定义方法（其他自定义方法）
     private function insertNewSystemRecord(){
         $systemData[SYSTEM_ID] = 1;
         $systemData[SYSTEM_NAME] = 'KIKI';
         $systemData[SYSTEM_SYSTEM_ENABLED] = 1;
         $systemData[SYSTEM_WEBSITE_ENABLED] = 1;
         $systemData[SYSTEM_SYSTEM_VERSION] = BACKSTAGE_VERSION;
         $systemData[SYSTEM_WEBSITE_VERSION] = FOREGROUND_VERSION;
         $this->getDBEvent()->insertSystemRecord($systemData);
     }

//判断方法，is
     private function isSystemRecordExist(){
         if($this->getSystemModel()->find()) {
             return true;
         } else {
             return false;
         }
     }

     public function isSystemEnabled(){
         $systemResult = $this->getSystemStatus();
         if($systemResult[SYSTEM_SYSTEM_ENABLED] == 1){
             return true;
         } else {
             return false;
         }
     }

//设值方法，setter

//获取方法，getter
     public function getSystemStatus(){
         if(!$this->isSystemRecordExist()){
             $this->insertNewSystemRecord();
         }
         return $this->getSystemModel()->find();
     }

     public function getSystemToString(){

     }
 }
