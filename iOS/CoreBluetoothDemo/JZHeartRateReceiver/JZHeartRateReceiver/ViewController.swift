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
import SVProgressHUD
//MARK: - 类函数
class ViewController: UIViewController {
    //MARK: 类属性
    let peripheralName : String = String("Heart Rate Simulate Receiver")
    let serviceUUID : CBUUID = CBUUID(string: "3655296F-96CE-44D4-912D-CD83F06E7E7E")
    let characteristicUUIDReadable : CBUUID = CBUUID(string: "C22D1ECA-0F78-463B-8C21-688A517D7D2B")
    let characteristicUUIDWriteable : CBUUID = CBUUID(string: "632FB3C9-2078-419B-83AA-DBC64B5B685A")
    //MARK: 储存 - Int/Float/Double/String/Bool
    var isScanning : Bool = false
    //MARK: 集合 - Array/Dictionary/Tuple
    var peripherals: [CBPeripheral] = Array()    //连接的外围设备
    var messages: [String] = Array()
    //MARK: UIView - UIView/UIControl/UIViewController
    
    @IBOutlet weak var tableView: UITableView!
    //MARK: Foundation - NS/CG/CA/CF
    
    //MARK: 其他类 - Imported/Included
    // 指定当前类为代理对象，所以其需要实现CBCentralManagerDelegate协议
    // 如果queue为nil，则Central管理器使用主队列来发送事件
    lazy var centralManager : CBCentralManager = { return CBCentralManager(delegate: self, queue: nil) }()
    
    var characteristicWriteable : CBCharacteristic?
    //MARK: 闭包与结构体 - Closure/Struct
    
    //MARK: 代理与数据源 - delegate/datasource
    
    //MARK: 自定义 - Customed
    
    //MARK: 计算 - Property Observers
    
    //MARK: 生命周期 - Life Cycle
    //初始化实例
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        Log.VLog("初始化中央设备：\(self.centralManager)")
    }
    //添加视图
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }
    //改变视图数据
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        self.tableView.tableFooterView = UIView()
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
extension ViewController {
    func doStartScanning() {
        self.isScanning = true
        
        Log.VLog("开始扫描周边设备...")
        SVProgressHUD.showWithMaskType(.Gradient)
        
        // 查找Peripheral设备
        // 如果第一个参数传递nil，则管理器会返回所有发现的Peripheral设备。
        // 通常我们会指定一个UUID对象的数组，来查找特定的设备
        self.centralManager.scanForPeripheralsWithServices([self.serviceUUID], options: nil)
    }
    func doConnectToPeripherals() {
        if self.isScanning == false {
            for peripheral in self.peripherals {
                //连接外围设备
                self.centralManager.connectPeripheral(peripheral, options: nil)
                Log.VLog("尝试连接到设备\(peripheral.name ?? "")。")
            }
        }
    }
}
//MARK: 响应方法 - Selector - didX()
extension ViewController {
    @IBAction func didScanDevicesButtonClicked(sender : AnyObject) {
        self.doStartScanning()
    }
}
//MARK: 回调 - Call Back - doneX()

//MARK: 判断 - Judgement - checkX() -> Bool, isX() -> Bool, hasX() -> Bool

//MARK: 更新 - Updater - updateX()

//MARK: 设置 - Setter - setX(), resetX(), changeX()

//MARK: 获取 - Getter - getX(), acquiredX(), requestX()

//MARK: 数据源与代理 - DataSrouce & Delegate
//MARK: UITableViewDataSource
extension ViewController : UITableViewDataSource {
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.peripherals.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = "cell"
        var cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier)
        if cell == nil {
            cell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: cellIdentifier)
        }
        cell!.textLabel?.text = nil
        cell!.detailTextLabel?.text = nil
        
        if self.peripherals.count > indexPath.row {
            cell!.textLabel?.text = self.peripherals[indexPath.row].name
        }
        if self.messages.count > indexPath.row {
            cell!.detailTextLabel?.text = self.messages[indexPath.row]
        }
        
        return cell!
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return nil
    }
    func tableView(tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return nil
    }
}
//MARK: UITableViewDelegate
extension ViewController : UITableViewDelegate {
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 60
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        let alertController = UIAlertController(title: nil, message: "请选择：", preferredStyle: .ActionSheet)
        let cancelAction = UIAlertAction(title: "返回", style: .Cancel, handler: nil)
        let fetchAction = UIAlertAction(title: "获取数据", style: .Destructive) { (action: UIAlertAction) -> Void in
            if self.peripherals.count > indexPath.row {
                let peripheral = self.peripherals[indexPath.row]
                let data = NSString(string: "fetch").dataUsingEncoding(NSUTF8StringEncoding)
                Log.VLog("向外围设备\(peripheral.name ?? "")发送数据。")
                if self.characteristicWriteable?.properties == .Write {
                    peripheral.writeValue(data!, forCharacteristic: self.characteristicWriteable!, type: .WithResponse)
                } else {
                    Log.VLog("没有向该特征写入数据的权限。")
                }
            }
        }
        let cleanAction = UIAlertAction(title: "清除数据", style: .Default) { (action: UIAlertAction) -> Void in
            if self.messages.count > indexPath.row {
                self.messages[indexPath.row] = ""
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    tableView.beginUpdates()
                    tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
                    tableView.endUpdates()
                })
            }
        }
        
        alertController.addAction(cancelAction)
        alertController.addAction(fetchAction)
        alertController.addAction(cleanAction)
        
        self.presentViewController(alertController, animated: true, completion: nil)
    }
}
//MARK: CBCentralManagerDelegate
extension ViewController : CBCentralManagerDelegate {
    func centralManagerDidUpdateState(central: CBCentralManager) {
        Log.VLog("中央设备状态变更：")
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
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
            SVProgressHUD.dismiss()
        })
        Log.VLog("扫描到设备: \(peripheral.name ?? "")")
        // 当我们查找到Peripheral端时，我们可以停止查找其它设备，以节省电量
        if !self.peripherals.contains(peripheral) {
            //添加保存外围设备，注意如果这里不保存外围设备（或者说peripheral没有一个强引用，无法到达连接成功（或失败）的代理方法，因为在此方法调用完就会被销毁
            Log.VLog("中央 - 保存外围设备信息。\(peripheral.name ?? "")")
            self.peripherals.append(peripheral)
            self.messages.append("")
//            centralManager.stopScan()
            let alertController = UIAlertController(title: nil, message: "已扫描到新的设备：\(peripheral.name ?? "")，是否继续扫描其它？", preferredStyle: .ActionSheet)
            let cancelAction = UIAlertAction(title: "停止扫描", style: .Cancel, handler: { (action: UIAlertAction) -> Void in
                self.centralManager.stopScan()
                self.isScanning = false
                
                Log.VLog("已停止扫描。")
                
                self.doConnectToPeripherals()
            })
            let confirmAction = UIAlertAction(title: "继续扫描", style: .Default, handler: { (action: UIAlertAction) -> Void in
                SVProgressHUD.showWithMaskType(.Gradient)
                self.isScanning = true
                Log.VLog("继续扫描。")
            })
            
            alertController.addAction(cancelAction)
            alertController.addAction(confirmAction)
            
            self.presentViewController(alertController, animated: true, completion: nil)
        } else {
            SVProgressHUD.showInfoWithStatus("没有发现其他设备。")
            Log.VLog("没有发现其他设备。")
            self.centralManager.stopScan()
        }
    }
    
    func centralManager(central: CBCentralManager, didConnectPeripheral peripheral: CBPeripheral) {
        Log.VLog("中央 - 连接外围设备成功!")
        
        self.tableView.reloadData()
        
        //设置外围设备的代理为当前视图控制器
        peripheral.delegate = self
        //外围设备开始寻找服务
        Log.VLog("外围 - 开始寻找服务...")
        peripheral.discoverServices([self.serviceUUID])
    }
    //断开连接
    func centralManager(central: CBCentralManager, didDisconnectPeripheral peripheral: CBPeripheral, error: NSError?) {
        Log.VLog("中央 - 已与设备\(peripheral.name ?? "")断开连接。")
        if self.peripherals.contains(peripheral) {
            for (index, peripheralT) in self.peripherals.enumerate() {
                if peripheralT == peripheral {
                    self.peripherals.removeAtIndex(index)
                    Log.VLog("设备\(peripheral.name ?? "")已被移除。")
                }
            }
        }
    }
    //连接外围设备失败
    func centralManager(central: CBCentralManager, didFailToConnectPeripheral peripheral: CBPeripheral, error: NSError?) {
        Log.VLog("中央 - 连接外围设备失败！错误信息：\(error)")
    }
    
    
}
//MARK: CBPeripheralDelegate
extension ViewController : CBPeripheralDelegate {
    func peripheral(peripheral: CBPeripheral, didDiscoverServices error: NSError?) {
        guard error == nil else {
            Log.VLog("Discovering services failed with error message: \(error?.localizedDescription ?? "")")
            return
        }
        Log.VLog("外围 - 已发现可用服务.")
        if let services = peripheral.services {
            Log.VLog("外围 - 开始遍历查找到的服务...")
            for service in services {
                Log.VLog("外围 - 开始在外围设备查找指定服务中的特征...")
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
        Log.VLog("外围 - 已发现可用特征。")
        if let characteristics = service.characteristics {
            Log.VLog("外围 - 开始遍历遍历服务中的特征...")
            for characteristic in characteristics {
                //                peripheral.readValueForCharacteristic(characteristic)
                if characteristic.UUID == self.characteristicUUIDReadable {
                    Log.VLog("订阅特征: \(characteristic)")
                    peripheral.setNotifyValue(true, forCharacteristic: characteristic)
                } else if characteristic.UUID == self.characteristicUUIDWriteable {
                    self.characteristicWriteable = (characteristic as? CBMutableCharacteristic)
                }
            }
        } else {
            Log.VLog("No characteristic in service: \(service)")
        }
    }
    func peripheral(peripheral: CBPeripheral, didUpdateNotificationStateForCharacteristic characteristic: CBCharacteristic, error: NSError?) {
        if error != nil {
            Log.VLog("Notifying update failed with error message: \(error?.localizedDescription ?? "") in characteristic: \(characteristic)")
        }
        
        Log.VLog("外围 - 收到外围设备的特征更新通知。")
        
        //给特征值设置新的值
        if characteristic.isNotifying {
            if characteristic.properties == .Notify {
                Log.VLog("外围 - 已订阅特征通知.")
                return
            } else if characteristic.properties == .Read {
                //从外围设备读取新值,调用此方法会触发代理方法：-(void)peripheral:(CBPeripheral *)peripheral didUpdateValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error
                peripheral.readValueForCharacteristic(characteristic)
            }
        } else {
            Log.VLog("外围 - 已停止.")
            //取消连接
            self.centralManager.cancelPeripheralConnection(peripheral)
        }
    }
    func peripheral(peripheral: CBPeripheral, didUpdateValueForCharacteristic characteristic: CBCharacteristic, error: NSError?) {
        guard error == nil else {
            Log.VLog("外围 - 更新特征值时发生错误，错误信息：\(error?.localizedDescription ?? "")")
            return
        }
        if let value = characteristic.value {
            let valueString = NSString(data: value, encoding: NSUTF8StringEncoding)
            Log.VLog(String(valueString ?? ""))
            for (index, peripheralT) in self.peripherals.enumerate() {
                if peripheral == peripheralT {
                    self.messages[index] = String(valueString ?? "")
                    self.tableView.beginUpdates()
                    self.tableView.reloadRowsAtIndexPaths([NSIndexPath(forRow: index, inSection: 0)], withRowAnimation: .Automatic)
                    self.tableView.endUpdates()
                }
            }
        } else {
            Log.VLog("外围 - 未发现特征值。")
        }
    }
}
//MARK: - 其他
//MARK: 全局

//MARK: 协议  -   Protocol

//MARK: 枚举  -   Enumeration
