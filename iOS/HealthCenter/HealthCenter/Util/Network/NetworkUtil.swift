//
//  NetworkUtil.swift
//  JZAppFrameworkDemo
//
//  Created by Jason.Chengzi on 16/01/18.
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
    enum imageType {
        case PNG
        case JPG
    }
    //MARK: 重用 - Override/Required/Convenience
    
}
//MARK: - 拓展
//MARK: 初始化与配置 - Initailize & Setup

//MARK: 操作与执行 - Action & Operation
extension NetworkUtil {
    /*
    *   方法名：postWithURL
    *   描述：HTTP的POST请求方法
    *   参数：url - 请求URL地址
            parameters - POST提交的数据
            callbackClosure - 请求完成时的回调闭包
            updatingClosure - 请求进度更新时的回调闭包
    */
    func postWithURL(
        url: String,
        andParameters parameters: [String : AnyObject]? = nil,
        andCallbackClosure callbackClosure: CallbackClosure? = nil,
        andProgressUpdatingClosure updatingClosure: UpdatingClosure? = nil) {
            Alamofire.request(
                .POST,
                url,
                parameters: parameters
                ).validate().progress{
                    (bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) -> Void in
                    debugPrint("bytesWritten: \(bytesWritten)")
                    debugPrint("totalBytesWritten: \(totalBytesWritten)")
                    debugPrint("totalBytesExpectedToWrite: \(totalBytesExpectedToWrite)")
                    if let closure = updatingClosure  {
                        dispatch_async(dispatch_get_main_queue()) {
                            //在主线程执行更新闭包
                            closure(bytesWritten: bytesWritten, totalBytesWritten: totalBytesWritten, totalBytesExpectedToWrite: totalBytesExpectedToWrite)
                        }
                    }
                }.responseJSON {
                    (responseResult: Response<AnyObject, NSError>) -> Void in
                    //HTTP状态不为200为失败。
                    if responseResult.result.isSuccess {
                        debugPrint("状态：\(responseResult.response?.statusCode)")
                        debugPrint("返回数据：\(responseResult.result.value)")
                        if let responseObject = responseResult.result.value {
                            
                        } else {
                            debugPrint("返回异常：没有任何数据。")
                        }
                    } else {
                        debugPrint("请求错误：\(responseResult.result.error)")
                    }
            }
    }

    /*
    *   方法名：getWithURL
    *   描述：HTTP的GET请求方法
    *   参数：url - 请求URL地址
            parameters - POST提交的数据
            callbackClosure - 请求完成时的回调闭包
            updatingClosure - 请求进度更新时的回调闭包
    */
    func getWithURL(
        url: String,
        andParameters parameters: [String : AnyObject]? = nil,
        andCallbackClosure callbackClosure: CallbackClosure? = nil,
        andProgressUpdatingClosure updatingClosure: UpdatingClosure? = nil) {
            
            Alamofire.request(
                .GET,
                url,
                parameters: parameters
                ).validate().progress {
                    (bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) -> Void in
                    debugPrint("bytesWritten: \(bytesWritten)")
                    debugPrint("totalBytesWritten: \(totalBytesWritten)")
                    debugPrint("totalBytesExpectedToWrite: \(totalBytesExpectedToWrite)")
                    if let closure = updatingClosure  {
                        
                        dispatch_async(dispatch_get_main_queue()) {
                            closure(bytesWritten: bytesWritten, totalBytesWritten: totalBytesWritten, totalBytesExpectedToWrite: totalBytesExpectedToWrite)
                        }
                    }
                }.responseJSON {
                    (responseResult: Response<AnyObject, NSError>) -> Void in
                    if responseResult.result.isSuccess {
                        debugPrint("状态：\(responseResult.response?.statusCode)")
                        debugPrint("返回数据：\(responseResult.result.value)")
                    } else if responseResult.result.isFailure {
                        debugPrint("请求错误：\(responseResult.result.error)")
                    }
            }
    }
    /*
    *   方法名：uploadFileWithURL
    *   描述：HTTP上传单个文件
    *   参数：url - 请求URL地址
            fileURL - 上传的文件路径
            callbackClosure - 请求完成时的回调闭包
            updatingClosure - 请求进度更新时的回调闭包
    */
    func uploadFileWithURL(
        url: String,
        andFileURL fileURL: NSURL,
        andCallbackClosure callbackClosure: CallbackClosure? = nil,
        andProgressUpdatingClosure updatingClosure: UpdatingClosure? = nil) {
            Alamofire.upload(.POST, url, file: fileURL).progress { bytesWritten, totalBytesWritten, totalBytesExpectedToWrite in
                debugPrint("bytesWritten: \(bytesWritten)")
                debugPrint("totalBytesWritten: \(totalBytesWritten)")
                debugPrint("totalBytesExpectedToWrite: \(totalBytesExpectedToWrite)")
                if let closure = updatingClosure  {
                    
                    dispatch_async(dispatch_get_main_queue()) {
                        closure(bytesWritten: bytesWritten, totalBytesWritten: totalBytesWritten, totalBytesExpectedToWrite: totalBytesExpectedToWrite)
                    }
                }
                }.responseJSON { (responseResult: Response<AnyObject, NSError>) -> Void in
                    if responseResult.result.isSuccess {
                        debugPrint("状态：\(responseResult.response?.statusCode)")
                        debugPrint("返回数据：\(responseResult.result.value)")
                    } else if responseResult.result.isFailure {
                        debugPrint("请求错误：\(responseResult.result.error)")
                    }
            }
    }
    func uploadDataWithURL(url: String, andData data: NSData, andCallbackClosure callbackClosure: CallbackClosure, andUpdatingClosure updatingClosure: UpdatingClosure) {
        //FIXME: To finished.
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
typealias CallbackClosure = (responseObject: [String : AnyObject]?, responseError: NSError?, responseExeception: String?)->Void
typealias UpdatingClosure = (bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64)->Void
//MARK: 协议 - Protocol

//MARK: 枚举 - Enumeration