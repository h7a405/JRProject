//
//  ConvertUtil.swift
//  HealthCenter
//
//  Created by Jason.Chengzi on 16/02/23.
//  Copyright © 2016年 HVIT. All rights reserved.
//

import UIKit

class ConvertUtil {
    class func parseInt32(bytes:[UInt8], offset:Int)->Int32{
        
        var pointer = UnsafePointer<UInt8>(bytes)
        pointer = pointer.advancedBy(offset)
        
        let iPointer =  UnsafePointer<Int32>(pointer)
        return iPointer.memory
        
    }
    
    class func parseFloat32(bytes:[UInt8], offset:Int)->Float32{
        var pointer = UnsafePointer<UInt8>(bytes)
        pointer = pointer.advancedBy(offset)
        
        let fPointer =  UnsafePointer<Float32>(pointer)
        return fPointer.memory
        
    }
}
