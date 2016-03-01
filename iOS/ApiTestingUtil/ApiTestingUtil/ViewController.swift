//
//  ViewController.swift
//  ApiTestingUtil
//
//  Created by Jason.Chengzi on 16/01/20.
//  Copyright © 2016年 hvit. All rights reserved.
//
//MARK: - 类注释
/**
*
*/

//MARK: - 类描述
///

//MARK: - 头文件
import UIKit

//MARK: - class函数
class ViewController: UIViewController {
    //MARK: 储存变量 - Int/Float/Double/String/Bool
    var currentProjectIndex = 0 //当前项目标记
    var currentApiIndex = 0 //当前api标记
    var currentApiRepeatCount = 0   //api重复次数
    
    var hasNextProject = false  //是否有下一个项目
    var isRepeatApi = false //是否重复当前api
    //MARK: 集合类型 - Array/Dictionary/Tuple
    var projects: [Project] = Array()   //项目列表
    var abnormalList: [Api] = Array()   //含有异常api的项目列表
    var failedList: [Api] = Array() //含有失败api的项目列表
    //MARK: 自定义类型 - Custom
    var status: TestingStatus = .Prepared   //当前状态
    //MARK: UIView子类 - UIView/UIControl/UIViewController
    @IBOutlet weak var loadLabel: UILabel!
    @IBOutlet weak var loadButton: UIButton!
    
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var restartButton: UIButton!
    
    @IBOutlet weak var resultTextView: UITextView!
    
    @IBOutlet weak var resultButton: UIButton!
    
    @IBOutlet weak var normalLabel: UILabel!
    @IBOutlet weak var abnormalLabel: UILabel!
    @IBOutlet weak var failedLabel: UILabel!
    //MARK: Foundation - NS/CG/CA
    
    //MARK: 计算变量
    
    //MARK: 闭包与结构体 - Closure/Struct
    
    //MARK: 代理与数据源 - delegate/datasource
    
    //MARK: 重用 - Override/Required/Convenience
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
//        self.loadDatas()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let _ = segue.destinationViewController as? ResultTableViewController {
            
        }
    }
}
//MARK: - 拓展
//MARK: 初始化与配置 - Initailize & Setup

//MARK: 操作与执行 - Action & Operation
extension ViewController {
    func loadDatas() {
        var status = self.status
        var hasNext = false
        var text = ""
        if let filePath = NSBundle.mainBundle().pathForResource("data", ofType: "plist") {
            if let projectArray = NSArray(contentsOfFile: filePath) {
                for object in projectArray {
                    if let dictionary = object as? [String : AnyObject] {
                        self.projects.append(Project(data: dictionary))
                    }
                    if self.projects.count > 0 {
                        for project in self.projects {
                            print(project.toString())
                        }
                        text = "提取数据成功。"
                        hasNext = true
                        status = .Loaded
                        
                        var totalNum = 0
                        for project in self.projects {
                            totalNum += project.apis.count
                        }
                        
                        self.normalLabel.text = "\(totalNum)"
                        
                    } else {
                        status = .LoadedFailure
                        text = ("提取数据失败。")
                        hasNext = false
                    }
                }
            } else {
                status = .LoadedFailure
                text = ("提取数据失败。")
                hasNext = false
            }
        } else {
            status = .LoadedFailure
            text = ("没有数据文件。")
            hasNext = false
        }
        self.hasNextProject = hasNext
        self.status = status
        self.resultTextView.append(text)
        
        self.updateStatus()
    }
    
    
    func startTesting() {
        if self.hasNextProject {
            self.resultTextView.append("开始测试……")
            
            self.goNextProject()
        } else {
            self.resultTextView.append("没有测试数据，测试中止。")
            
            self.status = .Abort
            self.updateStatus()
        }
    }
    func endTesting() {
        self.status = .Finished
        self.updateStatus()
        
        self.reset()
    }
    
    func checkGoNextApi() {
        switch self.status {
        case .Running:
            self.goNextApi()
        default:
            break
        }
    }
    
    func goNextProject() {
        self.resetProject()
        if self.currentProjectIndex + 1 <= self.projects.count {
            let project = self.projects[self.currentProjectIndex]
            
            self.resultTextView.append("\n开始测试项目：[\(self.currentProjectIndex + 1)]\(project.name)")
            
            guard project.apis.count > 0 else {
                self.resultTextView.append("\n没有接口数据，项目：\(project.name)结束。")
                
                self.goNextProject()
                
                return
            }
            
            self.checkGoNextApi()
            
        } else {
            
            //            self.resultTextView.append("\n测试失败接口数：\(self.failureApi.count)\n失败接口为：")
            //
            //            for api in self.failureApi {
            //                self.resultTextView.append(api.name)
            //            }
            
            self.resultTextView.append("\n测试结束。")
            
            self.resultTextView.contentOffset = CGPoint(x: 0, y: self.resultTextView.contentSize.height - self.resultTextView.frame.size.height)
            
            self.endTesting()
        }
    }
    func goNextApi() {
        if self.currentApiIndex + 1 <= self.projects[self.currentProjectIndex].apis.count {
            var api = self.projects[self.currentProjectIndex].apis[self.currentApiIndex]
            
            if self.isRepeatApi {
                if self.currentApiRepeatCount >= 10 {
                    self.isRepeatApi = false
                    self.currentApiIndex++
                    self.currentApiRepeatCount = 0
                    self.resultTextView.append("接口：【\(api.name)】重试次数过多，跳过接口。")
                    
                    api.belongToProject = self.projects[self.currentProjectIndex].name
                    self.failedList.append(api)
                    
                    self.failedLabel.text = "\(self.failedList.count)"
                    
                    self.checkGoNextApi()
                    return
                } else {
                    self.currentApiRepeatCount++
                    self.resultTextView.append("\n重试次数：第\(self.currentApiRepeatCount)次。")
                }
            }
            self.resultTextView.append("\n\(self.isRepeatApi ? "【重试】" : "")接口：\(api.name)")
            
            guard api.api_url != "" else {
                self.resultTextView.append("\n接口没有数据，跳过。")
                
                self.currentApiIndex++
                self.currentApiRepeatCount = 0
                self.isRepeatApi = false
                
                self.checkGoNextApi()
                return
            }
            
            let url = self.projects[self.currentProjectIndex].base_url + self.projects[self.currentProjectIndex].route_url + api.api_url
            
            print("接口请求url地址：\(url)")
            print("接口请求参数：\(api.requestParams)")
            
            let network = AFNetworkingHelper(delegate: self)
            network.postWithURL(url, andParameters: api.requestParams)
            
        } else {
            self.currentProjectIndex++
            self.currentApiIndex = 0
            self.currentApiRepeatCount = 0
            self.isRepeatApi = false
            
            if self.currentProjectIndex < self.projects.count {
                self.resultTextView.append("\n没有更多接口，项目【\(self.projects[self.currentProjectIndex].name)】测试结束。")
            }
            
            self.goNextProject()
        }
    }
}
//MARK: 更新 - Update
extension ViewController {
    func updateStatus() {
        self.updateLoadButton()
        self.updateStartButton()
        self.updateRestartButton()
        self.updateResultButton()
    }
    
    func updateLoadButton() {
        var enabled = true
        var title = ""
        var text = ""
        switch self.status {
        case .Prepared:
            title = "加载数据"
            text = "请先加载数据。"
        case .Loading:
            title = "加 载 中"
            enabled = false
            text = "加载中……"
        case .LoadedFailure:
            title = "重新加载"
            text = "加载失败，请尝试重新加载。"
        case .Loaded:
            title = "加载完成"
            enabled = false
            text = "共加载：\(self.projects.count)个项目。"
        case .Finished:
            title = "重新加载"
        default:
            title = "测 试 中"
            enabled = false
        }
        self.loadButton.setTitle(title, forState: .Normal)
        self.loadButton.enabled = enabled
        self.loadLabel.text = text
    }
    func updateStartButton() {
        var enabled = true
        var title = ""
        switch self.status {
        case .Loaded:
            title = "开始测试"
        case .Running:
            title = " 暂 停 "
        case .Holding:
            title = " 继 续 "
        case .Abort:
            title = "重新开始"
        default:
            title = "不可开始"
            enabled = false
        }
        self.startButton.enabled = enabled
        self.startButton.setTitle(title, forState: .Normal)
    }
    func updateRestartButton() {
        var enabled = true
        var title = ""
        switch self.status {
        case .Holding:
            title = " 中 止 "
        default:
            enabled = false
            title = " "
        }
        self.restartButton.enabled = enabled
        self.restartButton.setTitle(title, forState: .Normal)
    }
    func updateResultButton() {
        var enabled = true
        var title = ""
        switch self.status {
        case .Finished:
            title = "查看结果"
        default:
            title = "暂无结果"
            enabled = false
        }
        self.resultButton.enabled = enabled
        self.resultButton.setTitle(title, forState: .Normal)
    }
}
//MARK: 判断 - Judgement

//MARK: 响应方法 - Selector
extension ViewController {
    @IBAction func didLoadButtonClicked(sender: AnyObject) {
        self.status = TestingStatus.Loading
        self.loadLabel.text = nil
        self.normalLabel.text = nil
        self.abnormalLabel.text = nil
        self.failedLabel.text = nil
        self.resultTextView.clean()
        
        self.updateStatus()
        
        self.loadDatas()
    }
    
    @IBAction func didStartButtonClicked(sender: AnyObject) {
        switch self.status {
        case .Loaded:
            self.status = .Running
            self.updateStatus()
            self.startTesting()
        case .Running:
            self.status = .Holding
            self.updateStatus()
        case .Holding:
            self.status = .Running
            self.updateStatus()
            self.checkGoNextApi()
        case .Abort:
            self.status = .Running
            self.updateStatus()
            self.startTesting()
        default:
            break
        }
        
    }
    
    @IBAction func didRestartButtonClicked(sender: AnyObject) {
        switch self.status {
        case .Holding:
            self.status = .Abort
            self.updateStatus()
            self.resetStatus()
        default:
            break
        }
    }
}
//MARK: 回调 - Call back

//MARK: 数据源与代理 - DataSrouce & Delegate
extension ViewController: AFNetworkingHelperProtocol {
    func succeededWithResponseObject(responseObject: AnyObject!) {
//        var responseCode: String?
        
//        let project = self.projects[self.currentProjectIndex]
//        let api = project.apis[self.currentApiIndex]
        
        var text = "成功"
        
        if let response = responseObject as? [String : AnyObject] {
            if let code = response["code"] as? String {
//                responseCode = code
                if let codeNumber = Int(code) {
                    if codeNumber != 0 {
                        var api = self.projects[self.currentProjectIndex].apis[self.currentApiIndex]
                        api.belongToProject = self.projects[self.currentProjectIndex].name
                        self.abnormalList.append(api)
                        text = "异常"
                        self.abnormalLabel.text = "\(self.abnormalList.count)"
                    }
                }
            }
        }
        
        self.resultTextView.append(
            "=== 接口连接结果\n（*\(text)*）\n" +
            "=== 开始测试下个接口\n"
        )
        
        print("返回的数据：\(responseObject)")
        
        self.currentApiIndex++
        self.isRepeatApi = false
        self.checkGoNextApi()
    }
    func failedWithError(error: NSError!) {
//        let project = self.projects[self.currentProjectIndex]
//        let api = project.apis[self.currentApiIndex]
        self.resultTextView.append(
            "=== 接口连接结果\n(*失败*)\n" +
            "=== 开始重新请求\n")
        
        print("错误内容：\(error)")
        
        self.isRepeatApi = true
        self.checkGoNextApi()
    }
}
//MARK: 设置 - Setter
extension ViewController {
    func resetProject() {
        self.hasNextProject = false
        self.isRepeatApi = false
    }
    
    func resetStatus() {
        self.currentProjectIndex = 0
        self.currentApiRepeatCount = 0
        self.currentApiIndex = 0
        
        self.abnormalList = Array()
        self.failedList = Array()
    }
    
    func reset() {
        self.resetProject()
        self.resetStatus()
        self.projects = Array()
    }

}
//MARK: 获取 - Getter

//MARK: - 其他
//MARK: 协议  -   Protocol

//MARK: 枚举  -   Enumeration
enum TestingStatus {
    case Prepared
    case Loaded
    case Loading
    case LoadedFailure
    case Running
    case Holding
    case Abort
    case Finished
    
    var stringValue: String {
        switch self {
        case .Prepared:
            return "已准备就绪，请加载数据。"
        case .Loaded:
            return "加载成功，可以随时开始"
        case .Loading:
            return "开始解析并加载数据……"
        case .LoadedFailure:
            return "加载失败，请检查数据格式"
        case .Running:
            return "开始解析数据……"
        case .Holding:
            return "挂起等待中……"
        case .Abort:
            return "已中止。"
        case .Finished:
            return "已结束。"
        }
    }
}
//MARK: 其他
struct Project {
    
    private var projectName: String?
    private var baseURL: String?
    private var routeURL: String?
    private var apiArray: [Api] = Array()
    
    var name: String {
        get {
            return self.projectName ?? ""
        }
    }
    var base_url: String {
        get {
            return self.baseURL ?? ""
        }
    }
    var route_url: String {
        get {
            return self.routeURL ?? ""
        }
    }
    var apis: [Api] {
        return self.apiArray
    }
    
    init(data: [String: AnyObject]) {
        self.projectName = data["project_name"] as? String
        self.baseURL = data["base_url"] as? String
        self.routeURL = data["route_url"] as? String
        if let tempArray = data["apis"] as? [[String : AnyObject]] {
            for data in tempArray {
                self.apiArray.append(Api(data: data))
            }
        }
    }
    
    func toDictionary() -> [String : AnyObject] {
        return ["project_name" : self.name,
            "base_url" : self.base_url,
            "route_url" : self.route_url,
//            "apis" : self.apiArray
        ]
    }
    
    func toString() -> String {
        var apiString = ""
        for api in self.apiArray {
            apiString += "\(api.toString())"
        }
        return ("{\nproject_name : \(self.name)\nbase_url : \(self.base_url)\nroute_url : \(self.route_url)\napis : \n\(apiString)\n}")
    }
}
struct Api {
    
    private var apiName: String?
    private var apiURL: String?
    private var requestParams: [String : AnyObject]?
    private var responseParams: [String : AnyObject]?
    var belongToProject: String?
    
    var name: String {
        get {
            return self.apiName ?? ""
        }
    }
    var api_url: String {
        get {
            return self.apiURL ?? ""
        }
    }
    var request_params: [String : AnyObject] {
        get {
            return self.requestParams ?? [String : AnyObject]()
        }
    }
    var response_params: [String : AnyObject] {
        get {
            return self.responseParams ?? [String : AnyObject]()
        }
    }
    
    init(data: [String: AnyObject]) {
        self.apiName = data["api_name"] as? String
        self.apiURL = data["api_url"] as? String
        self.requestParams = data["request_params"] as? [String : AnyObject]
        self.responseParams = data["response_params"] as? [String : AnyObject]
    }
    
    func toData() -> [String : AnyObject] {
        return [
            "api_name" : self.name,
            "api_url" : self.api_url,
            "request_params" : self.request_params,
            "response_params" : self.response_params
        ]
    }
    
    func toString() -> String {
        return ("    {\n    api_name : \(self.name)\n    api_url : \(self.api_url)\n    request_params : \(self.request_params.toString())\n    response_params : \(self.response_params.toString())\n    }\n")
    }
}

extension UITextView {
    func append(text: String) {
        print(text)
        let tempText = (self.text ?? "") + "\n\(text)"
        self.text = tempText
        self.contentOffset = CGPoint(x: 0, y: self.contentSize.height)
    }
    func clean() {
        self.text = ""
    }
}
extension Dictionary {
    func toString() -> String {
        var dicString = "{"
        for key in self.keys {
            dicString += "\n        [\(key) : \(((self[key] as? String) ?? ""))]"
        }
        return dicString + "\n        }"
    }
}