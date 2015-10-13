<?php
namespace Home\Controller;
use Think\Controller;
class BaseController extends Controller {

    public function _initialize(){
        header("Content-type: text/html; charset=utf8");

        $isSystemAvailable = $this->isSystemAvailable();
//        dump($isSystemAvailable);die;
        if(!$isSystemAvailable){
            $this->error('系统关闭中...', U(PAGE_ERROR), 3);
        }
        if(!$this->isActionExist()){
            $this->error('该功能尚未添加至菜单列表，请先前往添加。', U('Menu/addMenu'), 3);
        }
        if(!$this->isActionAvailable()){
            $this->error('该功能尚未启用。', U('Index/index'), 3);
        }

        $this->assign('controllerName', $this->getCurrentControllerName(CONTROLLER_NAME));
        $this->assign('actionName', $this->getCurrentActionName(ACTION_NAME, CONTROLLER_NAME));
        $this->assign('currentURL', U(CONTROLLER_NAME.'/'.ACTION_NAME));
        $this->assign('title', $this->getSystemName());
        $this->assign('username', $this->getCurrentUserName());
        $this->assign('menus', $this->getMenus());
    }

    protected function isSystemAvailable(){
        $systemSelectResult = $this->getSystemInfoModel()->find();
//        dump($systemSelectResult);
//        dump(count($systemSelectResult['issystemopened']));
//        dump("isSystemOpened == 1 ? : ".$systemSelectResult['issystemopened'] == 1);
        return ($systemSelectResult[SYSTEM_INFO_OPENED] == true);
    }

    protected  function isActionAvailable(){
        $menuID = $this->getActionID(ACTION_NAME, CONTROLLER_NAME);
        $menuData = $this->getMenuModel()->where(array(MENU_ADMIN_ID => $menuID))->find();
        if($menuData[MENU_ADMIN_AVAILABLE] == 0){
            return false;
        } else
            return true;
    }

    protected function isActionExist(){
        $menuID = $this->getActionID(ACTION_NAME, CONTROLLER_NAME);
//        dump($menuID);
        $menuData = $this->getMenuModel()->where(array(MENU_ADMIN_ID => $menuID))->find();
//        dump($menuData);die;
        if($menuData){
            return true;
        } else
            return false;
    }

    protected function isAccessible(){

    }

    /**
     *
     */
    protected function isLogin(){
        if(session(SESSION_ADMIN_ID) == null){
//            $this->redirect('Login/login');
            return false;
        }
        return true;
    }

    public function displayDefaultError(){
        $this->error('操作失败, 请稍后再试!');
    }

    public function displayDefaultSuccess(){
        $this->success('操作成功!');
    }

    /**
     * @param $operatedModule
     * @param $operatedFunction
     * @param $operatedInfo
     * @return true or false
     */
    public function doWriteAdminOperationLog($operatedModule, $operatedFunction, $operatedInfo){
        $log[LOG_ADMIN_DATE] = $this->getCurrentDateTime();
        $log[LOG_ADMIN_OPERATOR] = session(SESSION_ADMIN_ID);
        if($log[LOG_ADMIN_OPERATOR] == null){
            $log[LOG_ADMIN_DETAILS] .= "未知用户 ";
        }
        $log[LOG_ADMIN_MODULE] = $this->getControllerID($operatedModule);
        $log[LOG_ADMIN_FUNCTION] = $this->getActionID($operatedFunction, $operatedModule);
        if($log[LOG_ADMIN_MODULE] == null){
            $log[LOG_ADMIN_DETAILS] .= "未知模块:".$operatedModule." ";
        }
        if($log[LOG_ADMIN_FUNCTION] == null) {
            $log[LOG_ADMIN_DETAILS] .= "未知功能:".$operatedFunction." ";
        }
        $log[LOG_ADMIN_INFORMATION] = $operatedInfo;
//        dump($log);die;
        $logInsertResult = $this->getLogModel()->data($log)->add();
        if($logInsertResult){
            return true;
        } else {
            return false;
        }
    }

    /**
     * @param $str
     * @param $key
     * @param bool $toBase64
     * @return string
     */
    protected function encrypt($str, $key, $toBase64=true){
        if ($str == "") {
            return "";
        }
        if ($toBase64) {
            return base64_encode(self::_des($key,$str,1));
        }
        return self::_des($key,$str,1);
    }

    /**
     * @param $str
     * @param $key
     * @param bool $toBase64
     * @return string
     */
    protected function decrypt($str, $key, $toBase64=true){
        if ($str == "") {
            return "";
        }
        if ($toBase64) {
            return self::_des($key,base64_decode($str),0);
        }
        return self::_des($key,$str,0);
    }
    private function _des($key, $message, $encrypt, $mode=0, $iv=null) {
        $spfunction1 = array (0x1010400,0,0x10000,0x1010404,0x1010004,0x10404,0x4,0x10000,0x400,0x1010400,0x1010404,0x400,0x1000404,0x1010004,0x1000000,0x4,0x404,0x1000400,0x1000400,0x10400,0x10400,0x1010000,0x1010000,0x1000404,0x10004,0x1000004,0x1000004,0x10004,0,0x404,0x10404,0x1000000,0x10000,0x1010404,0x4,0x1010000,0x1010400,0x1000000,0x1000000,0x400,0x1010004,0x10000,0x10400,0x1000004,0x400,0x4,0x1000404,0x10404,0x1010404,0x10004,0x1010000,0x1000404,0x1000004,0x404,0x10404,0x1010400,0x404,0x1000400,0x1000400,0,0x10004,0x10400,0,0x1010004);
        $spfunction2 = array (-0x7fef7fe0,-0x7fff8000,0x8000,0x108020,0x100000,0x20,-0x7fefffe0,-0x7fff7fe0,-0x7fffffe0,-0x7fef7fe0,-0x7fef8000,-0x80000000,-0x7fff8000,0x100000,0x20,-0x7fefffe0,0x108000,0x100020,-0x7fff7fe0,0,-0x80000000,0x8000,0x108020,-0x7ff00000,0x100020,-0x7fffffe0,0,0x108000,0x8020,-0x7fef8000,-0x7ff00000,0x8020,0,0x108020,-0x7fefffe0,0x100000,-0x7fff7fe0,-0x7ff00000,-0x7fef8000,0x8000,-0x7ff00000,-0x7fff8000,0x20,-0x7fef7fe0,0x108020,0x20,0x8000,-0x80000000,0x8020,-0x7fef8000,0x100000,-0x7fffffe0,0x100020,-0x7fff7fe0,-0x7fffffe0,0x100020,0x108000,0,-0x7fff8000,0x8020,-0x80000000,-0x7fefffe0,-0x7fef7fe0,0x108000);
        $spfunction3 = array (0x208,0x8020200,0,0x8020008,0x8000200,0,0x20208,0x8000200,0x20008,0x8000008,0x8000008,0x20000,0x8020208,0x20008,0x8020000,0x208,0x8000000,0x8,0x8020200,0x200,0x20200,0x8020000,0x8020008,0x20208,0x8000208,0x20200,0x20000,0x8000208,0x8,0x8020208,0x200,0x8000000,0x8020200,0x8000000,0x20008,0x208,0x20000,0x8020200,0x8000200,0,0x200,0x20008,0x8020208,0x8000200,0x8000008,0x200,0,0x8020008,0x8000208,0x20000,0x8000000,0x8020208,0x8,0x20208,0x20200,0x8000008,0x8020000,0x8000208,0x208,0x8020000,0x20208,0x8,0x8020008,0x20200);
        $spfunction4 = array (0x802001,0x2081,0x2081,0x80,0x802080,0x800081,0x800001,0x2001,0,0x802000,0x802000,0x802081,0x81,0,0x800080,0x800001,0x1,0x2000,0x800000,0x802001,0x80,0x800000,0x2001,0x2080,0x800081,0x1,0x2080,0x800080,0x2000,0x802080,0x802081,0x81,0x800080,0x800001,0x802000,0x802081,0x81,0,0,0x802000,0x2080,0x800080,0x800081,0x1,0x802001,0x2081,0x2081,0x80,0x802081,0x81,0x1,0x2000,0x800001,0x2001,0x802080,0x800081,0x2001,0x2080,0x800000,0x802001,0x80,0x800000,0x2000,0x802080);
        $spfunction5 = array (0x100,0x2080100,0x2080000,0x42000100,0x80000,0x100,0x40000000,0x2080000,0x40080100,0x80000,0x2000100,0x40080100,0x42000100,0x42080000,0x80100,0x40000000,0x2000000,0x40080000,0x40080000,0,0x40000100,0x42080100,0x42080100,0x2000100,0x42080000,0x40000100,0,0x42000000,0x2080100,0x2000000,0x42000000,0x80100,0x80000,0x42000100,0x100,0x2000000,0x40000000,0x2080000,0x42000100,0x40080100,0x2000100,0x40000000,0x42080000,0x2080100,0x40080100,0x100,0x2000000,0x42080000,0x42080100,0x80100,0x42000000,0x42080100,0x2080000,0,0x40080000,0x42000000,0x80100,0x2000100,0x40000100,0x80000,0,0x40080000,0x2080100,0x40000100);
        $spfunction6 = array (0x20000010,0x20400000,0x4000,0x20404010,0x20400000,0x10,0x20404010,0x400000,0x20004000,0x404010,0x400000,0x20000010,0x400010,0x20004000,0x20000000,0x4010,0,0x400010,0x20004010,0x4000,0x404000,0x20004010,0x10,0x20400010,0x20400010,0,0x404010,0x20404000,0x4010,0x404000,0x20404000,0x20000000,0x20004000,0x10,0x20400010,0x404000,0x20404010,0x400000,0x4010,0x20000010,0x400000,0x20004000,0x20000000,0x4010,0x20000010,0x20404010,0x404000,0x20400000,0x404010,0x20404000,0,0x20400010,0x10,0x4000,0x20400000,0x404010,0x4000,0x400010,0x20004010,0,0x20404000,0x20000000,0x400010,0x20004010);
        $spfunction7 = array (0x200000,0x4200002,0x4000802,0,0x800,0x4000802,0x200802,0x4200800,0x4200802,0x200000,0,0x4000002,0x2,0x4000000,0x4200002,0x802,0x4000800,0x200802,0x200002,0x4000800,0x4000002,0x4200000,0x4200800,0x200002,0x4200000,0x800,0x802,0x4200802,0x200800,0x2,0x4000000,0x200800,0x4000000,0x200800,0x200000,0x4000802,0x4000802,0x4200002,0x4200002,0x2,0x200002,0x4000000,0x4000800,0x200000,0x4200800,0x802,0x200802,0x4200800,0x802,0x4000002,0x4200802,0x4200000,0x200800,0,0x2,0x4200802,0,0x200802,0x4200000,0x800,0x4000002,0x4000800,0x800,0x200002);
        $spfunction8 = array (0x10001040,0x1000,0x40000,0x10041040,0x10000000,0x10001040,0x40,0x10000000,0x40040,0x10040000,0x10041040,0x41000,0x10041000,0x41040,0x1000,0x40,0x10040000,0x10000040,0x10001000,0x1040,0x41000,0x40040,0x10040040,0x10041000,0x1040,0,0,0x10040040,0x10000040,0x10001000,0x41040,0x40000,0x41040,0x40000,0x10041000,0x1000,0x40,0x10040040,0x1000,0x41040,0x10001000,0x40,0x10000040,0x10040000,0x10040040,0x10000000,0x40000,0x10001040,0,0x10041040,0x40040,0x10000040,0x10040000,0x10001000,0x10001040,0,0x10041040,0x41000,0x41000,0x1040,0x1040,0x40040,0x10000000,0x10041000);
        $masks = array (4294967295,2147483647,1073741823,536870911,268435455,134217727,67108863,33554431,16777215,8388607,4194303,2097151,1048575,524287,262143,131071,65535,32767,16383,8191,4095,2047,1023,511,255,127,63,31,15,7,3,1,0);
        $keys = self::_createKeys ($key);
        $m=0;
        $len = strlen($message);
        $chunk = 0;
        $iterations = ((count($keys) == 32) ? 3 : 9);
        if ($iterations == 3) {$looping = (($encrypt) ? array (0, 32, 2) : array (30, -2, -2));}
        else {$looping = (($encrypt) ? array (0, 32, 2, 62, 30, -2, 64, 96, 2) : array (94, 62, -2, 32, 64, 2, 30, -2, -2));}
        $message .= (chr(0) . chr(0) . chr(0) . chr(0) . chr(0) . chr(0) . chr(0) . chr(0));
        $result = "";
        $tempresult = "";
        if ($mode == 1) {
            $cbcleft = (ord($iv{$m++}) << 24) | (ord($iv{$m++}) << 16) | (ord($iv{$m++}) << 8) | ord($iv{$m++});
            $cbcright = (ord($iv{$m++}) << 24) | (ord($iv{$m++}) << 16) | (ord($iv{$m++}) << 8) | ord($iv{$m++});
            $m=0;
        }
        while ($m < $len) {
            $left = (ord($message{$m++}) << 24) | (ord($message{$m++}) << 16) | (ord($message{$m++}) << 8) | ord($message{$m++});
            $right = (ord($message{$m++}) << 24) | (ord($message{$m++}) << 16) | (ord($message{$m++}) << 8) | ord($message{$m++});
            if ($mode == 1) {if ($encrypt) {$left ^= $cbcleft; $right ^= $cbcright;} else {$cbcleft2 = $cbcleft; $cbcright2 = $cbcright; $cbcleft = $left; $cbcright = $right;}}
            $temp = (($left >> 4 & $masks[4]) ^ $right) & 0x0f0f0f0f; $right ^= $temp; $left ^= ($temp << 4);
            $temp = (($left >> 16 & $masks[16]) ^ $right) & 0x0000ffff; $right ^= $temp; $left ^= ($temp << 16);
            $temp = (($right >> 2 & $masks[2]) ^ $left) & 0x33333333; $left ^= $temp; $right ^= ($temp << 2);
            $temp = (($right >> 8 & $masks[8]) ^ $left) & 0x00ff00ff; $left ^= $temp; $right ^= ($temp << 8);
            $temp = (($left >> 1 & $masks[1]) ^ $right) & 0x55555555; $right ^= $temp; $left ^= ($temp << 1);
            $left = (($left << 1) | ($left >> 31 & $masks[31]));
            $right = (($right << 1) | ($right >> 31 & $masks[31]));
            for ($j=0; $j<$iterations; $j+=3) {
                $endloop = $looping[$j+1];
                $loopinc = $looping[$j+2];
                for ($i=$looping[$j]; $i!=$endloop; $i+=$loopinc) {
                    $right1 = $right ^ $keys[$i];
                    $right2 = (($right >> 4 & $masks[4]) | ($right << 28)) ^ $keys[$i+1];
                    $temp = $left;
                    $left = $right;
                    $right = $temp ^ ($spfunction2[($right1 >> 24 & $masks[24]) & 0x3f] | $spfunction4[($right1 >> 16 & $masks[16]) & 0x3f]
                            | $spfunction6[($right1 >>    8 & $masks[8]) & 0x3f] | $spfunction8[$right1 & 0x3f]
                            | $spfunction1[($right2 >> 24 & $masks[24]) & 0x3f] | $spfunction3[($right2 >> 16 & $masks[16]) & 0x3f]
                            | $spfunction5[($right2 >>    8 & $masks[8]) & 0x3f] | $spfunction7[$right2 & 0x3f]);
                }
                $temp = $left; $left = $right; $right = $temp;
            }
            $left = (($left >> 1 & $masks[1]) | ($left << 31));
            $right = (($right >> 1 & $masks[1]) | ($right << 31));
            $temp = (($left >> 1 & $masks[1]) ^ $right) & 0x55555555; $right ^= $temp; $left ^= ($temp << 1);
            $temp = (($right >> 8 & $masks[8]) ^ $left) & 0x00ff00ff; $left ^= $temp; $right ^= ($temp << 8);
            $temp = (($right >> 2 & $masks[2]) ^ $left) & 0x33333333; $left ^= $temp; $right ^= ($temp << 2);
            $temp = (($left >> 16 & $masks[16]) ^ $right) & 0x0000ffff; $right ^= $temp; $left ^= ($temp << 16);
            $temp = (($left >> 4 & $masks[4]) ^ $right) & 0x0f0f0f0f; $right ^= $temp; $left ^= ($temp << 4);
            if ($mode == 1) {if ($encrypt) {$cbcleft = $left; $cbcright = $right;} else {$left ^= $cbcleft2; $right ^= $cbcright2;}}
            $tempresult .= (chr($left>>24 & $masks[24]) . chr(($left>>16 & $masks[16]) & 0xff) . chr(($left>>8 & $masks[8]) & 0xff) . chr($left & 0xff) . chr($right>>24 & $masks[24]) . chr(($right>>16 & $masks[16]) & 0xff) . chr(($right>>8 & $masks[8]) & 0xff) . chr($right & 0xff));
            $chunk += 8;
            if ($chunk == 512) {$result .= $tempresult; $tempresult = ""; $chunk = 0;}
        }
        return ($result . $tempresult);
    }
    private function _createKeys ($key) {
        $pc2bytes0    = array (0,0x4,0x20000000,0x20000004,0x10000,0x10004,0x20010000,0x20010004,0x200,0x204,0x20000200,0x20000204,0x10200,0x10204,0x20010200,0x20010204);
        $pc2bytes1    = array (0,0x1,0x100000,0x100001,0x4000000,0x4000001,0x4100000,0x4100001,0x100,0x101,0x100100,0x100101,0x4000100,0x4000101,0x4100100,0x4100101);
        $pc2bytes2    = array (0,0x8,0x800,0x808,0x1000000,0x1000008,0x1000800,0x1000808,0,0x8,0x800,0x808,0x1000000,0x1000008,0x1000800,0x1000808);
        $pc2bytes3    = array (0,0x200000,0x8000000,0x8200000,0x2000,0x202000,0x8002000,0x8202000,0x20000,0x220000,0x8020000,0x8220000,0x22000,0x222000,0x8022000,0x8222000);
        $pc2bytes4    = array (0,0x40000,0x10,0x40010,0,0x40000,0x10,0x40010,0x1000,0x41000,0x1010,0x41010,0x1000,0x41000,0x1010,0x41010);
        $pc2bytes5    = array (0,0x400,0x20,0x420,0,0x400,0x20,0x420,0x2000000,0x2000400,0x2000020,0x2000420,0x2000000,0x2000400,0x2000020,0x2000420);
        $pc2bytes6    = array (0,0x10000000,0x80000,0x10080000,0x2,0x10000002,0x80002,0x10080002,0,0x10000000,0x80000,0x10080000,0x2,0x10000002,0x80002,0x10080002);
        $pc2bytes7    = array (0,0x10000,0x800,0x10800,0x20000000,0x20010000,0x20000800,0x20010800,0x20000,0x30000,0x20800,0x30800,0x20020000,0x20030000,0x20020800,0x20030800);
        $pc2bytes8    = array (0,0x40000,0,0x40000,0x2,0x40002,0x2,0x40002,0x2000000,0x2040000,0x2000000,0x2040000,0x2000002,0x2040002,0x2000002,0x2040002);
        $pc2bytes9    = array (0,0x10000000,0x8,0x10000008,0,0x10000000,0x8,0x10000008,0x400,0x10000400,0x408,0x10000408,0x400,0x10000400,0x408,0x10000408);
        $pc2bytes10 = array (0,0x20,0,0x20,0x100000,0x100020,0x100000,0x100020,0x2000,0x2020,0x2000,0x2020,0x102000,0x102020,0x102000,0x102020);
        $pc2bytes11 = array (0,0x1000000,0x200,0x1000200,0x200000,0x1200000,0x200200,0x1200200,0x4000000,0x5000000,0x4000200,0x5000200,0x4200000,0x5200000,0x4200200,0x5200200);
        $pc2bytes12 = array (0,0x1000,0x8000000,0x8001000,0x80000,0x81000,0x8080000,0x8081000,0x10,0x1010,0x8000010,0x8001010,0x80010,0x81010,0x8080010,0x8081010);
        $pc2bytes13 = array (0,0x4,0x100,0x104,0,0x4,0x100,0x104,0x1,0x5,0x101,0x105,0x1,0x5,0x101,0x105);
        $masks = array (4294967295,2147483647,1073741823,536870911,268435455,134217727,67108863,33554431,16777215,8388607,4194303,2097151,1048575,524287,262143,131071,65535,32767,16383,8191,4095,2047,1023,511,255,127,63,31,15,7,3,1,0);
        $iterations = ((strlen($key) >= 24) ? 3 : 1);
        $keys = array ();
        $shifts = array (0, 0, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 1, 0);
        $m=0;
        $n=0;
        for ($j=0; $j<$iterations; $j++) {
            $left = (ord($key{$m++}) << 24) | (ord($key{$m++}) << 16) | (ord($key{$m++}) << 8) | ord($key{$m++});
            $right = (ord($key{$m++}) << 24) | (ord($key{$m++}) << 16) | (ord($key{$m++}) << 8) | ord($key{$m++});
            $temp = (($left >> 4 & $masks[4]) ^ $right) & 0x0f0f0f0f; $right ^= $temp; $left ^= ($temp << 4);
            $temp = (($right >> 16 & $masks[16]) ^ $left) & 0x0000ffff; $left ^= $temp; $right ^= ($temp << -16);
            $temp = (($left >> 2 & $masks[2]) ^ $right) & 0x33333333; $right ^= $temp; $left ^= ($temp << 2);
            $temp = (($right >> 16 & $masks[16]) ^ $left) & 0x0000ffff; $left ^= $temp; $right ^= ($temp << -16);
            $temp = (($left >> 1 & $masks[1]) ^ $right) & 0x55555555; $right ^= $temp; $left ^= ($temp << 1);
            $temp = (($right >> 8 & $masks[8]) ^ $left) & 0x00ff00ff; $left ^= $temp; $right ^= ($temp << 8);
            $temp = (($left >> 1 & $masks[1]) ^ $right) & 0x55555555; $right ^= $temp; $left ^= ($temp << 1);
            $temp = ($left << 8) | (($right >> 20 & $masks[20]) & 0x000000f0);
            $left = ($right << 24) | (($right << 8) & 0xff0000) | (($right >> 8 & $masks[8]) & 0xff00) | (($right >> 24 & $masks[24]) & 0xf0);
            $right = $temp;
            for ($i=0; $i < count($shifts); $i++) {
                if ($shifts[$i] > 0) {
                    $left = (($left << 2) | ($left >> 26 & $masks[26]));
                    $right = (($right << 2) | ($right >> 26 & $masks[26]));
                } else {
                    $left = (($left << 1) | ($left >> 27 & $masks[27]));
                    $right = (($right << 1) | ($right >> 27 & $masks[27]));
                }
                $left = $left & -0xf;
                $right = $right & -0xf;
                $lefttemp = $pc2bytes0[$left >> 28 & $masks[28]] | $pc2bytes1[($left >> 24 & $masks[24]) & 0xf]
                    | $pc2bytes2[($left >> 20 & $masks[20]) & 0xf] | $pc2bytes3[($left >> 16 & $masks[16]) & 0xf]
                    | $pc2bytes4[($left >> 12 & $masks[12]) & 0xf] | $pc2bytes5[($left >> 8 & $masks[8]) & 0xf]
                    | $pc2bytes6[($left >> 4 & $masks[4]) & 0xf];
                $righttemp = $pc2bytes7[$right >> 28 & $masks[28]] | $pc2bytes8[($right >> 24 & $masks[24]) & 0xf]
                    | $pc2bytes9[($right >> 20 & $masks[20]) & 0xf] | $pc2bytes10[($right >> 16 & $masks[16]) & 0xf]
                    | $pc2bytes11[($right >> 12 & $masks[12]) & 0xf] | $pc2bytes12[($right >> 8 & $masks[8]) & 0xf]
                    | $pc2bytes13[($right >> 4 & $masks[4]) & 0xf];
                $temp = (($righttemp >> 16 & $masks[16]) ^ $lefttemp) & 0x0000ffff;
                $keys[$n++] = $lefttemp ^ $temp; $keys[$n++] = $righttemp ^ ($temp << 16);
            }
        }
        return $keys;
    }

    /**
     * @param $sessionInfo
     */
    public function setSession($sessionInfo){
        session(SESSION_ADMIN_ID, $sessionInfo[USER_ADMIN_ID]);
        session(SESSION_ADMIN_USERNAME, $sessionInfo[USER_ADMIN_USERNAME]);
    }
    public function setSessionClear(){
        session(SESSION_ADMIN_ID, null);
        session(SESSION_ADMIN_USERNAME, null);
    }

    public function toStringWithMenuID($targetID){
//        dump($targetID);
        $menuData = $this->getMenuModel()->where(array(MENU_ADMIN_ID => $targetID))->find();
//        dump($menuData);die;
        return '('.$menuData[MENU_ADMIN_ID].')菜单名:'.$menuData[MENU_ADMIN_NAME].'['.$menuData[MENU_ADMIN_URL].'], 上级菜单:'.$this->getCurrentControllerName($menuData[MENU_ADMIN_FATHER]).'('.$menuData[MENU_ADMIN_FATHER].')';
    }
    public function toStringWithSystemInfo(){
        $systemData = $this->getSystemInfo();
        return '('.$systemData[SYSTEM_INFO_NAME].')系统名, 域名:'.$systemData[SYSTEM_INFO_DOMAIN].', ip:['.$systemData[SYSTEM_INFO_IP].'], 关键词:'.$systemData[SYSTEM_INFO_INTRODUCTION].', 前台状态:(1开启, 0关闭)['.$systemData[SYSTEM_INFO_VISIBLE].'], 系统状态:(1开启, 0关闭)['.$systemData[SYSTEM_INFO_OPENED].']';
    }

    public function toStringWithPermissionID($permissionID){
        $permissionData = $this->getPermissionModel()->where(array(PERMISSION_ID => $permissionID))->find();
        $permissionData['menu_name'] = $this->getMenuNameWithID($permissionData[PERMISSION_MENU_ID]);
        return '('.$permissionData[PERMISSION_ID].')'.$permissionData[PERMISSION_NAME].' / '.$permissionData['menu_name'].'['.$permissionData[PERMISSION_MENU_ID].']';
    }

    public function toStringWithGroupID($groupID){
        $groupData = $this->getGroupModel()->where(array(GROUP_ID => $groupID))->find();
        if($groupData[GROUP_TYPE] == 1) $groupData['type_name'] = '前台用户群组';
        else if($groupData[GROUP_TYPE] == 2) $groupData['type_name'] = '后台用户群组';
        return '('.$groupData[GROUP_ID].')'.$groupData[GROUP_NAME].' / '.$groupData['type_name'].'['.$groupData[GROUP_TYPE].']';
    }

    public function toStringWithAuthorityID($authorityID){
        $permissionData = $this->getPermissionModel()->where(array(GROUP_PERMISSION_ID => $authorityID))->find();
        $permissionData['menu_name'] = $this->getMenuNameWithID($permissionData[PERMISSION_MENU_ID]);
        return '('.$permissionData[PERMISSION_ID].')'.$permissionData[PERMISSION_NAME].' / '.$permissionData['menu_name'].'['.$permissionData[PERMISSION_MENU_ID].']';
    }


    /*
     * getter
     */
    public function getClientIP(){
        $ip = get_client_ip();
        return $ip;
    }

    public function getSystemInfo(){
        return $this->getSystemInfoModel()->find();
    }

    public function getSystemName(){
        return $this->getSystemInfoModel()->find()[SYSTEM_INFO_NAME];
    }

    public function getSystemDomain(){
        return $this->getSystemInfoModel()->find()[SYSTEM_INFO_DOMAIN];
    }

    public function getSystemIP(){
        return $this->getSystemInfoModel()->find()[SYSTEM_INFO_IP];
    }


    public function getMenus(){
        $Level0MenuSelectResult = $this->getMenuModel()->where(array(MENU_ADMIN_LEVEL => 0, MENU_ADMIN_VISIBLE => 1))->select();
//        dump($Level0MenuSelectResult);
        for($i = 0; $i < count($Level0MenuSelectResult); $i++){
            $Level0MenuSelectResult[$i]['childMenus'] = $this->getMenuModel()->where(array(MENU_ADMIN_FATHER => $Level0MenuSelectResult[$i][MENU_ADMIN_ID], MENU_ADMIN_VISIBLE => 1))->select();
//            dump($Level0MenuSelectResult[$i]['childMenus']);
//            dump(CONTROLLER_NAME);
            if(CONTROLLER_NAME == $Level0MenuSelectResult[$i][MENU_ADMIN_URL]){
//                dump($Level0MenuSelectResult[$i]);
                for($j = 0; $j < count($Level0MenuSelectResult[$i]['childMenus']); $j++){
//                    dump(ACTION_NAME);
                    if(ACTION_NAME == $Level0MenuSelectResult[$i]['childMenus'][$j][MENU_ADMIN_URL]){
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

    public function getMenuNameWithID($menuID){
        $menuFindResult = $this->getMenuModel()->where(array(MENU_ADMIN_ID => $menuID))->find();
        if($menuFindResult){
            return $menuFindResult[MENU_ADMIN_NAME]."(".$menuFindResult[MENU_ADMIN_URL].")";
        } else {
            return '未知菜单('.$menuID.')';
        }
    }

    public function getUserNameWithID($userID){
        $userFindResult = $this->getUserModel()->where(array(USER_ADMIN_ID => $userID))->find();
        if($userFindResult){
            return $userFindResult[USER_ADMIN_NICKNAME]."(".$userFindResult[USER_ADMIN_USERNAME].")";
        }else{
            return '未知用户('.$userID.')';
        }
    }

    public function getPage($targetModel, $map, $pageSize = 10){
        $model = $targetModel;

        if($map['keyword_type']){
            $condition[$map['keyword_type']] = array('like',"%".$map['keyword']."%");
        }

        $count = $model->where($condition)->count();

        $Page = new \Think\Page($count, $pageSize);


        //分页跳转的时候保证查询条件
        foreach($map as $key=>$val) {
            $Page->parameter[$key]   =   urlencode($val);
        }
//        $Page->setConfig('theme', '<li><a>%totalRow% %header%</a></li> %upPage% %downPage% %first% %prePage% %linkPage% %nextPage% %end% ');
        return $Page;
    }

    public function getActionID($actionName, $controllerName){
        $controllerData = $this->getControllerID($controllerName);
//        dump($controllerData);dump($actionName);
        $menuSelectResult = $this->getMenuModel()->where(array(MENU_ADMIN_URL => $actionName, MENU_ADMIN_FATHER => $controllerData))->find();
//        dump($menuSelectResult);
        return $menuSelectResult[MENU_ADMIN_ID];
    }
    public function getControllerID($controllerName){
        $menuSelectResult = $this->getMenuModel()->where(array(MENU_ADMIN_URL => $controllerName, MENU_ADMIN_LEVEL => 0))->find();
//        dump($menuSelectResult);die;
        return $menuSelectResult[MENU_ADMIN_ID];
    }

    public function getCurrentControllerName($targetControllerURL){
        $menuFindResult = $this->getMenuModel()->where(array(MENU_ADMIN_URL => $targetControllerURL, MENU_ADMIN_LEVEL => 0))->find();
        return $menuFindResult[MENU_ADMIN_NAME];
    }

    public function getCurrentActionName($targetActionURL, $targetControllerURL){
        $controllerFindResult = $this->getMenuModel()->where(array(MENU_ADMIN_URL => $targetControllerURL, MENU_ADMIN_LEVEL => 0))->find();
        $actionFindResult = $this->getMenuModel()->where(array(MENU_ADMIN_URL => $targetActionURL, MENU_ADMIN_LEVEL => 1, MENU_ADMIN_FATHER => $controllerFindResult[MENU_ADMIN_ID]))->find();
        return $actionFindResult[MENU_ADMIN_NAME];
    }

    public function getCurrentUserName(){
        return session(SESSION_ADMIN_USERNAME);
    }

    public function getCurrentUserID(){
        return session(SESSION_ADMIN_ID);
    }

    public function getCurrentDateTime(){
        return date(FORMAT_DATE, NOW_TIME);
    }

    public function getDatabaseFields($targetDatabase){
        $model = $targetDatabase;
        $fields = $model->getDBFields();
        return $fields;
    }

    public function getLogModel(){
        return M(DB_LOG);
    }
    public function getMenuModel(){
        return M(DB_MENU);
    }
    public function getUserModel(){
        return M(DB_USER);
    }
    public function getSystemInfoModel(){
        return M(DB_SYSTEM);
    }
    public function getPermissionModel(){
        return M(DB_PERMISSION);
    }
    public function getGroupModel(){
        return M(DB_GROUP);
    }
    public function getAuthorityModel(){
        return M(DB_AUTHORITY);
    }
}