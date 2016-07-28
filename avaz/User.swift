//
//  User.swift
//  avaz
//
//  Created by Nerdiacs Mac on 7/28/16.
//  Copyright © 2016 Nerdiacs. All rights reserved.
//


import SwiftyJSON
class User {
    var UserName = ""
    var PicId = ""
    var Email = ""
    
    init()
    {
        
    }
   
    init(json : JSON )
    {
        //        pictureURL = json["user"]["picture"].stringValue
        self.UserName = json["username"].stringValue
        self.PicId = json["picreference"].stringValue
        self.Email = json["email"].stringValue
        
    }
    
}