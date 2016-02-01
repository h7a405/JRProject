//
//  ViewController.swift
//  JZHeartRateMonitor
//
//  Created by Jason.Chengzi on 16/02/01.
//  Copyright © 2016年 WeSwift. All rights reserved.
//

//MARK: - 类注释
/*
*
*/

//MARK: - 头文件
import UIKit
import CoreBluetooth
//MARK: - 类函数
class ViewController: UIViewController {
    //MARK: 类属性
    let peripheralName : String = String("Heart Rate Monitor")
    let serviceUUID : CBUUID = CBUUID(string: "3655296F-96CE-44D4-912D-CD83F06E7E7E")
    let characteristicUUIDReadable : CBUUID = CBUUID(string: "C22D1ECA-0F78-463B-8C21-688A517D7D2B")
    let characteristicUUIDWriteable : CBUUID = CBUUID(string: "632FB3C9-2078-419B-83AA-DBC64B5B685A")
    //MARK: 储存 - Int/Float/Double/String/Bool
    
    //MARK: 集合 - Array/Dictionary/Tuple
    
    //MARK: UIView - UIView/UIControl/UIViewController
    
    //MARK: Foundation - NS/CG/CA/CF
    
    //MARK: 其他类 - Imported/Included
    // 创建一个Peripheral管理器
    // 我们将当前类作为peripheralManager，因此必须实现CBPeripheralManagerDelegate
    // 第二个参数如果指定为nil，则默认使用主队列
    lazy var peripheralManager : CBPeripheralManager = { return CBPeripheralManager(delegate: self, queue: nil )}()
    
    lazy var characteristicReadable : CBMutableCharacteristic = { return CBMutableCharacteristic(type: self.characteristicUUIDReadable, properties: .Read, value: nil, permissions: .Readable) }()
    lazy var characteristicWriteable : CBMutableCharacteristic = { return CBMutableCharacteristic(type: self.characteristicUUIDWriteable, properties: .Notify, value: nil, permissions: .Writeable) }()
    lazy var service : CBMutableService = {
        var tempService = CBMutableService(type: self.serviceUUID, primary: true)
        tempService.characteristics = [self.characteristicReadable, self.characteristicWriteable]
        return tempService
    }()
    //MARK: 闭包与结构体 - Closure/Struct
    
    //MARK: 代理与数据源 - delegate/datasource
    
    //MARK: 自定义 - Customed
    
    //MARK: 计算 - Property Observers
    
    //MARK: 生命周期 - Life Cycle
    //初始化实例
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    //添加视图
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }
    //改变视图数据
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        self.peripheralManager.addService(self.service)
        
    }
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
    }
    override func viewDidDisappear(animated: Bool) {
        super.viewDidAppear(animated)
    }
    //MARK: Memory Warning
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //MARK: 父类初始化
    //使用xib初始化视图
    /*
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    }
    convenience init() {
    let nibNameOrNil = String?("")
    self.init(nibName: nibNameOrNil, bundle: nil)
    }
    */
}
//MARK: - 拓展
//MARK: 初始化与配置 - Initailize / Setup - initX(), setupX()

//MARK: 操作与执行 - Action / Operation - doX(), gotoX(), calculateX()

//MARK: 响应方法 - Selector - didX()
extension ViewController {
    @IBAction func didStartAdvertisingButtonClicked(sender : AnyObject) {
        
        self.peripheralManager.startAdvertising([
            CBAdvertisementDataLocalNameKey : self.peripheralName,
            CBAdvertisementDataServiceUUIDsKey : self.serviceUUID
            ])
        
        Log.VLog("Start advertising...")
        
        (sender as? UIBarButtonItem)?.enabled = false
    }
}
//MARK: 回调 - Call Back - doneX()

//MARK: 判断 - Judgement - checkX() -> Bool, isX() -> Bool, hasX() -> Bool

//MARK: 更新 - Updater - updateX()

//MARK: 设置 - Setter - setX(), resetX(), changeX()

//MARK: 获取 - Getter - getX(), acquiredX(), requestX()

//MARK: 数据源与代理 - DataSrouce & Delegate
//MARK: CBPeripheralManagerDelegate
extension ViewController : CBPeripheralManagerDelegate {
    func peripheralManagerDidUpdateState(peripheral: CBPeripheralManager) {
        Log.VLog("Peripheral Manager did update state:")
        switch peripheral.state {
        case .PoweredOn:
            Log.VLog("State Powered On.")
        case .PoweredOff:
            Log.VLog("State Powered Off.")
        case .Unsupported:
            Log.VLog("BLE is not supported on this device.")
        default:
            break
        }
    }
    
    func peripheralManager(peripheral: CBPeripheralManager, didAddService service: CBService, error: NSError?) {
        guard error == nil else {
            Log.VLog("An error has occured when adding service. Error message: \(error?.localizedDescription ?? "")")
            return
        }
        Log.VLog("Service has been successfully added.")
    }
    
    func peripheralManagerDidStartAdvertising(peripheral: CBPeripheralManager, error: NSError?) {
        guard error == nil else {
            Log.VLog("An error has occured when starting advertising. Error message: \(error?.localizedDescription ?? "")")
            return
        }
        Log.VLog("Adveritise has been successfully started.")
    }
    
    func peripheralManager(peripheral: CBPeripheralManager, didReceiveReadRequest request: CBATTRequest) {
        Log.VLog("Receiving a request from other device.")
        // 查看请求的特性是否是指定的特性
        if request.characteristic.UUID == self.characteristicUUIDReadable {
            if let value = self.characteristicReadable.value {
            // 确保读请求所请求的偏移量没有超出我们的特性的值的长度范围
            // offset属性指定的请求所要读取值的偏移位置
            if request.offset > value.length {
                Log.VLog("Requesting data's length is out of range.")
                self.peripheralManager.respondToRequest(request, withResult: .InvalidOffset)
            } else {
                // 如果读取位置未越界，则将特性中的值的指定范围赋给请求的value属性。
                request.value = value.subdataWithRange(NSRange(location: request.offset, length: value.length - request.offset))
                // 对请求作出成功响应
                self.peripheralManager.respondToRequest(request, withResult: .Success)
                }
            } else {
                Log.VLog("Characteristic has no datas.")
            }
        }
        Log.VLog("Wrong request.")
    }
    
    func peripheralManager(peripheral: CBPeripheralManager, didReceiveWriteRequests requests: [CBATTRequest]) {
        let request = requests[0]
        self.characteristicReadable.value = request.value
        self.peripheralManager.respondToRequest(request, withResult: .Success)
    }
    
    func peripheralManager(peripheral: CBPeripheralManager, central: CBCentral, didSubscribeToCharacteristic characteristic: CBCharacteristic) {
        Log.VLog("Central sbuscribed to characteristic: \(characteristic)")
        if let updatedData = characteristic.value {
            // 获取属性更新的值并调用以下方法将其发送到Central端
            // 最后一个参数指定我们想将修改发送给哪个Central端，如果传nil，则会发送给所有连接的Central
            // 将方法返回一个BOOL值，表示修改是否被成功发送，如果用于传送更新值的队列被填充满，则方法返回NO
            if self.peripheralManager.updateValue(updatedData, forCharacteristic: (characteristic as! CBMutableCharacteristic), onSubscribedCentrals: nil) == true {
                Log.VLog("Send Succeeded.")
            } else {
                Log.VLog("Send failed.")
            }
        }
    }
    
    func peripheralManager(peripheral: CBPeripheralManager, central: CBCentral, didUnsubscribeFromCharacteristic characteristic: CBCharacteristic) {
        
    }
}
//MARK: - 其他
//MARK: 全局

//MARK: 协议  -   Protocol

//MARK: 枚举  -   Enumeration
