//
//  ApiInterface.swift
//  ApiTestingUtil
//
//  Created by Jason Lee on 16/01/25.
//  Copyright © 2016年 CZLee. All rights reserved.
//

import UIKit

struct ApiInterface {
    private var apiName: String?
    private var apiURL: String?
    var requestParams: [String : AnyObject]?
    var responseParams: [String : AnyObject]?
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
    
    func toDictionary() -> [String : AnyObject] {
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
