//
//  ViewTool.swift
//  XiaoFeiXia
//
//  Created by Jason.Chengzi on 16/01/08.
//  Copyright © 2016年 HVIT. All rights reserved.
//

import UIKit

class ViewTool {
    //MARK: 设置避免navigationBar遮挡
    class func setNavigationBarUncovered(viewController: UIViewController) {
        if System_Version.is_iOS_7_later {
            viewController.edgesForExtendedLayout = UIRectEdge.None
            viewController.extendedLayoutIncludesOpaqueBars = false
            viewController.modalPresentationCapturesStatusBarAppearance = false
        }
    }
}
