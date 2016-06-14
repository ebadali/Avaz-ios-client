//
//  Post.swift
//  avaz
//
//  Created by Nerdiacs Mac on 5/30/16.
//  Copyright © 2016 Nerdiacs. All rights reserved.
//

import SwiftyJSON
class Post {
        var tex1 = ""
        var tex2 = ""
//    var User: String
        var up = 0 , down = 0
        
//        init(text1 : String, text2 : String, up: Int, down: Int )
//        {
//            self.tex1 = text1
//            self.tex2 = text2
//            self.up = up
//            self.down = down
//        }
//    
    required init(json : JSON )
    {
        
//        pictureURL = json["user"]["picture"].stringValue
//        username = json["username"].stringValue
        self.tex1 = json["detail"].stringValue
        self.tex2 = json["title"].stringValue
        self.up = json["Votes"]["up"].intValue
        self.down = json["Votes"]["down"].intValue

    }
    
}