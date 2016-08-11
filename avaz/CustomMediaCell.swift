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
    lazy var subtractingHorizontalFact: Int = {
        return Int(self.frame.size.width/8)
    }()
    lazy var subtractingVecticalFact: Int = {
        return Int(self.frame.size.height/6)
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
        subtractingHorizontalFact = Int(self.frame.size.width/8)
        subtractingVecticalFact = Int(self.frame.size.height/6)
        
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
            self.addSubview(button)
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
        let totalHeight = Int(self.frame.size.height) - subtractingVecticalFact
        let totalWidth = Int(self.frame.size.width) - (subtractingHorizontalFact*4)
        

        // Offset each button's origin by the length of the button plus spacing.
        let butnY = subtractingVecticalFact/2
        let butnX = totalWidth - totalWidth/12
        
        button.frame = CGRect(x: butnX, y: butnY, width: totalWidth/8, height: totalWidth/8)
        filter.frame = CGRect(x: subtractingHorizontalFact/2, y: subtractingVecticalFact/2, width: totalWidth, height: totalHeight/4)
        
        // Lets Create an Image View
        imageView.frame = CGRect(x: subtractingHorizontalFact/2, y: subtractingVecticalFact/2, width: totalWidth, height: totalHeight)
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
    
    
    func getThumbnail()  {
        do {
            if case .Video() = self.mediaType {
                print("compressing video frame")
                let asset = AVURLAsset(URL: NSURL(fileURLWithPath: self.url), options: nil)
                let imgGenerator = AVAssetImageGenerator(asset: asset)
                imgGenerator.appliesPreferredTrackTransform = true
                let cgImage = try imgGenerator.copyCGImageAtTime(CMTimeMake(0, 1), actualTime: nil)
                
                guard let loadedImage: UIImage = UIImage(CGImage: cgImage) else {
                    return
                    
                }
                // Set Compress Data
                self.imageView.image = UIImage(data: UIImageJPEGRepresentation(loadedImage, 0.1)!)
                print("done compressing")
            }else if  case .Image() = self.mediaType {
                print("compressing image")
                // Set Compress Data
                if let loadedImage = UIImage(named: self.url) {
                    //FIXME: there was an undetected bug, when deleting and adding more images.
                    self.imageView.image = UIImage(data: UIImageJPEGRepresentation(loadedImage, 0.1)!)
                }
            }
        } catch let error as NSError {
            print("Error generating thumbnail: \(error)")
        }
    }
    
    // MARK: Button Action
    
    func CancleButton(button: AnyObject) {
        
        cancleCallback()
    }
    
    func PreviewButton(sender: AnyObject)  {
        
        previewCallback()
    }
    
    
    
}
