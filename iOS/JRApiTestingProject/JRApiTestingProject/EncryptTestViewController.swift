//
//  EncryptTestViewController.swift
//  JRApiTestingProject
//
//  Created by SilversRayleigh on 30/9/15.
//  Copyright (c) 2015 qi-cloud.com. All rights reserved.
//

import UIKit

class EncryptTestViewController: UIViewController {

    @IBOutlet weak var numberTextField: UITextField!
    @IBOutlet weak var keyTextField: UITextField!
    
    @IBOutlet weak var alertLabel: UILabel!
    
    @IBOutlet weak var logTextView: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    convenience init() {
        let nibNameOrNil = String?("EncryptTestViewController")
        self.init(nibName: nibNameOrNil, bundle: nil)
    }

    @IBAction func didGenerateWithSwiftButtonClicked(sender: AnyObject) {
        if self.keyTextField.isEmpty() {
            self.alertLabel.text = "Key can't not be empty."
            return
        }
        var numberToGenerate: Int = 1
        if !self.numberTextField.isEmpty() {
            numberToGenerate = self.numberTextField.text.toInt()!
        }
        self.logTextView.text.extend(String("\(numberToGenerate) data(s) generated by Swift:\n"))
        for i in 0..<numberToGenerate {
            var qc_app_str: String = AppParamEncryptUtil().requestRandomEncryptedString()
            var qc_app_sign: String = AppParamEncryptUtil().signParam(byString: qc_app_str, andKey: self.keyTextField.text)
            self.logTextView.text.extend(String("\(i + 1). qc_app_str: \(qc_app_str)\n"))
            self.logTextView.text.extend(String("    qc_app_sign: \(qc_app_sign)\n"))
        }
        self.logTextView.text.extend("\n")
        self.alertLabel.text = "Done!"
    }
    @IBAction func didGenerateWithOCButtonClicked(sender: AnyObject) {
        if self.keyTextField.isEmpty() {
            self.alertLabel.text = "Key can't not be empty."
            return
        }
        var numberToGenerate: Int = 1
        if !self.numberTextField.isEmpty() {
            numberToGenerate = self.numberTextField.text.toInt()!
        }
        self.logTextView.text.extend(String("\(numberToGenerate) data(s) generated by Objective-C:\n"))
        for i in 0..<numberToGenerate {
            var qc_app_str: String = QCloudAppParamEncrptTool().requestRandomEncryptedString()
            var qc_app_sign: String = QCloudAppParamEncrptTool().signParamWithString(qc_app_str, andKey: self.keyTextField.text)
            self.logTextView.text.extend(String("\(i + 1). qc_app_str: \(qc_app_str)\n"))
            self.logTextView.text.extend(String("    qc_app_sign: \(qc_app_sign)\n"))
        }
        self.logTextView.text.extend("\n")
        self.alertLabel.text = "Done!"
    }
    @IBAction func didCleanButtonClicked(sender: AnyObject) {
        self.logTextView.text = ""
        self.alertLabel.text = "Alert"
    }
}
extension EncryptTestViewController: UITextFieldDelegate {
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}