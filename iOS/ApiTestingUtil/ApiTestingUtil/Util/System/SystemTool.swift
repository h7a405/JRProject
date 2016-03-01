//
//  System.swift
//  JZAppFramework
//
//  Created by Jason Lee on 16/01/08.
//  Copyright © 2016年 CZLee. All rights reserved.
//

import UIKit

enum System_Version {
    case iOS_5
    case iOS_6
    case iOS_7
    case iOS_8
    case iOS_9
    case Other
    
    static var iOSVersion: Float {
        return Float(UIDevice.currentDevice().systemVersion)!
    }
    
    var floatValue: Float {
        switch self {
        case .iOS_5:
            return 5.0
        case .iOS_6:
            return 6.0
        case .iOS_7:
            return 7.0
        case .iOS_8:
            return 8.0
        case .iOS_9:
            return 9.0
        default:
            return 0
        }
    }
    
    static func getVersionWithFloatValue(floatValue: Float) -> System_Version {
        if floatValue == 5.0 {
            return self.iOS_5
        } else if floatValue == 6.0 {
            return self.iOS_6
        } else if floatValue == 7.0 {
            return self.iOS_7
        } else if floatValue == 8.0 {
            return self.iOS_8
        } else if floatValue == 9.0 {
            return self.iOS_9
        } else {
            return self.Other
        }
    }
    
    static var is_iOS_5: Bool {
        if System_Version.iOSVersion < self.iOS_6.floatValue && System_Version.iOSVersion >= self.iOS_5.floatValue {
            return true
        } else {
            return false
        }
    }
    static var is_iOS_6: Bool {
        if System_Version.iOSVersion < self.iOS_7.floatValue && System_Version.iOSVersion >= self.iOS_6.floatValue {
            return true
        } else {
            return false
        }
    }
    static var is_iOS_7: Bool {
        if System_Version.iOSVersion < self.iOS_8.floatValue && System_Version.iOSVersion >= self.iOS_7.floatValue {
            return true
        } else {
            return false
        }
    }
    static var is_iOS_8: Bool {
        if System_Version.iOSVersion < self.iOS_9.floatValue && System_Version.iOSVersion >= self.iOS_8.floatValue {
            return true
        } else {
            return false
        }
    }
    static var is_iOS_9: Bool {
        if System_Version.iOSVersion >= self.iOS_9.floatValue {
            return true
        } else {
            return false
        }
    }
    static var is_iOS_5_later: Bool {
        if System_Version.iOSVersion >= self.iOS_5.floatValue {
            return true
        } else {
            return false
        }
    }
    static var is_iOS_6_later: Bool {
        if System_Version.iOSVersion >= self.iOS_6.floatValue {
            return true
        } else {
            return false
        }
    }
    static var is_iOS_7_later: Bool {
        if System_Version.iOSVersion >= self.iOS_7.floatValue {
            return true
        } else {
            return false
        }
    }
    static var is_iOS_8_later: Bool {
        if System_Version.iOSVersion >= self.iOS_8.floatValue {
            return true
        } else {
            return false
        }
    }
    static var is_iOS_9_later: Bool {
        if System_Version.iOSVersion >= self.iOS_9.floatValue {
            return true
        } else {
            return false
        }
    }
}

class SystemTool {
    //MARK: - Open URL 集成
    class func dial(toPhoneNumber phone: String) {
        let url = NSURL(string: "tel://\(phone)")
        Log.VLog("\(url ?? "")")
        UIApplication.sharedApplication().openURL(url!)
    }
    class func sms(toPhoneNumber phone: String) {
        let url = NSURL(string: "sms://\(phone)")
        Log.VLog("\(url ?? "")")
        UIApplication.sharedApplication().openURL(url!)
    }
    class func browse(toURL theUrl: String) {
        let url = NSURL(string: theUrl)
        Log.VLog("\(url ?? "")")
        UIApplication.sharedApplication().openURL(url!)
    }
    class func mail(toAddress theAddress: String) {
        let url = NSURL(string: "mailto:\(theAddress)")
        Log.VLog("\(url ?? "")")
        UIApplication.sharedApplication().openURL(url!)
    }
}
