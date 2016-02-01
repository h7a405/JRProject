//
//  ViewController.swift
//  JZHeartRateReceiver
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
    
    //MARK: 储存 - Int/Float/Double/String/Bool
    var isScanning : Bool = false
    //MARK: 集合 - Array/Dictionary/Tuple
    
    //MARK: UIView - UIView/UIControl/UIViewController
    
    //MARK: Foundation - NS/CG/CA/CF
    
    //MARK: 其他类 - Imported/Included
    // 指定当前类为代理对象，所以其需要实现CBCentralManagerDelegate协议
    // 如果queue为nil，则Central管理器使用主队列来发送事件
    lazy var centralManager : CBCentralManager = { return CBCentralManager(delegate: self, queue: nil) }()
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
    @IBAction func didScanDevicesButtonClicked(sender : AnyObject) {
        self.isScanning = true
        // 查找Peripheral设备
        // 如果第一个参数传递nil，则管理器会返回所有发现的Peripheral设备。
        // 通常我们会指定一个UUID对象的数组，来查找特定的设备
        self.centralManager.scanForPeripheralsWithServices(nil, options: nil)
        Log.VLog("Start scanning...")
    }
}
//MARK: 回调 - Call Back - doneX()

//MARK: 判断 - Judgement - checkX() -> Bool, isX() -> Bool, hasX() -> Bool

//MARK: 更新 - Updater - updateX()

//MARK: 设置 - Setter - setX(), resetX(), changeX()

//MARK: 获取 - Getter - getX(), acquiredX(), requestX()

//MARK: 数据源与代理 - DataSrouce & Delegate
//MARK: CBCentralManagerDelegate
extension ViewController : CBCentralManagerDelegate {
    func centralManagerDidUpdateState(central: CBCentralManager) {
        Log.VLog("Central Manager did update state:")
        switch central.state {
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
    
    func centralManager(central: CBCentralManager, didDiscoverPeripheral peripheral: CBPeripheral, advertisementData: [String : AnyObject], RSSI: NSNumber) {
        Log.VLog("One device has been scanned with name: \(peripheral.name ?? "")")
        // 当我们查找到Peripheral端时，我们可以停止查找其它设备，以节省电量
        centralManager.stopScan()
        Log.VLog("Scan's stopped")
        
        centralManager.connectPeripheral(peripheral, options: nil)
        Log.VLog("Attempt to connect to device...")
    }
    
    func centralManager(central: CBCentralManager, didConnectPeripheral peripheral: CBPeripheral) {
        Log.VLog("Device \(peripheral.name ?? "") is now connected.")
        peripheral.delegate = self
        Log.VLog("Discovering services in device.")
        peripheral.discoverServices(nil)
        
    }
}
//MARK: CBPeripheralDelegate
extension ViewController : CBPeripheralDelegate {
    func peripheral(peripheral: CBPeripheral, didDiscoverServices error: NSError?) {
        guard error == nil else {
            Log.VLog("Discovering services failed with error message: \(error?.localizedDescription ?? "")")
            return
        }
        if let services = peripheral.services {
            Log.VLog("Services discovered.")
            for service in services {
                Log.VLog("Discovering characteristic in service: \(service)")
                peripheral.discoverCharacteristics(nil, forService: service)
            }
        } else {
            Log.VLog("No services found.")
        }
    }
    func peripheral(peripheral: CBPeripheral, didDiscoverCharacteristicsForService service: CBService, error: NSError?) {
        guard error == nil else {
            Log.VLog("Discovering characteristics failed with error message: \(error?.localizedDescription ?? "") in service: \(service)")
            return
        }
        if let characteristics = service.characteristics {
            for characteristic in characteristics {
                Log.VLog("Subscribing characteristic: \(characteristic)")
                //                peripheral.readValueForCharacteristic(characteristic)
                peripheral.setNotifyValue(true, forCharacteristic: characteristic)
            }
        } else {
            Log.VLog("No characteristic in service: \(service)")
        }
    }
    func peripheral(peripheral: CBPeripheral, didUpdateValueForCharacteristic characteristic: CBCharacteristic, error: NSError?) {
        guard error == nil else {
            Log.VLog("Reading value failed with error message: \(error?.localizedDescription ?? "") in characteristic: \(characteristic)")
            return
        }
        if let data = characteristic.value {
            Log.VLog("Data is: \(data)")
        } else {
            Log.VLog("Read no data.")
        }
    }
    func peripheral(peripheral: CBPeripheral, didUpdateNotificationStateForCharacteristic characteristic: CBCharacteristic, error: NSError?) {
        if error != nil {
            Log.VLog("Notifying update failed with error message: \(error?.localizedDescription ?? "") in characteristic: \(characteristic)")
        }
        
        Log.VLog("Notifying updating state.")
        
        //给特征值设置新的值
        if characteristic.isNotifying {
            if characteristic.properties == .Notify {
                Log.VLog("Characteristic subscribed.")
                return
            } else if characteristic.properties == .Read {
                //从外围设备读取新值,调用此方法会触发代理方法：-(void)peripheral:(CBPeripheral *)peripheral didUpdateValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error
                peripheral.readValueForCharacteristic(characteristic)
            }
        } else {
            Log.VLog("Characteristic unsubscribed.")
            //取消连接
            self.centralManager.cancelPeripheralConnection(peripheral)
        }
    }
}
//MARK: - 其他
//MARK: 全局

//MARK: 协议  -   Protocol

//MARK: 枚举  -   Enumeration
