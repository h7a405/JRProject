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
 * Time: 21:33
 */
/*
 *ApplicationModuleName：应用模块名，在Admin模块下就是Admin，Home模块下是Home
 *ModuleName：类所在模块名，在Service模块下就是Service，在Controller模块下就是Controller
 */
 namespace Admin\Event;
/*
 * ModuleName：同上。
 */

class GroupEvent  extends BaseEvent  {
//继承方法

//页面方法（用于显示页面）

//请求方法，request（用于页面请求数据）

//提交方法，post（用于页面提交数据）

//处理方法，do

//自定义方法（其他自定义方法）

//判断方法，is

//设值方法，setter

//获取方法，getter
    public function getGroupLevelWithGroupID($groupID){
        return $this->getGroupModel()->where(array(GROUP_ID => $groupID))->find()[GROUP_LEVEL];
    }
}
