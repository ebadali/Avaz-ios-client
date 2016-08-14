//
//  MediaSourceObject.swift
//  avaz
//
//  Created by Nerdiacs Mac on 8/12/16.
//  Copyright © 2016 Nerdiacs. All rights reserved.
//

import Foundation


var score:Int = 0


class MediaSourceObject: UICollectionViewCell {
    
    var url:String = ""
    var mediaType: MediaType = .Image()
    var accessType: AccessType = .Local()
    
    var cancleCallback = {}
    var previewCallback: (MediaSourceObject)->() = {_ in }
    
    
    var imageView : UIImageView
    
    func setMedia(url: String ,medType: MediaType, accType: AccessType, prevCallback: (MediaSourceObject)->())
    {
        self.url  = url
        self.mediaType = medType
        self.accessType = accType
        self.previewCallback = prevCallback

    }
    
    func load()  {
        imageView.loadmedia(self.url, mediatype: self.mediaType, accessType: self.accessType)
    }
    
    func PreviewButton(_: AnyObject)  {
        self.previewCallback(self)
    }
    let cscore: Int!
    
    override init(frame: CGRect) {
        cscore = score
        print("MediaSourceObject \(score)")
        score = score+1
        
        imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height*2/3))
        imageView.contentMode = UIViewContentMode.ScaleAspectFit
        
        imageView.userInteractionEnabled = true
        
        super.init(frame: frame)
        
        contentView.addSubview(imageView)
        imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.PreviewButton(_:))))

    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
   

  
}
