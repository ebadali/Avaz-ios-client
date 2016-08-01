//
//  ApiManager.swift
//  avaz
//
//  Created by Nerdiacs Mac on 6/14/16.
//  Copyright © 2016 Nerdiacs. All rights reserved.
//

import Foundation
import SwiftHTTP
import SwiftyJSON



typealias ServiceResponse = (JSON, String?) -> Void
typealias Payload = [String: AnyObject]
class ApiManager: NSObject {
    static let sharedInstance = ApiManager()
    
//    let baseURL = "http://api.randomuser.me/"
//    let baseURL = "http://beta.json-generator.com/api/json/get/4JnRwJKE-"
    let baseURL = "http://localhost:8001/"
    

    func getRandomPost(onCompletion: (JSON) -> Void) {
        let route = baseURL
        makeHTTPGetRequest(route, params:[:], onCompletion: { json, err in
            onCompletion(json as JSON)
        })
    }
    
//    ------ Start API's -----------
    
    func LogInApi(userName: String, password: String, onCompletion: (JSON) ->Void) {
        
        let someTuble = [ "username":userName, "password":password];
        makeHTTPPostRequest(baseURL+"user/login",params: someTuble, onCompletion: { json, err in
            onCompletion(json as JSON)
        })
    }
    func RegsiterApi(userName: String,email: String, password: String, pic: String?,  onCompletion: (JSON) ->Void) {
        
//        let fileUrl = NSURL(fileURLWithPath: "/Users/nerdmac/Documents/ios/avaz/avaz/Assets.xcassets/upload.imageset/Upload-50.png")
        
        
        let picData =  ( pic != "") ?  Upload(fileUrl: NSURL(fileURLWithPath: pic!)) : ""
        let parameters = [ "username":userName, "password":password, "email":email, "file": picData];
        makeHTTPPostRequest(baseURL+"user/register", params: parameters, onCompletion: { json, err in
            onCompletion(json as JSON)
        })
    }
    
    func getAllPost(onCompletion: (JSON) ->Void) {
        
        let parameters = [ "sessionid": UserData.sharedInstance.GetSessionID()];
        makeHTTPGetRequest(baseURL+"post/getallpost", params:parameters, onCompletion: { json, err in
            onCompletion(json as JSON)
        })

    }
    
    
//    ------ End API's -----------
    
    
    func makeHTTPPostRequest(baseurl: String , params: [String: AnyObject], onCompletion: ServiceResponse) {

        do {
//            ["aParam": "aValue", "file": Upload(fileUrl: fileUrl)]
            let opt = try HTTP.POST(baseurl, parameters: params)
            opt.start { response in

                print("text is :  \(response.text) " )
                print("responce is :  \(response) " )
                
                
                
                var json: NSDictionary?
                do {
                    json = try NSJSONSerialization.JSONObjectWithData(response.data, options: NSJSONReadingOptions()) as? NSDictionary
                } catch {
                    
                    onCompletion(nil,"\(response.error)")
                    return
                }
                
                guard let status = json!["status"] as? String
                    else {
                    onCompletion(nil, "\(response.error)")
                    return
                }
                
                
                // Checking All Failures.
                
                if  status == "success" {
                    print("completed: \(json!["data"])")
                    let data = json!["data"]
                    onCompletion(JSON(data!), nil)
                }else{
                    let data = json!["error"] as? JSON
                    onCompletion(nil, "\(data)")
                }
            }
        }catch let error {
            print("got an error creating the request: \(error)\n")
            onCompletion(nil, "\(error)")
            
        }
 
       
    }
    
    func makeHTTPGetRequest(path: String,params: [String: AnyObject]?, onCompletion: ServiceResponse) {
    
        do {
            let opt = try HTTP.GET(path, parameters: params)
            opt.start { response in
                var json: NSDictionary?
                do {
                    json = try NSJSONSerialization.JSONObjectWithData(response.data, options: NSJSONReadingOptions()) as? NSDictionary
                } catch {
                    
                    onCompletion(nil,"\(response.error)")
                    return
                }
                
                guard let status = json!["status"] as? String
                    else {
                        onCompletion(nil, "\(response.error)")
                        return
                }
                
                
                // Checking All Failures.
                
                if  status == "success" {
                    print("completed: \(json!["data"])")
                    let data = json!["data"]
                    onCompletion(JSON(data!), nil)
                }else{
                    let data = json!["error"] as? JSON
                    onCompletion(nil, "\(data)")
                }

            }
        } catch let error {
            print("got an error creating the request: \(error)")
            onCompletion(nil, "\(error)")
        }
//        let request = NSMutableURLRequest(URL: NSURL(string: path)!)
//        
//        let session = NSURLSession.sharedSession()
//        
//        let task = session.dataTaskWithRequest(request, completionHandler:
//            {(data, response, error) -> Void in
//                if let jsonData = data {
//                    let json:JSON = JSON(data: jsonData)
//                    onCompletion(json, "\(error)")
//                } else {
//                    onCompletion(nil, "\(error)")
//                }
//            })
//        task.resume()
    }
    
}

extension Dictionary {
    mutating func update(other:Dictionary) {
        for (key,value) in other {
            self.updateValue(value, forKey:key)
        }
    }
}


