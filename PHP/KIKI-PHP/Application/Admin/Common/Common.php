<?php
/**
 * Created by PhpStorm.
 * User: OrinJay
 * Date: 2015/8/8 0008
 * Time: 10:06
 */

namespace Admin\Common;


class Common {
    //继承方法

//页面方法（用于显示页面）

//请求方法，request（用于页面请求数据）

//提交方法，post（用于页面提交数据）

//处理方法，do

//自定义方法（其他自定义方法）

//判断方法，is

//设值方法，setter

//获取方法，getter
    public function getSystemModel(){
        return M(TB_SYSTEM);
    }
}