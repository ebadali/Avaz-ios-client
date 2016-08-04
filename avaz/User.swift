//
//  User.swift
//  avaz
//
//  Created by Nerdiacs Mac on 7/28/16.
//  Copyright © 2016 Nerdiacs. All rights reserved.
//


import SwiftyJSON
class User : NSData{
    var UserName = ""
    var PicId = ""
    var Email = ""
    
    override init()
    {
        super.init()
    }
   
    init(json : JSON )
    {
        super.init()
        //        pictureURL = json["user"]["picture"].stringValue
        self.UserName = json["username"].stringValue
        self.PicId = json["picreference"].stringValue
        self.Email = json["email"].stringValue
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}