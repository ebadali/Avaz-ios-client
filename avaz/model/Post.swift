//
//  Post.swift
//  avaz
//
//  Created by Nerdiacs Mac on 5/30/16.
//  Copyright © 2016 Nerdiacs. All rights reserved.
//
import UIKit
import SwiftyJSON
import SwiftHTTP

class Post {
    var detail = ""
    var title = ""
    var loc = ""
    var lat = 0.0 , lng = 0.0
    //    var postedBy : User
    
    var up = 0 , down = 0
    
    var postID : String
    var media: Media?
    var user: User?
    
    init(postid: String, media : Media, title : String, up: Int, down: Int, loc : String, latitude : Double ,longitude : Double )
    {
        self.media = media
        self.title = title
        self.up = up
        self.down = down
        
        self.loc = loc
        self.lat = latitude
        self.lng = longitude
        
        self.postID = postid
        self.user = UserData.sharedInstance.currentUser
        
        
    }
    //
    init(json : JSON )
    {
        
        //        pictureURL = json["user"]["picture"].stringValue
        self.loc = json["loc"].stringValue
        self.lat = json["latitude"].doubleValue
        self.lng = json["longtitude"].doubleValue
        
        //        self.detail = json["detail"].stringValue
        self.title = json["title"].stringValue
        self.up = json["Votes"]["up"].intValue
        self.down = json["Votes"]["down"].intValue
        
        self.postID = json["id"].stringValue
        
    }
    
    init(post : JSON, media : JSON , location : JSON, user: JSON)
    {
        self.postID = post["id"].stringValue
        //        self.loc = location["loc"].stringValue
        self.lat = location["latitude"].doubleValue
        self.lng = location["longtitude"].doubleValue
        
        
        self.title = post["title"].stringValue
        
        self.media = Media(media: media)
        
        self.detail = (self.media?.content)!
        
        
        self.user = User(json: user)
        
        
        self.up = 0
        self.down = 0
        
    }
    
    func getlocation() -> String {
        return String("\(self.lat),\(self.lng)")
        
    }
    
    
    func getUploadableMedia() -> [String: AnyObject] {
        
        
        //        if self.media?.images == nil && self.media?.videos == nil
        //        {
        //            return [:]
        //        }
        
        guard let imCount = self.media?.images.count ,
            vidCount = self.media?.videos.count
            else
        {
            return [:]
        }
        
        var images  = self.media?.images.flatMap{$0}.map( {Upload(fileUrl: NSURL(fileURLWithPath: $0))} )
        let videos = self.media?.videos.flatMap{$0}.map( {Upload(fileUrl: NSURL(fileURLWithPath: $0))} )
        //        guard let imCount = images?.count ,
        //                   vidCount = videos?.count
        //        else
        //        {
        //            return [:]
        //        }
        images![imCount..<imCount] = videos![0..<vidCount]
        
        // lets conver it to dict.
        let dict = images!.reduce([String:AnyObject]()) { (var dict, entry) in
            dict["file\(dict.count)"] = entry
            return dict
        }
        
        return dict
    }
    
    
    
    
}