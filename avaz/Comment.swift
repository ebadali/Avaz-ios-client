//
//  Comment.swift
//  avaz
//
//  Created by Nerdiacs Mac on 8/3/16.
//  Copyright © 2016 Nerdiacs. All rights reserved.
//

import Foundation

import SwiftyJSON

class Comment {
//    var text: String
//    var imageUrl: String?
//    var videoUrl: String?
    
    var media : Media

    init(mediaJson: JSON){
        
        self.media = Media(media: mediaJson)
    }
    
    init(text: String){
        
        self.media = Media(text: text)
    }
}
