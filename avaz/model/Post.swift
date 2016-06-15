//
//  Post.swift
//  avaz
//
//  Created by Nerdiacs Mac on 5/30/16.
//  Copyright © 2016 Nerdiacs. All rights reserved.
//

import SwiftyJSON
class Post {
        var detail = ""
        var title = ""
        var loc = ""
        var lat = 0.0 , lng = 0.0
//    var postedBy : User
    
        var up = 0 , down = 0
        
    init(details : String, title : String, up: Int, down: Int, loc : String, latitude : Double ,longitude : Double )
        {
            self.detail = details
            self.title = title
            self.up = up
            self.down = down
            
            self.loc = loc
            self.lat = latitude
            self.lng = longitude
        }
//
     init(json : JSON )
    {
        
//        pictureURL = json["user"]["picture"].stringValue
        self.loc = json["loc"].stringValue
        self.lat = json["latitude"].doubleValue
        self.lng = json["longitude"].doubleValue

        self.detail = json["detail"].stringValue
        self.title = json["title"].stringValue
        self.up = json["Votes"]["up"].intValue
        self.down = json["Votes"]["down"].intValue

    }
    
}