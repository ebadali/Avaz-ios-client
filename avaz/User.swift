//
//  User.swift
//  avaz
//
//  Created by Nerdiacs Mac on 7/28/16.
//  Copyright © 2016 Nerdiacs. All rights reserved.
//


import SwiftyJSON
class User : NSObject, NSCoding{
    var UserName:NSString = ""
    var PicId:NSString = ""
    var Email:NSString = ""
    
    override init()
    {
    }
   
    init(json : JSON )
    {
        //        pictureURL = json["user"]["picture"].stringValue
        self.UserName = json["username"].stringValue
        self.PicId = json["picreference"].stringValue
        self.Email = json["email"].stringValue
        
    }
    
    
    
    init(username: NSString, picid:NSString, email: NSString) {
        self.UserName = username
        self.PicId = picid
        self.Email = email
        
    }
    
    required convenience init(coder aDecoder: NSCoder) {
        let username = aDecoder.decodeObjectForKey("username") as! String
        let picreference = aDecoder.decodeObjectForKey("picreference") as! String
        let email = aDecoder.decodeObjectForKey("email") as! String
        self.init(username: username, picid: picreference, email: email)
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(self.UserName, forKey: "username")
        aCoder.encodeObject(self.PicId, forKey: "picreference")
        aCoder.encodeObject(self.Email, forKey: "email")
    }
    
}