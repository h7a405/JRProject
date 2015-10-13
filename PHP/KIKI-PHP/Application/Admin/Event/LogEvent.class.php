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
 * Time: 0:52
 */
/*
 *ApplicationModuleName：应用模块名，在Admin模块下就是Admin，Home模块下是Home
 *ModuleName：类所在模块名，在Service模块下就是Service，在Controller模块下就是Controller
 */
 namespace Admin\Event;
/*
 * ModuleName：同上。
 */

class LogEvent  extends BaseEvent  {
//继承方法

//页面方法（用于显示页面）

//请求方法，request（用于页面请求数据）

//提交方法，post（用于页面提交数据）

//处理方法，do
 public function doWriteLoginLog($operatedInfo){
     $this->doWriteAdminOperationLog('Login', 'login', $operatedInfo);
 }

//自定义方法（其他自定义方法）
     public function doWriteAdminOperationLog($controller_name, $action_name, $operatedInfo){
         $log[LOG_DATE] = $this->getCurrentDateTime();
         if(!session('?'.SESSION_ADMIN_ID)){
             $log[LOG_OPERATOR_ID] = 0;
             $log[LOG_REMARK] .= "Unknown user or done by system. ";
         } else {
             $log[LOG_OPERATOR_ID] = session(SESSION_ADMIN_ID);
         }
         $log[LOG_CONTROLLER_ID] = $this->getMenuEvent()->getControllerID($controller_name);
         $log[LOG_ACTION_ID] = $this->getMenuEvent()->getActionID($controller_name, $action_name);
         if($log[LOG_CONTROLLER_ID] == null){
             $log[LOG_REMARK] .= "Unknown Module:".$controller_name.". ";
         }
         if($log[LOG_ACTION_ID] == null) {
             $log[LOG_REMARK] .= "Unknown Action:".$action_name.". ";
         }
         $log[LOG_INFORMATION] .= $operatedInfo;
//        dump($log);die;
         $logInsertResult = $this->getDBEvent()->insertLogRecord($log);
         if($logInsertResult){
             return true;
         } else {
             return false;
         }
     }

//判断方法，is

//设值方法，setter

//获取方法，getter
}
