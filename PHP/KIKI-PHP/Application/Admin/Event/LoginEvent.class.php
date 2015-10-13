<?php
/**
 * Created by PhpStorm.
 * User: OrinJay
 * Date: 2015/8/4 0004
 * Time: 21:29
 */

namespace Admin\Event;

class LoginEvent extends BaseEvent{
    public function doSignIn($userData){
        if($this->getSessionEvent()->isSessionExist()){
            $failed[IS_SIGNED_IN_SUCCESS] = NO;
            $failed[ERROR] = 'Already signed in, do not resign.';
            return $failed;
        } else {
            if($this->getUserEvent()->isUserExistWithUserName($userData['username'], USER_TYPE_ADMIN)){
                $userID = $this->getUserEvent()->getUserIDWithUsername($userData[USERNAME], USER_TYPE_ADMIN);
                $salt = $this->getUserEvent()->getDecodedUserSaltWithUserID($userID, USER_TYPE_ADMIN);
                $password = $this->getUserEvent()->getPasswordWithUserID($userID, USER_TYPE_ADMIN);
                $encodedPassword = $this->getEncryptEvent()->encrypt($userData[PASSWORD], $salt);
                if($encodedPassword == $password){
                    $lastLogin[ADMIN_LAST_IP] = $this->getIP();
                    $lastLogin[ADMIN_LAST_DATE] = $this->getCurrentDateTime();
                    $lastLogin[ADMIN_ID] = $userID;
                    $this->getDBEvent()->updateAdmin($lastLogin);
                    $sessionData[SESSION_ADMIN_ID] = $userID;
                    $sessionData[SESSION_ADMIN_USERNAME] = $userData['username'];
                    $this->getSessionEvent()->setSessionWithType(USER_TYPE_ADMIN, $sessionData);
                    $this->getLogEvent()->doWriteLoginLog('Success login on '.$lastLogin[ADMIN_LAST_DATE].' and ip:'.$lastLogin[ADMIN_LAST_IP].' with username:'.$userData['username']);
                    $success[IS_SIGNED_IN_SUCCESS] = YES;
                    $success[SUCCESS] = 'Login success';
                    $success[DIRECT_TO] = U('Index/index');
                    return $success;
                } else {
                    $failed[IS_SIGNED_IN_SUCCESS] = NO;
                    $failed[ERROR] = 'Wrong Username or Password. Please recheck.';
                    $this->getLogEvent()->doWriteLoginLog('Wrong password attempt with username:'.$userData['username']);
                    return $failed;
                }
            } else {
                $failed[IS_SIGNED_IN_SUCCESS] = NO;
                $failed[ERROR] = 'Username does not exist. Please recheck.';
                return $failed;
            }
        }
    }
    public function isSignedIn(){
        if(!$this->getSessionEvent()->isSessionExist())
            return false;
        else
            return true;
    }

    public function getSessionEvent(){
        return new SessionEvent();
    }
}

class SessionEvent{
    public function isSessionExist(){
        return session('?'.SESSION_ADMIN_ID);
    }
    public function setSessionCleaned(){
        session(null);
    }
    public function setSessionWithType($type, $data){
        if($type == USER_TYPE_ADMIN){
            session(SESSION_ADMIN_ID, $data[SESSION_ADMIN_ID]);
            session(SESSION_ADMIN_USERNAME, $data[SESSION_ADMIN_USERNAME]);
        }
    }
}