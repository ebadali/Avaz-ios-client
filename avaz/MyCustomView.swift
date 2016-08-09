//
//  MediaView.swift
//  avaz
//
//  Created by Nerdiacs Mac on 8/9/16.
//  Copyright © 2016 Nerdiacs. All rights reserved.
//

import Foundation


class MediaView: UIView {
    
    
    var scrollView : UIScrollView = UIScrollView()
    
    
    var scrollViewWidth:CGFloat
    var scrollViewHeight:CGFloat
    
    var isUploadAble: Bool = false

    var uploadImageView: CustomMediaCell?
    
    
    
    override init(frame: CGRect) {
                print("init without bool")
        self.scrollView.frame = CGRectMake(0, 0, frame.width, frame.height)
        self.scrollViewWidth = self.scrollView.frame.width
        self.scrollViewHeight = self.scrollView.frame.height
        super.init(frame: frame)

        
        self.addCustomView()
    }
    
    init(frame: CGRect, uploadable: Bool) {
        
        print("init with bool")
        
        self.isUploadAble = uploadable
        self.scrollView.frame = CGRectMake(0, 0, frame.width, frame.height)
        self.scrollViewWidth = self.scrollView.frame.width
        self.scrollViewHeight = self.scrollView.frame.height
        
        super.init(frame: frame)
        
        
        self.addCustomView()
        
    }
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func AddImageToScrollView(named: String) -> CustomMediaCell{
        
        let count = CGFloat( self.scrollView.subviews.count )
        
        let imgOne = CustomMediaCell(frame: CGRectMake(self.scrollViewWidth * count, 0,self.scrollViewWidth, self.scrollViewHeight) ,
                                     url: named ,mediaType: MediaType.Image(), accessType: AccessType.Local())

        imgOne.contentMode = .ScaleAspectFit
        imgOne.userInteractionEnabled = true
        
        self.scrollView.addSubview(imgOne)//(iv, atIndex: endIndexx+1)
        self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.width * (count+1), self.scrollView.frame.height)
        
        return imgOne
    }
    
    func addCustomView() {

        if self.isUploadAble {
            uploadImageView = self.AddImageToScrollView("upload")
        }
        
//        self.AddImageToScrollView("social-media")
//        self.AddImageToScrollView("social-media")
//        self.AddImageToScrollView("social-media")

        self.addSubview(self.scrollView)
    }
    
    
//    func AddRemoteMedia(url: String, type: MediaType) -> CustomMediaCell {
//        
//    }
}











