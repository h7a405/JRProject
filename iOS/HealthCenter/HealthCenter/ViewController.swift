//
//  ViewController.swift
//  HealthCenter
//
//  Created by Jason.Chengzi on 16/02/16.
//  Copyright © 2016年 HVIT. All rights reserved.
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
    let subscribeUUID   = "1002"
    let writeUUID       = "1001"
    //MARK: 集合 - Array/Dictionary/Tuple
    
    //MARK: UIView - UIView/UIControl/UIViewController
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: Foundation - NS/CG/CA/CF
    
    //MARK: 其他类 - Imported/Included
    let central = JZBLECentralManager.sharedManager()
    
    //    var toWriteCharacteristic : [CBCharacteristic?] = Array()
    var toWriteCharacteristic : CBCharacteristic?
    //MARK: 闭包与结构体 - Closure/Struct
    
    //MARK: 代理与数据源 - delegate/datasource
    
    //MARK: 自定义 - Customed
    
    //MARK: 计算 - Property Observers
    
    //MARK: 生命周期 - Life Cycle
    //初始化实例
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.setupBLEDelegates()
    }
    //添加视图
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.tableView.tableFooterView = UIView()
    }
    //改变视图数据
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        //        for _ in 0..<5 {
        //            self.toWriteCharacteristic.append(nil)
        //        }
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
extension ViewController {
    func setupBLEDelegates() {
        self.setLeftBarButtonItemEnabled(false)
        self.setRightBarButtonItemEnabled(false)
        
        //中央设备
        //        self.central.setScanningFilterOfServices(String.generateUUIDString())
        //        self.central.setScanningFilterContainingString(String.generateRandomString())
        self.central.setCallbackOfCentralManagerDidUpdateState { (central) -> Void in
            //TODO: 中央设备状态改变时候的回调
            //需先调用方法：scanPeripherals() / scanPeripheralsForAmount() / scanPeripheralsWithTimeout
            switch central.state {
            case .PoweredOn:
                Log.SDLog("蓝牙已启动。", logType: .Bluetooth)
            case .PoweredOff:
                Log.SDLog("蓝牙已关闭。", logType: .Bluetooth)
            case .Unauthorized:
                Log.SDLog("蓝牙未授权。", logType: .Bluetooth)
            default:
                Log.SDLog("无法使用蓝牙。", logType: .Bluetooth)
            }
        }
        self.central.setCallbackOfDidDiscoverPeripheral { (central, peripheral, advertisementData, RSSI) -> Bool in
            //TODO: 搜索到设备时候的回调
            //返回真则连接该设备，返回否则不连接该设备
            Log.SDLog("搜索到设备【\(peripheral.notNull_name)】\t信号强度：\(RSSI)\n广播数据：\(advertisementData)", logType: .Bluetooth)
            self.tableView.reloadData()
            return false
        }
        self.central.setCallbackOfDidConnectPeripheral { (central, peripheral) -> Void in
            //TODO: 连接外围设备成功时候的回调
            //需先调用方法：connectToAllPeripherals()
            self.setLeftBarButtonItemEnabled()
            if peripheral.notNull_name.hasSuffix("BPM") {
                Log.SDLog("成功连接到血压仪【\(peripheral.notNull_name)】。", logType: .Bluetooth)
            } else {
                Log.SDLog("成功连接到未知设备【\(peripheral.notNull_name)】。", logType: .Bluetooth)
            }
            
            self.tableView.reloadData()
        }
        self.central.setCallbackOfDidConnectPeripheralFailed { (central, peripheral, error) -> Void in
            //TODO: 连接外围设备失败时候的回调
            Log.SDLog("连接到设备【\(peripheral.notNull_name)】失败。", logType: .Bluetooth)
        }
        self.central.setCallbackOfDidDisconnectPeripheral { (central, peripheral, error) -> Void in
            //TODO: 断开外围设备连接时的回调
            self.setLeftBarButtonItemEnabled(false)
            Log.SDLog("已经断开与设备【\(peripheral.notNull_name)】的连接。", logType: .Bluetooth)
            
            self.tableView.reloadData()
        }
        self.central.setCallbackOfDidDiscoverServices { (peripheral, error) -> Void in
            //TODO: 搜索到服务时候的回调
            //需先调用方法：discoverServices()
            //            Log.SDLog("在设备【\(peripheral.notNull_name)】中搜索到服务。", logType: .Bluetooth)
        }
        self.central.setCallbackOfDidDiscoverCharacteristicsForService { (peripheral, service, error) -> Void in
            //TODO: 搜索到特征时候的回调
            //需先调用方法：discoverCharacteristics()
            //            Log.SDLog("在服务【\(service.UUID.UUIDString)】中发现特征。", logType: .Bluetooth)
            if let characteristics = service.characteristics {
                for characteristic in characteristics {
                    Log.SVLog(characteristic, logType: .Bluetooth)
                    
                    //                    let property = characteristic.properties.rawValue
                    //                    if property == CBCharacteristicPropertiesString.Read.UIntValue || property == CBCharacteristicPropertiesString.ReadAndNotify.UIntValue || property == CBCharacteristicPropertiesString.ReadAndWrite.UIntValue || property == CBCharacteristicPropertiesString.ReadAndWriteAndWithoutResponseAndNotify.UIntValue {
                    //                        peripheral.readValueForCharacteristic(characteristic)
                    //                    }
                    //                    if property == CBCharacteristicPropertiesString.Notify.UIntValue || property == CBCharacteristicPropertiesString.ReadAndNotify.UIntValue || property == CBCharacteristicPropertiesString.ReadAndWriteAndWithoutResponseAndNotify.UIntValue {
                    //                        peripheral.setNotifyValue(true, forCharacteristic: characteristic)
                    //                    }
                    //                    if property == CBCharacteristicPropertiesString.Write.UIntValue || property == CBCharacteristicPropertiesString.WriteWithoutResponse.UIntValue || property == CBCharacteristicPropertiesString.ReadAndWrite.UIntValue || property == CBCharacteristicPropertiesString.ReadAndWriteAndWithoutResponseAndNotify.UIntValue {
                    //                        if characteristic.UUID.UUIDString == "1001" {
                    //                            self.toWriteCharacteristic[0] = characteristic
                    //                        } else if characteristic.UUID.UUIDString == "1002" {
                    //                            self.toWriteCharacteristic[1] = characteristic
                    //                        } else if characteristic.UUID.UUIDString == "1003" {
                    //                            self.toWriteCharacteristic[2] = characteristic
                    //                        } else if characteristic.UUID.UUIDString == "1004" {
                    //                            self.toWriteCharacteristic[3] = characteristic
                    //                        } else if characteristic.UUID.UUIDString == "1005" {
                    //                            self.toWriteCharacteristic[4] = characteristic
                    //                        }
                    //                    }
                    if characteristic.UUID.UUIDString == self.subscribeUUID {
                        peripheral.setNotifyValue(true, forCharacteristic: characteristic)
                    }
                    if characteristic.UUID.UUIDString == self.writeUUID {
                        self.toWriteCharacteristic = characteristic
                    }
                }
            }
        }
        self.central.setCallbackOfDidDiscoverDescriptorsForCharacteristic { (peripheral, characteristic, error) -> Void in
            //TODO: 搜索到描述时候的回调
            //需先调用方法：discoverDescriptors()
            //            let stringValue = CBCharacteristicPropertiesString(rawValue: Int(characteristic.properties.rawValue))?.stringValue
            //            Log.SDLog("在特征【\(characteristic.UUID.UUIDString)】中发现描述。特征属性：\(stringValue ?? "")", logType: .Bluetooth)
            
        }
        self.central.setCallbackOfDidUpdateNotificationStateForCharacteristic { (peripheral, characteristic, error) -> Void in
            //TODO: 订阅特征时候的回调
            //需先调用方法：subscribeAllCharacteristics()
            Log.SDLog("订阅的特征【\(characteristic)】接收到更新。", logType: .Bluetooth)
        }
        self.central.setCallbackOfDidUpdateValueForCharacteristic { (peripheral, characteristic, error) -> Void in
            //TODO: 从特征读取值时候的回调
            //需先调用方法：readValueFromCharacteristics()
            if let value = characteristic.value {
                //                    let stringValue_UTF8    = NSString(data: value, encoding: NSUTF8StringEncoding)
                //                    let stringValue_Unicode = NSString(data: value, encoding: NSUnicodeStringEncoding)
                var bytesValue = [Byte]()
                //                    Log.SDLog("从特征【\(characteristic)】读取的值：{", logType: .Bluetooth)
                //                    print("UTF-8【\(stringValue_UTF8 ?? "")】")
                //                    print("Unicode【\(stringValue_Unicode ?? "")】")
                //                    print("Bytes【\(bytesValue)】\n}")
                for i in 0..<value.length {
                    var tempByte : Byte = 0
                    value.getBytes(&tempByte, range: NSRange(location: i, length: 1))
                    bytesValue.append(tempByte)
                }
                
                if bytesValue.count > 3 {
                    if bytesValue[0] == 0x55 {
                        var type = PackageType.Unknown
                        let typeValue = bytesValue[2]
                        if typeValue == 0 {
                            type = .Information
                        } else if typeValue == 1 {
                            type = .Begining
                        } else if typeValue == 2 {
                            type = .Accessing
                        } else if typeValue == 3 {
                            type = .Result
                        } else if typeValue == 4 {
                            type = .Finish
                        }
                        Log.SVLog("从特征【\n\(characteristic)\n】读取的【\(type.rawValue)】的值\n\(bytesValue)\n【\(value.bytes)】\n【\(value)】", logType: .Bluetooth)
                        switch type {
                        case .Information, .Begining, .Result:
                            if let toWrite = self.toWriteCharacteristic {
                                peripheral.writeValue(self.packData(90, length: 11, type: 5, year: 14, month: 11, day: 8, hour: 12, min: 18, cs1: 0xA9, cs2: 0x00, cs3: 0x00), forCharacteristic: toWrite, type: CBCharacteristicWriteType.WithResponse)
                            }
                        default:
                            break
                        }
                    }
                }
            }
            //            else {
            //                Log.SDLog("特征【\(characteristic)】没有值。", logType: .Bluetooth)
            //            }
            //            if characteristic.UUID.UUIDString == "1002" {
            //                if let toWrite = self.toWriteCharacteristic[2] {
            //                    peripheral.writeValue(self.packData(90, length: 11, type: 5, year: 14, month: 11, day: 8, hour: 12, min: 18, cs1: 0xA9, cs2: 0x00, cs3: 0x00), forCharacteristic: toWrite, type: CBCharacteristicWriteType.WithResponse)
            //                }
            //            }
            
        }
        self.central.setCallbackOfDidWriteValueForCharacteristic { (peripheral, characteristic, error) -> Void in
            //TODO: 向特征写入值时候的回调
            guard error == nil else {
                Log.SVLog("发送消息时失败，错误信息：\(error?.localizedDescription ?? "")")
                return
            }
            Log.SVLog("发送成功。")
        }
        self.central.setCallbackOfDidUpdateValueForDescriptor { (peripheral, descriptor, error) -> Void in
            //TODO: 从描述读取值时候的回调
            //需先调用方法：readValueFromDescriptors()
            //            Log.VLog("从描述【\(descriptor.UUID.UUIDString)】读取值【\(descriptor.value)】", logType: .Bluetooth)
            if let value = descriptor.value {
                Log.SDLog("从描述【\(descriptor)】读取的值是：\(value)。")
            }
        }
        self.central.setCallbackOfDidWriteValueForDescriptor { (peripheral, descriptor, error) -> Void in
            //TODO: 向描述写入值时候的回调
        }
        
        self.setRightBarButtonItemEnabled()
    }
}
//MARK: 操作与执行 - Action / Operation - doX(), gotoX(), calculateX()
extension ViewController {
    func packData(stage : Int, length : Int, type : Int, year : Int, month : Int, day : Int, hour : Int, min : Int, cs1 : Int, cs2 : Int, cs3 : Int) -> NSData {
        let bytes : [Byte] = [UInt8(stage), UInt8(length), UInt8(type), UInt8(year), UInt8(month), UInt8(day), UInt8(hour), UInt8(min), UInt8(cs1), UInt8(cs2), UInt8(cs3)]
        let data = NSData(bytes: bytes, length: bytes.count)
        
        Log.SVLog(data, logType: .Bluetooth)
        
        return data
    }
}
//MARK: 响应方法 - Selector - didX()
extension ViewController {
    @IBAction func didLeftBarButtonItemClicked(sender: AnyObject) {
        let alertController = UIAlertController(title: nil, message: "是否断开所有设备的连接？", preferredStyle: .ActionSheet)
        let alertActionCancel = UIAlertAction(title: "取消", style: .Cancel, handler: nil)
        let alertActionConfirm = UIAlertAction(title: "断开所有", style: .Destructive) { (action : UIAlertAction) -> Void in
            self.central.disconnectAllPeripherals()
            self.setRightBarButtonItemEnabled()
        }
        alertController.addAction(alertActionCancel)
        alertController.addAction(alertActionConfirm)
        
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    @IBAction func didRightBarButtonItemClicked(sender : UIBarButtonItem) {
        self.setRightBarButtonItemEnabled(false)
        self.central.cleanAllPeripherals().setScanningFilterContainingString("Bioland").scanPeripheralsWithTimeout(120, andStopWhenOneFound: true).connectToAllPeripherals().discoverServices().discoverCharacteristics().subscribeAllCharacteristics().execute()
    }
}
//MARK: 回调 - Call Back - doneX()

//MARK: 判断 - Judgement - checkX() -> Bool, isX() -> Bool, hasX() -> Bool

//MARK: 更新 - Updater - updateX()

//MARK: 设置 - Setter - setX(), resetX(), changeX()
extension ViewController {
    func setLeftBarButtonItemEnabled(enabled : Bool = true) {
        self.navigationItem.leftBarButtonItem?.enabled = enabled
    }
    func setRightBarButtonItemEnabled(enabled : Bool = true) {
        self.navigationItem.rightBarButtonItem?.enabled = enabled
    }
}
//MARK: 获取 - Getter - getX(), acquiredX(), requestX()

//MARK: 数据源与代理 - DataSrouce & Delegate
//MARK: UITableViewDataSource
extension ViewController : UITableViewDataSource {
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return self.central.connectedPeripherals.count
        case 1:
            return self.central.foundPeripherals.count
        default:
            return 0
        }
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier : String = "cell"
        
        var cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier)
        
        if cell == nil {
            cell = UITableViewCell(style: .Default, reuseIdentifier: cellIdentifier)
        }
        
        cell!.accessoryType = .DisclosureIndicator
        
        switch indexPath.section {
        case 0:
            cell!.textLabel?.text = self.central.connectedPeripherals[indexPath.row].name
        case 1:
            cell!.textLabel?.text = self.central.foundPeripherals[indexPath.row].name
        default:
            break
        }
        
        return cell!
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "已连接设备"
        case 1:
            return "已发现设备"
        default:
            return nil
        }
    }
    func tableView(tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        if section == 1 {
            return "当前搜索关键字为：\(self.central.scanningFilterString)"
        } else {
            return nil
        }
    }
}
//MARK: UITableViewDelegate
extension ViewController : UITableViewDelegate {
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 25
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 44
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        let cancelAction = UIAlertAction(title: "取消", style: .Cancel, handler: nil)
        var confirmAction : UIAlertAction?
        var alertController : UIAlertController?
        switch indexPath.section {
        case 0:
            confirmAction = UIAlertAction(title: "断开连接", style: .Destructive, handler: { (action : UIAlertAction) -> Void in
                self.central.disconnectPeripheral(self.central.connectedPeripherals[indexPath.row])
            })
            alertController = UIAlertController(title: nil, message: "请选择：", preferredStyle: .ActionSheet)
            if let characteristic = self.toWriteCharacteristic {
                let writeAction = UIAlertAction(title: "发送'开始包'", style: .Default, handler: { (action : UIAlertAction) -> Void in
                    let peripheral = self.central.connectedPeripherals[indexPath.row]
                    peripheral.writeValue(self.packData(90, length: 11, type: 5, year: 14, month: 11, day: 8, hour: 12, min: 18, cs1: 0xA9, cs2: 0x00, cs3: 0x00), forCharacteristic: characteristic, type: CBCharacteristicWriteType.WithResponse)
                })
                alertController?.addAction(writeAction)
            }
        case 1:
            confirmAction = UIAlertAction(title: "立即连接", style: .Default, handler: { (action : UIAlertAction) -> Void in
                self.central.connectToPeripheral(self.central.foundPeripherals[indexPath.row])
            })
            alertController = UIAlertController(title: nil, message: "是否连接该设备？", preferredStyle: .ActionSheet)
        default:
            break
        }
        alertController!.addAction(cancelAction)
        alertController!.addAction(confirmAction!)
        
        self.presentViewController(alertController!, animated: true, completion: nil)
    }
}
//MARK: - 其他
//MARK: 全局

//MARK: 协议  -   Protocol

//MARK: 枚举  -   Enumeration
enum CBCharacteristicPropertiesString : Int {
    case Broadcast                                      = 0x01  //1
    case Read                                           = 0x02  //2
    case WriteWithoutResponse                           = 0x04  //4
    case Write                                          = 0x08  //8
    case ReadAndWrite                                   = 0x0A  //10
    case Notify                                         = 0x10  //16
    case ReadAndNotify                                  = 0x12  //18
    case ReadAndWriteAndWithoutResponseAndNotify        = 0x1E  //30
    case Indicate                                       = 0x20  //32
    case AuthenticatedSignedWrites                      = 0x40  //40
    case ExtendedProperties                             = 0x80
    case NotifyEncryptionRequired                       = 0x100
    case IndicateEncryptionRequired                     = 0x200
    
    var stringValue : String {
        switch self {
        case .Broadcast:                                return "Broadcast"                                  //1 = 0x01
        case .Read:                                     return "Read"                                       //2 = 0x02
        case .WriteWithoutResponse:                     return "WriteWithoutResponse"                       //4 = 0x04
        case .Write:                                    return "Write"                                      //8 = 0x08
        case .ReadAndWrite:                             return "Read Write"                                 //10 = 0x0A
        case .Notify:                                   return "Notify"                                     //16 = 0x10
        case .ReadAndNotify:                            return "Read Notify"                                //18 = 0x12
        case .ReadAndWriteAndWithoutResponseAndNotify:  return "Read Write WriteWithoutResponse Notify"     //30 = 0x1E
        case .Indicate:                                 return "Indicate"                                   //32 = 0x20
        case .AuthenticatedSignedWrites:                return "AuthenticatedSignedWrites"                  //40 = 0x40
        case .ExtendedProperties:                       return "ExtendedProperties"                         // = 0x80
        case .NotifyEncryptionRequired:                 return "NotifyEncryptionRequired"                   // = 0x100
        case .IndicateEncryptionRequired:               return "IndicateEncryptionRequired"                 // = 0x200
        }
    }
    
    var UIntValue : UInt {
        return UInt(self.rawValue)
    }
}

enum PackageType : String {
    case Information    = "信息包"
    case Begining       = "开始包"
    case Accessing      = "过程包"
    case Result         = "结果包"
    case Finish         = "结束包"
    case Unknown        = "未知包"
}