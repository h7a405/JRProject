//
//  ApiProject.swift
//  ApiTestingUtil
//
//  Created by Jason Lee on 16/01/25.
//  Copyright © 2016年 CZLee. All rights reserved.
//

import UIKit

struct ApiProject {
    private var projectName: String?
    private var baseURL: String?
    private var routeURL: String?
    private var apiArray: [ApiInterface] = Array()
    
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
    var apis: [ApiInterface] {
        return self.apiArray
    }
    
    init(data: [String: AnyObject]) {
        self.projectName = data["project_name"] as? String
        self.baseURL = data["base_url"] as? String
        self.routeURL = data["route_url"] as? String
        if let tempArray = data["apis"] as? [[String : AnyObject]] {
            for data in tempArray {
                self.apiArray.append(ApiInterface(data: data))
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
