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
 * Time: 11:03
 */
/*
 *ApplicationModuleName：应用模块名，在Admin模块下就是Admin，Home模块下是Home
 *ModuleName：类所在模块名，在Service模块下就是Service，在Controller模块下就是Controller
 */
 namespace Admin\Event;
/*
 * ModuleName：同上。
 */

class UserEvent  extends BaseEvent  {
//继承方法

//页面方法（用于显示页面）

//请求方法，request（用于页面请求数据）

//提交方法，post（用于页面提交数据）

//处理方法，do

//自定义方法（其他自定义方法）

//判断方法，is
    public function isUserExistWithUserName($username, $type){
        $target = null;
        if($type == USER_TYPE_ADMIN){
            $target = ADMIN_USERNAME;
        } else if ($type == USER_TYPE_USER){
            $target = USER_USERNAME;
        }
        $userResult = $this->getModelWithType($type)->where(array($target => $username))->find();
        if($userResult){
            return true;
        } else {
            return false;
        }

    }
     public function isUserExistWithUserID($userID, $type){
         $target = null;
         if($type == USER_TYPE_ADMIN){
             $target = ADMIN_ID;
         } else if ($type == USER_TYPE_USER){
             $target = USER_ID;
         }
         $userResult = $this->getModelWithType($type)->where(array($target => $userID))->find();
         if($userResult){
             return true;
         } else {
             return false;
         }
     }

//设值方法，setter

//获取方法，getter
    public function getDecodedUserSaltWithUserID($userID, $type){
        $target = null;
        $targetSelect = null;
        if($type == USER_TYPE_ADMIN){
            $target = ADMIN_ID;
            $targetSelect = ADMIN_SALT;
        } else if ($type == USER_TYPE_USER){
            $target = USER_ID;
            $targetSelect = USER_SALT;
        }
        $salt = $this->getModelWithType($type)->where(array($target => $userID))->find()[$targetSelect];
        return base64_decode($salt);
    }
     public function getPasswordWithUserID($userID, $type){
         $target = null;
         if($type == USER_TYPE_ADMIN){
             $target = ADMIN_ID;
         } else if ($type == USER_TYPE_USER){
             $target = USER_ID;
         }
         $password = $this->getModelWithType($type)->where(array($target => $userID))->find()[PASSWORD];
         return $password;
     }

     public function getUserIDWithUsername($username, $type){
         $target = null;
         if($type == USER_TYPE_ADMIN){
             $target = ADMIN_USERNAME;
         } else if ($type == USER_TYPE_USER){
             $target = USER_USERNAME;
         }
         $userID = $this->getModelWithType($type)->where(array($target => $username))->find()[ID];
         return $userID;
     }
     public function getUserNameWithUserID($userID, $type){
         $target = null;
         if($type == USER_TYPE_ADMIN){
             $target = ADMIN_ID;
         } else if ($type == USER_TYPE_USER){
             $target = USER_ID;
         }
         $username = $this->getModelWithType($type)->where(array($target => $userID))->find()[USERNAME];
         return $username;
     }
     public function getUserGroupWithUserID($userID, $type){
         $target = null;
         if($type == USER_TYPE_ADMIN){
             $target = ADMIN_ID;
         } else if ($type == USER_TYPE_USER){
             $target = USER_ID;
         }
         $userData = $this->getModelWithType($type)->where(array($target => $userID))->find()[ADMIN_GROUP_ID];
         return $userData;
     }
     public function getUserWithUserID($userID, $type){
         $target = null;
         if($type == USER_TYPE_ADMIN){
             $target = ADMIN_ID;
         } else if ($type == USER_TYPE_USER){
             $target = USER_ID;
         }
         $userData = $this->getModelWithType($type)->where(array($target => $userID))->find();
         return $userData;
     }

     private function getModelWithType($type){
         $model = null;
         if($type == USER_TYPE_ADMIN){
             $model = $this->getAdminModel();
         } else if ($type == USER_TYPE_USER){
             $model = $this->getUserModel();
         }
         return $model;
    }
}
