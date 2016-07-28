//
//  ApiManager.swift
//  avaz
//
//  Created by Nerdiacs Mac on 6/14/16.
//  Copyright © 2016 Nerdiacs. All rights reserved.
//

import Foundation
import SwiftyJSON

typealias ServiceResponse = (JSON, NSError?) -> Void

class ApiManager: NSObject {
    static let sharedInstance = ApiManager()
    
//    let baseURL = "http://api.randomuser.me/"
//    let baseURL = "http://beta.json-generator.com/api/json/get/4JnRwJKE-"
    let baseURL = "http://localhost:8001/"
    

    func getRandomPost(onCompletion: (JSON) -> Void) {
        let route = baseURL
        makeHTTPGetRequest(route, onCompletion: { json, err in
            onCompletion(json as JSON)
        })
    }
    
//    ------ API's -----------
    
    func LogInApi(userName: String, password: String, onCompletion: (JSON) ->Void) {
        
        let someTuble = ["route":baseURL+"user/login", "username":userName, "password":password];
        makeHTTPPostRequest(someTuble, onCompletion: { json, err in
            onCompletion(json as JSON)
        })
    }
    func RegsiterApi(userName: String,email: String, password: String, pic: UIImage,  onCompletion: (JSON) ->Void) {
        
        let someTuble = ["route":baseURL+"user/login", "username":userName, "password":password];
        makeHTTPPostRequest(someTuble, onCompletion: { json, err in
            onCompletion(json as JSON)
        })
    }
    
//    ------ API's -----------
    
    
    func makeHTTPPostRequest(params: [String: AnyObject], onCompletion: ServiceResponse) {
        let request = NSMutableURLRequest(URL: NSURL(string: params["route"] as! String)!)
        request.HTTPMethod="POST"
        
        
        var bodyData = ""
        for singleItem in params{
            bodyData += "\(singleItem.0)=\(singleItem.1)&"
            
        }
        bodyData=bodyData.substringToIndex(bodyData.endIndex.predecessor())
        
        request.HTTPBody = bodyData.dataUsingEncoding(NSUTF8StringEncoding);
        
        let session = NSURLSession.sharedSession()
        
        let task = session.dataTaskWithRequest(request, completionHandler:
            {(data, response, error) -> Void in
                if let jsonData = data {
                    let json:JSON = JSON(data: jsonData)
                    onCompletion(json, error)
                } else {
                    onCompletion(nil, error)
                }
        })
        task.resume()
    }
    
    func makeHTTPGetRequest(path: String, onCompletion: ServiceResponse) {

        
        let request = NSMutableURLRequest(URL: NSURL(string: path)!)
        
        let session = NSURLSession.sharedSession()
        
        let task = session.dataTaskWithRequest(request, completionHandler:
            {(data, response, error) -> Void in
                if let jsonData = data {
                    let json:JSON = JSON(data: jsonData)
                    onCompletion(json, error)
                } else {
                    onCompletion(nil, error)
                }
            })
        task.resume()
    }
}