//
//  UIKitExtension.swift
//  JZAppFramework
//
//  Created by Jason Lee on 15/12/24.
//  Copyright © 2015年 CZLee. All rights reserved.
//

import UIKit

//MARK: - UIBarItem
//MARK: UIBarButtonItem
//MARK: UITabBarItem
//MARK: - UIColor
extension UIColor {
    class func colorWithRed(red: CGFloat, green: CGFloat, blue: CGFloat, andAlpha alpha: CGFloat) -> UIColor {
        return UIColor(red: (red / 255.0), green: (green / 255.0), blue: (blue / 255.0), alpha: alpha)
    }
    class func colorWithRed(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
        return UIColor.colorWithRed(red, green: green, blue: blue, andAlpha: 1)
    }
    class func colorWithHex(hex h: Int, andAlpha alpha: CGFloat) -> UIColor {
        let red = (CGFloat(((h & 0xFF0000) >> 16)) / 255.0)
        let green = (CGFloat(((h & 0xFF00) >> 8)) / 255.0)
        let blue = (CGFloat((h & 0xFF)) / 255.0)
        return UIColor.colorWithRed(red, green: green, blue: blue, andAlpha: alpha)
    }
    class func colorWithHex(hex h: Int) -> UIColor {
        return UIColor.colorWithHex(hex: h, andAlpha: 1)
    }
    class func silverColor() -> UIColor {
        return UIColor.colorWithHex(hex: 0xC0C0C0)
    }
    class func skyBlueColor() -> UIColor {
        return UIColor.colorWithHex(hex: 0x87CEFA)
    }
    class func _66CCFF() -> UIColor {
        return UIColor.colorWithHex(hex: 0x66CCFF)
    }
}
//MARK: - UIDevice
//MARK: - UIEvent
//MARK: - UIFont
//MARK: - UIGestureRecognizer
//MARK: UILongPressGestureRecognizer
//MARK: UIPanGestureRecognizer
//MARK: UIPinchGestureRecognizer
//MARK: UIRotationGestureRecognizer
//MARK: UISwipeGestureRecognizer
//MARK: UITapGestureRecognizer
//MARK: - UIImage
//MARK: - UIMenuController
//MARK: - UIMenuItem
//MARK: - UINavigationItem
//MARK: - UINib
//MARK: - UIPasteBoard
//MARK: - UIPopoverController
//MARK: - UIResponder
//MARK: UIApplication
//MARK: UIView
extension UIView {
    var viewX : CGFloat { get {return self.frame.origin.x} set(newX) {self.frame.origin.x = newX} }
    var viewY : CGFloat { get {return self.frame.origin.y} set(newY) {self.frame.origin.y = newY} }
    var viewWidth : CGFloat { get {return self.frame.size.width} set(newWidth) {self.frame.size.width = newWidth} }
    var viewHeight: CGFloat { get {return self.frame.size.height} set(newHeight) {self.frame.size.height = newHeight} }
    
    var viewOrigin : CGPoint { get {return self.frame.origin }
        set(newOrigin) {self.frame.origin.x = newOrigin.x; self.frame.origin.y = newOrigin.y} }
    var viewSize : CGSize { get {return self.frame.size}
        set(newSize) {self.frame.size.width = newSize.width; self.frame.size.height = newSize.height}}
    
    var viewCenterPoint : CGPoint { get {return CGPoint(x: (self.viewWidth / 2) + self.viewX, y: (self.viewHeight / 2) + self.viewY)}
        set(newCenterPoint) { self.viewOrigin = CGPoint(x: newCenterPoint.x - (self.viewWidth / 2), y: newCenterPoint.y - (self.viewHeight / 2))} }
}
//MARK: UIWindow
//MARK: UILabel
extension UILabel {
    func setHeightWithContent(content: String) {
        let heightToSet = StringTool.getContentHeight(content, andFont: self.font, andWidth: self.viewWidth)
        self.viewSize = CGSize(width: self.viewWidth, height: heightToSet)
    }
}
//MARK: UIPickerView
//MARK: UIProgressView
//MARK: UIActivityIndicatorView
//MARK: UIImageView
//MARK: UITabBar
//MARK: UIToolBar
//MARK: UINavigationBar
//MARK: UITableViewCell
//MARK: UIActionSheet
//MARK: UIAlertView
//MARK: UIScrollView
extension UIScrollView {
    func scrollToBottom() {
        print("offset:\(self.contentOffset)\nsize:\(self.contentSize)\nviewHeight:\(self.viewHeight)")
        if (self.contentOffset.y + self.viewHeight) <= self.contentSize.height {
            self.setContentOffset(CGPoint(x: 0, y: (self.contentSize.height - self.viewHeight)), animated: true)
        }
    }
}
//MARK: UITableView
//MARK: UITextView
extension UITextView {
    var length: Int {
        get {
            return self.text!.characters.count
        }
    }
    func isEmpty() -> Bool {
        if self.text!.characters.count == 0 || self.text!.characters.count < 1 || self.text == nil || self.text == "" {
            return true
        } else {
            return false
        }
    }
    
    func append(text: String) {
        print(text)
        let tempText = (self.text ?? "") + "\n\(text)"
        self.text = tempText
        
        self.scrollToBottom()
    }
    func clean() {
        self.text = ""
    }
}
//MARK: UISearchBar
//MARK: UIWebView
//MARK: UIControl
//MARK: UIButton
extension UIButton {
    func setNormalTitle(title: String?) {
        self.setTitle(title, forState: UIControlState.Normal)
    }
    func setHighlightedTitle(title: String?) {
        self.setTitle(title, forState: UIControlState.Highlighted)
    }
    func setNormalTitleColor(color: UIColor?) {
        self.setTitleColor(color, forState: UIControlState.Normal)
    }
    func setHighlightedTitleColor(color: UIColor?) {
        self.setTitleColor(color, forState: UIControlState.Highlighted)
    }
    func setFontSize(size: CGFloat) {
        self.titleLabel?.font = UIFont.systemFontOfSize(size)
    }
}
//MARK: UIDatePicker
//MARK: UIPageControl
//MARK: UISegmentedControl
//MARK: UITextField
extension UITextField {
    var length: Int {
        get {
            return self.text!.characters.count
        }
    }
    var isEmpty: Bool {
        if self.text!.characters.count == 0 || self.text!.characters.count < 1 || self.text == nil || self.text == "" {
            return true
        } else {
            return false
        }
    }
    class func phoneNumberTextField(frame: CGRect) -> UITextField {
        return UITextField.specialTextField(frame, type: .PhonePad)
    }
    class func numberTextField(frame: CGRect) -> UITextField {
        return UITextField.specialTextField(frame, type: .NumberPad)
    }
    class func secureTextField(frame: CGRect) -> UITextField {
        return UITextField.specialTextField(frame, secure: true)
    }
    private class func specialTextField(frame: CGRect, type: UIKeyboardType? = .Default, secure: Bool? = false) -> UITextField {
        let textField = UITextField(frame: frame)
        textField.clearButtonMode = .WhileEditing
        textField.keyboardType = type!
        textField.secureTextEntry = secure!
        return textField
    }
}
//MARK: UISlider
//MARK: UISwitch
//MARK: UIViewController
//MARK: UISplitViewController
//MARK: UITabBarController
//MARK: UITableViewContoller
//MARK: UINavigationController
//MARK: UIImagePickerController
//MARK: UIVideoEditorController
//MARK: - UIScreen
extension UIScreen {
    func screenSize() -> CGRect {
        return self.bounds
    }
    func screenWidth() -> CGFloat {
        return self.bounds.width
    }
    func screenHeight() -> CGFloat {
        return self.bounds.height
    }
}
//MARK: - UISearchDisplayController
//MARK: - UITouch
