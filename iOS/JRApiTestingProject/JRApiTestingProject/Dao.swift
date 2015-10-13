//
//  DaoEntity.swift
//  JingJianLogistics-iOS
//
//  Created by SilversRayleigh on 24/8/15.
//  Copyright (c) 2015 qi-cloud.com. All rights reserved.
//

import UIKit

class Dao {
    
    class func post(url: String, callBack: ((NSDictionary?)->Void)) {
        SVProgressHUD.show()
        var manager = AFHTTPRequestOperationManager()
//        manager.requestSerializer = AFJSONRequestSerializer()
//        manager.responseSerializer = AFJSONResponseSerializer()
        manager.POST(url, parameters: NSNull(), success: {(operation: AFHTTPRequestOperation!, responseObject: AnyObject!) in
            var dic = NSDictionary(dictionary: (responseObject as! NSDictionary))
            Dao.toStringWithResponseData(dic, error: nil)
            callBack(dic)
            }, failure: {(operation: AFHTTPRequestOperation!, error: NSError!) in
                Dao.toStringWithResponseData(nil, error: error)
                callBack(nil)
        })
    }
    
    class func get(url: String, callBack: ((NSDictionary?)->Void)) {
        SVProgressHUD.show()
        var manager = AFHTTPRequestOperationManager()
//        manager.requestSerializer = AFJSONRequestSerializer()
//        manager.responseSerializer = AFJSONResponseSerializer()
        manager.GET(url, parameters: NSNull(), success: {(operation: AFHTTPRequestOperation!, responseObject: AnyObject!) in
            var dic = NSDictionary(dictionary: (responseObject as! NSDictionary))
            Dao.toStringWithResponseData(dic, error: nil)
            callBack(dic)
            }, failure: {(operation: AFHTTPRequestOperation!, error: NSError!) in
                Dao.toStringWithResponseData(nil, error: error)
                callBack(nil)
        })
    }
    
    class func post(url: String, andParameters parameters: NSDictionary, callBack: ((NSDictionary?)->Void)) {
        SVProgressHUD.show()
        var manager = AFHTTPRequestOperationManager()
//        manager.requestSerializer = AFJSONRequestSerializer()
//        manager.responseSerializer = AFJSONResponseSerializer()
        manager.responseSerializer.acceptableContentTypes = NSSet(object: "text/plain") as Set<NSObject>
        manager.POST(url, parameters: parameters, success: {(operation: AFHTTPRequestOperation!, responseObject: AnyObject!) in
            var dic = NSDictionary(dictionary: (responseObject as! NSDictionary))
            Dao.toStringWithResponseData(dic, error: nil)
            callBack(dic)
            }, failure: {(operation: AFHTTPRequestOperation!, error: NSError!) in
                Dao.toStringWithResponseData(nil, error: error)
                callBack(nil)
        })
    }
    
    class func get(url: String, andParameters parameters: NSDictionary, callBack: ((NSDictionary?)->Void)) {
        SVProgressHUD.show()
        var manager = AFHTTPRequestOperationManager()
//        manager.requestSerializer = AFJSONRequestSerializer()
//        manager.responseSerializer = AFJSONResponseSerializer()
        manager.GET(url, parameters: parameters, success: {(operation: AFHTTPRequestOperation!, responseObject: AnyObject!) in
            var dic = NSDictionary(dictionary: (responseObject as! NSDictionary))
            Dao.toStringWithResponseData(dic, error: nil)
            callBack(dic)
            }, failure: {(operation: AFHTTPRequestOperation!, error: NSError!) in
                Dao.toStringWithResponseData(nil, error: error)
                callBack(nil)
        })
    }
    
    class func requestWithoutParamters() {
        
    }
    
    class func requestWithParamters() {
        
    }
    
    class func toStringWithResponseData(dic: NSDictionary?, error: NSError?) {
        SVProgressHUD.dismiss()
        if (dic != nil) {
//            Log.DLog("请求返回的数据：\(dic)")
            var (status, message) = (dic!.objectForKey("status") as! Int, dic!.objectForKey("message") as! String)
            Log.VLog("服务器返回数据：(status: \(status), message: \(message))")
            var data: AnyObject? = dic!.objectForKey("data")
            Log.VLog("Data:\(data)")
        } else {
            Log.VLog("网络请求失败。\(error)")
        }
    }
}
