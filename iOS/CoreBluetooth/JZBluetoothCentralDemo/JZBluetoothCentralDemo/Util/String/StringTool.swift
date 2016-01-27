//
//  StringTool.swift
//  XiaoFeiXia
//
//  Created by Jason.Chengzi on 16/01/08.
//  Copyright © 2016年 HVIT. All rights reserved.
//

import UIKit

class StringTool {
    //MARK: - 获取字符串尺寸
    class func getContentSize(content: String, andFont font: UIFont) -> CGSize {
        let sizeOfContent: CGSize = NSString(string: content).sizeWithAttributes([NSFontAttributeName: font])
        return sizeOfContent
    }
    //MARK: 获取字符串高度
    class func getContentHeight(content: String, andFont font: UIFont, andWidth width: CGFloat) -> CGFloat {
        let sizeOfContent: CGSize = StringTool.getContentSize(content, andFont: font)
        let heightOfContent: CGFloat = sizeOfContent.width / width
        return heightOfContent
    }
}
