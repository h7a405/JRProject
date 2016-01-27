//
//  ViewController.swift
//  JZBluetoothCentralDemo
//
//  Created by Jason.Chengzi on 16/01/26.
//  Copyright © 2016年 WeSwift. All rights reserved.
//

//MARK: - 类注释
/*
*
*/

//MARK: - 类描述
///

//MARK: - 头文件
import UIKit
import CoreBluetooth

//MARK: - class函数
class ViewController: UIViewController {
    let kServiceUUID: String = "C4FB2349-72FE-4CA2-94D6-1F3CB16331EE"    //服务的UUID
    let kCharacteristicUUID: String = "6A3E4B28-522D-4B3B-82A9-D5E2004534FC" //特征的UUID
    //MARK: 储存变量 - Int/Float/Double/String
    
    //MARK: 集合类型 - Array/Dictionary/Tuple
    
    //MARK: 自定义类型 - Custom
    lazy var centralManager: CBCentralManager = {
        //创建中心设备管理器并设置当前控制器视图为代理
        return CBCentralManager(delegate: self, queue: nil)
    }()   //中心设备管理器
    var peripherals: [CBPeripheral] = Array()    //连接的外围设备
    //MARK: UIView子类 - UIView/UIControl/UIViewController
    
    @IBOutlet weak var textView: UITextView!
    //MARK: Foundation - NS/CG/CA
    
    //MARK: 计算变量
    
    //MARK: 闭包与结构体 - Closure/Struct
    
    //MARK: 代理与数据源 - delegate/datasource
    
    //MARK: 重用 - Override/Required/Convenience
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        Log.VLog(self.centralManager)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
//MARK: - 拓展
//MARK: 初始化与配置 - Initailize & Setup

//MARK: 操作与执行 - Action & Operation
extension ViewController {
    /**
     *  记录日志
     *
     *  @param info 日志信息
     */
    func writeToLog(log: String) {
        self.textView.append(log)
        //        Log.VLog(log)
    }
}
//MARK: 更新 - Update

//MARK: 判断 - Judgement

//MARK: 响应方法 - Selector
extension ViewController {
    @IBAction func didStartButtonClicked(sender: AnyObject) {
        //        Log.VLog(self.centralManager)
        self.textView.clean()
        self.writeToLog("中央 - 开始扫描外围设备：")
        self.centralManager.scanForPeripheralsWithServices(nil, options: [CBCentralManagerScanOptionAllowDuplicatesKey: true])
    }
}
//MARK: 回调 - Call back

//MARK: 数据源与代理 - DataSrouce & Delegate
//CBCentralManagerDelegate
extension ViewController: CBCentralManagerDelegate {
    //中心服务器状态更新后
    func centralManagerDidUpdateState(central: CBCentralManager) {
        switch central.state {
        case .PoweredOn:
            self.writeToLog("中央 - 已开启。")
//            central.scanForPeripheralsWithServices(nil, options: [CBCentralManagerScanOptionAllowDuplicatesKey: true])
            
        default:
            self.writeToLog("此设备不支持BLE或未打开蓝牙功能，无法作为中央设备.")
        }
    }
    /**
     *  发现外围设备
     *
     *  @param central           中心设备
     *  @param peripheral        外围设备
     *  @param advertisementData 特征数据
     *  @param RSSI              信号质量（信号强度）
     */
    func centralManager(central: CBCentralManager, didDiscoverPeripheral peripheral: CBPeripheral, advertisementData: [String : AnyObject], RSSI: NSNumber) {
        self.writeToLog("中央 - 发现外围设备。信号强度：\(RSSI)")
        //停止扫描
        self.centralManager.stopScan()
        self.writeToLog("中央 - 停止扫描外围设备。")
        //连接外围设备
        //添加保存外围设备，注意如果这里不保存外围设备（或者说peripheral没有一个强引用，无法到达连接成功（或失败）的代理方法，因为在此方法调用完就会被销毁
        if !self.peripherals.contains(peripheral) {
            self.writeToLog("中央 - 保存外围设备信息。\(peripheral.name ?? "")")
            self.peripherals.append(peripheral)
        }
        self.writeToLog("中央 - 开始连接外围设备...")
        self.centralManager.connectPeripheral(peripheral, options: nil)
    }
    //连接到外围设备
    func centralManager(central: CBCentralManager, didConnectPeripheral peripheral: CBPeripheral) {
        self.writeToLog("中央 - 连接外围设备成功!")
        //设置外围设备的代理为当前视图控制器
        peripheral.delegate = self
        //外围设备开始寻找服务
        self.writeToLog("外围 - 开始寻找服务...")
        peripheral.discoverServices([CBUUID(string: self.kServiceUUID)])
    }
    //连接外围设备失败
    func centralManager(central: CBCentralManager, didFailToConnectPeripheral peripheral: CBPeripheral, error: NSError?) {
        self.writeToLog("中央 - 连接外围设备失败！错误信息：\(error)")
    }
}
//CBPeripheralDelegate
extension ViewController: CBPeripheralDelegate {
    //外围设备寻找到服务后
    func peripheral(peripheral: CBPeripheral, didDiscoverServices error: NSError?) {
        self.writeToLog("外围 - 已发现可用服务.")
        
        if error != nil {
            self.writeToLog("外围 - 寻找服务过程中发生错误，错误信息：\(error?.localizedDescription)")
        }
        //遍历查找到的服务
        self.writeToLog("外围 - 开始遍历查找到的服务...")
        let serviceUUID: CBUUID = CBUUID(string: self.kServiceUUID)
        let characteristicUUID: CBUUID = CBUUID(string: self.kCharacteristicUUID)
        if let services = peripheral.services {
            for service in services {
                if service.UUID == serviceUUID {
                    //外围设备查找指定服务中的特征
                    self.writeToLog("外围 - 开始在外围设备查找指定服务中的特征...")
                    peripheral.discoverCharacteristics([characteristicUUID], forService: service)
                }
            }
        }
        self.writeToLog("外围 - 寻找可用服务结束。")
    }
    //外围设备寻找到特征后
    func peripheral(peripheral: CBPeripheral, didDiscoverCharacteristicsForService service: CBService, error: NSError?) {
        self.writeToLog("外围 - 已发现可用特征。")
        
        if error != nil {
            self.writeToLog("外围 - 找特征过程中发生错误，错误信息：\(error?.localizedDescription)")
        }
        
        //遍历服务中的特征
        self.writeToLog("外围 - 开始遍历遍历服务中的特征...")
        let serviceUUID: CBUUID = CBUUID(string: self.kServiceUUID)
        let characteristicUUID: CBUUID = CBUUID(string: self.kCharacteristicUUID)
        
        if service.UUID == serviceUUID {
            if let characteristics = service.characteristics {
                for characteristic in characteristics {
                    if characteristic.UUID == characteristicUUID {
                        //情景一：通知
                        /*找到特征后设置外围设备为已通知状态（订阅特征）：
                        *1.调用此方法会触发代理方法：-(void)peripheral:(CBPeripheral *)peripheral didUpdateNotificationStateForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error
                        *2.调用此方法会触发外围设备的订阅代理方法
                        */
                        peripheral.setNotifyValue(true, forCharacteristic: characteristic)
                        //情景二：读取
                        //                [peripheral readValueForCharacteristic:characteristic];
                        //                    if(characteristic.value){
                        //                    NSString *value=[[NSString alloc]initWithData:characteristic.value encoding:NSUTF8StringEncoding];
                        //                    NSLog(@"读取到特征值：%@",value);
                        //                }
                    }
                }
            }
        }
        self.writeToLog("外围 - 寻找可用特征结束。")
    }
    //特征值被更新后
    func peripheral(peripheral: CBPeripheral, didUpdateNotificationStateForCharacteristic characteristic: CBCharacteristic, error: NSError?) {
        self.writeToLog("外围 - 收到外围设备的特征更新通知。")
        
        if error != nil {
            self.writeToLog("外围 - 更新通知状态时发生错误，错误信息：\(error?.localizedDescription)")
        }
        
        //给特征值设置新的值
        let characteristicUUID: CBUUID = CBUUID(string: self.kCharacteristicUUID)
        if characteristicUUID.UUIDString == self.kCharacteristicUUID {
            if characteristic.isNotifying {
                if characteristic.properties == .Notify {
                    self.writeToLog("外围 - 已订阅特征通知.")
                    return
                } else if characteristic.properties == .Read {
                    //从外围设备读取新值,调用此方法会触发代理方法：-(void)peripheral:(CBPeripheral *)peripheral didUpdateValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error
                    peripheral.readValueForCharacteristic(characteristic)
                }
            } else {
                self.writeToLog("外围 - 已停止.")
                //取消连接
                self.centralManager.cancelPeripheralConnection(peripheral)
            }
        }
    }
    //更新特征值后（调用readValueForCharacteristic:方法或者外围设备在订阅后更新特征值都会调用此代理方法）
    func peripheral(peripheral: CBPeripheral, didUpdateValueForCharacteristic characteristic: CBCharacteristic, error: NSError?) {
        guard error == nil else {
            self.writeToLog("外围 - 更新特征值时发生错误，错误信息：\(error?.localizedDescription)")
            return
        }
        if let value = characteristic.value {
            let valueString = NSString(data: value, encoding: NSUTF8StringEncoding)
            self.writeToLog(String(valueString ?? ""))
        } else {
            self.writeToLog("外围 - 未发现特征值。")
        }
    }
}
//MARK: 设置 - Setter

//MARK: 获取 - Getter

//MARK: - 其他
//MARK: 协议  -   Protocol

//MARK: 枚举  -   Enumeration