//
//  Systems.swift
//  JingJianLogistics-iOS
//
//  Created by SilversRayleigh on 17/8/15.
//  Copyright (c) 2015 qi-cloud.com. All rights reserved.
//

import UIKit

func SCREEN_FRAME() -> CGRect {
    return (UIScreen.mainScreen().bounds)
}
func SCREEN_WIDTH() -> CGFloat {
    return SCREEN_FRAME().size.width
}
func SCREEN_HEIGHT() -> CGFloat {
    return SCREEN_FRAME().size.height
}

let APPDELEGATE = UIApplication.sharedApplication().delegate as! AppDelegate
let KEYWINDOW = APPDELEGATE.window!

extension String {
    func length() -> Int {
        return count(self)
    }
    func md5() -> String {
        let str = self.cStringUsingEncoding(NSUTF8StringEncoding)
        let strLen = CUnsignedInt(self.lengthOfBytesUsingEncoding(NSUTF8StringEncoding))
        let digestLen = Int(CC_MD5_DIGEST_LENGTH)
        let result = UnsafeMutablePointer<CUnsignedChar>.alloc(digestLen)
        CC_MD5(str!, strLen, result)
        var hash = NSMutableString()
        for i in 0..<digestLen {
            hash.appendFormat("%02x", result[i])
        }
        result.destroy()
        return String(format: hash as String)
    }
}
extension Character {
    func toInt() -> Int {
        var intFromCharacter:Int = 0
        for i in String(self).utf8
        {
            intFromCharacter = Int(i)
        }
        return intFromCharacter
    }
}
extension UIApplication {
    func mainWindow() -> UIWindow {
        return (self.delegate as! AppDelegate).window!
    }
}
extension CGRect {
    static func screenFrame() -> CGRect {
        return UIScreen.mainScreen().bounds
    }
}
extension CGFloat {
    static func screenHeight() -> CGFloat {
        return CGRect.screenFrame().height
    }
    static func screenWidth() -> CGFloat {
        return CGRect.screenFrame().width
    }
}
extension NSString {
    func md5() -> NSString {
        return NSString(string: String(self).md5())
    }
}
extension UIColor {
    //MARK: - UIColor
    static func RGBA (red r:CGFloat, green g:CGFloat, blue b:CGFloat, alpha a:CGFloat) -> UIColor {
        return UIColor(red: (r / 255.0), green: (g / 255.0), blue: (b / 255.0), alpha: a)
    }
    static func RGB (red r: CGFloat, green g: CGFloat, blue b: CGFloat) -> UIColor {
        return UIColor.RGBA(red: r, green: g, blue: b, alpha:1)
    }
    static func colorWithHexAndAlpha(hex h: Int, alpha a: CGFloat) -> UIColor {
        var red = (CGFloat(((h & 0xFF0000) >> 16)) / 255.0)
        var green = (CGFloat(((h & 0xFF00) >> 8)) / 255.0)
        var blue = (CGFloat((h & 0xFF)) / 255.0)
        return UIColor.RGBA(red: red, green: green, blue: blue, alpha: a)
    }
    static func colorWithHex(hex h: Int) -> UIColor {
        return UIColor.colorWithHexAndAlpha(hex: h, alpha: 1)
    }
}
extension UITextField {
    func isEmpty() -> Bool {
        if count(self.text) == 0 || count(self.text) < 1 {
            return true
        } else {
            return false
        }
    }
    func lengthOfContent() -> Int {
        return count(self.text)
    }
}
extension UIView {
    func frameHeight() -> CGFloat {
        return self.frame.size.height
    }
    func frameWidth() -> CGFloat {
        return self.frame.size.width
    }
    func xCoordinator() -> CGFloat {
        return self.frame.origin.x
    }
    func yCoordinator() -> CGFloat {
        return self.frame.origin.y
    }
    func centerRect(widthOfSubView sWidth: CGFloat, heightOfSubView sHeight: CGFloat) -> CGRect {
        var x: CGFloat = (self.frameWidth() - sWidth) / 2
        var y: CGFloat = (self.frameHeight() - sHeight) / 2
        return CGRect(x: x, y: y, width: sWidth, height: sHeight)
    }
    
}