//
//  AFNetworkingHelper.swift
//  JZAppFramework
//
//  Created by Jason Lee on 16/01/08.
//  Copyright © 2016年 CZLee. All rights reserved.
//
//MARK: - 类注释
/*
 *
 */

//MARK: - 头文件
import UIKit
import AFNetworking

@objc protocol AFNetworkingHelperProtocol: NSObjectProtocol {
    func succeededWithResponseObject(responseObject: AnyObject!)
    func failedWithError(error: NSError!)
}
//MARK: - class函数
class AFNetworkingHelper: NSObject {
    //MARK: UIKit - UIView/UIControl/UIViewController
    
    //MARK: 储存变量 - Int/Float/Double/String
    
    //MARK: 集合类型 - Array/Dictionary/Tuple
    
    //MARK: 自定义变量
    
    //MARK: 计算变量
    
    //MARK: 闭包与结构体 - Closure/Struct
    
    //MARK: 代理与数据源 - Delegate/Datasource
    var delegate: AFNetworkingHelperProtocol?
    
    //MARK: 重写 - Override/Required/Convenience
    override init() {
        super.init()
    }
    
    convenience init(delegate: AFNetworkingHelperProtocol?) {
        self.init()
        self.delegate = delegate
    }
}
//MARK: - 拓展
//MARK: 初始化与配置 - Initailize & Setup

//MARK: 操作与执行 - Action & Operation
extension AFNetworkingHelper {
    func postWithURL(url: String!, andParameters parameters: [String: AnyObject]? = nil) {
        
        let configuration = NSURLSessionConfiguration.defaultSessionConfiguration()
        
        configuration.timeoutIntervalForRequest = 60
        
        let session = AFHTTPSessionManager(sessionConfiguration: configuration)
        
        session.responseSerializer.acceptableContentTypes = ["application/json", "text/html", "text/json"]
        
        session.POST(
            url,
            parameters: parameters,
            progress: nil,
            success: {
                (sessionDataTask: NSURLSessionDataTask, responseObject: AnyObject?) -> Void in
                self.responseWithSuccess(responseObject)
            } ,failure: {
                (sessionDataTask: NSURLSessionDataTask?, responseError: NSError) -> Void in
                self.responseWithFailure(responseError)
        })
    }
}

//MARK: 判断 - Judgement

//MARK: 选择器 - Selector

//MARK: 回调 - Call back
extension AFNetworkingHelper {
    func responseWithSuccess(responseObject: AnyObject!) {
        self.delegate?.succeededWithResponseObject(responseObject)
    }
    func responseWithFailure(error: NSError!) {
        self.delegate?.failedWithError(error)
    }
}
//MARK: 数据源与代理 - DataSrouce/Delegate

//MARK: Getter/Setter