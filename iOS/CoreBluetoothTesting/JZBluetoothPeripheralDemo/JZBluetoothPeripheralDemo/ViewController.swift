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
    let kPeripheralName: String = "JZBluetooth Testing Device"  //外围设备名称
    let kServiceUUID: String = "C4FB2349-72FE-4CA2-94D6-1F3CB16331EE"   //服务的UUID
    let kCharacteristicUUID: String = "6A3E4B28-522D-4B3B-82A9-D5E2004534FC"    //特征的UUID
    //MARK: 储存变量 - Int/Float/Double/String
    
    //MARK: 集合类型 - Array/Dictionary/Tuple
    
    //MARK: 自定义类型 - Custom
    lazy var peripheralManager: CBPeripheralManager = {
        return CBPeripheralManager(delegate: self, queue: nil)
    }()   //外围设备管理器
    var centralM: [CBCentral] = Array()  //订阅此外围设备特征的中心设备
    var characteristicM: CBMutableCharacteristic?   //特征
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
    //创建特征、服务并添加服务到外围设备
    func setupService() {
        /*1.创建特征*/
        //创建特征的UUID对象
        let characteristicUUID: CBUUID = CBUUID(string: self.kCharacteristicUUID)
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
        let serviceUUID: CBUUID = CBUUID(string: self.kServiceUUID)
        //创建服务
        let serviceM: CBMutableService = CBMutableService(type: serviceUUID, primary: true)
        //设置服务的特征
        serviceM.characteristics = [self.characteristicM!]
        /*将服务添加到外围设备*/
        self.peripheralManager.addService(serviceM)
    }
    //更新特征值
    func updateCharacteristicValue() {
        //特征值
        let valueStr: String = "\(self.kPeripheralName) - \(NSDate().toString())"
        if let value: NSData = NSString(string: valueStr).dataUsingEncoding(NSUTF8StringEncoding) {
            //更新特征值
            self.peripheralManager.updateValue(value, forCharacteristic: self.characteristicM!, onSubscribedCentrals: nil)
            self.writeToLog("更新特征值：" + valueStr)
        }
    }
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
    //创建外围设备
    @IBAction func didStartBarButtonClicked(sender: AnyObject) {
        self.textView.clean()
        Log.VLog(self.peripheralManager)
        self.writeToLog("创建外围设备")
    }
    @IBAction func didUpdateBarButtonClicked(sender: AnyObject) {
        self.updateCharacteristicValue()
    }
}
//MARK: 回调 - Call back

//MARK: 数据源与代理 - DataSrouce & Delegate
//CBPeripheralManager代理方法
extension ViewController: CBPeripheralManagerDelegate {
    //外围设备状态发生变化后调用
    func peripheralManagerDidUpdateState(peripheral: CBPeripheralManager) {
        switch peripheralManager.state {
        case .PoweredOn:
            self.writeToLog("外围 - 已开启。")
            //添加服务
            self.setupService()
        default:
            self.writeToLog("此设备不支持BLE或未打开蓝牙功能，无法作为外围设备.")
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
        let dic = [CBAdvertisementDataLocalNameKey: self.kPeripheralName]
        //开始广播
        self.peripheralManager.startAdvertising(dic)
        self.writeToLog("外围 - 添加了服务并开始广播。\n广播名：\(self.kPeripheralName)\n广播UUID：\(self.kServiceUUID)")
    }
    func peripheralManagerDidStartAdvertising(peripheral: CBPeripheralManager, error: NSError?) {
        guard error == nil else {
            self.writeToLog("外围 - 启动广播过程中发生错误，错误信息：\(error?.localizedDescription ?? "")")
            return
        }
        self.writeToLog("外围 - 广播已启动。")
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
        Log.VLog("didUnsubscribeFromCharacteristic")
    }
    func peripheralManager(peripheral: CBPeripheralManager, didReceiveWriteRequests requests: [CBATTRequest]) {
        Log.VLog("didReceiveWriteRequests")
    }
    func peripheralManager(peripheral: CBPeripheralManager, willRestoreState dict: [String : AnyObject]) {
        Log.VLog("willRestoreState")
    }
}
//MARK: 设置 - Setter

//MARK: 获取 - Getter

//MARK: - 其他
//MARK: 协议  -   Protocol

//MARK: 枚举  -   Enumeration