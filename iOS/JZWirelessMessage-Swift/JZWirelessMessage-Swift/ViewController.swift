//
//  ViewController.swift
//  JZWirelessMessage-Swift
//
//  Created by Jason.Chengzi on 16/01/27.
//  Copyright © 2016年 WeSwift. All rights reserved.
//

//MARK: - 类注释
/*
*
*/

//MARK: - 类描述
///

//MARK: - 头文件
import UIKit
import CocoaAsyncSocket

//MARK: - class函数
class ViewController: UIViewController {
    //MARK: 储存变量 - Int/Float/Double/String
    
    //MARK: 集合类型 - Array/Dictionary/Tuple
    
    //MARK: 自定义类型 - Custom
    
    //MARK: UIView子类 - UIView/UIControl/UIViewController
    
    //MARK: Foundation - NS/CG/CA
    
    //MARK: 计算变量
    
    //MARK: 闭包与结构体 - Closure/Struct
    
    //MARK: 代理与数据源 - delegate/datasource
    
    //MARK: 重用 - Override/Required/Convenience
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
//MARK: - 拓展
//MARK: 初始化与配置 - Initailize & Setup

//MARK: 操作与执行 - Action & Operation

//MARK: 更新 - Update

//MARK: 判断 - Judgement

//MARK: 响应方法 - Selector

//MARK: 回调 - Call back

//MARK: 数据源与代理 - DataSrouce & Delegate
extension ViewController: AsyncSocketDelegate {
    func onSocket(sock: AsyncSocket!, didConnectToHost host: String!, port: UInt16) {
        Log.VLog("已连接。")
    }
    func onSocket(sock: AsyncSocket!, didReadData data: NSData!, withTag tag: Int) {
        let dataString = String(NSString(data: data, encoding: NSUTF8StringEncoding))
        Log.VLog("收到消息：\(dataString)")
    }
}
//MARK: 设置 - Setter

//MARK: 获取 - Getter

//MARK: - 其他
//MARK: 协议  -   Protocol

//MARK: 枚举  -   Enumeration