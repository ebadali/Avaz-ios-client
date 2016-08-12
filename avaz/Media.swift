//
//  Media.swift
//  avaz
//
//  Created by ebad ali on 8/2/16.
//  Copyright © 2016 Nerdiacs. All rights reserved.
//

import SwiftyJSON


class Media {
    
    var videos: [String] = []
    var images: [String] = []
    var content: String?
    init(text: String)
    {
        self.content = text
    }
    
    init()
    {
        self.content = ""
    }
    
    init(media: JSON)
    {
        let text = media["text"]
        self.content = text[text.dictionaryValue.keys.first!].stringValue
//        self.content = "sdsd"
        
        
        var vid = media["videourl"]
        var img = media["imgurl"]

        print(img)
        print("---Images")
        
        if let img = media["imgurl"].dictionary {
            for somevar in img
            {
                addMediaContent(somevar.1.stringValue, type: .Image())
                print(somevar.1)
            }
        }
        print("---Videos")
        if let vid = media["videourl"].dictionary {
            for somevar in vid
            {
                addMediaContent(somevar.1.stringValue, type: .Video())
//                print(somevar.0)
                print(somevar.1)
                
            }
        }
        
        
//        print(img)
//        print(vid)
        
//        for somevar in img.dictionary!
//        {
//            print(somevar.0)
//            print(somevar.1)
//            
//        }
//        
//        
//        guard let allVides = media["videourl"].array,
//                allImages = media["imgurl"].array else
//        {
//            return
//        }
//        
        
//        for video in allVides {
//            addMediaContent(video[video.dictionaryValue.keys.first!].stringValue, type: .Video())
//        }
//        
//        
//        for img in allImages {
//
//            addMediaContent(img[img.dictionaryValue.keys.first!].stringValue, type: .Image())
//            
//        }
        
    }
    
    func setTextContent(contn: String)  {
        self.content = contn
    }    
    
    func addMediaContent(url: String, type : MediaType)  {
        if case .Video() = type {
            videos.append(url)
        }else if  case .Image() = type {
            images.append(url)
        }
    }
    
    func removeMediaContent(url: String, type : MediaType)  {
        if case .Video() = type , let foundIndex = videos.indexOf(url)  {
            videos.removeAtIndex(foundIndex)
        }else if  case .Image() = type , let foundIndex = images.indexOf(url){
            images.removeAtIndex(foundIndex)
        }
    }
    
}




