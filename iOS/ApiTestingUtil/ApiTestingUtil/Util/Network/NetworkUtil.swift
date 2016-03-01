//
//  NetworkUtil.swift
//  JZAppFrameworkDemo
//
//  Created by Jason Lee on 16/01/18.
//  Copyright © 2016年 weSwift. All rights reserved.
//

//MARK: - 类注释
/*
*
*/

//MARK: - 类描述
///

//MARK: - 头文件
import UIKit
import Alamofire

//MARK: - class函数
class NetworkUtil: NSObject {
    //MARK: 储存变量 - Int/Float/Double/String
    
    //MARK: 集合类型 - Array/Dictionary/Tuple
    
    //MARK: 自定义类型 - Custom
    
    //MARK: UIView子类 - UIView/UIControl/UIViewController
    
    //MARK: Foundation - NS/CG/CA
    
    //MARK: 计算变量
    
    //MARK: 闭包与结构体 - Closure/Struct
    
    //MARK: 代理与数据源 - delegate/datasource
    
    //MARK: 枚举 - Enumeration
    
    //MARK: 重用 - Override/Required/Convenience
    
}
//MARK: - 拓展
//MARK: 初始化与配置 - Initailize & Setup

//MARK: 操作与执行 - Action & Operation
extension NetworkUtil {
    ///Post方法。参数：url地址，提交的参数
    func postWith(URLString: String!, parameters: [String : AnyObject]? = nil) {
        Alamofire.request(
            .POST,
            URLString,
            parameters: parameters
            ).validate()
            .responseJSON {
                (responseObject: Response<AnyObject, NSError>) -> Void in
                self.handlingResponseData(responseObject)
        }
    }
    ///Get方法。参数：url地址，提交的参数
    func getWith(URLString: String!, parameters: [String : AnyObject]? = nil) {
        Alamofire.request(
            .GET,
            URLString,
            parameters: parameters
            ).validate()
            .responseJSON {
                (responseObject: Response<AnyObject, NSError>) -> Void in
                self.handlingResponseData(responseObject)
        }
    }
    ///Upload单个文件数据方法。
    func uploadWith(URLString: String!, data: NSData, parameters: [String : AnyObject]? = nil, respondingClosure: ((totalBytesWritten: Int64)->Void)? = nil) {
        Alamofire.upload(
            .POST,
            URLString,
            data: data
            ).validate()
            .progress {
                (bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) -> Void in
                Log.VLog("bytesWritten: \(bytesWritten)\ntotalBytesWritten: \(totalBytesWritten)\ntotalBytesExpectedToWrite: \(totalBytesExpectedToWrite)", logType: LogType.Network)
                if respondingClosure != nil {
                    dispatch_async(dispatch_get_main_queue()) {
                        respondingClosure!(totalBytesWritten: totalBytesWritten)
                    }
                }
            }.responseJSON {
                (responseObject: Response<AnyObject, NSError>) -> Void in
                self.handlingResponseData(responseObject)
        }
    }
    
    ///返回数据的处理
    func handlingResponseData(responseObject: Response<AnyObject, NSError>) {
        Log.VLog("请求结果： \(responseObject.result)\n请求对象： \(responseObject.request)\n响应对象： \(responseObject.response)\n服务端返回的数据： \(responseObject.data)", logType: LogType.Network)
        
        switch responseObject.result {
        case .Success:
            self.handlingSucceeded(responseObject.result.value)
        case .Failure:
            self.handlingFailed(responseObject.result.error)
        }
    }
    
    //成功时的调用方法
    func handlingSucceeded(responseData: AnyObject?) {
        guard let _ = responseData else {
            self.handlingFailed(NSError(domain: "没有数据", code: 0, userInfo: nil))
            return
        }
        
    }
    //失败时的调用方法
    func handlingFailed(error: NSError?) {
        Log.VLog("错误信息：\(error)", logType: LogType.Network)
    }
}
//MARK: 判断 - Judgement

//MARK: 响应方法 - Selector

//MARK: 回调 - Call back

//MARK: 数据源与代理 - DataSrouce & Delegate

//MARK: 设置 - Setter

//MARK: 获取 - Getter

//MARK: - 其他
//MARK: 协议 - Protocol

//MARK: 枚举 - Enumeration