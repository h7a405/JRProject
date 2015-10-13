<?php
namespace Home\Controller;
use Think\Controller;
class LogController extends BaseController {
    public function _initialize(){
        parent::_initialize();
        if(!$this->isLogin()){
            $this->redirect('Login/login');
        }
    }
    public function index(){
        $keyword = $_GET['keyword'];
        $keywordType = $_GET['keywordType'];
        $pageSize = $_GET['pageSize'];
        $logResult = $this->getLogs($keyword, $keywordType, $pageSize);
//        dump($logResult);die;
        $this->assign('fields', $this->getLogFields());
        $this->assign('list', $logResult['list']);
        $this->assign('page', $logResult['page']);
        $this->display();
    }

    public function getLogs($keyword, $keywordType, $pageSize){
//        dump($keyword);dump($keywordType);
        if($keywordType != ''){
            if($keyword) {
                if($keywordType == LOG_ADMIN_OPERATOR){
                    $target = $this->getUserModel()->where(array(USER_ADMIN_USERNAME => $keyword))->find();
                    $map['keyword'] = $target[USER_ADMIN_ID];
                } else if($keywordType == LOG_ADMIN_MODULE){
                    $target = $this->getMenuModel()->where(array(MENU_ADMIN_URL => $keyword, MENU_ADMIN_LEVEL => 0))->find();
                    $map['keyword'] = $target[MENU_ADMIN_ID];
                } else if($keywordType == LOG_ADMIN_FUNCTION){
                    $target = $this->getMenuModel()->where(array(MENU_ADMIN_URL => $keyword, MENU_ADMIN_LEVEL => 1))->find();
                    $map['keyword'] = $target[MENU_ADMIN_ID];
                }
//                $map['keyword'] = $keyword;

                $map['keyword_type'] = $keywordType;
            }
        }
        if($pageSize == null){
            $pageSize = 20;
        }
//        dump($map);
        $page = $this->getPage($this->getLogModel(), $map, $pageSize);
//        dump($page);
        $condition[$map['keyword_type']] = array('like',"%".$map['keyword']."%");

        $list = $this->getLogModel()->where($condition)->order(LOG_ADMIN_DATE.' DESC')->limit($page->firstRow.','.$page->listRows)->select();
//        dump($list);die;
        for($i = 0; $i < count($list); $i++){
            if($list[$i][LOG_ADMIN_MODULE] != null){
                $list[$i]['operatedmodulename'] = $this->getMenuNameWithID($list[$i][LOG_ADMIN_MODULE]);
            }else{
                $list[$i]['operatedmodulename'] = '未知模块';
            }
//            dump($list[$i]);
            if($list[$i][LOG_ADMIN_FUNCTION] != null){
                $list[$i]['operatedfunctionname'] = $this->getMenuNameWithID($list[$i][LOG_ADMIN_FUNCTION]);
            }else{
                $list[$i]['operatedfunctionname'] = '未知功能';
            }
            if($list[$i][LOG_ADMIN_OPERATOR] != null){
                $list[$i]['addedbyname'] = $this->getUserNameWithID($list[$i][LOG_ADMIN_OPERATOR]);
            }else{
                $list[$i]['addedbyname'] = '未知用户';
            }
        }
//        dump($list);die;
        $result['list'] = $list;
//        dump($page->show());
        $result['page'] = $page->show();
        return $result;
    }

    public function getLogFields(){
        $fields = $this->getDatabaseFields($this->getLogModel());
        for($i = 0; $i < count($fields); $i++){
            if($fields[$i] == LOG_ADMIN_OPERATOR) {
                $returnFields[$i]['value'] = $fields[$i];
                $returnFields[$i]['name'] = '记录帐号';
            } else if($fields[$i] == LOG_ADMIN_MODULE){
                $returnFields[$i]['value'] = $fields[$i];
                $returnFields[$i]['name'] = '记录模块';
            } else if($fields[$i] == LOG_ADMIN_FUNCTION){
                $returnFields[$i]['value'] = $fields[$i];
                $returnFields[$i]['name'] = '记录功能';
            }
        }
//        dump($returnFields);die;
        return $returnFields;
    }
}