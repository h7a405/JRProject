//
//  RootViewController.swift
//  JZBLEMessage
//
//  Created by Jason.Chengzi on 16/01/31.
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
class RootViewController: UIViewController {
    //MARK: 储存变量 - Int/Float/Double/String
    //外围设备名称
    lazy var peripheralName: String = {
        let nameString = "Device " + String.generateRandomString()
        Log.VLog("生成的外围设备名：\(nameString)")
        return nameString
    }()
    //服务的UUID
    lazy var serviceUUID: String = {
        let uuidString = String.generateUUIDString()
        Log.VLog("生成的 Service UUID：\(uuidString)")
        return uuidString
    }()
    //特征的UUID
    lazy var characteristicUUID: String = {
        let uuidString = String.generateUUIDString()
        Log.VLog("生成的 Characteristic UUID：\(uuidString)")
        return uuidString
    }()
    //MARK: 集合类型 - Array/Dictionary/Tuple
    
    //MARK: 自定义类型 - Custom
    //中心设备管理器
    //用于搜索和建立连接
    lazy var centralManager: CBCentralManager = {
        //创建中心设备管理器并设置当前控制器视图为代理
        //系统蓝牙设备管理对象，可以把他理解为主设备，通过他，可以去扫描和链接外设
        return CBCentralManager(delegate: self, queue: nil)
    }()
    //连接的外围设备
    var peripherals: [CBPeripheral] = Array()
    var messages: [String] = Array() //
    //外围设备管理器
    //用于发送和建立连接
    lazy var peripheralManager: CBPeripheralManager = {
        return CBPeripheralManager(delegate: self, queue: nil)
    }()
    //订阅此外围设备特征的中心设备
    var centralM: [CBCentral] = Array()
    //中央设备的特征
    var characteristicM: CBMutableCharacteristic?
    //MARK: UIView子类 - UIView/UIControl/UIViewController
    @IBOutlet weak var tableView: UITableView!
    
    lazy var refreshControl: UIRefreshControl = {
        return UIRefreshControl()
    }()
    //MARK: Foundation - NS/CG/CA
    
    //MARK: 计算变量
    
    //MARK: 闭包与结构体 - Closure/Struct
    
    //MARK: 代理与数据源 - delegate/datasource
    
    //MARK: 重用 - Override/Required/Convenience
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.refreshControl.addTarget(self, action: "doRefresh", forControlEvents: .ValueChanged)
        self.refreshControl.attributedTitle = NSAttributedString(string: "刷新联系人列表", attributes: [NSFontAttributeName: UIFont.systemFontOfSize(15), NSForegroundColorAttributeName: UIColor.orangeColor()])

    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        self.tableView.addSubview(self.refreshControl)
        
        self.tableView.tableFooterView = UIView()
        
        Log.VLog(self.centralManager)
        Log.VLog(self.peripheralManager)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    /*
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
    */
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
}
//MARK: - 拓展
//MARK: 初始化与配置 - Initailize & Setup

//MARK: 操作与执行 - Action & Operation
extension RootViewController {
    //MARK: 外围设备的操作
    //创建特征、服务并添加服务到外围设备
    func setupService() {
        /*1.创建特征*/
        //创建特征的UUID对象
        let characteristicUUID: CBUUID = CBUUID(string: self.characteristicUUID)
        //特征值
        //创建特征
        /** 参数
        * uuid:特征标识
        * properties:特征的属性，例如：可通知、可写、可读等
        * value:特征值
        * permissions:特征的权限
        */
        self.characteristicM = CBMutableCharacteristic(type: characteristicUUID, properties: .Notify, value: nil, permissions: .Readable)
        /*创建服务并且设置特征*/
        //创建服务UUID对象
        let serviceUUID: CBUUID = CBUUID(string: self.serviceUUID)
        //创建服务
        let serviceM: CBMutableService = CBMutableService(type: serviceUUID, primary: true)
        //设置服务的特征
        serviceM.characteristics = [self.characteristicM!]
        /*将服务添加到外围设备*/
        self.peripheralManager.addService(serviceM)
    }
    //更新特征值
    func updateCharacteristicValue(index: Int? = nil) {
        //特征值
        let valueStr: String = "\(self.peripheralName) - \(NSDate().toString())"
        if let value: NSData = NSString(string: valueStr).dataUsingEncoding(NSUTF8StringEncoding) {
            //更新特征值
            if index == nil {
                self.peripheralManager.updateValue(value, forCharacteristic: self.characteristicM!, onSubscribedCentrals: nil)
                self.writeToLog("更新特征值：" + valueStr + "到全体。")
            } else if self.peripherals.count > index! {
                self.peripheralManager.updateValue(value, forCharacteristic: self.characteristicM!, onSubscribedCentrals: [self.centralM[index!]])
                self.writeToLog("更新特征值：" + valueStr + "到指定中央设备\(self.peripherals[index!].name)。")
            }
            
        }
        self.refreshControl.endRefreshing()
    }
    /**
     *  记录日志
     *
     *  @param info 日志信息
     */
    func writeToLog(log: String) {
        Log.VLog(log)
    }
}
//MARK: 更新 - Update

//MARK: 判断 - Judgement

//MARK: 响应方法 - Selector
extension RootViewController {
    /**
     *  下拉刷新的响应方法
     */
    func doRefresh() {
        self.didSearchButtonClicked()
    }
    //创建外围设备
    @IBAction func didStartBarButtonClicked(sender: AnyObject) {
        Log.VLog(self.peripheralManager)
        self.writeToLog("外围 - 创建外围设备")
        self.peripheralManager.startAdvertising(nil)
    }
    @IBAction func didSearchButtonClicked() {
        self.writeToLog("中央 - 开始扫描外围设备：")
        //开始扫描周围的外设
        /*
        第一个参数nil就是扫描周围所有的外设，扫描到外设后会进入
        - (void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary *)advertisementData RSSI:(NSNumber *)RSSI;
        */
        self.centralManager.scanForPeripheralsWithServices(nil, options: [CBCentralManagerScanOptionAllowDuplicatesKey: true])
    }
    
    @IBAction func didUpdateBarButtonClicked(sender: AnyObject) {
        //        self.updateCharacteristicValue()
    }
}

//MARK: 回调 - Call back

//MARK: 数据源与代理 - DataSrouce & Delegate
//UITableViewDataSource
extension RootViewController: UITableViewDataSource {
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return ContactsSection.count
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case ContactsSection.Online.rawValue:
            return self.peripherals.count
        case ContactsSection.Offline.rawValue:
            return 0
        default:
            return 0
        }
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = "cell"
        var cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier)
        if cell == nil {
            cell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: cellIdentifier)
        }
        
        cell!.textLabel?.text = nil
        cell!.detailTextLabel?.text = nil
        cell!.accessoryType = .None
        
        if self.peripherals.count > indexPath.row {
            cell!.textLabel?.text = self.peripherals[indexPath.row].name
            if !self.messages[indexPath.row].isEmpty {
                cell!.detailTextLabel?.text = "发了一条消息，点击查看。"
                cell!.accessoryType = .DetailButton
            }
        }
        
        return cell!
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return ContactsSection.fromIndex(section).stringValue
    }
}
//UITableViewDelegate
extension  RootViewController: UITableViewDelegate {
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20
    }
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 5
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 44
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        if self.messages[indexPath.row].isEmpty {
            let message = String.generateRandomString(10)
            Log.VLog("即将发送的消息：\(message)")
            let alertController: UIAlertController = UIAlertController(title: "确认发送以下随机信息？", message: message, preferredStyle: .ActionSheet)
            let alertCancelAction = UIAlertAction(title: "不发了", style: .Cancel, handler: nil)
            let alertSendAction = UIAlertAction(title: "赶紧发！", style: .Destructive, handler: { (action : UIAlertAction) -> Void in
                self.updateCharacteristicValue(indexPath.row)
            })
            
            alertController.addAction(alertCancelAction)
            alertController.addAction(alertSendAction)
            
            self.navigationController?.presentViewController(alertController, animated: true, completion: nil)
        } else {
            let alertController = UIAlertController(title: "读取到的信息：", message: self.messages[indexPath.row], preferredStyle: .Alert)
            let alertCancelAction = UIAlertAction(title: "知道了", style: .Cancel, handler: { (action: UIAlertAction) -> Void in
                self.messages[indexPath.row] = ""
                self.tableView.reloadData()
            })
            
            alertController.addAction(alertCancelAction)
            
            self.navigationController?.presentViewController(alertController, animated: true, completion: nil)
        }

    }
}
//MARK: CBCentralManagerDelegate
extension RootViewController: CBCentralManagerDelegate {
    //中心服务器状态更新后
    //扫描外设（discover），扫描外设的方法我们放在centralManager成功打开的委托中，因为只有设备成功打开，才能开始扫描，否则会报错。
    func centralManagerDidUpdateState(central: CBCentralManager) {
        switch central.state {
        case .PoweredOn:
            self.writeToLog("中央 - 已开启。")
            //            central.scanForPeripheralsWithServices(nil, options: [CBCentralManagerScanOptionAllowDuplicatesKey: true])
            
        default:
            self.writeToLog("此设备不支持BLE或未打开蓝牙功能，无法作为中央设备.")
        }
    }
    //扫描到设备会进入方法
    /**
    *  发现外围设备
    *
    *  @param central           中心设备
    *  @param peripheral        外围设备
    *  @param advertisementData 特征数据
    *  @param RSSI              信号质量（信号强度）
    */
    func centralManager(central: CBCentralManager, didDiscoverPeripheral peripheral: CBPeripheral, advertisementData: [String : AnyObject], RSSI: NSNumber) {
        self.writeToLog("中央 - 发现外围设备。信号强度：\(RSSI)，设备名称：\(peripheral.name ?? "")")
        //接下来连接设备
        //停止扫描
        if self.peripherals.count == 7 {
            self.centralManager.stopScan()
        }
        self.writeToLog("中央 - 停止扫描外围设备。")
        //连接外围设备
        //添加保存外围设备，注意如果这里不保存外围设备（或者说peripheral没有一个强引用，无法到达连接成功（或失败）的代理方法，因为在此方法调用完就会被销毁
        if !self.peripherals.contains(peripheral) {
            self.writeToLog("中央 - 保存外围设备信息。\(peripheral.name ?? "")")
            self.peripherals.append(peripheral)
            self.messages.append("")
        }
        self.writeToLog("中央 - 开始连接外围设备...")
        //连接设备
        self.centralManager.connectPeripheral(peripheral, options: nil)
    }
    //连接到Peripherals-成功
    func centralManager(central: CBCentralManager, didConnectPeripheral peripheral: CBPeripheral) {
        self.writeToLog("中央 - >>>连接到名称为（\(peripheral.name)）的设备-成功")
        //设置外围设备的代理为当前视图控制器
        //设置的peripheral委托CBPeripheralDelegate
        //@interface ViewController : UIViewController<CBCentralManagerDelegate,CBPeripheralDelegate>
        peripheral.delegate = self
        //外围设备开始寻找服务
        //扫描外设Services，成功后会进入方法：-(void)peripheral:(CBPeripheral *)peripheral didDiscoverServices:(NSError *)error{
        self.writeToLog("外围 - 开始寻找服务...")
        peripheral.discoverServices([CBUUID(string: self.serviceUUID)])
        
        self.tableView.reloadData()
    }
    //连接到Peripherals-失败
    func centralManager(central: CBCentralManager, didFailToConnectPeripheral peripheral: CBPeripheral, error: NSError?) {
        self.writeToLog("中央 - >>>连接到名称为（\(peripheral.name)）的设备-失败,原因：\(error)")
    }
}
//MARK: CBPeripheralDelegate
extension RootViewController: CBPeripheralDelegate {
    //外围设备寻找到服务后
    func peripheral(peripheral: CBPeripheral, didDiscoverServices error: NSError?) {
        self.writeToLog("外围 - 已发现可用服务.")
        
        guard error == nil else {
            self.writeToLog("外围 - 寻找服务过程中发生错误，错误信息：\(error?.localizedDescription)")
            return
        }
        //遍历查找到的服务
        self.writeToLog("外围 - 开始遍历查找到的服务...")
        let serviceUUID: CBUUID = CBUUID(string: self.serviceUUID)
        let characteristicUUID: CBUUID = CBUUID(string: self.characteristicUUID)
        if let services = peripheral.services {
            for service in services {
                if service.UUID == serviceUUID {
                    //外围设备查找指定服务中的特征
                    self.writeToLog("外围 - 开始在外围设备查找指定服务中的特征...")
                    //扫描每个service的Characteristics，扫描到后会进入方法： -(void)peripheral:(CBPeripheral *)peripheral didDiscoverCharacteristicsForService:(CBService *)service error:(NSError *)error
                    peripheral.discoverCharacteristics([characteristicUUID], forService: service)
                }
            }
        }
        self.writeToLog("外围 - 寻找可用服务结束。")
    }
    //外围设备寻找到特征后
    func peripheral(peripheral: CBPeripheral, didDiscoverCharacteristicsForService service: CBService, error: NSError?) {
        self.writeToLog("外围 - 已发现可用特征。")
        
        guard error == nil else {
            self.writeToLog("外围 - 找特征过程中发生错误，错误信息：\(error?.localizedDescription)")
            return
        }
        
        //遍历服务中的特征
        self.writeToLog("外围 - 开始遍历服务中的特征...")
        let serviceUUID: CBUUID = CBUUID(string: self.serviceUUID)
        let characteristicUUID: CBUUID = CBUUID(string: self.characteristicUUID)
        
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
        
        guard error == nil else {
            self.writeToLog("外围 - 更新通知状态时发生错误，错误信息：\(error?.localizedDescription)")
            return
        }
        
        //!注意，value的类型是NSData，具体开发时，会根据外设协议制定的方式去解析数据
        
        //给特征值设置新的值
        let characteristicUUID: CBUUID = CBUUID(string: self.characteristicUUID)
        if characteristicUUID.UUIDString == self.characteristicUUID {
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
            for (index, peripheralT) in self.peripherals.enumerate() {
                if peripheralT == peripheral {
                    self.messages[index] = String(valueString)
                    self.tableView.reloadData()
//                    Log.VLog("index:\(index)")
                    break
                }
            }
        } else {
            self.writeToLog("外围 - 未发现特征值。")
        }
    }
}

//MARK: CBPeripheralManager代理方法
extension RootViewController: CBPeripheralManagerDelegate {
    //外围设备状态发生变化后调用
    func peripheralManagerDidUpdateState(peripheral: CBPeripheralManager) {
        switch peripheralManager.state {
        case .PoweredOn:
            self.writeToLog("外围 - 广播功能已开启，即将开始广播。")
            //添加服务
            self.setupService()
        default:
            self.writeToLog("此设备不支持BLE或未打开蓝牙功能，无法作为外围设备.")
//            SVProgressHUD.showErrorWithStatus("设备不支持。")
        }
    }
    //外围设备添加服务后调用
    func peripheralManager(peripheral: CBPeripheralManager, didAddService service: CBService, error: NSError?) {
        guard error == nil else {
            self.writeToLog("外围 - 添加服务失败，错误详情：\(error?.localizedDescription ?? "")")
            return
        }
        //添加服务后开始广播
        //广播设置
        let dic = [CBAdvertisementDataLocalNameKey: self.peripheralName]
        //开始广播
        self.peripheralManager.startAdvertising(dic)
        self.writeToLog("外围 - 广播名：\(self.peripheralName)\n广播UUID：\(self.serviceUUID)\n特征UUID：\(self.characteristicUUID)\n添加了服务并开始广播，现已可被发现。")
    }
    func peripheralManagerDidStartAdvertising(peripheral: CBPeripheralManager, error: NSError?) {
        guard error == nil else {
            self.writeToLog("外围 - 启动广播过程中发生错误，错误信息：\(error?.localizedDescription ?? "")")
            return
        }
        self.writeToLog("外围 - 正在广播中。")
    }
    //订阅特征
    func peripheralManager(peripheral: CBPeripheralManager, central: CBCentral, didSubscribeToCharacteristic characteristic: CBCharacteristic) {
        self.writeToLog("外围 - 已订阅特征：\(characteristic.UUID.UUIDString)")
        //发现中心设备并存储
        if !self.centralM.contains(central) {
            self.centralM.append(central)
        }
    }
    //取消订阅特征
    func peripheralManager(peripheral: CBPeripheralManager, central: CBCentral, didUnsubscribeFromCharacteristic characteristic: CBCharacteristic) {
        Log.VLog("外围 - 已取消订阅特征：\(characteristic.UUID.UUIDString)")
    }
    func peripheralManager(peripheral: CBPeripheralManager, didReceiveWriteRequests requests: [CBATTRequest]) {
        Log.VLog("外围 - didReceiveWriteRequests")
    }
    func peripheralManager(peripheral: CBPeripheralManager, willRestoreState dict: [String : AnyObject]) {
        Log.VLog("外围 - willRestoreState")
    }
}

//MARK: 设置 - Setter

//MARK: 获取 - Getter

//MARK: - 其他
//MARK: 协议  -   Protocol

//MARK: 枚举  -   Enumeration
enum ContactsSection: Int {
    case Online = 0
    case Offline
    
    static var count: Int {
        return 2
    }
    
    var stringValue: String {
        switch self {
        case .Offline:
            return "离线"
        case .Online:
            return "在线"
        }
    }
    
    var toString: String {
        switch self {
        case .Offline:
            return "Offline"
        case .Online:
            return "Online"
        }
    }
    
    static func fromIndex(index: Int) -> ContactsSection {
        return ContactsSection(rawValue: index) ?? ContactsSection.Offline
    }
    static func fromString(string: String) -> ContactsSection {
        if string == ContactsSection.Online.toString {
            return .Online
//        } else if string == ContactsSection.Offline.toString {
        } else {
            return .Offline
        }
    }
}