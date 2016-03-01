//
//  CoreAnimationExtension.swift
//  JZAppFramework
//
//  Created by Jason Lee on 15/12/29.
//  Copyright © 2015年 CZLee. All rights reserved.
//

import UIKit

//MARK: - Control
//MARK: CALayer
extension CALayer {
    //CGColor转UIColor
    func borderUIColor() -> UIColor? {
        return borderColor != nil ? UIColor(CGColor: borderColor!) : nil
    }
    //UIColor转CGColor
    func setBorderUIColor(color: UIColor) {
        borderColor = color.CGColor
    }
}