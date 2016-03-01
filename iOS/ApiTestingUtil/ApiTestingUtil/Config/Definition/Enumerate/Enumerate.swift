//
//  Enumerate.swift
//  JZAppFramework
//
//  Created by Jason Lee on 15/12/24.
//  Copyright © 2015年 CZLee. All rights reserved.
//

import Foundation

//MARK: - 用户相关 - User
//MARK: 用户登陆状态 - Status
///
enum UserStatus {
    case NotLoggedIn
    case LoggedIn
    case Other
}

enum TestingStatus {
    case Prepared
    case Loaded
    case Loading
    case LoadedFailure
    case Running
    case Holding
    case Abort
    case Finished
    
    var stringValue: String {
        switch self {
        case .Prepared:
            return "已准备就绪，请加载数据。"
        case .Loaded:
            return "加载成功，可以随时开始"
        case .Loading:
            return "开始解析并加载数据……"
        case .LoadedFailure:
            return "加载失败，请检查数据格式"
        case .Running:
            return "开始解析数据……"
        case .Holding:
            return "挂起等待中……"
        case .Abort:
            return "已中止。"
        case .Finished:
            return "已结束。"
        }
    }
}