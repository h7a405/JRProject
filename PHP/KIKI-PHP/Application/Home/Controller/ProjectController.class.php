<?php
/**
 * Created by PhpStorm.
 * User: OrinJay
 * Date: 2015/8/31 0031
 * Time: 22:54
 */

namespace Home\Controller;


class ProjectController extends BaseController {
    public function doCreateProject() {
        if(!IS_POST) {
            $this->ajaxReturn($this->getReturnData(204));
        }
        $jsonString = $_POST['json'];
        $json = json_decode($jsonString, true);
        dump($json);
    }

}