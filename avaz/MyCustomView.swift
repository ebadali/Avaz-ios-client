//
//  MediaView.swift
//  avaz
//
//  Created by Nerdiacs Mac on 8/9/16.
//  Copyright © 2016 Nerdiacs. All rights reserved.
//

import Foundation

class MediaView: UIView {

    
    @IBInspectable var canupload: Bool = false {
        didSet {
            
            if self.canupload {
                
                // Will use it later
//                uploadImageView = self.AddImageToScrollView("upload")
            }

        }
    }
    
    
    var scrollView : UIScrollView = UIScrollView()
//        = {
//        var temp = UIScrollView()
//        temp.frame = CGRectMake(0, 0, self.frame.width, self.frame.height)
//        
////        let leadingContraints = NSLayoutConstraint(item: temp, attribute:
////            .LeadingMargin, relatedBy: .Equal, toItem: self,
////                            attribute: .LeadingMargin, multiplier: 1.0,
////                            constant: 0)
////        
////        
////        let trailingContraints = NSLayoutConstraint(item: temp, attribute:
////            .TrailingMargin, relatedBy: .Equal, toItem: self,
////                             attribute: .TrailingMargin, multiplier: 1.0,
////                             constant: 0)
////        temp.translatesAutoresizingMaskIntoConstraints = false
////        //        self.setTranslatesAutoresizingMaskIntoConstraints(false)
////        //IOS 8
////        //activate the constrains.
////        //we pass an array of all the contraints
////        NSLayoutConstraint.activateConstraints([leadingContraints, trailingContraints])
//        
//        return temp
//    }()
//    
    
    lazy var scrollViewWidth:CGFloat = {
        return self.frame.width
    }()
    lazy var scrollViewHeight:CGFloat = {
        return self.frame.height
    }()
    
    

    var uploadImageView: CustomMediaCell?
    
    
    
    override init(frame: CGRect) {
                print("init without bool")
//        self.scrollView.frame = CGRectMake(0, 0, frame.width, frame.height)
        super.init(frame: frame)

        
        self.addCustomView()
    }
    
    init(frame: CGRect, uploadable: Bool) {
        
//        self.scrollView.frame = CGRectMake(0, 0, frame.width, frame.height)
        print("init with bool")
        
        self.canupload = uploadable
      
        
        super.init(frame: frame)
        
        
        self.addCustomView()
        
    }
    required init(coder aDecoder: NSCoder) {

        
        super.init(coder: aDecoder)!
        self.addCustomView()
        
    }
    
    
    func AddImageToScrollView(named: String, mediaType: MediaType, accessType: AccessType ) -> CustomMediaCell{
        
        let count = CGFloat( self.scrollView.subviews.count )
        print("AddImageToScrollView \(count) ")
//        let imgOne = CustomMediaCell(frame: CGRectMake(self.scrollViewWidth * count, 0,self.scrollViewWidth, self.scrollViewHeight) ,
//                                     url: named ,mediaType: MediaType.Image(), accessType: AccessType.Local())
//
//        imgOne.contentMode = .ScaleAspectFit
//        imgOne.userInteractionEnabled = true
//        
//        self.scrollView.addSubview(imgOne)//(iv, atIndex: endIndexx+1)
//        self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.width * (count+1), self.scrollView.frame.height)
//        
        
        
        let imgOne = CustomMediaCell(frame: CGRectMake(self.scrollViewWidth * count, 0,self.scrollViewWidth, self.scrollViewHeight) ,
                                     url: named ,mediaType: mediaType, accessType: accessType)
        
        imgOne.contentMode = .ScaleAspectFit
        imgOne.userInteractionEnabled = true
          self.scrollView.addSubview(imgOne)
//        self.scrollView.insertSubview(imgOne, atIndex: Int(count+1))
        self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.width * (count+1), self.scrollView.frame.height)
        
        return imgOne
    }
    
    func addCustomView() {
        
        self.scrollView.frame = CGRectMake(0, 0, frame.width, frame.height)
        self.scrollViewWidth = self.scrollView.frame.width
            
        self.scrollViewHeight = self.scrollView.frame.height
        
        self.addSubview(self.scrollView)
        
//        self.AddImageToScrollView("social-media")
//        self.AddImageToScrollView("social-media")

        
        //
//        let horizontalConstraint = self.centerXAnchor.constraintEqualToAnchor(self.centerXAnchor)
//        let verticalConstraint = self.centerYAnchor.constraintEqualToAnchor(self.centerYAnchor)
//        let widthConstraint = self.widthAnchor.constraintEqualToAnchor(nil, constant: 0)
//        let heightConstraint = self.heightAnchor.constraintEqualToAnchor(nil, constant: 0)
//        NSLayoutConstraint.activateConstraints([horizontalConstraint, verticalConstraint, widthConstraint, heightConstraint])
    }
    
    
//    func AddRemoteMedia(url: String, type: MediaType) -> CustomMediaCell {
//        
//    }
    
    
    func RemoveThisMediaCell(image: CustomMediaCell)  {
        //        print("try to this \(image.tag)")
        // Do indexing
        
        //FIXME: Move back all the cells by recalculating their positions.
        
        var found = false;
        var counter = 0
        for subview in self.scrollView.subviews  {
            //            print("Removing this \(subview.tag)")
            
            if found {
                subview.frame.origin.x = (subview.frame.origin.x-image.frame.width)
                counter += 1
            }
            else if subview.tag == image.tag {
                subview.removeFromSuperview()
                found = true
            }
            
        }
    }
    
    
    
}











