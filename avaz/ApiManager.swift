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
import SwiftLoader


typealias ServiceResponse = (JSON, String?) -> Void
typealias Payload = [String: AnyObject]
class ApiManager: NSObject {
    static let sharedInstance = ApiManager()
    
//    let baseURL = "http://api.randomuser.me/"
//    let baseURL = "http://beta.json-generator.com/api/json/get/4JnRwJKE-"
//    let baseURL = "http://localhost:8001/"

    let baseURL = "http://dev.nerdiacs.com:8001/"

    func getRandomPost(onCompletion: (JSON) -> Void) {
        
        
        let route = baseURL
        makeHTTPGetRequest(route, params:[:], onCompletion: { json, err in
            
            onCompletion(json as JSON )
        })
    }
    
//    ------ Start API's -----------
    
    func LogInApi(userName: String, password: String, onCompletion: (JSON) ->Void) {
        

        let someTuble = [ "username":userName, "password":password];
        makeHTTPPostRequest(baseURL+"user/login",params: someTuble, onCompletion: { json, err in

//            LoadingIndicatorView.hide()
            if err != nil{
//                 onCompletion(err! as String)
            }
            
            
                       onCompletion(json as JSON)
        })
    }
    func RegsiterApi(userName: String,email: String, password: String, pic: String?,  onCompletion: (JSON) ->Void) {
        
   

        
        let picData =  ( pic != "") ?  Upload(fileUrl: NSURL(fileURLWithPath: pic!)) : ""
        let parameters = [ "username":userName, "password":password, "email":email, "file": picData];
        makeHTTPPostRequest(baseURL+"user/register", params: parameters, onCompletion: { json, err in
           
            onCompletion(json as JSON )
        })
    }
    
    func ForgetPassApi(email: String, password: String, confirmpassword: String,  onCompletion: (JSON) ->Void) {
        
        
        let parameters = [ "email":email, "password":password];
        makeHTTPPostRequest(baseURL+"user/forgot", params: parameters, onCompletion: { json, err in
            onCompletion(json as JSON )
        })
    }
    
   
    
    func getAllPost(onCompletion: (JSON) ->Void) {
        
        let parameters = [ "sessionid": UserData.sharedInstance.sessionId as! AnyObject];
        makeHTTPGetRequest(baseURL+"post/getallpost", params:parameters, onCompletion: { json, err in
            onCompletion(json as JSON)
        })

    }
    
    
    func getAllPostByUser(onCompletion: (JSON) ->Void) {
        
        let parameters = [ "sessionid": UserData.sharedInstance.sessionId as! AnyObject];
        makeHTTPGetRequest(baseURL+"post/getallpostbyuser", params:parameters, onCompletion: { json, err in
            onCompletion(json as JSON)
        })
        
    }

    
    
    
    //// get all Comments
    func getAllComments(postid : String? , onCompletion: (JSON) ->Void) {
        
        guard let postToFetch = postid else{
            return
        }
        let parameters = [ "sessionid": UserData.sharedInstance.sessionId as! AnyObject, "postid":postToFetch];
        makeHTTPGetRequest(baseURL+"post/getallcomments", params:parameters, onCompletion: { json, err in
          
            onCompletion(json as JSON)
        })
        
    }
    
    
    
    //// Insert a Comment
    func insertAComment(postid : String?, comment: Comment , onCompletion: (JSON) ->Void) {
        
        guard let postToFetch = postid else{
            return
        }
        let parameters = [ "sessionid": UserData.sharedInstance.sessionId as! AnyObject, "postid":postToFetch , "comment": comment.media.content! ];
        makeHTTPPostRequest(baseURL+"post/docomment", params:parameters, onCompletion: { json, err in
           
            onCompletion(json as JSON)
        })
        
    }
    
    //// Insert a Post
    func insertAPost( post: Post , onCompletion: (JSON) ->Void) {
        let statparameters:[String: AnyObject] = [ "sessionid": UserData.sharedInstance.sessionId as! AnyObject,
                           "title": post.title,
                           "location": post.getlocation() as AnyObject,
                           "text": post.media?.content as! AnyObject ]
        
        // This should be upload array.
        
        let param2:[String: AnyObject] = post.getUploadableMedia()
        
        
        let parameters = statparameters.reduce(param2) { (var dict, pair) in
            dict[pair.0] = pair.1
            return dict
        }
        makeHTTPPostRequest(baseURL+"post/dopost", params: parameters, onCompletion: { json, err in
        
            onCompletion(json as JSON)
        })
        
    }
    
    
    // Logout call back
    func logOut(  onCompletion: (JSON) ->Void) {
        let parameters:[String: AnyObject] = [ "sessionid": UserData.sharedInstance.sessionId as! AnyObject]
        
        
        makeHTTPGetRequest(baseURL+"user/logout", params: parameters, onCompletion: { json, err in
            
            onCompletion(json as JSON)
        })
        
    }
    

    
//    ------ End API's -----------
    
    
    func makeHTTPPostRequest(baseurl: String , params: [String: AnyObject], onCompletion: ServiceResponse) {

        
        //Todo: Could add sessionid object in params may be concat two array.
        do {
//            SwiftLoader.show(animated: true)
            let opt = try HTTP.POST(baseurl, parameters: params)
            opt.start { response in
//                SwiftLoader.hide()
                
//                print("text is :  \(response.text) " )
//                print("responce is :  \(response) " )
//                
                
                
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
//                    print("completed: \(json!["data"])")
                    let data = json!["data"]
                    onCompletion(JSON(data!), nil)
                }else{
                    let data = json!["error"] as? JSON
                    onCompletion(nil, "\(data)")
                }
            }
        }catch let error {
//            print("got an error creating the request: \(error)\n")
            onCompletion(nil, "\(error)")
            
        }
 
       
    }
    
    func makeHTTPGetRequest(path: String,params: [String: AnyObject]?, onCompletion: ServiceResponse) {
    
        do {
//            SwiftLoader.show(animated: true)
            let opt = try HTTP.GET(path, parameters: params)
            opt.start { response in
//                SwiftLoader.hide()
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
//                    print("completed: \(json!["data"])")
                    let data = json!["data"]
                    onCompletion(JSON(data!), nil)
                }else{
                    let data = json!["error"] as? JSON
                    onCompletion(nil, "\(data)")
                }

            }
        } catch let error {
//            print("got an error creating the request: \(error)")
            onCompletion(nil, "\(error)")
        }

    }
    
    
    private override init() {
        super.init()
        
        var config : SwiftLoader.Config = SwiftLoader.Config()
        config.size = 150
        config.spinnerColor = .redColor()
        config.foregroundColor = .blackColor()
        config.backgroundColor = .clearColor()
        config.foregroundAlpha = 0.5
        
        
         SwiftLoader.setConfig(config)
        
    }
    
}

extension Dictionary {
    mutating func update(other:Dictionary) {
        for (key,value) in other {
            self.updateValue(value, forKey:key)
        }
    }
}


