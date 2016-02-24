//
//  TestUtil.swift
//  JZAppFrameworkDemo
//
//  Created by Jason.Chengzi on 16/02/01.
//  Copyright © 2016年 weSwift. All rights reserved.
//

import UIKit

class TestUtil {
    class func measure(title: String!, call: () -> Void) {
        let startTime = CACurrentMediaTime()
        call()
        let endTime = CACurrentMediaTime()
        if let title = title {
            print("\(title): ")
        }
        print("Time - \(endTime - startTime)")
    }
}
