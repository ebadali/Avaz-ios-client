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
    
    var postID : String
    var media: Media?
        
    init(postid: String, details : String, title : String, up: Int, down: Int, loc : String, latitude : Double ,longitude : Double )
        {
            self.detail = details
            self.title = title
            self.up = up
            self.down = down
            
            self.loc = loc
            self.lat = latitude
            self.lng = longitude
            
            self.postID = postid
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
        
         self.postID = json["id"].stringValue

    }
    
    init(post : JSON, media : JSON , location : JSON)
    {
        self.postID = post["id"].stringValue
//        self.loc = location["loc"].stringValue
        self.lat = location["latitude"].doubleValue
        self.lng = location["longitude"].doubleValue

        
        self.title = post["title"].stringValue
        
        self.media = Media(media: media)
        
        self.detail = (self.media?.content)!
        
        self.up = 0
        self.down = 0
        
    }
    
    func getlocation() -> String {
        return String("\(self.lat),\(self.lng)")
        
    }
    
}