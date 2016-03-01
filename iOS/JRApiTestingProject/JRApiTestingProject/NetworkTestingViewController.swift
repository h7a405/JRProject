//
//  NetworkTestingViewController.swift
//  JingJianLogistics-iOS
//
//  Created by SilversRayleigh on 29/9/15.
//  Copyright (c) 2015 qi-cloud.com. All rights reserved.
//

import UIKit

class NetworkTestingViewController: UIViewController {

    @IBOutlet weak var baseURLTextField: UITextField!
    @IBOutlet weak var routeTextField: UITextField!
    @IBOutlet weak var randomTextField: UITextField!
    @IBOutlet weak var keyTextField: UITextField!
    @IBOutlet weak var encryptTextField: UITextField!
    @IBOutlet weak var decryptTextField: UITextField!
    
    @IBOutlet weak var resultTextView: UITextView!
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var baseURLSwitch: UISwitch!
    @IBOutlet weak var methodSegmentedControl: UISegmentedControl!
    
    @IBOutlet weak var generateButton: UIButton!
    @IBOutlet weak var encryptButton: UIButton!
    @IBOutlet weak var decryptButton: UIButton!
    @IBOutlet weak var submitButton: UIButton!
    
    var selectedIndex: Int = Int(-1)
    
    var interfaces: [(String, String)] = [
        ("登陆", "/app/clerk/login.do"),
        ("发送短信", "/app/clerk/sendMsgForCode.do"),
        ("忘记密码", "/app/clerk/updatePwd.do"),
        ("修改密码", "/app/clerk/resetPwd.do"),
        ("查看个人信息", "/app/clerk/getClerk.do")
    ]
    var keyOfRowsForInterface: [[String]] = [
        ["username", "pwd"],
        ["mobile"],
        ["mobile", "code", "pwd"],
        ["pwd", "pwd1", "pwd2"],
        []
    ]
    
    let baseURL: String = "jingjian-test.qi-cloud.net"
    let baseKEY: String = "jjwl"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if !self.baseURL.isEmpty {
            self.baseURLTextField.text = self.baseURL
            self.keyTextField.text = self.baseKEY
            self.baseURLSwitch.setOn(true, animated: true)
            self.baseURLLock(self.baseURLSwitch)
        }
        self.tableView.tableFooterView = UIView()
        
        let rightBarButton: UIBarButtonItem = UIBarButtonItem(title: "Encrypt", style: UIBarButtonItemStyle.Done, target: self, action: "didRightBarButtonItemClicked:")
        self.navigationItem.rightBarButtonItem = rightBarButton
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    convenience init() {
        let nibNameOrNil = String?("NetworkTestingViewController")
        self.init(nibName: nibNameOrNil, bundle: nil)
    }

    @IBAction func baseURLLock(sender: AnyObject) {
        let theSwitch = sender as! UISwitch
        if theSwitch.on {
            self.baseURLTextField.enabled = false
        } else {
            self.baseURLTextField.enabled = true
        }
    }
    
    @IBAction func didGenerateButtonClicked(sender: AnyObject) {
        let randomString = AppParamEncryptUtil().requestRandomEncryptedString()
//        var tool = QCloudAppParamEncrptTool()
//        var randomString = tool.requestRandomEncryptedString()
        Log.DLog(randomString)
        self.randomTextField.text = randomString
        self.encryptTextField.text = ""
        self.decryptTextField.text = ""
    }
    @IBAction func didEncryptButtonClicked(sender: AnyObject) {
        if self.randomTextField.text?.length() > 0 {
            if self.keyTextField.text?.length() > 0 {
                let encryptString = AppParamEncryptUtil().signParam(byString: self.randomTextField.text!, andKey: self.keyTextField.text!)
//                var tool = QCloudAppParamEncrptTool()
//                var encryptString = tool.signParamWithString(self.randomTextField.text, andKey: self.keyTextField.text)
                Log.DLog(encryptString)
                self.encryptTextField.text = encryptString
            }
        }
    }
    @IBAction func didDecryptButtonClicked(sender: AnyObject) {
        if self.randomTextField.text?.length() > 0 {
            let result = AppParamEncryptUtil().decryptParam(byString: self.randomTextField.text!)
//            var tool = QCloudAppParamEncrptTool()
//            var result = tool.decryptParamWithString(self.randomTextField.text)
            Log.DLog("\(result)")
            if result {
                self.decryptTextField.text = String("Succeed.")
            } else {
                self.decryptTextField.text = String("Failed.")
            }
            
        }
    }
    @IBAction func didResetButtonClicked(sender: AnyObject) {
        self.randomTextField.text = ""
        self.encryptTextField.text = ""
        self.decryptTextField.text = ""
    }
    @IBAction func didSubmitButtonClicked(sender: AnyObject) {
        if self.baseURLTextField.text?.length() > 0 {
            let theURL: String = "http://" + self.baseURLTextField.text! + self.routeTextField.text!
            Log.DLog(theURL)
            let dic: NSMutableDictionary = NSMutableDictionary()
            if self.randomTextField.text!.length() > 0 {
                dic.setObject(self.randomTextField.text!, forKey: "qc_app_str")
            }
            if self.encryptTextField.text!.length() > 0 {
                dic.setObject(self.encryptTextField.text!, forKey: "qc_app_sign")
            }
            let numberOfRows: Int = self.tableView(self.tableView, numberOfRowsInSection: 0)
            if numberOfRows > 0 {
                for i in 0..<numberOfRows {
                    let tempCell = self.tableView.cellForRowAtIndexPath(NSIndexPath(forRow: i, inSection: 0)) as? NetworkTestingTableViewCell
                    if tempCell != nil {
                        if tempCell!.keyTextField.text!.length() > 0 && tempCell!.dataTextField.text!.length() > 0 {
                            dic.setObject(tempCell!.dataTextField.text!, forKey: tempCell!.keyTextField.text!)
                        }
                    }
                }
            }
            Log.VLog(dic)
            if self.methodSegmentedControl.selectedSegmentIndex == 0 {
                Dao.post(theURL, andParameters: dic, callBack: {(dic: NSDictionary?) in
                    self.doDataReceived(dic)
                })
            } else {
                Dao.get(theURL, andParameters: dic, callBack: {(dic: NSDictionary?) in
                    self.doDataReceived(dic)
                })
            }
            self.resultTextView.text = ""
        } else {
            self.resultTextView.text = ""
        }
    }
    func doUpdateTableView(index: Int) {
        self.selectedIndex = index
//        var indexPaths: [NSIndexPath] = Array()
//        for i in 0..<self.numberOfRowsForInterface[index] {
//            indexPaths.append(NSIndexPath(forRow: i, inSection: 0))
//        }
//        self.textFieldOfParameters = Array()
//        self.dataOfParameters = Array()
        self.tableView.reloadData()
    }
    func doDataReceived(dic: NSDictionary?) {
        if dic != nil {
            let (status, message) = (dic!.objectForKey("status") as! Int, dic!.objectForKey("message") as! String)
            let data: AnyObject? = dic!.objectForKey("data")
            self.resultTextView.text = "Request data:(\nstatus: \(status), \nmessage: \(message), \nData:\(data)\n)"
        } else {
            self.resultTextView.text = "Request failed."
        }
    }
    func didRightBarButtonItemClicked(sender: AnyObject) {
        let instance = EncryptTestViewController()
        
        self.navigationController!.pushViewController(instance, animated: true)
    }
}
//MARK: - Classes - Extension
//MARK: - Extensions - DataSource
extension NetworkTestingViewController: UITableViewDataSource {
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.selectedIndex != -1 {
            return self.keyOfRowsForInterface[selectedIndex].count
        } else {
            return 0
        }
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = "cell"
        var cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier) as? NetworkTestingTableViewCell
        if cell == nil {
            let array_xib = NSBundle.mainBundle().loadNibNamed("NetworkTestingTableViewCell", owner: nil, options: nil)
            cell = array_xib[0] as? NetworkTestingTableViewCell
        }
        cell!.keyTextField.delegate = self
        cell!.dataTextField.delegate = self
        if indexPath.row <= self.keyOfRowsForInterface[selectedIndex].count - 1 {
            cell!.keyTextField.text = self.keyOfRowsForInterface[selectedIndex][indexPath.row]
        }
//        self.dataOfParameters.append()
        return cell!
    }
}
//MARK: - Extensions - Delegate
extension  NetworkTestingViewController: UITableViewDelegate {
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 60.0
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
}
//MARK: - Classes - Custom
extension NetworkTestingViewController: UITextFieldDelegate {
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    func textFieldDidBeginEditing(textField: UITextField) {
        if textField === self.routeTextField {
            textField.resignFirstResponder()
            var strings: [String] = Array()
            for (_, tuple) in self.interfaces.enumerate() {
                let (name, _) = tuple
                strings.append(name)
            }
            JRPickerView(pickerData: strings, delegate: self).showOnView(KEYWINDOW)
        }
    }
}
extension NetworkTestingViewController: JRPickerViewDelegate {
    func JRpickerView(pickerView: JRPickerView, didSelectRowAtIndexPath indexPath: NSIndexPath?, content: String) {
        let (_, route): (String, String) = self.interfaces[indexPath!.row]
        self.routeTextField.text = route
        self.doUpdateTableView(indexPath!.row)
    }
}
