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
import SVProgressHUD
//MARK: - 类函数
class ViewController: UIViewController {
    //MARK: 类属性
    let peripheralName : String = String("Heart Rate Simulate Monitor")
    let serviceUUID : CBUUID = CBUUID(string: "3655296F-96CE-44D4-912D-CD83F06E7E7E")
    let characteristicUUIDReadable : CBUUID = CBUUID(string: "C22D1ECA-0F78-463B-8C21-688A517D7D2B")
    let characteristicUUIDWriteable : CBUUID = CBUUID(string: "632FB3C9-2078-419B-83AA-DBC64B5B685A")
    //MARK: 储存 - Int/Float/Double/String/Bool
    var dataPointer: Int = 0
    var isDetecting: Bool = false
    //MARK: 集合 - Array/Dictionary/Tuple
    var heartRateDatas: [Int] = Array() //模拟心率数据。只保存10条。
    var subscribedCentral: [CBCentral] = Array()
    //MARK: UIView - UIView/UIControl/UIViewController
    @IBOutlet weak var logs: UITextView!
    @IBOutlet weak var detectButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    //MARK: Foundation - NS/CG/CA/CF
    
    //MARK: 其他类 - Imported/Included
    // 创建一个Peripheral管理器
    // 我们将当前类作为peripheralManager，因此必须实现CBPeripheralManagerDelegate
    // 第二个参数如果指定为nil，则默认使用主队列
    lazy var peripheralManager : CBPeripheralManager = { return CBPeripheralManager(delegate: self, queue: nil )}()
    
    lazy var characteristicReadable : CBMutableCharacteristic = { return CBMutableCharacteristic(type: self.characteristicUUIDReadable, properties: .Notify, value: nil, permissions: .Readable) }()
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
        
        self.stopButton.enabled = false
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
    func doStartGCDTimer() {
        self.writeLog("检测仪 - 开始检测心率数据...")
        let queue: dispatch_queue_t = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0) //Initate the queue object
        let _timer: dispatch_source_t = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue)
        dispatch_source_set_timer(_timer, dispatch_walltime(UnsafePointer(), 0), 10 * NSEC_PER_SEC, 0) //每10秒生成一次
        dispatch_source_set_event_handler(_timer, {()
            if !self.isDetecting { //count down finished
                dispatch_source_cancel(_timer)
                dispatch_async(dispatch_get_main_queue(), {()
                    
                })
            } else {
                dispatch_async(dispatch_get_main_queue(), {()
                    if self.dataPointer > 9 {
                        self.dataPointer = 0
                    }
                    let heartRate: Int = 60 + Int(arc4random_uniform(120))
                    if self.heartRateDatas.count > self.dataPointer {
                        self.heartRateDatas[self.dataPointer] = heartRate
                    } else {
                        self.heartRateDatas.append(heartRate)
                    }
                    Log.VLog("heart rate: \(heartRate)")
                })
                self.dataPointer++
            }
        })
        dispatch_resume(_timer)
    }
    
    //更新特征值
    func updateCharacteristicValue() {
        //特征值
        let valueStr: String = "[\(NSDate().toString())]:\(self.heartRateDatas.toString())"
        if let value: NSData = NSString(string: valueStr).dataUsingEncoding(NSUTF8StringEncoding) {
            //更新特征值
            self.peripheralManager.updateValue(value, forCharacteristic: self.characteristicReadable, onSubscribedCentrals: nil)
            self.writeLog("上传的数据为：" + valueStr)
        }
    }
    
    func writeLog(log : String) {
        Log.VLog(log)
        self.logs.append(log)
    }
}
//MARK: 响应方法 - Selector - didX()
extension ViewController {
    @IBAction func didStartAdvertisingButtonClicked(sender : AnyObject) {
        self.logs.clean()
        
        Log.VLog(self.peripheralManager)
        
        self.writeLog("监测仪 - 已启动。")
        
        (sender as? UIBarButtonItem)?.enabled = false
        (sender as? UIBarButtonItem)?.title = "已启动"
        
//        self.doStartGCDTimer()
    }
    @IBAction func didUploadDataButtonClicked(sender : AnyObject) {
        self.writeLog("监测仪 - 开始上传数据...")
        self.updateCharacteristicValue()
    }
    @IBAction func didDectectButtonClicked(sender: AnyObject) {
        self.doStartGCDTimer()
        self.isDetecting = true
        (sender as? UIButton)?.enabled = false
        self.stopButton.enabled = true
    }
    @IBAction func didStopButtonClicked(sender: AnyObject) {
        
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
        self.writeLog("监测仪 - 状态更改")
        switch peripheral.state {
        case .PoweredOn:
            self.writeLog(" * Powered On * ")
            self.peripheralManager.addService(self.service)
        case .PoweredOff:
            self.writeLog(" * Powered Off * ")
        case .Unsupported:
            self.writeLog("监测仪 - 此设备不支持BLE或未打开蓝牙功能，无法作为外围设备。")
        default:
            break
        }
    }
    
    func peripheralManager(peripheral: CBPeripheralManager, didAddService service: CBService, error: NSError?) {
        guard error == nil else {
            self.writeLog("监测仪 - 在添加检测服务的时候发生了错误！错误信息： \(error?.localizedDescription ?? "")")
            self.navigationItem.leftBarButtonItem?.enabled = true
            self.navigationItem.leftBarButtonItem?.title = "开机"
            self.navigationItem.rightBarButtonItem?.enabled = false
            return
        }
        self.navigationItem.rightBarButtonItem?.enabled = true
        self.navigationItem.leftBarButtonItem?.enabled = false
        self.navigationItem.leftBarButtonItem?.title = "已启动"
        
        self.writeLog("监测仪 - 检测服务添加成功，开始广播。")
        
        self.peripheralManager.startAdvertising([
            CBAdvertisementDataLocalNameKey: self.peripheralName,
            CBAdvertisementDataServiceUUIDsKey: [self.serviceUUID]
        ])
    }
    
    func peripheralManagerDidStartAdvertising(peripheral: CBPeripheralManager, error: NSError?) {
        guard error == nil else {
            self.writeLog("监测仪 - 广播过程中发生错误，错误信息： \(error?.localizedDescription ?? "")")
            return
        }
        self.writeLog("监测仪 - 已成功广播。等待连接...")
    }
    
    func peripheralManager(peripheral: CBPeripheralManager, didReceiveReadRequest request: CBATTRequest) {
        self.writeLog("监测仪 - 中央设备请求读取心率数据。")
        // 查看请求的特性是否是指定的特性
        if request.characteristic.UUID == self.characteristicUUIDReadable {
            if let value = self.characteristicReadable.value {
            // 确保读请求所请求的偏移量没有超出我们的特性的值的长度范围
            // offset属性指定的请求所要读取值的偏移位置
            if request.offset > value.length {
                self.writeLog("监测仪 - 中央设备请求的数据长度超限。")
                self.peripheralManager.respondToRequest(request, withResult: .InvalidOffset)
            } else {
                // 如果读取位置未越界，则将特性中的值的指定范围赋给请求的value属性。
                request.value = value.subdataWithRange(NSRange(location: request.offset, length: value.length - request.offset))
                // 对请求作出成功响应
                self.peripheralManager.respondToRequest(request, withResult: .Success)
                }
            } else {
                self.writeLog("监测仪 - 请求的特征没有数据。")
            }
        } else {
            self.writeLog("监测仪 - 错误的请求")
        }
    }
    
    func peripheralManager(peripheral: CBPeripheralManager, didReceiveWriteRequests requests: [CBATTRequest]) {
        let request = requests[0]
        self.characteristicReadable.value = request.value
        self.peripheralManager.respondToRequest(request, withResult: .Success)
    }
    
    func peripheralManager(peripheral: CBPeripheralManager, central: CBCentral, didSubscribeToCharacteristic characteristic: CBCharacteristic) {
        self.writeLog("监测仪 - 发现中央设备尝试订阅特征： \(characteristic.UUID.UUIDString ?? "")")
        //发现中心设备并存储
        if !self.subscribedCentral.contains(central) {
            self.subscribedCentral.append(central)
            self.writeLog("监测仪 - 设备已保存。")
        } else {
            self.writeLog("监测仪 - 已连接的设备。")
        }
    }
    
    func peripheralManager(peripheral: CBPeripheralManager, central: CBCentral, didUnsubscribeFromCharacteristic characteristic: CBCharacteristic) {
        self.writeLog("监测仪 - 中央设备取消订阅特征：\(characteristic.UUID.UUIDString ?? "")")
        if self.subscribedCentral.contains(central) {
            for (index, sCentral) in self.subscribedCentral.enumerate() {
                if sCentral == central {
                    self.subscribedCentral.removeAtIndex(index)
                    self.writeLog("监测仪 - 中央设备已移除。")
                    break
                }
            }
        } else {
            self.writeLog("监测仪 - 没有该中央设备信息。")
        }
    }
}
//MARK: - 其他
//MARK: 全局

//MARK: 协议  -   Protocol

//MARK: 枚举  -   Enumeration
