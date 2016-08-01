//
//  Media.swift
//  avaz
//
//  Created by ebad ali on 8/2/16.
//  Copyright © 2016 Nerdiacs. All rights reserved.
//

import SwiftyJSON


class Media {
    
    var videos: [String]?
    var images: [String]?
    var content: String?

    
    init(media: JSON)
    {
        let text = media["text"]
        self.content = text[text.dictionaryValue.keys.first!].stringValue
        
        
        guard let allVides = media["videourl"].array,
                allImages = media["imgurl"].array else
        {
            return
        }
        
        
        for video in allVides {
            videos?.append(video[video.dictionaryValue.keys.first!].stringValue)
        }
        
        
        for img in allImages {
            videos?.append(img[img.dictionaryValue.keys.first!].stringValue)
        }
        
    }
    
    
    
}