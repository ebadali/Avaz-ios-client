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

class CustomMediaCell:  UIView {
    

    
    
    // Objects To Use
    var url: String = ""
    var mediaType: MediaType = .Video()
    var cancleCallback = {}
    var previewCallback = {}
    
    
    
    let button = UIImageView()
    let imageView = UIImageView()
    let filter = UIView()

    let padding = 10
    
    required init?(coder aDecoder: NSCoder) {
         super.init(coder: aDecoder)
       initialize()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        initialize()
    }
    
    func initialize()  {
        button.image = UIImage(named: "cancle")
        filter.backgroundColor = UIColor.blackColor()
        filter.alpha = 0.2
        imageView.backgroundColor = UIColor.whiteColor()
        
        imageView.userInteractionEnabled = true
        
        addSubview(imageView)
        addSubview(button)
        addSubview(filter)
        
        
        imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.PreviewButton(_:))))
        filter.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.CancleButton(_:))))

        getThumbnail()
        
    }
    
    init(frame: CGRect, url: String, mediaType: MediaType) {

        super.init(frame: frame)
        self.url = url
        self.mediaType = mediaType
        initialize()
    }
    override func layoutSubviews() {
        // Set the button's width and height to a square the size of the frame's height.
        let totalHeight = Int(frame.size.height) - padding
        let totalWidth = Int(frame.size.width) - padding
        
        
        // Offset each button's origin by the length of the button plus spacing.
        let butnHeight = totalHeight/6
        let butnWidth = totalWidth/6
        
        button.frame = CGRect(x: totalWidth-butnWidth, y: (butnHeight/2), width: butnWidth, height: butnHeight)
        filter.frame = CGRect(x: 0, y: 0, width: totalWidth, height: totalHeight/4)
        
        // Lets Create an Image View
        imageView.frame = CGRect(x: 0, y: 0, width: totalWidth, height: totalHeight)
        imageView.image = UIImage(contentsOfFile: url)
        
       
        
    }
    
    override func intrinsicContentSize() -> CGSize {
        let buttonSize = Int(frame.size.height)
        let width = 455;
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
                
                // Set Compress Data
                self.imageView.image = UIImage(data: UIImageJPEGRepresentation(UIImage(CGImage: cgImage), 0.1)!)
                print("done compressing")
            }else if  case .Image() = self.mediaType {
                                print("compressing image")
                // Set Compress Data
                
                //FIXME: there was an undetected bug, when deleting and adding more images.
                self.imageView.image = UIImage(data: UIImageJPEGRepresentation(UIImage(imageLiteral: self.url), 0.1)!)
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
