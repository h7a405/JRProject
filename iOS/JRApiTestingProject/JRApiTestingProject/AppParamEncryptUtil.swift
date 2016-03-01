//
//  AppParamEncryptUtil.swift
//  JingJianLogistics-iOS
//
//  Created by SilversRayleigh on 24/9/15.
//  Copyright (c) 2015 qi-cloud.com. All rights reserved.
//
//MARK: - Header
//MARK: Header - Files
import Foundation
//MARK: Header - Enums
//MARK: Header - Protocols

//MARK: - Class
//MARK: - Classes - Body
class AppParamEncryptUtil: NSObject {
    //MARK: - Parameter
    //MARK: - Parameters - Constant
    //MARK: - Parameters - Basic
    //MARK: - Parameters - Foundation
    //MARK: - Parameters - UIKit
    //MARK: - Parameters - Array
    let charArray: [Character] = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"]
    //MARK: - Parameters - Dictionary
    //MARK: - Parameters - Tuple
    //MARK: - Parameters - Customed
    //MARK: Customed - Normal
    //MARK: Customed - Delegate
    //MARK: Customed - Datasource
    //MARK: Customed - Enum
    
    //MARK: - Method
    //MARK: - Methods - Life Circle
    //MARK: - Methods - Implementation
    override init() {
        super.init()
    }
    //MARK: - Methods - Initation
    //MARK: - Methods - Class(Static)
    //MARK: - Methods - Selector
    //MARK: Selectors - Gesture Recognizer
    //MARK: Selectors - Action
    //MARK: - Methods - Operation
    //MARK: Operations - Go Operation
    //MARK: Operations - Do Operation
    //MARK: Operations - Show or Dismiss Operation
    //MARK: Operations - Setup Operation
    //MARK: Operations - Customed Operation
    func signParam(byString theString: String, andKey theKey: String) -> String {
        if theString.isEmpty || theString == "" {
            return ""
        }
        if theKey.isEmpty || theKey == "" {
            return theString.md5()
        }
        let stringToReturn: String = theString + "@" + theKey
        return stringToReturn.md5()
    }
    func decryptParam(byString theString: String) -> Bool {
        if theString.isEmpty {
            return false
        }
        if theString.length() != 24 {
            return false
        }
        let firstCharacter: Character = self.getCharacter(atIndex: 0, theString: theString)
        let firstCharacterIndex: Int = self.getIndex(byChararacter: firstCharacter)
        if firstCharacterIndex == -1 || firstCharacterIndex > 23 {
            return false
        }
        let characterAtIndex: Character = self.getCharacter(atIndex: firstCharacterIndex, theString: theString)
        let characterIndex: Int = self.getIndex(byChararacter: characterAtIndex)
        if characterIndex == -1 || characterIndex > 23 {
            return false
        }
        let sumOfCharacters: Int = firstCharacter.toInt() + characterAtIndex.toInt()
        var count: Int = firstCharacterIndex + 1
        for index in 0..<11 {
            let nextIndex: Int = count > 23 ? (count % 23) : count
            let anotherNextIndex: Int = nextIndex + 11 > 23 ? (nextIndex + 11) % 23 : nextIndex + 11
            let nextIndexCharacter: Character = self.getCharacter(atIndex: nextIndex, theString: theString)
            let anotherNextIndexCharacter: Character = self.getCharacter(atIndex: anotherNextIndex, theString: theString)
            let theCharacter: Character = self.charArray[(nextIndexCharacter.toInt() + sumOfCharacters + index) % 25]
            if anotherNextIndexCharacter != theCharacter {
                return false
            }
            count++
        }
        return true
    }
    func requestRandomEncryptedString() -> String {
        var ca: [Character] = Array()
        for _ in 0..<24 {
            ca.append("a")
        }
        let index: Int = Int(arc4random_uniform(23)) + 1
        let jndex: Int = Int(arc4random_uniform(24))
        ca[0] = self.charArray[index]
        ca[index] = self.charArray[jndex]
        var j: Int = index + 1
        let sum: Int = ca[0].toInt() + ca[index].toInt()
        for i in 0..<11 {
            let next: Int = Int(arc4random_uniform(26))
            let nextIndex: Int = j > 23 ? j % 23 : j
            let nextJndex: Int = nextIndex + 11 > 23 ? (nextIndex + 11) % 23 : nextIndex + 11
            ca[nextIndex] = self.charArray[next]
            ca[nextJndex] = self.charArray[(ca[nextIndex].toInt() + sum + i) % 25]
            j++
        }
        return String(ca)
    }
    //MARK: - Methods - Getter
    func getCharacter(atIndex theIndex: Int, theString: String) -> Character {
        var theCharacter: Character = "a"
        for (index, character) in theString.characters.enumerate() {
            if theIndex == index {
                theCharacter = character
                break
            }
        }
        return theCharacter
    }
    func getIndex(byChararacter theCharacter: Character) -> Int {
        var theIndex: Int = -1
        for (index, character) in self.charArray.enumerate() {
            if theCharacter == character {
                theIndex = index
                break
            }
        }
        return theIndex
    }
    //MARK: - Methods - Setter
}

//MARK: - Classes - Extension
//MARK: - Extensions - DataSource
//MARK: - Extensions - Delegate
//MARK: - Classes - Custom