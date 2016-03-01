//
//  SwiftExtension.swift
//  JZAppFramework
//
//  Created by Jason Lee on 15/12/24.
//  Copyright © 2015年 CZLee. All rights reserved.
//

import Foundation

//MARK: String
extension String {
    func length() -> Int {
        return self.characters.count
    }
//    func md5() -> String {
//        let str = self.cStringUsingEncoding(NSUTF8StringEncoding)
//        let strLen = CUnsignedInt(self.lengthOfBytesUsingEncoding(NSUTF8StringEncoding))
//        let digestLen = Int(CC_MD5_DIGEST_LENGTH)
//        let result = UnsafeMutablePointer<CUnsignedChar>.alloc(digestLen)
//        CC_MD5(str!, strLen, result)
//        let hash = NSMutableString()
//        for i in 0..<digestLen {
//            hash.appendFormat("%02x", result[i])
//        }
//        result.destroy()
//        return String(format: hash as String)
//    }
    func print() {
        Log.VLog(self)
    }
    func intValue() -> Int? {
        return Int(self)
    }
    func floatValue() -> Float? {
        return Float(self)
    }
    func doubleValue() -> Double? {
        return Double(self)
    }
}
//MARK: Character
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
//MARK: Dictionary
extension Dictionary {
    func toString() -> String {
        var dicString = "{"
        for key in self.keys {
            dicString += "\n        [\(key) : \(((self[key] as? String) ?? ""))]"
        }
        return dicString + "\n        }"
    }
    func print() {
        Log.VLog(self.toString())
    }
}
//MARK: Array
extension Array {
    func toString() -> String {
        var stringToReturn = ""
        for (index, object) in self.enumerate() {
            stringToReturn += "\(index): \(object)"
        }
        return stringToReturn
    }
    func print() {
        Log.VLog(self.toString())
    }
}