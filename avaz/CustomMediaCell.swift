//
//  CustomMediaCell.swift
//  avaz
//
//  Created by ebad ali on 7/8/16.
//  Copyright © 2016 Nerdiacs. All rights reserved.
//

import UIKit
import AVFoundation


enum MediaType{
    case Video();
    case Image();
    
}


enum AccessType{
    case Remote();
    case Local();
    
}

class CustomMediaCell:  UIView {
    
    
    
    
    // Objects To Use
    var url: String = ""
    var mediaType: MediaType = .Video()
    var accessType: AccessType = .Local()
    
    var cancleCallback = {}
    var previewCallback = {}
    
    
    
    lazy var button = UIImageView()
    var imageView = UIImageView(){
        didSet {
            
        }
    }
    let filter = UIView()
    
    let padding = 40
    lazy var fact = 10
    
    
    lazy var subtractingHorizontalFact: Int = {
//        return Int(self.frame.size.width/8)
        return Int(self.frame.size.width ) - 10
    }()
    lazy var subtractingVecticalFact: Int = {
//        return Int(self.frame.size.height/6)
        
        return Int(self.frame.size.height) - 10
    }()
    
    
    lazy var xHorizontalFact: Int = {
        
        return Int(self.frame.origin.x ) + 10
    }()
    lazy var yVecticalFact: Int = {
        return Int(self.frame.origin.y ) + 10
    }()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialize()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        initialize()
    }
    
    func initialize()  {
//        subtractingHorizontalFact = Int(self.frame.size.width/8)
//        subtractingVecticalFact = Int(self.frame.size.height/6)
        var bounds = self.bounds
        var centeer = self.center
        var fm = self.frame
        
        if self.url == ""{
            url = "notfound"
        }else{
            

            
            button.image = UIImage(named: "cancle")
            filter.backgroundColor = UIColor.blackColor()
            filter.alpha = 0.2
            
            imageView.backgroundColor = UIColor.whiteColor()
            imageView.userInteractionEnabled = true
            
            CustomLayouting()
            
            
            
            
            imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.PreviewButton(_:))))
            filter.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.CancleButton(_:))))
         
            self.addSubview(imageView)
            

            self.addSubview(filter)
//            self.addSubview(button)
        }
        
    }
    
    init(frame: CGRect, url: String, mediaType: MediaType, accessType : AccessType) {
        
        super.init(frame: frame)
        self.url = url
        self.mediaType = mediaType
        self.accessType = accessType
        initialize()
    }
    func CustomLayouting() {
        
        print("layout Subviews Called")
        // Set the button's width and height to a square the size of the frame's height.
        let totalHeight = subtractingVecticalFact - yVecticalFact
        let totalWidth = (subtractingHorizontalFact - xHorizontalFact)
        

        // Offset each button's origin by the length of the button plus spacing.
        
        
        let bx =  self.center.x  - (self.bounds.width/2)
        let by =  self.center.y  - (self.bounds.height/2)
        let w = self.bounds.width
        let h = self.bounds.height
        
        
        
        let butnY = subtractingVecticalFact/2
        let butnX = totalWidth - totalWidth/12
        
//        button.frame = CGRect(x: butnX, y: butnY, width: totalWidth/8, height: totalWidth/8)
//        filter.frame = CGRect(x: subtractingHorizontalFact/2, y: subtractingVecticalFact/2, width: totalWidth, height: totalHeight/4)
        
        // Lets Create an Image View
        imageView.frame = CGRect(x: bx, y: by, width: w, height: h)
        imageView.loadmedia(url, mediatype: self.mediaType, accessType: self.accessType)
        
//        LoadImage(url)
//        imageView.image = UIImage(named:  url)
//        .imageWithRenderingMode(.AlwaysTemplate))
        
        
    }
    
    
    
    override func intrinsicContentSize() -> CGSize {
        let buttonSize = Int(frame.size.height)
        let width = Int(frame.size.width);
        return CGSize(width: width, height: buttonSize)
    }
    
    

    
    // MARK: Button Action
    
    func CancleButton(button: AnyObject) {
        
        cancleCallback()
    }
    
    func PreviewButton(sender: AnyObject)  {
        
        previewCallback()
    }
    
    
    
}
